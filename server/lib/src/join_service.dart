import 'dart:math';

import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'store.dart';

/// Ajout d'un salarié par code à 6 chiffres (section 6 du cahier des charges) :
/// le salarié génère un code valable 2 minutes, le responsable le saisit,
/// puis le salarié confirme. Personne n'est ajouté sans son accord.
class JoinService {
  final Store store;
  final CompanyService companies;
  final DateTime Function() now;

  static const codeLifetime = Duration(minutes: 2);
  static const maxFailures = 3;
  static const lockout = Duration(minutes: 2);

  final _random = Random.secure();

  JoinService(this.store, this.companies, {required this.now});

  /// Nouveau code pour l'utilisateur ; ses anciens codes ne valent plus rien.
  Future<(String, DateTime)> createCode(User user) => store.db.runTx((tx) async {
        final at = now();
        await store.query(tx, 'DELETE FROM join_codes WHERE used_at IS NULL AND expires_at < @at',
            {'at': at});
        await store.query(tx,
            'UPDATE join_codes SET used_at = @at WHERE user_id = @u::uuid AND used_at IS NULL',
            {'u': user.id, 'at': at});
        final expires = at.add(codeLifetime);
        while (true) {
          final code = _random.nextInt(1000000).toString().padLeft(6, '0');
          final rows = await store.query(tx, '''
            INSERT INTO join_codes (code, user_id, expires_at) VALUES (@c, @u::uuid, @e)
            ON CONFLICT (code) WHERE used_at IS NULL DO NOTHING RETURNING id''',
              {'c': code, 'u': user.id, 'e': expires});
          if (rows.isNotEmpty) return (code, expires);
        }
      });

  /// Le responsable saisit le code. Après [maxFailures] codes erronés en
  /// [lockout], l'ajout est suspendu pour ce responsable, cette entreprise
  /// et cette adresse IP, pour qu'on ne puisse pas contourner la limite
  /// avec plusieurs comptes.
  Future<(JoinRequest, User)> redeem(
    User manager,
    String companyId, {
    required String code,
    required Role role,
    List<String>? sites,
    required String ip,
  }) async {
    final (company, chosen) = await _openForInvite(manager, companyId, role, sites);
    final at = await _checkLockout(manager, companyId, ip);
    final found = await store.db.runTx((tx) async {
      final rows = await store.query(tx, '''
        UPDATE join_codes SET used_at = @at
        WHERE code = @code AND used_at IS NULL AND expires_at > @at
        RETURNING user_id::text''', {'code': code.trim(), 'at': at});
      return rows.isEmpty ? null : rows.first[0] as String;
    });
    await _attempt(manager, companyId, ip, at, success: found != null);
    if (found == null) throw const ApiError.notFound('Code invalide ou expiré.');
    return _invite(manager, company, (await store.findUser(found))!, role, chosen);
  }

  static final _publicId = RegExp(r'SF-[A-Z2-9]{8}');

  /// Le responsable scanne le QR code permanent de la personne (il contient
  /// son identifiant SF-…). Comme pour le code, elle doit accepter. Les
  /// identifiants inconnus comptent comme des codes erronés : on ne peut pas
  /// en essayer au hasard.
  Future<(JoinRequest, User)> inviteByQr(
    User manager,
    String companyId, {
    required String qr,
    required Role role,
    List<String>? sites,
    required String ip,
  }) async {
    final (company, chosen) = await _openForInvite(manager, companyId, role, sites);
    final at = await _checkLockout(manager, companyId, ip);
    final id = _publicId.firstMatch(qr.toUpperCase())?[0];
    final user = id == null ? null : await store.findUserByPublicId(id);
    await _attempt(manager, companyId, ip, at, success: user != null);
    if (user == null) throw const ApiError.notFound('Compte introuvable.');
    return _invite(manager, company, user, role, chosen);
  }

  /// Vérifie le droit d'inviter et renvoie les sites de la future équipe :
  /// un responsable de site invite forcément dans un ou plusieurs de ses sites.
  Future<(Company, List<String>?)> _openForInvite(
      User manager, String companyId, Role role, List<String>? sites) async {
    final (company, actorRole) = await companies.open(manager, companyId);
    if (!actorRole.canManage) throw const ApiError.forbidden();
    if (company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
    if (role != Role.employee && role != Role.extra) {
      throw const ApiError.badRequest('Rôle attendu : salarié ou extra.');
    }
    final chosen = sites == null ? null : await companies.validSites(companyId, sites);
    final mine = await companies.managedSites(companyId, manager, actorRole);
    if (mine != null) {
      if (chosen == null || chosen.isEmpty) {
        throw const ApiError.badRequest('Choisissez au moins un de vos sites.');
      }
      if (!chosen.every(mine.contains)) {
        throw const ApiError.forbidden('Ce site n\'est pas sous votre responsabilité.');
      }
    }
    return (company, chosen == null || chosen.isEmpty ? null : chosen);
  }

  /// Renvoie l'heure de la tentative, ou lève 429 pendant la suspension.
  Future<DateTime> _checkLockout(User manager, String companyId, String ip) async {
    final at = now();
    final failures = await store.query(store.db, '''
      SELECT count(*) FROM join_attempts
      WHERE NOT success AND at > @since
        AND (manager_id = @m::uuid OR company_id = @c::uuid OR ip = @ip)''',
        {'since': at.subtract(lockout), 'm': manager.id, 'c': companyId, 'ip': ip});
    if ((failures.first[0] as int) >= maxFailures) {
      await _attempt(manager, companyId, ip, at, success: false, blocked: true);
      throw const ApiError(429, 'too_many_attempts',
          'Trop de codes erronés : réessayez dans 2 minutes.');
    }
    return at;
  }

  Future<(JoinRequest, User)> _invite(User manager, Company company, User user, Role role, List<String>? sites) async {
    final companyId = company.id;
    if (await store.roleOf(companyId, user.id) != null) {
      throw ApiError.conflict('{name} fait déjà partie de l\'entreprise.', {'name': user.name});
    }
    final rows = await store.query(store.db, '''
      INSERT INTO join_requests (company_id, user_id, role, invited_by, sites)
      VALUES (@c::uuid, @u::uuid, @r, @m::uuid, @s::uuid[])
      ON CONFLICT (company_id, user_id) WHERE status = 'pending'
        DO UPDATE SET role = EXCLUDED.role, invited_by = EXCLUDED.invited_by, sites = EXCLUDED.sites,
          created_at = now()
      RETURNING id::text''', {'c': companyId, 'u': user.id, 'r': role.name, 'm': manager.id, 's': sites});
    final request = JoinRequest(id: rows.first[0] as String, company: company, role: role);
    await store.audit(
        companyId: companyId,
        actorId: manager.id,
        action: 'join.invite',
        details: {'userId': user.id, 'role': role.name});
    return (request, user);
  }

  Future<List<JoinRequest>> pendingFor(User user) async {
    final rows = await store.query(store.db, '''
      SELECT r.id::text AS request_id, r.role, c.* FROM join_requests r
      JOIN companies c ON c.id = r.company_id
      WHERE r.user_id = @u::uuid AND r.status = 'pending'
      ORDER BY r.created_at''', {'u': user.id});
    return [
      for (final r in rows.map((r) => r.toColumnMap()))
        JoinRequest(
          id: r['request_id'] as String,
          company: Store.companyFromRow(r),
          role: Role.parse(r['role'] as String),
        ),
    ];
  }

  /// Renvoie l'entreprise concernée.
  Future<String> answer(User user, String requestId, {required bool accept}) async {
    final rows = await store.query(store.db, '''
      UPDATE join_requests SET status = @s, resolved_at = now()
      WHERE id = @id::uuid AND user_id = @u::uuid AND status = 'pending'
      RETURNING company_id::text, role, sites::text[]''',
        {'id': requestId, 'u': user.id, 's': accept ? 'accepted' : 'declined'});
    if (rows.isEmpty) throw const ApiError.notFound('Invitation introuvable.');
    final companyId = rows.first[0] as String;
    if (accept) {
      final sites = rows.first[2] as List?;
      await store.addMember(companyId, user.id, Role.parse(rows.first[1] as String),
          sites: sites?.cast<String>());
    }
    await store.audit(
        companyId: companyId, actorId: user.id, action: accept ? 'join.accept' : 'join.decline');
    return companyId;
  }

  Future<void> _attempt(User manager, String companyId, String ip, DateTime at,
      {required bool success, bool blocked = false}) async {
    // Une tentative refusée pendant la suspension n'est que journalisée :
    // elle ne prolonge pas la suspension.
    if (!blocked) {
      await store.query(store.db, '''
        INSERT INTO join_attempts (manager_id, company_id, ip, success, at)
        VALUES (@m::uuid, @c::uuid, @ip, @ok, @at)''',
          {'m': manager.id, 'c': companyId, 'ip': ip, 'ok': success, 'at': at});
    }
    await store.audit(
        companyId: companyId,
        actorId: manager.id,
        action: blocked ? 'join.blocked' : (success ? 'join.code_ok' : 'join.code_bad'),
        details: {'ip': ip});
  }
}
