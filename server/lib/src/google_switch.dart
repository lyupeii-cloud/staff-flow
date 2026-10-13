import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'notifications.dart';
import 'store.dart';
import 'telegram.dart';

/// Changer le compte Google d'un compte Staff Flow (même compte, même
/// numéro, mêmes entreprises), de deux façons :
///
/// - par le bot Telegram (`/changegoogle`) : la personne envoie l'adresse du
///   nouveau compte Google, confirme, puis se connecte avec ce compte dans
///   les 10 minutes ;
/// - sans Telegram : le patron ou un responsable (pas un sous-responsable)
///   crée un lien à usage unique (24 h), ouvert dans le navigateur ; la
///   personne s'y connecte avec son nouveau compte Google.
///
/// Dans les deux cas, toutes ses anciennes sessions sont fermées.
class GoogleSwitchService {
  final Store store;
  final CompanyService companies;
  final TelegramService telegram;
  final NotificationService notifications;
  final DateTime Function() now;

  GoogleSwitchService(this.store, this.companies, this.telegram, this.notifications, {required this.now});

  static const window = Duration(minutes: 10);
  static const linkLifetime = Duration(hours: 24);
  static final _random = Random.secure();
  static const _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  static String _hash(String s) => sha256.convert(utf8.encode(s)).toString();
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  // --- Bot Telegram ---------------------------------------------------------------

  /// Conversation en cours par compte Telegram : adresse attendue, puis confirmation.
  final _talks = <int, ({String userId, String? email, DateTime until})>{};

  /// Message reçu par le bot ; `true` s'il concernait le changement de compte.
  Future<bool> onTelegram(int chatId, String lang, {String? text, String? button}) async {
    String t(String fr, [Map<String, String> args = const {}]) => TelegramService.t(fr, lang, args);
    final talk = _talks[chatId];
    final alive = talk != null && talk.until.isAfter(now());
    if (text == '/changegoogle') {
      final rows = await store.query(store.db,
          'SELECT id::text, public_id FROM users WHERE telegram_chat_id = @c AND deleted_at IS NULL', {'c': chatId});
      if (rows.isEmpty) {
        await telegram.reply(chatId, t('Ce compte Telegram n\'est relié à aucun compte Staff Flow. Reliez-le d\'abord depuis l\'application : Mon profil, puis Telegram.'));
        return true;
      }
      _talks[chatId] = (userId: rows.first[0] as String, email: null, until: now().add(window));
      await telegram.reply(chatId,
          t('Envoyez l\'adresse e-mail du nouveau compte Google à relier à votre compte Staff Flow {id}. (/cancel pour annuler)', {'id': rows.first[1] as String}));
      return true;
    }
    if (text == '/cancel' || button == 'gs:no') {
      _talks.remove(chatId);
      await telegram.reply(chatId, t('Annulé : rien n\'a changé.'));
      return true;
    }
    if (!alive) return false;
    if (button == 'gs:yes' && talk.email != null) {
      _talks.remove(chatId);
      await store.query(store.db, '''
        INSERT INTO google_switches (user_id, email, expires_at) VALUES (@u::uuid, @e, @x)
        ON CONFLICT (user_id) DO UPDATE SET email = EXCLUDED.email, expires_at = EXCLUDED.expires_at''',
          {'u': talk.userId, 'e': talk.email, 'x': now().add(window)});
      await store.audit(actorId: talk.userId, action: 'account.google_switch_requested', details: {'email': talk.email});
      await telegram.reply(chatId, t('C\'est noté : connectez-vous à Staff Flow avec {email} dans les 10 minutes. Sinon, rien ne change.', {'email': talk.email!}));
      return true;
    }
    if (text == null || text.startsWith('/') || talk.email != null) return false;
    final email = text.trim().toLowerCase();
    if (!_email.hasMatch(email)) {
      await telegram.reply(chatId, t('Adresse e-mail invalide. Envoyez l\'adresse du nouveau compte Google, ou /cancel.'));
      return true;
    }
    if (await _usedElsewhere(email, talk.userId)) {
      await telegram.reply(chatId, t('Ce compte Google est déjà utilisé dans une entreprise Staff Flow : choisissez-en un autre.'));
      return true;
    }
    _talks[chatId] = (userId: talk.userId, email: email, until: now().add(window));
    await telegram.reply(
        chatId,
        t('Relier le compte Google {email} à votre compte Staff Flow ? Après confirmation, connectez-vous à Staff Flow avec ce compte dans les 10 minutes ; sinon rien ne change. Tous vos autres appareils seront déconnectés.', {'email': email}),
        buttons: [('gs:yes', t('Confirmer')), ('gs:no', t('Annuler'))]);
    return true;
  }

  /// Un autre compte Staff Flow, encore membre d'une entreprise, utilise déjà cette adresse.
  Future<bool> _usedElsewhere(String email, String userId) async => (await store.query(store.db, '''
        SELECT 1 FROM users u WHERE lower(u.email) = @e AND u.id <> @u::uuid AND u.deleted_at IS NULL
          AND EXISTS (SELECT 1 FROM memberships m WHERE m.user_id = u.id AND m.left_at IS NULL)''',
          {'e': email, 'u': userId}))
      .isNotEmpty;

  // --- Lien créé par le patron ou un responsable --------------------------------------

  /// Compte sans Google : jeton (30 minutes) à passer à la prochaine
  /// connexion Google, qui relie ce compte Google au compte Staff Flow.
  Future<String> selfLink(User actor) async {
    if (!actor.googleSub.startsWith('local:')) throw const ApiError.conflict('Ce compte se connecte déjà avec Google.');
    final token = base64Url.encode([for (var i = 0; i < 24; i++) Random.secure().nextInt(256)]).replaceAll('=', '');
    await store.query(store.db, '''
      INSERT INTO google_switch_links (token_hash, user_id, created_by, expires_at)
      VALUES (@h, @u::uuid, @u::uuid, @e)''', {'h': _hash(token), 'u': actor.id, 'e': now().add(const Duration(minutes: 30))});
    return token;
  }

  /// Lien à usage unique (24 h) pour une personne sans Telegram, qui ne
  /// travaille que dans cette entreprise. Renvoie le chemin `/switch/<jeton>`.
  Future<String> createLink(User actor, String companyId, String userId) async {
    final (company, role) = await companies.open(actor, companyId);
    final target = await store.roleOf(companyId, userId);
    if (target == null) throw const ApiError.notFound('Membre introuvable.');
    final deputy = role == Role.manager && await store.appointedBy(companyId, actor.id) != null;
    final allowed = userId != actor.id &&
        target != Role.owner &&
        (role == Role.owner ||
            (role == Role.manager &&
                !deputy &&
                (target == Role.employee || target == Role.extra) &&
                await companies.inSites(companyId, userId, await companies.managedSites(companyId, actor, role))));
    if (!allowed) throw const ApiError.forbidden();
    final info = await store.query(store.db, '''
      SELECT u.telegram_chat_id IS NOT NULL,
        (SELECT count(*) FROM memberships m WHERE m.user_id = u.id AND m.left_at IS NULL)
      FROM users u WHERE u.id = @u::uuid''', {'u': userId});
    if (info.first[0] == true) {
      throw const ApiError.conflict(
          'Cette personne a relié son Telegram : elle change elle-même de compte Google avec le bot (/changegoogle).');
    }
    if ((info.first[1] as num) > 1) {
      throw const ApiError.conflict(
          'Cette personne travaille dans plusieurs entreprises : elle doit relier son Telegram pour changer de compte Google.');
    }
    final token = List.generate(32, (_) => _alphabet[_random.nextInt(_alphabet.length)]).join();
    await store.query(store.db, 'DELETE FROM google_switch_links WHERE user_id = @u::uuid OR expires_at < @t',
        {'u': userId, 't': now()});
    await store.query(store.db, '''
      INSERT INTO google_switch_links (token_hash, user_id, company_id, created_by, expires_at)
      VALUES (@h, @u::uuid, @c::uuid, @a::uuid, @x)''',
        {'h': _hash(token), 'u': userId, 'c': companyId, 'a': actor.id, 'x': now().add(linkLifetime)});
    await store.audit(companyId: companyId, actorId: actor.id, action: 'account.google_switch_link', details: {'userId': userId});
    // La personne est prévenue : si elle n'a rien demandé, elle le dit à son responsable.
    await notifications.notify([userId], companyId: company.id, kind: 'google_switch_link', data: {'byName': actor.name});
    return '/switch/$token';
  }

  // --- Connexion avec le nouveau compte Google -----------------------------------------

  /// À la connexion Google : si un changement attend ce compte (lien, ou
  /// adresse confirmée par le bot dans les 10 minutes), le compte Google est
  /// rattaché au compte Staff Flow concerné et toutes ses anciennes
  /// sessions sont fermées. Renvoie ce compte, ou `null` (connexion normale).
  Future<User?> onLogin(
      {required String sub, required String email, required String name, String? photo, String? locale, String? link}) async {
    String? targetId;
    if (link != null && link.isNotEmpty) {
      final rows = await store.query(store.db, '''
        UPDATE google_switch_links SET used_at = @t
        WHERE token_hash = @h AND used_at IS NULL AND expires_at > @t RETURNING user_id::text''',
          {'h': _hash(link), 't': now()});
      if (rows.isEmpty) throw const ApiError.notFound('Lien expiré.');
      targetId = rows.first[0] as String;
    } else {
      final rows = await store.query(store.db,
          'DELETE FROM google_switches WHERE lower(email) = @e AND expires_at > @t RETURNING user_id::text',
          {'e': email.toLowerCase(), 't': now()});
      if (rows.isEmpty) return null;
      targetId = rows.first[0] as String;
    }
    final existing = await store.query(store.db, 'SELECT id::text FROM users WHERE google_sub = @s', {'s': sub});
    final existingId = existing.isEmpty ? null : existing.first[0] as String;
    if (existingId == targetId) return null;
    if (existingId != null &&
        (await store.query(store.db, 'SELECT 1 FROM memberships WHERE user_id = @u::uuid AND left_at IS NULL',
                {'u': existingId}))
            .isNotEmpty) {
      throw const ApiError.conflict(
          'Ce compte Google est déjà utilisé dans une entreprise : connectez-vous avec un compte Google qui n\'a jamais servi à Staff Flow.');
    }
    await store.db.runTx((tx) async {
      if (existingId != null) {
        // Compte vide créé par une connexion précédente avec ce compte Google.
        await store.query(tx, '''
          UPDATE users SET google_sub = 'merged:' || id, email = '', name = 'Ghost · ' || public_id, photo_url = NULL,
            deleted_at = @t, erased = true
          WHERE id = @u::uuid''', {'u': existingId, 't': now()});
      }
      await store.query(tx, '''
        UPDATE users SET google_sub = @s, email = @e, name = @n, photo_url = @p, locale = coalesce(locale, @l),
          deleted_at = NULL, session_version = session_version + 1
        WHERE id = @u::uuid''', {'u': targetId, 's': sub, 'e': email, 'n': name, 'p': photo, 'l': locale});
      // Anciens appareils : plus de notifications ; leurs sessions ne valent plus.
      await store.query(tx, 'DELETE FROM google_switches WHERE user_id = @u::uuid', {'u': targetId});
      await store.audit(actorId: targetId!, action: 'account.google_changed', details: {'email': email, 'by': link == null ? 'telegram' : 'link'}, tx: tx);
    });
    await notifications.revokeDevices(targetId);
    final user = (await store.findActiveUser(targetId))!;
    await telegram.sendTo(
        targetId,
        TelegramService.t('C\'est fait : votre compte Staff Flow {id} est relié au compte Google {email}. Vos autres appareils ont été déconnectés.',
            user.locale ?? 'en', {'id': user.publicId, 'email': email}));
    return user;
  }
}
