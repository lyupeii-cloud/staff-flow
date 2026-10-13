import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:pointycastle/export.dart';

import 'company_service.dart';
import 'errors.dart';
import 'import_service.dart';
import 'models.dart';
import 'notifications.dart';
import 'store.dart';

/// Comptes sans Google, créés par l'invitation de l'employeur et protégés
/// par une application d'authentification (codes à 6 chiffres, RFC 6238) :
///
/// 1. activation : le code de l'invitation (QR code ou saisi) prouve
///    l'identité ; la personne relie son application 2FA et confirme avec
///    un premier code ; le compte est créé dans l'entreprise ;
/// 2. connexion : identifiant SF (ou matricule + code de l'entreprise) et
///    code de l'application 2FA, ou un des 8 codes de secours ;
/// 3. 3 erreurs depuis un même appareil (adresse) : 15 minutes de blocage
///    pour cet appareil seulement, et la personne est prévenue.
///
/// Un compte sans Google ne crée pas d'entreprise : il relie d'abord un
/// compte Google. Téléphone perdu : le patron ou un responsable donne un
/// nouveau code d'activation.
class TotpService {
  final Store store;
  final CompanyService companies;
  final NotificationService notifications;
  final SecretKey _key;
  final Uint8List _aes;
  final DateTime Function() now;

  static const issuer = 'Staff Flow';
  static const maxFailures = 3;
  static const lockout = Duration(minutes: 15);
  static const backupCount = 8;
  static const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  final _random = Random.secure();

  TotpService(this.store, this.companies, this.notifications, String secret, {required this.now})
      : _key = SecretKey(secret),
        _aes = Uint8List.fromList(sha256.convert(utf8.encode('$secret:aes')).bytes);

  /// Compte créé sans Google (connexion par application 2FA).
  static bool isLocal(User u) => u.googleSub.startsWith('local:');

  // --- Codes à 6 chiffres (RFC 6238 : HMAC-SHA1, 30 secondes) ---------------

  static String newSecret() {
    final r = Random.secure();
    return base32(Uint8List.fromList([for (var i = 0; i < 20; i++) r.nextInt(256)]));
  }

  static String base32(Uint8List bytes) {
    const a = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    final out = StringBuffer();
    var buffer = 0, bits = 0;
    for (final b in bytes) {
      buffer = (buffer << 8) | b;
      bits += 8;
      while (bits >= 5) {
        out.write(a[(buffer >> (bits - 5)) & 31]);
        bits -= 5;
      }
    }
    if (bits > 0) out.write(a[(buffer << (5 - bits)) & 31]);
    return out.toString();
  }

  static Uint8List _unbase32(String s) {
    const a = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
    final out = <int>[];
    var buffer = 0, bits = 0;
    for (final c in s.toUpperCase().replaceAll('=', '').split('')) {
      buffer = (buffer << 5) | a.indexOf(c);
      bits += 5;
      if (bits >= 8) {
        out.add((buffer >> (bits - 8)) & 255);
        bits -= 8;
      }
    }
    return Uint8List.fromList(out);
  }

  static String code(String secret, int step) {
    final msg = ByteData(8)..setInt64(0, step);
    final h = Hmac(sha1, _unbase32(secret)).convert(msg.buffer.asUint8List()).bytes;
    final o = h.last & 15;
    final v = ((h[o] & 127) << 24) | (h[o + 1] << 16) | (h[o + 2] << 8) | h[o + 3];
    return (v % 1000000).toString().padLeft(6, '0');
  }

  int _step() => now().millisecondsSinceEpoch ~/ 30000;

  /// Pas de temps du code (une demi-minute avant ou après acceptée), sinon `null`.
  int? _match(String secret, String otp, {int lastStep = -1}) {
    final step = _step();
    for (final s in [step, step - 1, step + 1]) {
      if (s > lastStep && code(secret, s) == otp) return s;
    }
    return null;
  }

  static String otpauth(String secret, String account) =>
      'otpauth://totp/${Uri.encodeComponent('$issuer:$account')}?secret=$secret&issuer=${Uri.encodeComponent(issuer)}&digits=6&period=30';

  // --- Secret chiffré en base (AES-GCM) ------------------------------------

  String _seal(String secret) {
    final nonce = Uint8List.fromList([for (var i = 0; i < 12; i++) _random.nextInt(256)]);
    final c = GCMBlockCipher(AESEngine())..init(true, AEADParameters(KeyParameter(_aes), 128, nonce, Uint8List(0)));
    return base64.encode([...nonce, ...c.process(Uint8List.fromList(utf8.encode(secret)))]);
  }

  String _open(String sealed) {
    final raw = base64.decode(sealed);
    final c = GCMBlockCipher(AESEngine())
      ..init(false, AEADParameters(KeyParameter(_aes), 128, Uint8List.fromList(raw.sublist(0, 12)), Uint8List(0)));
    return utf8.decode(c.process(Uint8List.fromList(raw.sublist(12))));
  }

  static String _hash(String s) => sha256.convert(utf8.encode(s.toUpperCase())).toString();

  String _randomCode() => List.generate(8, (_) => _alphabet[_random.nextInt(_alphabet.length)]).join();

  // --- Blocage : 3 erreurs depuis un même appareil, 15 minutes ---------------

  Future<void> _checkLock(String key) async {
    final rows = await store.query(store.db, 'SELECT count(*) FROM auth_failures WHERE key = @k AND at > @since',
        {'k': key, 'since': now().subtract(lockout)});
    if ((rows.first[0] as num).toInt() >= maxFailures) {
      throw const ApiError(429, 'too_many_attempts', 'Trop de codes incorrects : réessayez dans 15 minutes.');
    }
  }

  /// Une erreur de plus ; renvoie `true` si cet appareil vient d'être bloqué.
  Future<bool> _fail(String key) async {
    await store.query(store.db, 'INSERT INTO auth_failures (key, at) VALUES (@k, @t)', {'k': key, 't': now()});
    await store.query(store.db, 'DELETE FROM auth_failures WHERE at < @old', {'old': now().subtract(const Duration(days: 2))});
    final rows = await store.query(store.db, 'SELECT count(*) FROM auth_failures WHERE key = @k AND at > @since',
        {'k': key, 'since': now().subtract(lockout)});
    return (rows.first[0] as num).toInt() == maxFailures;
  }

  // --- Activation ------------------------------------------------------------

  /// Invitation valable pour ce code : (id, entreprise, nom, compte à réactiver).
  Future<(String, String, String, String, String?)> _invite(String raw) async {
    final rows = await store.query(store.db, '''
      SELECT i.id::text, i.company_id::text, c.name, i.name, i.user_id::text FROM member_invites i
      JOIN companies c ON c.id = i.company_id
      WHERE i.code = @code AND i.used_at IS NULL AND i.expires_at > @t''', {'code': ImportService.cleanCode(raw), 't': now()});
    if (rows.isEmpty) throw const ApiError.notFound('Code d\'invitation inconnu ou expiré.');
    final r = rows.first;
    return (r[0] as String, r[1] as String, r[2] as String, r[3] as String, r[4] as String?);
  }

  /// Étape 1 : le code de l'employeur. Renvoie de quoi relier l'application 2FA.
  Future<Map<String, Object?>> start(String code, String ip) async {
    await _checkLock('act:$ip');
    final String inviteId, companyName, name;
    final String? userId;
    try {
      (inviteId, _, companyName, name, userId) = await _invite(code);
    } on ApiError {
      await _fail('act:$ip');
      rethrow;
    }
    final account = userId == null ? null : await store.findUser(userId);
    final secret = newSecret();
    final pending = JWT({'i': inviteId, 's': secret}, issuer: 'staff-flow-activation')
        .sign(_key, expiresIn: const Duration(minutes: 20));
    return {
      'pending': pending,
      'name': name,
      'companyName': companyName,
      'publicId': account?.publicId,
      'secret': secret,
      'otpauth': otpauth(secret, account?.publicId ?? name),
    };
  }

  /// Création libre d'un compte sans Google (sans entreprise) : 5 au plus
  /// par jour et par adresse ; un compte qui n'a rejoint aucune entreprise
  /// est effacé au bout de [unusedLifetime].
  static const signupsPerDay = 5;
  static const unusedLifetime = Duration(days: 30);

  Future<Map<String, Object?>> signupStart(String name, String ip) async {
    final clean = name.trim();
    if (clean.length < 2 || clean.length > 120) {
      throw const ApiError.badRequest('Le nom doit faire entre 1 et 120 caractères.');
    }
    final rows = await store.query(store.db, 'SELECT count(*) FROM auth_failures WHERE key = @k AND at > @since',
        {'k': 'signup:$ip', 'since': now().subtract(const Duration(days: 1))});
    if ((rows.first[0] as num).toInt() >= signupsPerDay) {
      throw const ApiError(429, 'too_many_attempts', 'Trop de comptes créés depuis cette connexion : réessayez demain.');
    }
    final secret = newSecret();
    final pending = JWT({'n': clean, 's': secret}, issuer: 'staff-flow-activation')
        .sign(_key, expiresIn: const Duration(minutes: 20));
    return {'pending': pending, 'name': clean, 'secret': secret, 'otpauth': otpauth(secret, clean)};
  }

  /// Compte Google qui ajoute la connexion par application 2FA : nouveau secret.
  Future<Map<String, Object?>> enableStart(User actor) async {
    final secret = newSecret();
    final pending = JWT({'u': actor.id, 's': secret}, issuer: 'staff-flow-totp-enable')
        .sign(_key, expiresIn: const Duration(minutes: 20));
    return {'pending': pending, 'secret': secret, 'otpauth': otpauth(secret, actor.publicId)};
  }

  /// Premier code de l'application : la 2FA est active ; renvoie les codes de secours.
  Future<List<String>> enableConfirm(User actor, String pending, String otp) async {
    final JWT jwt;
    try {
      jwt = JWT.verify(pending, _key, issuer: 'staff-flow-totp-enable');
    } on JWTException {
      throw const ApiError.notFound('Lien expiré.');
    }
    final claims = jwt.payload as Map;
    if (claims['u'] != actor.id) throw const ApiError.forbidden();
    final secret = claims['s'] as String;
    final step = _match(secret, otp.trim());
    if (step == null) {
      throw const ApiError.badRequest('Code de l\'application incorrect : vérifiez l\'heure du téléphone et réessayez.');
    }
    final backup = [for (var i = 0; i < backupCount; i++) _randomCode()];
    await store.query(store.db, '''
      UPDATE users SET totp_secret = @s, totp_last_step = @st, backup_codes = @b WHERE id = @u::uuid''',
        {'u': actor.id, 's': _seal(secret), 'st': step, 'b': [for (final c in backup) _hash(c)]});
    await store.audit(actorId: actor.id, action: 'account.totp_enabled');
    return backup;
  }

  /// Un compte Google retire la connexion 2FA (un compte sans Google la garde).
  Future<void> disable(User actor) async {
    if (isLocal(actor)) throw const ApiError.conflict('Ce compte se connecte avec une application 2FA : elle ne peut pas être retirée.');
    await store.query(store.db, 'UPDATE users SET totp_secret = NULL, totp_last_step = NULL, backup_codes = NULL WHERE id = @u::uuid',
        {'u': actor.id});
    await store.audit(actorId: actor.id, action: 'account.totp_disabled');
  }

  Future<bool> enabled(String userId) async =>
      (await store.query(store.db, 'SELECT totp_secret IS NOT NULL FROM users WHERE id = @u::uuid', {'u': userId}))
          .first[0] ==
      true;

  /// Comptes sans Google créés librement qui n'ont jamais rejoint d'entreprise.
  Future<void> purgeUnused() async {
    await store.query(store.db, '''
      DELETE FROM users u WHERE u.google_sub LIKE 'local:%' AND u.created_at < @t
        AND NOT EXISTS (SELECT 1 FROM memberships m WHERE m.user_id = u.id)''', {'t': now().subtract(unusedLifetime)});
  }

  /// Étape 2 : premier code de l'application 2FA. Crée le compte (ou relie
  /// la nouvelle application à un compte existant) ; renvoie le compte et
  /// les codes de secours.
  Future<(User, List<String>)> confirm(String pending, String otp, String ip) async {
    await _checkLock('act:$ip');
    final JWT jwt;
    try {
      jwt = JWT.verify(pending, _key, issuer: 'staff-flow-activation');
    } on JWTException {
      throw const ApiError.notFound('Lien expiré.');
    }
    final claims = jwt.payload as Map;
    final secret = claims['s'] as String;
    final step = _match(secret, otp.trim());
    if (step == null) {
      await _fail('act:$ip');
      throw const ApiError.badRequest('Code de l\'application incorrect : vérifiez l\'heure du téléphone et réessayez.');
    }
    // Création libre : un compte sans entreprise.
    if (claims['n'] case final String name) {
      final backup = [for (var i = 0; i < backupCount; i++) _randomCode()];
      final created = await store.query(store.db, '''
        INSERT INTO users (public_id, google_sub, email, name, totp_secret, totp_last_step, backup_codes, created_at)
        VALUES (@p, 'local:' || gen_random_uuid(), '', @n, @s, @st, @b, @now) RETURNING id::text''', {
        'now': now(),
        'p': newPublicId(),
        'n': name,
        's': _seal(secret),
        'st': step,
        'b': [for (final c in backup) _hash(c)],
      });
      await store.query(store.db, 'INSERT INTO auth_failures (key, at) VALUES (@k, @t)', {'k': 'signup:$ip', 't': now()});
      final userId = created.first[0] as String;
      await store.audit(actorId: userId, action: 'account.totp_signup');
      return ((await store.findActiveUser(userId))!, backup);
    }
    final rows = await store.query(store.db, '''
      SELECT i.code, i.company_id::text, i.user_id::text, i.sites::text[] FROM member_invites i
      WHERE i.id::text = @i AND i.used_at IS NULL AND i.expires_at > @t''', {'i': claims['i'], 't': now()});
    if (rows.isEmpty) throw const ApiError.notFound('Code d\'invitation inconnu ou expiré.');
    final companyId = rows.first[1] as String;
    final existing = rows.first[2] as String?;
    final backup = [for (var i = 0; i < backupCount; i++) _randomCode()];
    final String userId;
    if (existing != null) {
      // Nouveau téléphone : la nouvelle application remplace l'ancienne, les autres appareils sont déconnectés.
      userId = existing;
      await store.query(store.db, '''
        UPDATE users SET totp_secret = @s, totp_last_step = @st, backup_codes = @b, session_version = session_version + 1
        WHERE id = @u::uuid''', {'u': userId, 's': _seal(secret), 'st': step, 'b': [for (final c in backup) _hash(c)]});
      await store.query(store.db, 'UPDATE member_invites SET used_at = now(), used_by = @u::uuid WHERE id::text = @i',
          {'u': userId, 'i': claims['i']});
      await notifications.revokeDevices(userId);
      await store.audit(companyId: companyId, actorId: userId, action: 'account.totp_reset');
    } else {
      await companies.ensureSeat(companyId);
      final created = await store.query(store.db, '''
        INSERT INTO users (public_id, google_sub, email, name, totp_secret, totp_last_step, backup_codes, created_at)
        VALUES (@p, 'local:' || gen_random_uuid(), '', (SELECT name FROM member_invites WHERE id::text = @i), @s, @st, @b, @now)
        RETURNING id::text''', {
        'now': now(),
        'p': newPublicId(),
        'i': claims['i'],
        's': _seal(secret),
        'st': step,
        'b': [for (final c in backup) _hash(c)],
      });
      userId = created.first[0] as String;
      await store.addMember(companyId, userId, Role.employee, sites: (rows.first[3] as List?)?.cast<String>());
      await ImportService.applyInvite(store, companyId, userId, claims['i'] as String);
      await store.audit(companyId: companyId, actorId: userId, action: 'account.totp_created');
    }
    return ((await store.findActiveUser(userId))!, backup);
  }

  // --- Connexion ---------------------------------------------------------------

  /// [login] : identifiant SF, ou matricule avec [companyCode] (6 caractères).
  /// Écran de connexion à un seul champ : ce que l'identifiant tapé appelle.
  /// `code` (compte 2FA : demander le code), `google` (compte Google sans
  /// 2FA), `activation` (code de l'employeur), `number` (peut-être un
  /// matricule : demander le code de l'entreprise, puis le code 2FA),
  /// `unknown` (identifiant SF inconnu : proposer de créer un compte).
  /// Pour un matricule, on ne dit jamais s'il existe.
  Future<String> identify(String login) async {
    final id = login.trim();
    if (id.isEmpty) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    if (id.toUpperCase().startsWith('SF-')) {
      final rows = await store.query(store.db, '''
        SELECT totp_secret IS NOT NULL FROM users WHERE public_id = @p AND deleted_at IS NULL''', {'p': id.toUpperCase()});
      if (rows.isEmpty) return 'unknown';
      return rows.first[0] == true ? 'code' : 'google';
    }
    final invite = await store.query(store.db, '''
      SELECT 1 FROM member_invites WHERE code = @code AND used_at IS NULL AND expires_at > @t''',
        {'code': ImportService.cleanCode(id), 't': now()});
    return invite.isNotEmpty ? 'activation' : 'number';
  }

  Future<User> login(String login, String? companyCode, String otp, String ip) async {
    final id = login.trim();
    final rows = id.toUpperCase().startsWith('SF-')
        ? await store.query(store.db, '''
            SELECT id::text, totp_secret, totp_last_step, backup_codes FROM users
            WHERE public_id = @p AND deleted_at IS NULL AND totp_secret IS NOT NULL''', {'p': id.toUpperCase()})
        : await store.query(store.db, '''
            SELECT u.id::text, u.totp_secret, u.totp_last_step, u.backup_codes FROM users u
            JOIN memberships m ON m.user_id = u.id AND m.left_at IS NULL
            JOIN companies c ON c.id = m.company_id
            WHERE upper(c.public_id) = upper(@c) AND lower(m.employee_number) = lower(@n)
              AND u.deleted_at IS NULL AND u.totp_secret IS NOT NULL''', {'c': companyCode?.trim() ?? '', 'n': id});
    // Inconnu : même réponse qu'un mauvais code (on ne dit pas si le compte existe).
    final key = 'login:${rows.isEmpty ? id.toLowerCase() : rows.first[0]}:$ip';
    await _checkLock(key);
    if (rows.isNotEmpty) {
      final userId = rows.first[0] as String;
      final secret = _open(rows.first[1] as String);
      final clean = otp.trim().toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
      final step = clean.length == 6 ? _match(secret, clean, lastStep: rows.first[2] as int? ?? -1) : null;
      if (step != null) {
        await store.query(store.db, 'UPDATE users SET totp_last_step = @s WHERE id = @u::uuid', {'u': userId, 's': step});
        return (await store.findActiveUser(userId))!;
      }
      // Code de secours (8 caractères), une seule fois.
      final codes = (rows.first[3] as List?)?.cast<String>() ?? const [];
      if (clean.length == 8 && codes.contains(_hash(clean))) {
        await store.query(store.db, 'UPDATE users SET backup_codes = array_remove(backup_codes, @h) WHERE id = @u::uuid',
            {'u': userId, 'h': _hash(clean)});
        await store.audit(actorId: userId, action: 'auth.backup_code');
        return (await store.findActiveUser(userId))!;
      }
    }
    if (await _fail(key) && rows.isNotEmpty) {
      await notifications.notify([rows.first[0] as String], kind: 'login_blocked', data: const {});
    }
    throw const ApiError.unauthorized('Identifiant ou code incorrect.');
  }

  // --- Nouveau code d'activation (téléphone perdu) ---------------------------

  /// Le patron, ou un responsable (pas un sous-responsable) qui gère cette
  /// personne, donne un nouveau code. Réservé aux comptes sans Google qui ne
  /// travaillent que dans cette entreprise. Renvoie (code, lien).
  Future<(String, String)> reactivation(User actor, String companyId, String userId, String appUrl) async {
    final (company, role) = await companies.open(actor, companyId);
    if (company.status == CompanyStatus.readOnly) throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    final target = await store.findActiveUser(userId);
    final targetRole = await store.roleOf(companyId, userId);
    if (target == null || targetRole == null) throw const ApiError.notFound('Membre introuvable.');
    if (!isLocal(target)) throw const ApiError.conflict('Ce compte se connecte avec Google.');
    final allowed = role == Role.owner ||
        (role == Role.manager &&
            await store.appointedBy(companyId, actor.id) == null &&
            (targetRole == Role.employee || targetRole == Role.extra) &&
            await companies.inSites(companyId, userId, await companies.managedSites(companyId, actor, role)));
    if (!allowed || userId == actor.id) throw const ApiError.forbidden();
    final others = await store.query(store.db, '''
      SELECT 1 FROM memberships WHERE user_id = @u::uuid AND company_id <> @c::uuid AND left_at IS NULL''',
        {'u': userId, 'c': companyId});
    if (others.isNotEmpty) {
      throw const ApiError.conflict('Cette personne travaille aussi dans une autre entreprise : seul le support peut lui redonner un code.');
    }
    final code = _randomCode();
    await store.query(store.db, 'DELETE FROM member_invites WHERE user_id = @u::uuid AND used_at IS NULL', {'u': userId});
    await store.query(store.db, '''
      INSERT INTO member_invites (company_id, code, name, user_id, created_by, expires_at)
      VALUES (@c::uuid, @code, @n, @u::uuid, @a::uuid, @e)''',
        {'c': companyId, 'code': code, 'n': target.name, 'u': userId, 'a': actor.id, 'e': now().add(const Duration(days: 7))});
    await store.audit(companyId: companyId, actorId: actor.id, action: 'member.reactivation', details: {'userId': userId});
    return (code, '$appUrl/invite/$code');
  }
}
