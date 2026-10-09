import 'dart:convert';
import 'dart:math';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:excel/excel.dart';

import 'company_service.dart';
import 'errors.dart';
import 'messages.dart';
import 'models.dart';
import 'planning_service.dart' show formatDay, parseDay;
import 'store.dart';

/// Outils du responsable (section 4) : alertes légales, totaux d'heures,
/// exports pour la paie, impression ; et l'agenda des services (section 5).
class ToolsService {
  final Store store;
  final CompanyService companies;
  final SecretKey _key;

  ToolsService(this.store, this.companies, String secret) : _key = SecretKey(secret);

  // --- Réglages ---------------------------------------------------------------

  /// Règles reconnues (en minutes, sauf les jours d'affilée).
  static const ruleKeys = {'maxDayMin', 'maxWeekMin', 'minRestMin', 'maxConsecutiveDays'};

  /// Garde les règles valides ; `null` ou vide : aucune alerte.
  static Map<String, int>? cleanRules(Object? value) {
    if (value == null) return null;
    if (value is! Map) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final out = <String, int>{};
    for (final e in value.entries) {
      if (!ruleKeys.contains(e.key)) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
      final v = e.value;
      if (v == null) continue;
      final max = e.key == 'maxConsecutiveDays' ? 31 : 10080;
      if (v is! int || v < 1 || v > max) throw const ApiError.badRequest('Valeur d\'alerte invalide.');
      out[e.key as String] = v;
    }
    return out.isEmpty ? null : out;
  }

  // --- Services de la période -------------------------------------------------

  /// Services de l'entreprise : version de travail (responsables) ou
  /// publiée (ce que voient les salariés et la paie).
  Future<List<_S>> _shifts(String companyId, DateTime from, DateTime to, {required bool published, String? userId}) async {
    final rows = await store.query(store.db, published
        ? '''
      SELECT s.id::text, (s.published->>'day')::date, (s.published->>'start')::int, (s.published->>'end')::int,
        s.published->>'userId', s.published->>'siteId', s.published->>'positionId', s.published->>'note'
      FROM shifts s WHERE s.company_id = @c::uuid AND s.published IS NOT NULL
        AND (s.published->>'day')::date BETWEEN @from::date AND @to::date
        AND (@u::text IS NULL OR s.published->>'userId' = @u::text)'''
        : '''
      SELECT s.id::text, s.day, s.start_min, s.end_min, s.user_id::text, s.site_id::text, s.position_id::text, s.note
      FROM shifts s WHERE s.company_id = @c::uuid AND NOT s.deleted
        AND s.day BETWEEN @from::date AND @to::date
        AND (@u::text IS NULL OR s.user_id::text = @u::text)''',
        {'c': companyId, 'from': formatDay(from), 'to': formatDay(to), 'u': userId});
    return [
      for (final r in rows)
        _S(r[0] as String, r[1] as DateTime, r[2] as int, r[3] as int, r[4] as String?, r[5] as String?,
            r[6] as String?, r[7] as String?),
    ]..sort((a, b) => a.startAbs.compareTo(b.startAbs));
  }

  static (DateTime, DateTime) _range(String from, String to, {int maxDays = 62}) {
    final a = parseDay(from), b = parseDay(to);
    if (b.isBefore(a) || b.difference(a).inDays > maxDays) throw const ApiError.badRequest('Dates invalides.');
    return (a, b);
  }

  // --- Alertes légales ----------------------------------------------------------

  /// Avertissements (jamais des blocages) sur la version de travail du
  /// planning, pour les jours de la période. Les règles se calculent avec
  /// les services autour de la période (repos, jours d'affilée, semaine).
  Future<List<Map<String, Object?>>> alerts(User actor, String companyId, String from, String to) async {
    final (company, role) = await companies.open(actor, companyId);
    if (!role.canManage) throw const ApiError.forbidden();
    final rules = company.legalRules;
    if (rules == null) return const [];
    final (a, b) = _range(from, to);
    final shifts = await _shifts(companyId, a.subtract(const Duration(days: 35)), b.add(const Duration(days: 7)),
        published: false);
    final out = <Map<String, Object?>>[];
    void add(String userId, DateTime day, String kind, int value, int limit, [String? shiftId]) {
      if (day.isBefore(a) || day.isAfter(b)) return;
      out.add({'userId': userId, 'day': formatDay(day), 'kind': kind, 'value': value, 'limit': limit, 'shiftId': shiftId});
    }

    final byUser = <String, List<_S>>{};
    for (final s in shifts) {
      if (s.userId != null) (byUser[s.userId!] ??= []).add(s);
    }
    for (final MapEntry(key: user, value: list) in byUser.entries) {
      // Durée par jour.
      final maxDay = rules['maxDayMin'];
      if (maxDay != null) {
        final perDay = <DateTime, int>{};
        for (final s in list) {
          perDay[s.day] = (perDay[s.day] ?? 0) + s.minutes;
        }
        perDay.forEach((day, m) {
          if (m > maxDay) add(user, day, 'day', m, maxDay);
        });
      }
      // Durée par semaine (lundi à dimanche) : une alerte, sur le premier jour
      // travaillé de la semaine dans la période.
      final maxWeek = rules['maxWeekMin'];
      if (maxWeek != null) {
        final perWeek = <DateTime, int>{};
        for (final s in list) {
          final monday = s.day.subtract(Duration(days: s.day.weekday - 1));
          perWeek[monday] = (perWeek[monday] ?? 0) + s.minutes;
        }
        perWeek.forEach((monday, m) {
          if (m <= maxWeek) return;
          final days = [
            for (final s in list)
              if (!s.day.isBefore(monday) && s.day.difference(monday).inDays < 7 && !s.day.isBefore(a) && !s.day.isAfter(b))
                s.day
          ]..sort();
          if (days.isNotEmpty) add(user, days.first, 'week', m, maxWeek);
        });
      }
      // Repos entre deux services.
      final minRest = rules['minRestMin'];
      if (minRest != null) {
        for (var i = 1; i < list.length; i++) {
          final rest = list[i].startAbs - list[i - 1].endAbs;
          // Deux services le même jour à la suite (coupure) ne sont pas un « repos ».
          if (rest < minRest && list[i].day != list[i - 1].day) {
            add(user, list[i].day, 'rest', rest < 0 ? 0 : rest, minRest, list[i].id);
          }
        }
      }
      // Jours travaillés d'affilée.
      final maxRun = rules['maxConsecutiveDays'];
      if (maxRun != null) {
        final days = {for (final s in list) s.day}.toList()..sort();
        var run = 0;
        DateTime? previous;
        for (final day in days) {
          run = previous != null && day.difference(previous).inDays == 1 ? run + 1 : 1;
          previous = day;
          if (run > maxRun) add(user, day, 'consecutive', run, maxRun);
        }
      }
    }
    return out;
  }

  // --- Totaux d'heures --------------------------------------------------------

  /// Heures par personne sur la période. Un responsable voit tout le monde
  /// (version de travail, ou publiée avec [published]) ; un salarié, ses
  /// propres heures publiées.
  Future<List<Map<String, Object?>>> totals(User actor, String companyId, String from, String to,
      {bool published = false}) async {
    final (_, role) = await companies.open(actor, companyId);
    final (a, b) = _range(from, to);
    final manager = role.canManage;
    final shifts = await _shifts(companyId, a, b, published: published || !manager, userId: manager ? null : actor.id);
    return _totals(companyId, shifts);
  }

  Future<List<Map<String, Object?>>> _totals(String companyId, List<_S> shifts) async {
    final members = {for (final m in await store.members(companyId)) m.user.id: m};
    final minutes = <String, int>{}, count = <String, int>{};
    for (final s in shifts) {
      if (s.userId == null) continue;
      minutes[s.userId!] = (minutes[s.userId!] ?? 0) + s.minutes;
      count[s.userId!] = (count[s.userId!] ?? 0) + 1;
    }
    final out = [
      for (final e in minutes.entries)
        {
          'userId': e.key,
          'name': members[e.key]?.user.name ?? await _formerName(e.key),
          'role': members[e.key]?.role.name,
          'minutes': e.value,
          'shifts': count[e.key],
        },
    ];
    out.sort((x, y) => (x['name'] as String).toLowerCase().compareTo((y['name'] as String).toLowerCase()));
    return out;
  }

  Future<String> _formerName(String userId) async {
    final rows = await store.query(store.db, 'SELECT coalesce(custom_name, name) FROM users WHERE id = @u::uuid', {'u': userId});
    return rows.isEmpty ? '?' : rows.first[0] as String;
  }

  // --- Liens d'export -----------------------------------------------------------

  /// Lien à usage court (10 minutes) vers un export : Excel ou CSV pour un
  /// responsable ; page imprimable pour tous, limitée à son propre planning
  /// pour un salarié si le responsable l'a réglé ainsi.
  Future<String> exportLink(User actor, String companyId, Map<String, dynamic> body, String lang) async {
    final (company, role) = await companies.open(actor, companyId);
    final format = body['format'];
    final from = body['from'], to = body['to'];
    if (format is! String || from is! String || to is! String || !{'csv', 'xlsx', 'print'}.contains(format)) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    _range(from, to);
    final manager = role.canManage;
    if (!manager && format != 'print') throw const ApiError.forbidden();
    final team = body['scope'] != 'own';
    if (!manager && team && company.printScope != 'team') throw const ApiError.forbidden();
    final jwt = JWT({
      'c': companyId,
      'f': format,
      'from': from,
      'to': to,
      'own': !team,
      'pub': !manager || body['published'] != false,
      'l': lang,
    }, subject: actor.id, issuer: 'staff-flow-export');
    return jwt.sign(_key, expiresIn: const Duration(minutes: 10));
  }

  /// Fichier d'un lien d'export : (type, nom, contenu).
  Future<(String, String, List<int>)> export(String token) async {
    final JWT jwt;
    try {
      jwt = JWT.verify(token, _key, issuer: 'staff-flow-export');
    } on JWTException {
      throw const ApiError.notFound('Lien expiré.');
    }
    final claims = jwt.payload as Map<String, dynamic>;
    final userId = jwt.subject!;
    final companyId = claims['c'] as String;
    final user = await store.findUser(userId);
    if (user == null) throw const ApiError.notFound('Lien expiré.');
    // Les droits sont revérifiés : la personne a pu quitter l'entreprise.
    final (company, role) = await companies.open(user, companyId);
    final own = claims['own'] == true || !role.canManage && company.printScope != 'team';
    final lang = claims['l'] as String? ?? 'en';
    final (a, b) = _range(claims['from'] as String, claims['to'] as String);
    final shifts = await _shifts(companyId, a, b, published: claims['pub'] != false, userId: own ? userId : null);
    final names = await _names(companyId);
    final stem = '${_slug(company.name)}-${claims['from']}-${claims['to']}';
    String t(String fr) => translate(fr, lang);
    switch (claims['f']) {
      case 'csv':
        return ('text/csv; charset=utf-8', '$stem.csv', utf8.encode('\uFEFF${_csv(shifts, names, t)}'));
      case 'xlsx':
        return (
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          '$stem.xlsx',
          _xlsx(shifts, await _totals(companyId, shifts), names, t)
        );
      default:
        return ('text/html; charset=utf-8', '$stem.html', utf8.encode(_html(company, a, b, shifts, names, t, lang)));
    }
  }

  /// Noms des personnes, sites et postes de l'entreprise.
  Future<({Map<String, Member> people, Map<String, String> sites, Map<String, String> positions})> _names(
      String companyId) async {
    final people = {for (final m in await store.members(companyId)) m.user.id: m};
    Future<Map<String, String>> catalog(String table) async => {
          for (final r in await store.query(store.db, 'SELECT id::text, name FROM $table WHERE company_id = @c::uuid',
              {'c': companyId}))
            r[0] as String: r[1] as String,
        };
    return (people: people, sites: await catalog('sites'), positions: await catalog('positions'));
  }

  static String _slug(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-|-$'), '').padRight(1, 'x');

  static String _time(int minutes) {
    final m = minutes % 1440;
    return '${(m ~/ 60).toString().padLeft(2, '0')}:${(m % 60).toString().padLeft(2, '0')}';
  }

  static String _hours(int minutes) => (minutes / 60).toStringAsFixed(2);

  List<List<String>> _rows(List<_S> shifts, ({Map<String, Member> people, Map<String, String> sites, Map<String, String> positions}) n,
          String Function(String) t) =>
      [
        for (final s in shifts)
          [
            formatDay(s.day),
            _time(s.start),
            _time(s.end),
            _hours(s.minutes),
            s.userId == null ? t('Non attribué') : (n.people[s.userId]?.user.name ?? t('Ancien membre')),
            s.userId == null ? '' : _roleLabel(n.people[s.userId]?.role, t),
            n.sites[s.siteId] ?? '',
            n.positions[s.positionId] ?? '',
            s.note ?? '',
          ],
      ];

  static String _roleLabel(Role? role, String Function(String) t) => switch (role) {
        Role.extra => t('Extra'),
        null => '',
        _ => t('Salarié'),
      };

  List<String> _header(String Function(String) t) =>
      [t('Date'), t('Début'), t('Fin'), t('Heures'), t('Personne'), t('Statut'), t('Site'), t('Poste'), t('Note')];

  String _csv(List<_S> shifts, ({Map<String, Member> people, Map<String, String> sites, Map<String, String> positions}) n,
      String Function(String) t) {
    String cell(String v) => v.contains(RegExp('[;"\n]')) ? '"${v.replaceAll('"', '""')}"' : v;
    return [_header(t), ..._rows(shifts, n, t)].map((r) => r.map(cell).join(';')).join('\r\n');
  }

  List<int> _xlsx(List<_S> shifts, List<Map<String, Object?>> totals,
      ({Map<String, Member> people, Map<String, String> sites, Map<String, String> positions}) n, String Function(String) t) {
    final excel = Excel.createExcel();
    final planning = t('Planning'), hours = t('Totaux');
    excel.rename(excel.getDefaultSheet()!, planning);
    final sheet = excel[planning];
    sheet.appendRow([for (final h in _header(t)) TextCellValue(h)]);
    for (final r in _rows(shifts, n, t)) {
      sheet.appendRow([
        for (final (i, v) in r.indexed) i == 3 ? DoubleCellValue(double.parse(v)) : TextCellValue(v),
      ]);
    }
    final sum = excel[hours];
    sum.appendRow([TextCellValue(t('Personne')), TextCellValue(t('Statut')), TextCellValue(t('Heures')), TextCellValue(t('Services'))]);
    for (final row in totals) {
      final role = row['role'] == null ? null : Role.values.byName(row['role'] as String);
      sum.appendRow([
        TextCellValue(row['name'] as String),
        TextCellValue(_roleLabel(role, t)),
        DoubleCellValue(double.parse(_hours(row['minutes'] as int))),
        IntCellValue(row['shifts'] as int),
      ]);
    }
    return excel.encode()!;
  }

  static String _esc(String s) =>
      s.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;').replaceAll('"', '&quot;');

  /// Page imprimable : une grille par semaine (personnes × jours), à
  /// imprimer ou enregistrer en PDF depuis le navigateur. Les dates sont
  /// écrites dans la langue de la personne par le navigateur.
  String _html(Company company, DateTime from, DateTime to, List<_S> shifts,
      ({Map<String, Member> people, Map<String, String> sites, Map<String, String> positions}) n, String Function(String) t,
      String lang) {
    final out = StringBuffer()
      ..write('<!doctype html><html lang="${_esc(lang)}"><head><meta charset="utf-8">'
          '<meta name="viewport" content="width=device-width,initial-scale=1">'
          '<title>${_esc(company.name)} · ${t('Planning')}</title><style>'
          '@page{size:landscape;margin:10mm}body{font-family:system-ui,sans-serif;color:#061440;margin:16px}'
          'h1{font-size:18px;margin:0 0 4px}p.sub{margin:0 0 12px;color:#555;font-size:12px}'
          'table{border-collapse:collapse;width:100%;margin-bottom:16px;page-break-inside:avoid;font-size:11px}'
          'th,td{border:1px solid #c9cfdd;padding:4px;vertical-align:top;text-align:left}'
          'th{background:#eef3fb}td.n{font-weight:600;white-space:nowrap}td.h{text-align:right;white-space:nowrap}'
          'div.s{margin-bottom:3px}div.s small{color:#555;display:block}'
          'button{background:#1A8CFC;color:#fff;border:0;border-radius:18px;padding:8px 18px;font-size:14px;margin-bottom:12px}'
          '@media print{button{display:none}body{margin:0}}</style></head><body>'
          '<button onclick="window.print()">${_esc(t('Imprimer ou enregistrer en PDF'))}</button>'
          '<h1>${_esc(company.name)} · ${t('Planning')}</h1>'
          '<p class="sub"><span class="d" data-d="${formatDay(from)}"></span> – <span class="d" data-d="${formatDay(to)}"></span></p>');
    var monday = from.subtract(Duration(days: from.weekday - 1));
    while (!monday.isAfter(to)) {
      final days = [for (var i = 0; i < 7; i++) monday.add(Duration(days: i))];
      final week = [for (final s in shifts) if (!s.day.isBefore(days.first) && !s.day.isAfter(days.last)) s];
      if (week.isNotEmpty) {
        final people = <String?>{for (final s in week) s.userId}.toList()
          ..sort((x, y) => _who(x, n, t).toLowerCase().compareTo(_who(y, n, t).toLowerCase()));
        out.write('<table><tr><th>${t('Personne')}</th>');
        for (final d in days) {
          out.write('<th><span class="w" data-d="${formatDay(d)}"></span></th>');
        }
        out.write('<th>${t('Heures')}</th></tr>');
        for (final p in people) {
          final mine = [for (final s in week) if (s.userId == p) s];
          out.write('<tr><td class="n">${_esc(_who(p, n, t))}</td>');
          for (final d in days) {
            out.write('<td>');
            for (final s in mine.where((s) => s.day == d)) {
              final detail = [n.positions[s.positionId], n.sites[s.siteId]].whereType<String>().join(' · ');
              out.write('<div class="s">${_time(s.start)}–${_time(s.end)}'
                  '${detail.isEmpty ? '' : '<small>${_esc(detail)}</small>'}</div>');
            }
            out.write('</td>');
          }
          final total = mine.fold(0, (m, s) => m + s.minutes);
          out.write('<td class="h">${_hours(total).replaceAll('.00', '')} h</td></tr>');
        }
        out.write('</table>');
      }
      monday = monday.add(const Duration(days: 7));
    }
    if (shifts.isEmpty) out.write('<p>${t('Aucun service sur cette période.')}</p>');
    out.write('<script>const l=${jsonEncode(lang)};'
        'for(const e of document.querySelectorAll("[data-d]")){const d=new Date(e.dataset.d+"T12:00:00Z");'
        'e.textContent=d.toLocaleDateString(l,e.classList.contains("w")?{weekday:"short",day:"numeric",month:"short",timeZone:"UTC"}'
        ':{day:"numeric",month:"long",year:"numeric",timeZone:"UTC"})}</script></body></html>');
    return out.toString();
  }

  static String _who(String? userId,
          ({Map<String, Member> people, Map<String, String> sites, Map<String, String> positions}) n, String Function(String) t) =>
      userId == null ? t('Non attribué') : (n.people[userId]?.user.name ?? t('Ancien membre'));

  // --- Agenda (Google Agenda, en option) ----------------------------------------

  /// Active ou coupe le lien d'agenda personnel. Renvoie le jeton, ou `null`.
  Future<String?> setCalendar(User actor, bool enabled) async {
    final random = Random.secure();
    final token = enabled ? base64Url.encode([for (var i = 0; i < 24; i++) random.nextInt(256)]) : null;
    await store.query(store.db, 'UPDATE users SET calendar_token = @t WHERE id = @u::uuid', {'t': token, 'u': actor.id});
    return token;
  }

  Future<String?> calendarToken(String userId) async {
    final rows = await store.query(store.db, 'SELECT calendar_token FROM users WHERE id = @u::uuid', {'u': userId});
    return rows.isEmpty ? null : rows.first[0] as String?;
  }

  /// Agenda au format iCalendar : ses services publiés de toutes ses
  /// entreprises, du mois dernier aux trois mois à venir.
  Future<String> calendar(String token, DateTime now) async {
    final users = await store.query(store.db, 'SELECT id::text FROM users WHERE calendar_token = @t', {'t': token});
    if (users.isEmpty) throw const ApiError.notFound();
    final rows = await store.query(store.db, '''
      SELECT s.id::text, c.name, si.name, po.name, s.published->>'note',
        ((s.published->>'day')::date + make_interval(mins => (s.published->>'start')::int)) AT TIME ZONE c.timezone,
        ((s.published->>'day')::date + make_interval(mins => (s.published->>'end')::int)) AT TIME ZONE c.timezone
      FROM shifts s
      JOIN companies c ON c.id = s.company_id
      JOIN memberships m ON m.company_id = s.company_id AND m.user_id = @u::uuid AND m.left_at IS NULL
      LEFT JOIN sites si ON si.id::text = s.published->>'siteId'
      LEFT JOIN positions po ON po.id::text = s.published->>'positionId'
      WHERE s.published IS NOT NULL AND s.published->>'userId' = @u::text
        AND (s.published->>'day')::date BETWEEN @from::date AND @to::date''', {
      'u': users.first[0],
      'from': formatDay(now.subtract(const Duration(days: 31))),
      'to': formatDay(now.add(const Duration(days: 92))),
    });
    String stamp(DateTime d) => '${d.toUtc().toIso8601String().replaceAll(RegExp(r'[-:]'), '').split('.').first}Z';
    String text(String s) => s.replaceAll('\\', '\\\\').replaceAll(';', '\\;').replaceAll(',', '\\,').replaceAll('\n', '\\n');
    final out = StringBuffer()
      ..write('BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:-//Staff Flow//FR\r\nCALSCALE:GREGORIAN\r\n'
          'X-WR-CALNAME:Staff Flow\r\nREFRESH-INTERVAL;VALUE=DURATION:PT6H\r\n');
    for (final r in rows) {
      final summary = [r[1] as String, r[3] as String?].whereType<String>().join(' · ');
      out.write('BEGIN:VEVENT\r\nUID:${r[0]}@staff-flow\r\nDTSTAMP:${stamp(now)}\r\n'
          'DTSTART:${stamp(r[5] as DateTime)}\r\nDTEND:${stamp(r[6] as DateTime)}\r\nSUMMARY:${text(summary)}\r\n'
          '${r[2] == null ? '' : 'LOCATION:${text(r[2] as String)}\r\n'}'
          '${r[4] == null ? '' : 'DESCRIPTION:${text(r[4] as String)}\r\n'}END:VEVENT\r\n');
    }
    out.write('END:VCALENDAR\r\n');
    return out.toString();
  }
}

/// Service, avec début et fin en minutes depuis l'an zéro (pour comparer
/// d'un jour à l'autre).
class _S {
  final String id;
  final DateTime day;
  final int start, end;
  final String? userId, siteId, positionId, note;

  _S(this.id, this.day, this.start, this.end, this.userId, this.siteId, this.positionId, this.note);

  int get minutes => end - start;
  int get startAbs => day.millisecondsSinceEpoch ~/ 60000 + start;
  int get endAbs => day.millisecondsSinceEpoch ~/ 60000 + end;
}
