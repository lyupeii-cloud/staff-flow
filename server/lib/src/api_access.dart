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

  /// Option ouverte : pendant l'essai, entreprise offerte, ou option payée.
  static bool allowed(Company c) => c.billingStatus == 'trial' || c.billingStatus == 'comped' || c.apiOption;

  Future<Company> _owned(User actor, String companyId) async {
    final (company, role) = await companies.open(actor, companyId);
    if (role != Role.owner) throw const ApiError.forbidden();
    return company;
  }

  Future<List<Map<String, Object?>>> list(User actor, String companyId) async {
    await _owned(actor, companyId);
    final rows = await store.query(store.db, '''
      SELECT id::text, name, prefix, created_at, last_used_at FROM api_keys
      WHERE company_id = @c::uuid AND revoked_at IS NULL ORDER BY created_at''', {'c': companyId});
    return [
      for (final r in rows)
        {
          'id': r[0],
          'name': r[1],
          'prefix': 'sfk_${r[2]}',
          'createdAt': (r[3] as DateTime).toIso8601String(),
          'lastUsedAt': (r[4] as DateTime?)?.toIso8601String(),
        },
    ];
  }

  /// Nouvelle clé : renvoyée en entier une seule fois.
  Future<Map<String, Object?>> create(User actor, String companyId, String name) async {
    final company = await _owned(actor, companyId);
    if (!allowed(company)) {
      throw const ApiError(402, 'option_required', 'Option « accès API » nécessaire pour créer une clé.');
    }
    final clean = name.trim();
    if (clean.isEmpty || clean.length > 60) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final count = await store.query(store.db,
        'SELECT count(*) FROM api_keys WHERE company_id = @c::uuid AND revoked_at IS NULL', {'c': companyId});
    if ((count.first[0] as num) >= 10) throw const ApiError.conflict('10 clés au plus par entreprise.');
    final prefix = _token(8), secret = _token(32);
    await store.query(store.db, '''
      INSERT INTO api_keys (company_id, name, prefix, key_hash, created_by)
      VALUES (@c::uuid, @n, @p, @h, @u::uuid)''',
        {'c': companyId, 'n': clean, 'p': prefix, 'h': _hash(secret), 'u': actor.id});
    await store.audit(companyId: companyId, actorId: actor.id, action: 'api.key_created', details: {'name': clean, 'prefix': prefix});
    return {'key': 'sfk_${prefix}_$secret', 'prefix': 'sfk_$prefix', 'name': clean};
  }

  Future<void> revoke(User actor, String companyId, String keyId) async {
    await _owned(actor, companyId);
    final rows = await store.query(store.db, '''
      UPDATE api_keys SET revoked_at = @t WHERE id = @k::uuid AND company_id = @c::uuid AND revoked_at IS NULL
      RETURNING prefix''', {'k': keyId, 'c': companyId, 't': now()});
    if (rows.isEmpty) throw const ApiError.notFound();
    await store.audit(companyId: companyId, actorId: actor.id, action: 'api.key_revoked', details: {'prefix': rows.first[0]});
  }

  /// Entreprise d'une clé (`sfk_<préfixe>_<secret>`), ou 401 / 402.
  Future<Company> authenticate(String? header) async {
    final key = header == null
        ? null
        : header.startsWith('Bearer ')
            ? header.substring(7).trim()
            : header.trim();
    final m = RegExp(r'^sfk_([a-z0-9]{8})_([a-z0-9]{32})$').firstMatch(key ?? '');
    if (m == null) throw const ApiError.unauthorized('Clé API invalide.');
    final rows = await store.query(store.db, '''
      SELECT company_id::text, key_hash FROM api_keys WHERE prefix = @p AND revoked_at IS NULL''', {'p': m[1]});
    if (rows.isEmpty || rows.first[1] != _hash(m[2]!)) throw const ApiError.unauthorized('Clé API invalide.');
    final company = await store.findCompany(rows.first[0] as String);
    if (company == null) throw const ApiError.unauthorized('Clé API invalide.');
    if (!allowed(company)) {
      throw const ApiError(402, 'option_required', 'Option « accès API » nécessaire pour créer une clé.');
    }
    await store.query(store.db, 'UPDATE api_keys SET last_used_at = @t WHERE prefix = @p', {'p': m[1], 't': now()});
    return company;
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
