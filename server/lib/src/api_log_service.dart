import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import 'api_access.dart';
import 'errors.dart';
import 'models.dart';
import 'notifications.dart';
import 'platform_service.dart';
import 'store.dart';

/// Ce qu'un appel par clé API a fait, rempli par la route pendant l'appel.
class ApiLog {
  ApiKey? key;
  String? action;
  final Map<String, Object?> details = {};

  static ApiLog? of(Request r) => r.context['apiLog'] as ApiLog?;

  /// Remplit [action] et [details] (sans effet hors d'un appel journalisé).
  static void note(Request r, String action, [Map<String, Object?> details = const {}]) {
    final log = of(r);
    if (log == null) return;
    log.action = action;
    log.details.addAll(details);
  }
}

/// Journaux des clés API : chaque appel (lecture, écriture, assistant MCP)
/// et chaque envoi de webhook. Les mois récents restent en base ; les plus
/// anciens sont archivés compressés, puis supprimés après quelques années.
/// Lus par le patron et les responsables qui gèrent l'abonnement.
class ApiLogService {
  final Store store;
  final ApiAccessService access;
  final NotificationService notifications;
  final PlatformService platform;
  final String _key;
  final DateTime Function() now;

  ApiLogService(this.store, this.access, this.notifications, this.platform, this._key, {required this.now});

  static const pageSize = 50;

  /// Échecs d'une clé en une heure avant d'alerter le patron.
  static const failureAlert = 10;

  // --- Enregistrement ---------------------------------------------------------

  /// Un appel par clé API, après sa réponse.
  Future<void> capture(Request req, ApiLog log, String kind, int status, Object? error, Duration took,
      {required String ip}) async {
    try {
      final key = log.key ?? await access.peek(req.headers['authorization'] ?? req.headers['x-api-key']);
      if (key == null) return; // Clé inconnue : rien à rattacher à une entreprise.
      final query = req.url.query.isEmpty ? '' : '?${req.url.query}';
      await record(
        companyId: key.company.id,
        keyId: key.id,
        keyName: key.name,
        keyPrefix: key.prefix,
        source: req.context['mcp'] == true ? 'mcp' : 'api',
        kind: kind,
        method: req.method,
        path: '/${req.url.path}$query',
        action: log.action ?? '${req.method.toLowerCase()} /${req.url.path}',
        details: log.details,
        status: status,
        error: error is ApiError ? error : null,
        took: took,
        ip: ip,
      );
    } catch (e) {
      print('Journaux API : $e');
    }
  }

  Future<void> record({
    required String companyId,
    String? keyId,
    String? keyName,
    String? keyPrefix,
    required String source,
    required String kind,
    String? method,
    String? path,
    required String action,
    Map<String, Object?> details = const {},
    required int status,
    ApiError? error,
    String? errorText,
    required Duration took,
    String? ip,
  }) async {
    final ok = status < 400;
    final search = [keyName, keyPrefix, action, path, ip, error?.code, error?.message, errorText, ..._words(details)]
        .whereType<String>()
        .join(' ')
        .toLowerCase();
    await store.query(store.db, '''
      INSERT INTO api_logs (company_id, at, key_id, key_name, key_prefix, source, kind, method, path, action, details,
        status, ok, error, duration_ms, ip, search)
      VALUES (@c::uuid, @at, @k::uuid, @kn, @kp, @src, @kind, @m, @p, @a, @d::jsonb, @st, @ok, @e::jsonb, @ms, @ip, @s)''', {
      'c': companyId,
      'at': now(),
      'k': keyId,
      'kn': keyName,
      'kp': keyPrefix,
      'src': source,
      'kind': kind,
      'm': method,
      'p': path,
      'a': action,
      'd': jsonEncode(details),
      'st': status,
      'ok': ok,
      'e': error != null
          ? jsonEncode({'code': error.code, 'message': error.message, 'args': error.args})
          : errorText != null
              ? jsonEncode({'text': errorText})
              : null,
      'ms': took.inMilliseconds,
      'ip': ip,
      's': search,
    });
    if (keyId == null) return;
    if (!ok) await _failures(companyId, keyId, keyName ?? '');
    if (ip != null && source == 'api') await _newIp(companyId, keyId, keyName ?? '', ip);
  }

  static Iterable<String> _words(Object? v) sync* {
    if (v is String) {
      yield v;
    } else if (v is num || v is bool) {
      yield '$v';
    } else if (v is Map) {
      for (final x in v.values) {
        yield* _words(x);
      }
    } else if (v is List) {
      for (final x in v) {
        yield* _words(x);
      }
    }
  }

  /// Trop d'échecs en une heure : le patron est prévenu (une fois par jour).
  Future<void> _failures(String companyId, String keyId, String keyName) async {
    final t = now();
    final count = await store.query(store.db, '''
      SELECT count(*) FROM api_logs WHERE key_id = @k::uuid AND NOT ok AND at > @since''',
        {'k': keyId, 'since': t.subtract(const Duration(hours: 1))});
    if ((count.first[0] as int) < failureAlert) return;
    final claimed = await store.query(store.db, '''
      UPDATE api_keys SET failing_alert_at = @t WHERE id = @k::uuid
        AND (failing_alert_at IS NULL OR failing_alert_at < @day) RETURNING id''',
        {'k': keyId, 't': t, 'day': t.subtract(const Duration(days: 1))});
    if (claimed.isEmpty) return;
    await notifications.notify(await _managers(companyId),
        companyId: companyId, kind: 'api_failing', data: {'key': keyName, 'count': count.first[0]});
  }

  /// Clé utilisée depuis une nouvelle adresse IP (signe possible d'une clé
  /// volée) : le patron est prévenu, une fois par jour au plus. La toute
  /// première adresse n'alerte pas.
  Future<void> _newIp(String companyId, String keyId, String keyName, String ip) async {
    final added = await store.query(store.db, '''
      INSERT INTO api_key_ips (key_id, ip, first_at) VALUES (@k::uuid, @ip, @t)
      ON CONFLICT DO NOTHING RETURNING ip''', {'k': keyId, 'ip': ip, 't': now()});
    if (added.isEmpty) return;
    final known = await store.query(store.db, 'SELECT count(*) FROM api_key_ips WHERE key_id = @k::uuid', {'k': keyId});
    if ((known.first[0] as int) < 2) return;
    final t = now();
    final claimed = await store.query(store.db, '''
      UPDATE api_keys SET new_ip_alert_at = @t WHERE id = @k::uuid
        AND (new_ip_alert_at IS NULL OR new_ip_alert_at < @day) RETURNING id''',
        {'k': keyId, 't': t, 'day': t.subtract(const Duration(days: 1))});
    if (claimed.isEmpty) return;
    await notifications.notify(await _managers(companyId),
        companyId: companyId, kind: 'api_new_ip', data: {'key': keyName, 'ip': ip});
  }

  Future<List<String>> _managers(String companyId) async => [
        for (final r in await store.query(store.db, '''
          SELECT user_id::text FROM memberships WHERE company_id = @c::uuid AND left_at IS NULL
            AND (role = 'owner' OR (role = 'manager' AND billing_access))''', {'c': companyId}))
          r[0] as String
      ];

  // --- Compteurs par clé --------------------------------------------------------

  /// Appels du jour et du mois, dernier échec.
  Future<Map<String, Map<String, Object?>>> keyStats(Company company) async {
    final rows = await store.query(store.db, '''
      SELECT key_id::text,
        count(*) FILTER (WHERE (at AT TIME ZONE @tz)::date = (@t::timestamptz AT TIME ZONE @tz)::date),
        count(*),
        max(at) FILTER (WHERE NOT ok)
      FROM api_logs WHERE company_id = @c::uuid AND key_id IS NOT NULL
        AND date_trunc('month', at AT TIME ZONE @tz) = date_trunc('month', @t::timestamptz AT TIME ZONE @tz)
      GROUP BY key_id''', {'c': company.id, 'tz': company.timezone, 't': now()});
    final out = {
      for (final r in rows)
        r[0] as String: {
          'today': r[1],
          'month': r[2],
          'lastFailureAt': (r[3] as DateTime?)?.toUtc().toIso8601String(),
        }
    };
    // Dernier échec, même d'un mois précédent.
    for (final r in await store.query(store.db, '''
      SELECT DISTINCT ON (key_id) key_id::text, at, error FROM api_logs
      WHERE company_id = @c::uuid AND key_id IS NOT NULL AND NOT ok ORDER BY key_id, at DESC''', {'c': company.id})) {
      final s = out.putIfAbsent(r[0] as String, () => {'today': 0, 'month': 0});
      s['lastFailureAt'] = (r[1] as DateTime).toUtc().toIso8601String();
    }
    return out;
  }

  // --- Lecture ----------------------------------------------------------------

  /// Mois disponibles (« 2026-10 »), les plus récents d'abord, avec leur
  /// nombre de lignes ; `archived` : mois archivé (compressé).
  Future<List<Map<String, Object?>>> months(User actor, String companyId) async {
    final company = await access.owned(actor, companyId);
    final live = await store.query(store.db, '''
      SELECT to_char(date_trunc('month', at AT TIME ZONE @tz), 'YYYY-MM') m, count(*) FROM api_logs
      WHERE company_id = @c::uuid GROUP BY 1''', {'c': companyId, 'tz': company.timezone});
    final archived = await store.query(store.db, '''
      SELECT to_char(month, 'YYYY-MM'), count FROM api_log_archives WHERE company_id = @c::uuid''', {'c': companyId});
    final all = <String, Map<String, Object?>>{};
    for (final r in archived) {
      all[r[0] as String] = {'month': r[0], 'count': r[1], 'archived': true};
    }
    for (final r in live) {
      final m = all[r[0] as String];
      all[r[0] as String] = {'month': r[0], 'count': (r[1] as int) + ((m?['count'] as int?) ?? 0), 'archived': false};
    }
    final current = (await store.query(store.db, "SELECT to_char(@t::timestamptz AT TIME ZONE @tz, 'YYYY-MM')",
            {'t': now(), 'tz': company.timezone}))
        .first[0] as String;
    all.putIfAbsent(current, () => {'month': current, 'count': 0, 'archived': false});
    return all.values.toList()..sort((a, b) => (b['month'] as String).compareTo(a['month'] as String));
  }

  /// Lignes d'un mois ([month] « AAAA-MM »), ou, sans mois, une recherche dans
  /// tout l'historique (archives comprises). Filtres : [q] (texte), [keyId],
  /// [source] (api, mcp, webhook), [kind] (read, write, webhook), [result]
  /// (ok, error). [before] : id de la dernière ligne déjà affichée.
  Future<Map<String, Object?>> list(User actor, String companyId,
      {String? month, String? q, String? keyId, String? source, String? kind, String? result, int? before, String lang = 'fr'}) async {
    final company = await access.owned(actor, companyId);
    if (month != null && !RegExp(r'^\d{4}-\d{2}$').hasMatch(month)) throw const ApiError.badRequest('Mois invalide.');
    final filters = _Filters(q, keyId, source, kind, result);
    final out = <Map<String, Object?>>[];
    // Mois demandé (ou tous), du plus récent au plus ancien.
    final wanted = month == null ? [for (final m in await months(actor, companyId)) m['month'] as String] : [month];
    for (final m in wanted) {
      if (out.length >= pageSize) break;
      // En base…
      final rows = await store.query(store.db, '''
        SELECT ${_columns.join(', ')} FROM api_logs
        WHERE company_id = @c::uuid AND to_char(date_trunc('month', at AT TIME ZONE @tz), 'YYYY-MM') = @m
          AND (@before::bigint IS NULL OR id < @before::bigint)
          AND (@q::text IS NULL OR search LIKE @q::text)
          AND (@k::text IS NULL OR key_id::text = @k::text)
          AND (@src::text IS NULL OR source = @src::text)
          AND (@kind::text IS NULL OR kind = @kind::text)
          AND (@res::text IS NULL OR ok = (@res::text = 'ok'))
        ORDER BY id DESC LIMIT @n''', {
        'c': companyId,
        'tz': company.timezone,
        'm': m,
        'before': before,
        'q': filters.like,
        'k': keyId,
        'src': source,
        'kind': kind,
        'res': result,
        'n': pageSize - out.length,
      });
      out.addAll([for (final r in rows) _row(_fromColumns(r.toColumnMap()), lang)]);
      // … puis dans l'archive du mois.
      if (out.length < pageSize) {
        for (final e in await _archive(companyId, m)) {
          if (out.length >= pageSize) break;
          if (before != null && (e['id'] as int) >= before) continue;
          if (filters.match(e)) out.add(_row(e, lang));
        }
      }
    }
    return {'logs': out, 'more': out.length >= pageSize};
  }

  static const _columns = [
    'id', 'at', 'key_id::text AS key_id', 'key_name', 'key_prefix', 'source', 'kind', 'method', 'path', 'action',
    'details', 'status', 'ok', 'error', 'duration_ms', 'ip', 'search' //
  ];

  /// Ligne telle que gardée en archive (JSON).
  static Map<String, Object?> _fromColumns(Map<String, dynamic> r) => {
        'id': r['id'],
        'at': (r['at'] as DateTime).toUtc().toIso8601String(),
        'keyId': r['key_id'],
        'keyName': r['key_name'],
        'keyPrefix': r['key_prefix'],
        'source': r['source'],
        'kind': r['kind'],
        'method': r['method'],
        'path': r['path'],
        'action': r['action'],
        'details': r['details'],
        'status': r['status'],
        'ok': r['ok'],
        'error': r['error'],
        'durationMs': r['duration_ms'],
        'ip': r['ip'],
        'search': r['search'],
      };

  /// Ligne envoyée à l'appli : message d'erreur dans sa langue.
  static Map<String, Object?> _row(Map<String, Object?> e, String lang) {
    final err = e['error'] as Map?;
    String? message;
    if (err != null) {
      message = err['text'] as String? ??
          ApiError(e['status'] as int? ?? 400, err['code'] as String? ?? 'error', err['message'] as String? ?? '',
                  (err['args'] as Map?)?.cast<String, String>() ?? const {})
              .localized(lang);
    }
    return {
      for (final k in e.keys)
        if (k != 'search' && k != 'error') k: e[k],
      'errorCode': err?['code'],
      'error': message,
    };
  }

  // --- Archives ---------------------------------------------------------------

  Future<List<Map<String, Object?>>> _archive(String companyId, String month) async {
    final rows = await store.query(store.db, '''
      SELECT data FROM api_log_archives WHERE company_id = @c::uuid AND to_char(month, 'YYYY-MM') = @m''',
        {'c': companyId, 'm': month});
    if (rows.isEmpty) return const [];
    return _decode(rows.first[0] as List<int>);
  }

  static List<Map<String, Object?>> _decode(List<int> data) {
    final lines = utf8.decode(GZipDecoder().decodeBytes(data)).split('\n').where((l) => l.isNotEmpty);
    // Les plus récentes d'abord.
    return [for (final l in lines) (jsonDecode(l) as Map).cast<String, Object?>()]
      ..sort((a, b) => (b['id'] as int).compareTo(a['id'] as int));
  }

  static Uint8List _encode(List<Map<String, Object?>> rows) =>
      Uint8List.fromList(GZipEncoder().encode(utf8.encode(rows.map(jsonEncode).join('\n')))!);

  /// Archive les mois plus anciens que la durée en base, supprime ce qui
  /// dépasse la durée de conservation (appelé avec les autres échéances).
  Future<void> archive() async {
    final live = await platform.value('apiLogLiveMonths');
    final years = await platform.value('apiLogYears');
    final t = now();
    final due = await store.query(store.db, '''
      SELECT DISTINCT l.company_id::text, to_char(date_trunc('month', l.at AT TIME ZONE c.timezone), 'YYYY-MM')
      FROM api_logs l JOIN companies c ON c.id = l.company_id
      WHERE date_trunc('month', l.at AT TIME ZONE c.timezone)
        < date_trunc('month', @t::timestamptz AT TIME ZONE c.timezone) - make_interval(months => @live)''',
        {'t': t, 'live': live});
    for (final d in due) {
      final companyId = d[0] as String, month = d[1] as String;
      await store.db.runTx((tx) async {
        final rows = await store.query(tx, '''
          SELECT ${_columns.join(', ')} FROM api_logs WHERE id IN (
            SELECT l.id FROM api_logs l JOIN companies c ON c.id = l.company_id
            WHERE l.company_id = @c::uuid AND to_char(date_trunc('month', l.at AT TIME ZONE c.timezone), 'YYYY-MM') = @m)
          FOR UPDATE''', {'c': companyId, 'm': month});
        final entries = [for (final r in rows) _fromColumns(r.toColumnMap())];
        final old = await store.query(tx, '''
          SELECT data FROM api_log_archives WHERE company_id = @c::uuid AND to_char(month, 'YYYY-MM') = @m''',
            {'c': companyId, 'm': month});
        if (old.isNotEmpty) entries.addAll(_decode(old.first[0] as List<int>));
        await store.query(tx, '''
          INSERT INTO api_log_archives (company_id, month, count, data) VALUES (@c::uuid, @m::date, @n, @d::bytea)
          ON CONFLICT (company_id, month) DO UPDATE SET count = excluded.count, data = excluded.data''',
            {'c': companyId, 'm': '$month-01', 'n': entries.length, 'd': _encode(entries)});
        await store.query(tx, '''
          DELETE FROM api_logs l USING companies c WHERE c.id = l.company_id AND l.company_id = @c::uuid
            AND to_char(date_trunc('month', l.at AT TIME ZONE c.timezone), 'YYYY-MM') = @m''', {'c': companyId, 'm': month});
      });
    }
    // Conservation : au-delà de [years] ans, plus rien.
    await store.query(store.db, '''
      DELETE FROM api_log_archives WHERE month < date_trunc('month', @t::timestamptz) - make_interval(years => @y)''',
        {'t': t, 'y': years});
    await store.query(store.db, 'DELETE FROM api_logs WHERE at < @t::timestamptz - make_interval(years => @y)',
        {'t': t, 'y': years});
  }

  // --- Export d'une année (ZIP de fichiers CSV) -------------------------------

  Future<String> exportLink(User actor, String companyId, int year, String lang) async {
    await access.owned(actor, companyId);
    if (year < 2000 || year > 3000) throw const ApiError.badRequest('Année invalide.');
    return JWT({'c': companyId, 'y': year, 'l': lang}, subject: actor.id, issuer: 'staff-flow-api-logs')
        .sign(SecretKey(_key), expiresIn: const Duration(minutes: 10));
  }

  /// ZIP d'une année : un fichier CSV par mois, ouvrable dans Excel.
  Future<(String, List<int>)> export(String token) async {
    final JWT jwt;
    try {
      jwt = JWT.verify(token, SecretKey(_key), issuer: 'staff-flow-api-logs');
    } on JWTException {
      throw const ApiError.notFound('Lien expiré.');
    }
    final claims = jwt.payload as Map<String, dynamic>;
    final user = await store.findUser(jwt.subject!);
    if (user == null) throw const ApiError.notFound('Lien expiré.');
    final companyId = claims['c'] as String, year = claims['y'] as int, lang = claims['l'] as String? ?? 'en';
    final company = await access.owned(user, companyId);
    final zip = Archive();
    for (var m = 1; m <= 12; m++) {
      final month = '$year-${m.toString().padLeft(2, '0')}';
      final rows = <Map<String, Object?>>[];
      int? before;
      while (true) {
        final page = await list(user, companyId, month: month, before: before, lang: lang);
        final logs = (page['logs'] as List).cast<Map<String, Object?>>();
        rows.addAll(logs);
        if (page['more'] != true || logs.isEmpty) break;
        before = logs.last['id'] as int;
      }
      if (rows.isEmpty) continue;
      final csv = ApiAccessService.csv([
        for (final r in rows)
          {
            'date': r['at'],
            'key': r['keyName'],
            'prefix': r['keyPrefix'],
            'source': r['source'],
            'kind': r['kind'],
            'action': r['action'],
            'details': jsonEncode(r['details']),
            'status': r['status'],
            'error': r['error'],
            'duration_ms': r['durationMs'],
            'ip': r['ip'],
            'method': r['method'],
            'path': r['path'],
          }
      ]);
      final bytes = utf8.encode(csv);
      zip.addFile(ArchiveFile('$month.csv', bytes.length, bytes));
    }
    final name = 'staff-flow-api-${_slug(company.name)}-$year.zip';
    return (name, ZipEncoder().encode(zip)!);
  }

  static String _slug(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '').padRight(1, 'x');
}

class _Filters {
  final String? q, keyId, source, kind, result;

  _Filters(String? q, this.keyId, this.source, this.kind, this.result)
      : q = q == null || q.trim().isEmpty ? null : q.trim().toLowerCase();

  String? get like => q == null ? null : '%${q!.replaceAll('%', r'\%').replaceAll('_', r'\_')}%';

  bool match(Map<String, Object?> e) =>
      (q == null || '${e['search'] ?? ''}'.contains(q!)) &&
      (keyId == null || e['keyId'] == keyId) &&
      (source == null || e['source'] == source) &&
      (kind == null || e['kind'] == kind) &&
      (result == null || e['ok'] == (result == 'ok'));
}
