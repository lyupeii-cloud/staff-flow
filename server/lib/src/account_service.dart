import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'errors.dart';
import 'models.dart';
import 'store.dart';
import 'telegram.dart';

/// Le compte de chaque personne : export de ses données, suppression,
/// nouveau QR code, et reprise du compte avec un autre compte Google
/// (vérifiée par un code envoyé sur son Telegram).
class AccountService {
  final Store store;
  final TelegramService telegram;
  final SecretKey _key;
  final DateTime Function() now;

  AccountService(this.store, this.telegram, String secret, {required this.now}) : _key = SecretKey(secret);

  // --- Export des données personnelles ---------------------------------------

  /// Lien de téléchargement (10 minutes) du fichier de ses données.
  String exportLink(User user) =>
      JWT({}, subject: user.id, issuer: 'staff-flow-account-export').sign(_key, expiresIn: const Duration(minutes: 10));

  Future<(String, Uint8List)> exportFile(String token) async {
    final String userId;
    try {
      userId = JWT.verify(token, _key, issuer: 'staff-flow-account-export').subject!;
    } on JWTException {
      throw const ApiError.notFound('Lien expiré.');
    }
    final user = await store.findActiveUser(userId);
    if (user == null) throw const ApiError.notFound('Lien expiré.');
    final data = await export(user);
    final bytes = utf8.encode(const JsonEncoder.withIndent('  ').convert(data));
    return ('staff-flow-${user.publicId}.json', Uint8List.fromList(bytes));
  }

  /// Toutes les données personnelles conservées sur la personne.
  Future<Map<String, Object?>> export(User user) async {
    Future<List<Map<String, Object?>>> rows(String sql) async => [
          for (final r in await store.query(store.db, sql, {'u': user.id}))
            {for (final e in r.toColumnMap().entries) e.key: _plain(e.value)},
        ];
    final account = await rows('''
      SELECT public_id, email, name AS google_name, custom_name, photo_url, locale, created_at,
        notification_prefs, notice_retention, calendar_token IS NOT NULL AS calendar_feed,
        telegram_username, telegram_linked_at, trial_started_at
      FROM users WHERE id = @u::uuid''');
    return {
      'exportedAt': now().toIso8601String(),
      'service': 'Staff Flow — https://staff-flow.cloud',
      'account': account.first,
      'companies': await rows('''
        SELECT c.name AS company, c.public_id AS company_id, m.role, m.display_name AS name_in_company,
          m.joined_at, m.left_at, m.show_telegram
        FROM memberships m JOIN companies c ON c.id = m.company_id
        WHERE m.user_id = @u::uuid ORDER BY m.joined_at'''),
      'shifts': await rows('''
        SELECT c.name AS company, s.day, s.start_min, s.end_min, si.name AS site, p.name AS position, s.note
        FROM shifts s JOIN companies c ON c.id = s.company_id
        LEFT JOIN sites si ON si.id = s.site_id LEFT JOIN positions p ON p.id = s.position_id
        WHERE s.user_id = @u::uuid AND NOT s.deleted ORDER BY s.day, s.start_min'''),
      'requests': await rows('''
        SELECT c.name AS company, r.kind, r.status, r.start_day, r.end_day, r.weekdays, r.note, r.created_at
        FROM requests r JOIN companies c ON c.id = r.company_id
        WHERE r.requester_id = @u::uuid ORDER BY r.created_at'''),
      'messages': await rows('''
        SELECT c.name AS company, v.kind AS conversation, m.body, m.created_at
        FROM messages m JOIN conversations v ON v.id = m.conversation_id JOIN companies c ON c.id = v.company_id
        WHERE m.author_id = @u::uuid ORDER BY m.id'''),
      'notifications': await rows('''
        SELECT kind, data, created_at, read_at FROM notices WHERE user_id = @u::uuid ORDER BY created_at'''),
      'devices': await rows('''
        SELECT platform, language, created_at, seen_at FROM push_devices WHERE user_id = @u::uuid'''),
      'invoices': await rows('''
        SELECT number, company_name, issued_at, amount_cents FROM invoices
        WHERE owner_id = @u::uuid OR holder_id = @u::uuid ORDER BY id'''),
      'activity': await rows('''
        SELECT at, action, details FROM audit_log WHERE actor_id = @u::uuid ORDER BY id'''),
    };
  }

  static Object? _plain(Object? v) => switch (v) {
        DateTime d => d.toIso8601String(),
        final List l => [for (final e in l) _plain(e)],
        _ => v is num || v is bool || v is String || v is Map || v == null ? v : '$v',
      };

  // --- Suppression du compte -------------------------------------------------

  /// Supprime le compte. [erase] : effacement définitif (il ne reste qu'un
  /// « Ghost » anonyme dans l'historique des entreprises : services, demandes
  /// de congé…). Sinon le compte devient un fantôme que la personne
  /// réactive en se reconnectant avec le même compte Google.
  Future<void> delete(User user, {required bool erase}) async {
    final owned = await store.query(store.db, '''
      SELECT 1 FROM memberships WHERE user_id = @u::uuid AND role = 'owner' AND left_at IS NULL''', {'u': user.id});
    if (owned.isNotEmpty) {
      throw const ApiError(409, 'owner_must_transfer',
          'Vous êtes encore propriétaire d\'une entreprise : transférez-la, ou attendez la fin de son abonnement.');
    }
    await store.db.runTx((tx) async {
      Future<void> q(String sql) => store.query(tx, sql, {'u': user.id, 't': now()});
      await q('UPDATE memberships SET left_at = @t, show_telegram = false WHERE user_id = @u::uuid AND left_at IS NULL');
      await q("UPDATE requests SET status = 'cancelled', updated_at = @t WHERE requester_id = @u::uuid AND status IN ('pending_peer', 'pending_manager')");
      await q("UPDATE ownership_transfers SET status = 'cancelled' WHERE (from_user_id = @u::uuid OR to_user_id = @u::uuid) AND status = 'pending'");
      await q("DELETE FROM join_requests WHERE user_id = @u::uuid AND status = 'pending'");
      await q('DELETE FROM push_devices WHERE user_id = @u::uuid');
      await q('DELETE FROM telegram_links WHERE user_id = @u::uuid');
      await q('DELETE FROM account_recoveries WHERE new_user_id = @u::uuid OR old_user_id = @u::uuid');
      await q('UPDATE users SET deleted_at = @t, calendar_token = NULL WHERE id = @u::uuid');
      if (erase) {
        await q('''
          UPDATE users SET erased = true, google_sub = 'erased:' || id, email = '', name = 'Ghost · ' || public_id,
            custom_name = NULL, photo_url = NULL, locale = NULL, notification_prefs = '{}',
            telegram_chat_id = NULL, telegram_username = NULL, telegram_linked_at = NULL
          WHERE id = @u::uuid''');
        await q('UPDATE memberships SET display_name = NULL WHERE user_id = @u::uuid');
        await q('DELETE FROM notices WHERE user_id = @u::uuid');
        await q('DELETE FROM idempotency_keys WHERE user_id = @u::uuid');
        await q('DELETE FROM conversation_members WHERE user_id = @u::uuid');
        await q('DELETE FROM messages WHERE author_id = @u::uuid AND request_id IS NULL');
        await q("UPDATE messages SET body = '' WHERE author_id = @u::uuid");
      }
      await store.audit(actorId: user.id, action: 'account.delete', details: {'erase': erase}, tx: tx);
    });
  }

  // --- Nouveau QR code ---------------------------------------------------------

  /// Nouvel identifiant (et donc nouveau QR code) : l'ancien ne sert plus ;
  /// la place de la personne dans ses entreprises ne change pas.
  Future<User> newQrCode(User user) async {
    final rows = await store.query(store.db,
        'UPDATE users SET public_id = @p WHERE id = @u::uuid RETURNING public_id', {'u': user.id, 'p': newPublicId()});
    await store.audit(actorId: user.id, action: 'user.qr', details: {'old': user.publicId, 'new': rows.first[0]});
    return (await store.findActiveUser(user.id))!;
  }

  // --- Reprise du compte avec un autre compte Google ---------------------------

  static final _random = Random.secure();
  static String _hash(String code) => sha256.convert(utf8.encode(code)).toString();

  /// Depuis un compte Google tout neuf : demande un code, envoyé sur le
  /// Telegram vérifié du compte [publicId].
  Future<Map<String, Object?>> recoverStart(User current, String publicId) async {
    if (!telegram.enabled) throw const ApiError.conflict('Telegram n\'est pas encore disponible.');
    final id = publicId.trim().toUpperCase();
    final code = id.startsWith('SF-') ? id : 'SF-$id';
    final used = await store.query(store.db,
        'SELECT 1 FROM memberships WHERE user_id = @u::uuid AND left_at IS NULL', {'u': current.id});
    if (used.isNotEmpty) {
      throw const ApiError.conflict(
          'Ce compte Google est déjà utilisé dans une entreprise : connectez-vous avec un compte Google qui n\'a jamais servi à Staff Flow.');
    }
    final recent = await store.query(store.db, '''
      SELECT count(*) FROM audit_log WHERE actor_id = @u::uuid AND action = 'account.recovery_code' AND at > @t''',
        {'u': current.id, 't': now().subtract(const Duration(hours: 1))});
    if ((recent.first[0] as num) >= 3) throw const ApiError.conflict('Trop d\'essais. Réessayez dans une heure.');
    final rows = await store.query(store.db, '''
      SELECT id::text, locale, telegram_username FROM users
      WHERE public_id = @p AND NOT erased AND telegram_chat_id IS NOT NULL AND id <> @u::uuid''',
        {'p': code, 'u': current.id});
    if (rows.isEmpty) {
      await store.audit(actorId: current.id, action: 'account.recovery_code', details: {'publicId': code});
      throw const ApiError.notFound('Aucun compte avec ce numéro et un Telegram vérifié.');
    }
    final oldId = rows.first[0] as String;
    // Limites par compte visé, quel que soit le compte Google qui demande :
    // 5 codes et 10 mauvais codes par 24 heures au plus.
    final day = await store.query(store.db, '''
      SELECT count(*) FILTER (WHERE action = 'account.recovery_code'), count(*) FILTER (WHERE action = 'account.recovery_failed')
      FROM audit_log WHERE details->>'target' = @o AND at > @t''',
        {'o': oldId, 't': now().subtract(const Duration(hours: 24))});
    if ((day.first[0] as num) >= 5 || (day.first[1] as num) >= 10) {
      throw const ApiError.conflict('Trop de demandes pour ce compte : réessayez demain.');
    }
    await store.audit(actorId: current.id, action: 'account.recovery_code', details: {'publicId': code, 'target': oldId});
    final digits = List.generate(6, (_) => _random.nextInt(10)).join();
    final lang = rows.first[1] as String? ?? 'en';
    final sent = await telegram.sendTo(
        oldId,
        TelegramService.t('Code Staff Flow : {code}. Il relie votre compte {id} au compte Google {email}. Ne le donnez à personne, même à quelqu\'un qui dit travailler pour Staff Flow. Si ce n\'est pas vous, ignorez ce message.',
            lang,
            {'code': digits, 'id': code, 'email': current.email}));
    if (!sent) throw const ApiError.conflict('Le code n\'a pas pu être envoyé sur Telegram.');
    await store.query(store.db, '''
      INSERT INTO account_recoveries (new_user_id, old_user_id, code_hash, sent_at, expires_at)
      VALUES (@n::uuid, @o::uuid, @h, @t, @e)
      ON CONFLICT (new_user_id) DO UPDATE SET old_user_id = EXCLUDED.old_user_id, code_hash = EXCLUDED.code_hash,
        attempts = 0, sent_at = EXCLUDED.sent_at, expires_at = EXCLUDED.expires_at''',
        {'n': current.id, 'o': oldId, 'h': _hash(digits), 't': now(), 'e': now().add(const Duration(minutes: 10))});
    return {'telegram': rows.first[2]};
  }

  /// Le bon code : le compte Google actuel est rattaché à l'ancien compte
  /// (même numéro, mêmes entreprises) ; le compte vide créé à la connexion
  /// disparaît. Renvoie l'ancien compte.
  Future<User> recoverConfirm(User current, String code) async {
    final rows = await store.query(store.db, '''
      SELECT old_user_id::text, code_hash, attempts FROM account_recoveries
      WHERE new_user_id = @u::uuid AND expires_at > @t''', {'u': current.id, 't': now()});
    if (rows.isEmpty || (rows.first[2] as int) >= 5) {
      throw const ApiError.conflict('Code expiré : demandez-en un nouveau.');
    }
    final oldId = rows.first[0] as String;
    if (_hash(code.trim()) != rows.first[1]) {
      await store.query(store.db, 'UPDATE account_recoveries SET attempts = attempts + 1 WHERE new_user_id = @u::uuid',
          {'u': current.id});
      await store.audit(actorId: current.id, action: 'account.recovery_failed', details: {'target': oldId});
      throw const ApiError.badRequest('Code incorrect.');
    }
    final fresh = await store.query(store.db,
        'SELECT google_sub, email, name, photo_url, locale FROM users WHERE id = @u::uuid', {'u': current.id});
    final f = fresh.first;
    await store.db.runTx((tx) async {
      await store.query(tx, 'DELETE FROM account_recoveries WHERE new_user_id = @u::uuid', {'u': current.id});
      await store.query(tx, '''
        UPDATE users SET google_sub = 'merged:' || id, email = '', name = 'Ghost · ' || public_id, photo_url = NULL,
          deleted_at = @t, erased = true
        WHERE id = @u::uuid''', {'u': current.id, 't': now()});
      await store.query(tx, 'DELETE FROM push_devices WHERE user_id = @u::uuid', {'u': current.id});
      await store.query(tx, '''
        UPDATE users SET google_sub = @s, email = @e, name = @n, photo_url = @p, locale = coalesce(locale, @l),
          deleted_at = NULL
        WHERE id = @o::uuid''', {'o': oldId, 's': f[0], 'e': f[1], 'n': f[2], 'p': f[3], 'l': f[4]});
      await store.audit(actorId: oldId, action: 'account.google_changed', details: {'email': f[1]}, tx: tx);
    });
    final user = (await store.findActiveUser(oldId))!;
    await telegram.sendTo(
        oldId,
        TelegramService.t('Votre compte Staff Flow {id} est maintenant relié au compte Google {email}.',
            user.locale ?? 'en', {'id': user.publicId, 'email': user.email}));
    return user;
  }

  // --- Avatar et photos ------------------------------------------------------------

  /// Avatar choisi (`{icon, color}`), ou `null` pour revenir à la photo Google.
  Future<User> setAvatar(User user, Object? avatar) async {
    Map<String, Object?>? clean;
    if (avatar != null) {
      final icon = avatar is Map ? avatar['icon'] : null, color = avatar is Map ? avatar['color'] : null;
      if (icon is! String || !avatarIcons.contains(icon) || color is! int || color < 0 || color >= avatarColors) {
        throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
      }
      clean = {'icon': icon, 'color': color};
    }
    await store.query(store.db, 'UPDATE users SET avatar = @a::jsonb WHERE id = @u::uuid',
        {'u': user.id, 'a': clean == null ? null : jsonEncode(clean)});
    return (await store.findActiveUser(user.id))!;
  }

  /// Le patron masque les photos Google dans son entreprise.
  Future<void> hidePhotos(User actor, String companyId, bool hidden) async {
    final rows = await store.query(store.db, '''
      SELECT 1 FROM memberships WHERE company_id = @c::uuid AND user_id = @u::uuid AND role = 'owner' AND left_at IS NULL''',
        {'c': companyId, 'u': actor.id});
    if (rows.isEmpty) throw const ApiError.forbidden();
    await store.query(store.db, 'UPDATE companies SET hide_photos = @h WHERE id = @c::uuid', {'c': companyId, 'h': hidden});
    await store.audit(companyId: companyId, actorId: actor.id, action: 'company.photos', details: {'hidden': hidden});
  }

  // --- Telegram affiché dans une entreprise ---------------------------------------

  Future<void> showTelegram(User user, String companyId, bool show) async {
    if (show) {
      final rows = await store.query(store.db,
          'SELECT telegram_username FROM users WHERE id = @u::uuid AND telegram_chat_id IS NOT NULL', {'u': user.id});
      if (rows.isEmpty) throw const ApiError.conflict('Reliez d\'abord votre compte Telegram (Mon profil).');
      if (rows.first[0] == null) {
        throw const ApiError.conflict(
            'Votre compte Telegram n\'a pas de nom d\'utilisateur (@…) : ajoutez-en un dans Telegram, puis réessayez.');
      }
    }
    final rows = await store.query(store.db, '''
      UPDATE memberships SET show_telegram = @s
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL RETURNING 1''',
        {'c': companyId, 'u': user.id, 's': show});
    if (rows.isEmpty) throw const ApiError.notFound();
  }
}

/// Avatars proposés : une figure et une couleur de fond.
const avatarIcons = {
  'pets', 'cruelty_free', 'emoji_nature', 'local_florist', 'park', 'spa', 'eco', 'bolt', //
  'star', 'favorite', 'rocket_launch', 'flight', 'sailing', 'directions_bike', 'sports_soccer', 'music_note', //
  'headphones', 'palette', 'camera_alt', 'coffee', 'local_pizza', 'icecream', 'cake', 'beach_access',
};
const avatarColors = 12;
