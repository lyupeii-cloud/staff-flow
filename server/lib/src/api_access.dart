import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'planning_service.dart' show formatDay, parseDay;
import 'store.dart';
import 'tools_service.dart';

/// Accès par clé API (option payante) : un logiciel de comptabilité, de paie
/// ou un CRM lit le planning publié de l'entreprise, ses heures et ses
/// absences. Lecture seule. Le propriétaire crée et révoque les clés ; la
/// clé complète n'est montrée qu'une fois (seule son empreinte est gardée).
class ApiAccessService {
  final Store store;
  final CompanyService companies;
  final ToolsService tools;
  final DateTime Function() now;

  ApiAccessService(this.store, this.companies, this.tools, {required this.now});

  static final _random = Random.secure();
  static const _alphabet = 'abcdefghijklmnopqrstuvwxyz0123456789';
  static String _token(int n) => List.generate(n, (_) => _alphabet[_random.nextInt(_alphabet.length)]).join();
  static String _hash(String secret) => sha256.convert(utf8.encode(secret)).toString();

  /// Lecture ouverte : pendant l'essai, entreprise offerte, option « accès
  /// API » ou « API Pro » payée (coupées pendant la période de grâce).
  static bool allowed(Company c) =>
      c.billingStatus == 'trial' ||
      c.billingStatus == 'comped' ||
      ((c.apiOption || c.apiProOption) && c.billingStatus == 'active');

  /// Écriture (« API Pro ») : toujours payée, de bout en bout. Seulement avec
  /// un abonnement payé et l'option ; jamais incluse (ni essai, ni entreprise
  /// offerte, ni grande entreprise), coupée pendant la période de grâce.
  static bool proAllowed(Company c) => c.apiProOption && c.billingStatus == 'active';

  /// Droits possibles d'une clé.
  static const readScope = 'read';
  static const writeScopes = {'shifts', 'publish', 'members', 'catalog', 'news', 'requests'};

  /// Le patron et les responsables qui gèrent l'abonnement gèrent les clés.
  Future<Company> owned(User actor, String companyId) async {
    final (company, _) = await companies.open(actor, companyId);
    if (!await _billingAccess(companyId, actor.id)) throw const ApiError.forbidden();
    return company;
  }

  Future<bool> _billingAccess(String companyId, String userId) async => (await store.query(store.db, '''
      SELECT 1 FROM memberships WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL
        AND (role = 'owner' OR (role = 'manager' AND billing_access))''', {'c': companyId, 'u': userId})).isNotEmpty;

  Future<List<Map<String, Object?>>> list(User actor, String companyId) async {
    await owned(actor, companyId);
    final rows = await store.query(store.db, '''
      SELECT id::text, name, prefix, created_at, last_used_at, scopes FROM api_keys
      WHERE company_id = @c::uuid AND revoked_at IS NULL ORDER BY created_at''', {'c': companyId});
    return [
      for (final r in rows)
        {
          'id': r[0],
          'name': r[1],
          'prefix': 'sfk_${r[2]}',
          'createdAt': (r[3] as DateTime).toIso8601String(),
          'lastUsedAt': (r[4] as DateTime?)?.toIso8601String(),
          'scopes': r[5],
        },
    ];
  }

  /// Nouvelle clé : renvoyée en entier une seule fois.
  Future<Map<String, Object?>> create(User actor, String companyId, String name, {List<String> scopes = const ['read']}) async {
    final company = await owned(actor, companyId);
    final clean0 = {...scopes};
    if (clean0.isEmpty || clean0.any((s) => s != readScope && !writeScopes.contains(s))) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    if (clean0.any(writeScopes.contains)) {
      if (!proAllowed(company)) {
        throw const ApiError(402, 'option_required', 'Option « API Pro » nécessaire pour les droits d\'écriture.');
      }
    } else if (!allowed(company)) {
      throw const ApiError(402, 'option_required', 'Option « accès API » nécessaire pour créer une clé.');
    }
    final clean = name.trim();
    if (clean.isEmpty || clean.length > 60) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final count = await store.query(store.db,
        'SELECT count(*) FROM api_keys WHERE company_id = @c::uuid AND revoked_at IS NULL', {'c': companyId});
    if ((count.first[0] as num) >= 10) throw const ApiError.conflict('10 clés au plus par entreprise.');
    final prefix = _token(8), secret = _token(32);
    await store.query(store.db, '''
      INSERT INTO api_keys (company_id, name, prefix, key_hash, created_by, scopes)
      VALUES (@c::uuid, @n, @p, @h, @u::uuid, @s)''',
        {'c': companyId, 'n': clean, 'p': prefix, 'h': _hash(secret), 'u': actor.id, 's': clean0.toList()});
    await store.audit(companyId: companyId, actorId: actor.id, action: 'api.key_created', details: {'name': clean, 'prefix': prefix});
    return {'key': 'sfk_${prefix}_$secret', 'prefix': 'sfk_$prefix', 'name': clean, 'scopes': clean0.toList()};
  }

  /// Nom et droits modifiés, même clé : rien à changer dans les logiciels.
  /// Ajouter un droit d'écriture demande l'option « API Pro » ; en retirer
  /// est toujours possible.
  Future<Map<String, Object?>> update(User actor, String companyId, String keyId, {String? name, List<String>? scopes}) async {
    final company = await owned(actor, companyId);
    final rows = await store.query(store.db, '''
      SELECT name, scopes FROM api_keys WHERE id::text = @k AND company_id = @c::uuid AND revoked_at IS NULL''',
        {'k': keyId, 'c': companyId});
    if (rows.isEmpty) throw const ApiError.notFound();
    final before = (rows.first[1] as List).cast<String>().toSet();
    final after = scopes == null ? before : {...scopes};
    if (after.isEmpty || after.any((s) => s != readScope && !writeScopes.contains(s))) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    if (after.difference(before).any(writeScopes.contains) && !proAllowed(company)) {
      throw const ApiError(402, 'option_required', 'Option « API Pro » nécessaire pour les droits d\'écriture.');
    }
    final clean = (name ?? rows.first[0] as String).trim();
    if (clean.isEmpty || clean.length > 60) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final list = [for (final s in [readScope, ...writeScopes]) if (after.contains(s)) s];
    await store.query(store.db, 'UPDATE api_keys SET name = @n, scopes = @s WHERE id::text = @k',
        {'k': keyId, 'n': clean, 's': list});
    await store.audit(companyId: companyId, actorId: actor.id, action: 'api.key_updated', details: {
      'name': clean,
      'added': [for (final s in list) if (!before.contains(s)) s],
      'removed': [for (final s in before) if (!after.contains(s)) s],
    });
    return {'id': keyId, 'name': clean, 'scopes': list};
  }

  Future<void> revoke(User actor, String companyId, String keyId) async {
    await owned(actor, companyId);
    final rows = await store.query(store.db, '''
      UPDATE api_keys SET revoked_at = @t WHERE id = @k::uuid AND company_id = @c::uuid AND revoked_at IS NULL
      RETURNING prefix''', {'k': keyId, 'c': companyId, 't': now()});
    if (rows.isEmpty) throw const ApiError.notFound();
    await store.audit(companyId: companyId, actorId: actor.id, action: 'api.key_revoked', details: {'prefix': rows.first[0]});
  }

  /// Entreprise d'une clé (`sfk_<préfixe>_<secret>`), ou 401 / 402.
  Future<Company> authenticate(String? header) async => (await key(header)).company;

  /// Clé valide : entreprise, nom, droits et personne au nom de qui elle agit.
  Future<ApiKey> key(String? header) async {
    final key = header == null
        ? null
        : header.startsWith('Bearer ')
            ? header.substring(7).trim()
            : header.trim();
    final m = RegExp(r'^sfk_([a-z0-9]{8})_([a-z0-9]{32})$').firstMatch(key ?? '');
    if (m == null) throw const ApiError.unauthorized('Clé API invalide.');
    final rows = await store.query(store.db, '''
      SELECT company_id::text, key_hash, name, scopes, created_by::text FROM api_keys
      WHERE prefix = @p AND revoked_at IS NULL''', {'p': m[1]});
    if (rows.isEmpty || rows.first[1] != _hash(m[2]!)) throw const ApiError.unauthorized('Clé API invalide.');
    final company = await store.findCompany(rows.first[0] as String);
    if (company == null) throw const ApiError.unauthorized('Clé API invalide.');
    if (!allowed(company)) {
      throw const ApiError(402, 'option_required', 'Option « accès API » nécessaire pour créer une clé.');
    }
    await store.query(store.db, 'UPDATE api_keys SET last_used_at = @t WHERE prefix = @p', {'p': m[1], 't': now()});
    return ApiKey(company, rows.first[2] as String, {...(rows.first[3] as List).cast<String>()}, rows.first[4] as String?);
  }

  /// Personne au nom de qui une clé d'écriture agit : son créateur s'il
  /// gère encore toute l'entreprise, sinon le patron. Vérifie le droit
  /// [scope] et l'option « API Pro ».
  Future<User> actorFor(ApiKey k, String scope) async {
    if (!k.scopes.contains(scope)) {
      throw ApiError(403, 'scope_missing', 'Cette clé n\'a pas le droit « {scope} ».', {'scope': scope});
    }
    if (!proAllowed(k.company)) {
      throw const ApiError(402, 'option_required', 'Option « API Pro » nécessaire pour les droits d\'écriture.');
    }
    if (k.createdBy != null) {
      final u = await store.findActiveUser(k.createdBy!);
      if (u != null && await _billingAccess(k.company.id, u.id)) return u;
    }
    final owner = await store.query(store.db, '''
      SELECT user_id::text FROM memberships WHERE company_id = @c::uuid AND role = 'owner' AND left_at IS NULL''',
        {'c': k.company.id});
    return (await store.findActiveUser(owner.first[0] as String))!;
  }

  /// Personne désignée par son identifiant SF, son matricule ou son id interne.
  Future<String?> person(String companyId, Object? ref) async {
    if (ref == null) return null;
    if (ref is! String || ref.trim().isEmpty) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final rows = await store.query(store.db, '''
      SELECT u.id::text FROM memberships m JOIN users u ON u.id = m.user_id
      WHERE m.company_id = @c::uuid AND m.left_at IS NULL
        AND (upper(u.public_id) = upper(@r) OR lower(m.employee_number) = lower(@r) OR u.id::text = @r)''',
        {'c': companyId, 'r': ref.trim()});
    if (rows.isEmpty) throw ApiError.badRequest('Personne inconnue : {ref}.', {'ref': ref});
    return rows.first[0] as String;
  }

  /// Site ou poste désigné par son id ou son nom ; [create] : créé s'il manque.
  Future<String?> catalogItem(String companyId, String table, Object? ref, {bool create = false}) async {
    if (ref == null) return null;
    if (ref is! String || ref.trim().isEmpty) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final rows = await store.query(store.db, '''
      SELECT id::text FROM $table WHERE company_id = @c::uuid AND archived_at IS NULL
        AND (id::text = @r OR lower(name) = lower(@r)) LIMIT 1''', {'c': companyId, 'r': ref.trim()});
    if (rows.isNotEmpty) return rows.first[0] as String;
    if (!create) throw ApiError.badRequest('Site ou poste inconnu : {ref}.', {'ref': ref});
    final made = await store.query(store.db, 'INSERT INTO $table (company_id, name) VALUES (@c::uuid, @n) RETURNING id::text',
        {'c': companyId, 'n': ref.trim()});
    return made.first[0] as String;
  }

  // --- Lecture (planning publié) ------------------------------------------------

  /// Période demandée : par défaut depuis la création de l'entreprise
  /// jusqu'à aujourd'hui ; 5 ans au plus par appel.
  (DateTime, DateTime) period(Company c, Map<String, String> q) {
    final to = q['to'] == null ? DateTime.utc(now().year, now().month, now().day) : _day(q['to']!);
    final created = DateTime.utc(c.createdAt.year, c.createdAt.month, c.createdAt.day);
    final from = q['from'] == null ? (created.isAfter(to) ? to : created) : _day(q['from']!);
    if (to.isBefore(from) || to.difference(from).inDays > 1830) {
      throw const ApiError.badRequest('Période invalide (5 ans au plus).');
    }
    return (from, to);
  }

  static DateTime _day(String s) => parseDay(s);

  Future<Map<String, Object?>> company(Company c) async {
    Future<List<Map<String, Object?>>> catalog(String table) async => [
          for (final r in await store.query(store.db, 'SELECT id::text, name, archived_at IS NOT NULL FROM $table WHERE company_id = @c::uuid ORDER BY name',
              {'c': c.id}))
            {'id': r[0], 'name': r[1], 'archived': r[2]},
        ];
    return {
      'id': c.publicId,
      'name': c.name,
      'timezone': c.timezone,
      'createdAt': c.createdAt.toIso8601String(),
      'sites': await catalog('sites'),
      'positions': await catalog('positions'),
    };
  }

  Future<List<Map<String, Object?>>> members(Company c) async {
    final rows = await store.query(store.db, '''
      SELECT u.id::text, u.public_id, coalesce(m.display_name, u.custom_name, u.name), m.role, m.joined_at, m.left_at
      FROM memberships m JOIN users u ON u.id = m.user_id
      WHERE m.company_id = @c::uuid ORDER BY m.joined_at''', {'c': c.id});
    return [
      for (final r in rows)
        {
          'id': r[0],
          'publicId': r[1],
          'name': r[2],
          'role': r[3],
          'joinedAt': (r[4] as DateTime).toIso8601String(),
          'leftAt': (r[5] as DateTime?)?.toIso8601String(),
        },
    ];
  }

  Future<List<Map<String, Object?>>> shifts(Company c, DateTime from, DateTime to) =>
      tools.publishedForApi(c.id, from, to);

  Future<List<Map<String, Object?>>> totals(Company c, DateTime from, DateTime to) => tools.totalsForApi(c.id, from, to);

  /// Congés et indisponibilités validés qui touchent la période.
  Future<List<Map<String, Object?>>> absences(Company c, DateTime from, DateTime to) async {
    final rows = await store.query(store.db, '''
      SELECT r.id::text, r.kind, r.requester_id::text, r.start_day, r.end_day, r.weekdays
      FROM requests r WHERE r.company_id = @c::uuid AND r.status = 'approved' AND r.kind IN ('leave', 'unavailability')
        AND (r.start_day IS NULL OR r.start_day <= @to::date) AND (r.end_day IS NULL OR r.end_day >= @from::date)
      ORDER BY r.start_day NULLS FIRST''', {'c': c.id, 'from': formatDay(from), 'to': formatDay(to)});
    return [
      for (final r in rows)
        {
          'id': r[0],
          'kind': r[1],
          'userId': r[2],
          'from': r[3] == null ? null : formatDay(r[3] as DateTime),
          'to': r[4] == null ? null : formatDay(r[4] as DateTime),
          'weekdays': r[5],
        },
    ];
  }

  /// CSV (séparateur « ; », pour Excel) d'une liste d'objets.
  static String csv(List<Map<String, Object?>> rows) {
    if (rows.isEmpty) return '';
    final keys = rows.first.keys.toList();
    String cell(Object? v) {
      final s = v == null ? '' : (v is List ? v.join(',') : '$v');
      return s.contains(RegExp(r'[;"\n]')) ? '"${s.replaceAll('"', '""')}"' : s;
    }

    return '﻿${[keys.join(';'), for (final r in rows) [for (final k in keys) cell(r[k])].join(';')].join('\r\n')}\r\n';
  }
}

/// Clé API authentifiée.
class ApiKey {
  final Company company;
  final String name;
  final Set<String> scopes;
  final String? createdBy;

  const ApiKey(this.company, this.name, this.scopes, this.createdBy);
}
