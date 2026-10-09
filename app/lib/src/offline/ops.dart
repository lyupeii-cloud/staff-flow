import '../models.dart';

/// Modification du planning en attente d'envoi au serveur. Elle garde la
/// requête à rejouer (méthode, chemin, corps) et de quoi l'afficher tout de
/// suite sur l'appareil.
class PendingOp {
  /// Sert aussi de clé d'idempotence : rejouée, la requête n'est appliquée qu'une fois.
  final String id;
  final String companyId;
  final String kind; // create | update | delete | publish | replace
  final String method;
  final String path;
  final Map<String, dynamic>? body;
  final Map<String, dynamic> args;
  final DateTime createdAt;

  const PendingOp({
    required this.id,
    required this.companyId,
    required this.kind,
    required this.method,
    required this.path,
    this.body,
    this.args = const {},
    required this.createdAt,
  });

  factory PendingOp.fromJson(Map<String, dynamic> j) => PendingOp(
        id: j['id'],
        companyId: j['companyId'],
        kind: j['kind'],
        method: j['method'],
        path: j['path'],
        body: (j['body'] as Map?)?.cast<String, dynamic>(),
        args: (j['args'] as Map?)?.cast<String, dynamic>() ?? const {},
        createdAt: DateTime.parse(j['createdAt']),
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'companyId': companyId,
        'kind': kind,
        'method': method,
        'path': path,
        'body': body,
        'args': args,
        'createdAt': createdAt.toIso8601String(),
      };
}

/// Modifications du planning (les autres : messages…).
const planningKinds = {'create', 'update', 'delete', 'publish', 'replace', 'revert', 'discard'};

/// Planning affiché = services du serveur + modifications en attente, dans
/// l'ordre où elles ont été faites. Chaque service touché est marqué « en attente ».
List<Shift> overlay(List<Shift> server, List<PendingOp> ops) {
  final byId = {for (final s in server) s.id: s};
  for (final op in ops) {
    switch (op.kind) {
      case 'create':
        final body = op.body!;
        final days = [for (final d in body['days'] as List) parseDay(d as String)];
        final repeat = body['repeat'] as Map<String, dynamic>?;
        final dates = repeat == null ? (days.toSet().toList()..sort()) : occurrences(days, repeat);
        final end = body['end'] as int, start = body['start'] as int;
        for (var i = 0; i < dates.length; i++) {
          final id = 'local:${op.id}:$i';
          byId[id] = Shift(
            id: id,
            seriesId: repeat == null ? null : 'local:${op.id}',
            day: dates[i],
            start: start,
            end: end <= start ? end + 1440 : end,
            userId: body['userId'],
            siteId: body['siteId'],
            positionId: body['positionId'],
            note: body['note'],
            status: ShiftStatus.draft,
            pending: true,
          );
        }
      case 'update':
        final patch = op.body!;
        for (final s in _targets(byId, op)) {
          byId[s.id] = _patched(s, patch, moveDay: op.args['series'] != true);
        }
      case 'delete':
        for (final s in _targets(byId, op)) {
          if (s.status == ShiftStatus.draft) {
            byId.remove(s.id);
          } else {
            byId[s.id] = _copy(s, status: ShiftStatus.deleted);
          }
        }
      case 'publish':
        for (final s in [...byId.values]) {
          if (s.status == ShiftStatus.deleted) {
            byId.remove(s.id);
          } else if (s.status != ShiftStatus.published) {
            byId[s.id] = _copy(s, status: ShiftStatus.published);
          }
        }
      case 'replace':
        final a = op.body!;
        final from = parseDay(a['from']), to = parseDay(a['to']);
        for (final s in [...byId.values]) {
          if (s.userId == a['fromUserId'] && s.status != ShiftStatus.deleted &&
              !s.day.isBefore(from) && !s.day.isAfter(to)) {
            byId[s.id] = _copy(s, userId: a['toUserId']);
          }
        }
    }
  }
  return byId.values.toList()
    ..sort((a, b) => a.day != b.day ? a.day.compareTo(b.day) : a.start.compareTo(b.start));
}

/// Services touchés par une modification : celui visé, et pour « celui-ci et
/// les suivants » le reste de sa série (sauf les occurrences modifiées à part).
Iterable<Shift> _targets(Map<String, Shift> byId, PendingOp op) sync* {
  final target = byId[op.args['shiftId']];
  if (target == null) return;
  if (op.args['series'] != true || target.seriesId == null) {
    yield target;
    return;
  }
  for (final s in [...byId.values]) {
    if (s.seriesId == target.seriesId && !s.day.isBefore(target.day) &&
        s.status != ShiftStatus.deleted && (!s.detached || s.id == target.id)) {
      yield s;
    }
  }
}

Shift _patched(Shift s, Map<String, dynamic> p, {required bool moveDay}) {
  T? pick<T>(String k, T? current) => p.containsKey(k) ? p[k] as T? : current;
  final start = pick<int>('start', s.start)!;
  var end = pick<int>('end', s.end % 1440)!;
  if (end <= start) end += 1440;
  return _copy(s,
      day: moveDay && p['day'] != null ? parseDay(p['day']) : s.day,
      start: start,
      end: end,
      userId: pick('userId', s.userId),
      siteId: pick('siteId', s.siteId),
      positionId: pick('positionId', s.positionId),
      note: pick('note', s.note),
      clear: true,
      status: s.status == ShiftStatus.published ? ShiftStatus.modified : s.status);
}

/// Copie avec changements ; [clear] permet de mettre à null personne, site, poste, note.
Shift _copy(Shift s,
        {DateTime? day,
        int? start,
        int? end,
        String? userId,
        String? siteId,
        String? positionId,
        String? note,
        bool clear = false,
        ShiftStatus? status}) =>
    Shift(
      id: s.id,
      seriesId: s.seriesId,
      day: day ?? s.day,
      start: start ?? s.start,
      end: end ?? s.end,
      userId: clear ? userId : (userId ?? s.userId),
      siteId: clear ? siteId : (siteId ?? s.siteId),
      positionId: clear ? positionId : (positionId ?? s.positionId),
      note: clear ? note : (note ?? s.note),
      status: status ?? s.status,
      version: s.version,
      detached: s.detached,
      pending: true,
    );

/// Jours d'une série, mêmes règles que le serveur : chaque jour, ou chaque
/// semaine sur certains jours ; `count` compte des jours ou des semaines.
List<DateTime> occurrences(List<DateTime> days, Map<String, dynamic> repeat) {
  final start = days.reduce((a, b) => a.isBefore(b) ? a : b);
  final daily = repeat['freq'] == 'daily';
  final weekdays = {for (final d in (repeat['weekdays'] as List? ?? const [])) d as int};
  final week = weekdays.isEmpty ? {for (final d in days) d.weekday} : weekdays;
  final count = repeat['count'] as int?;
  final last = repeat['until'] != null
      ? parseDay(repeat['until'])
      : daily
          ? DateTime(start.year, start.month, start.day + count! - 1)
          : DateTime(start.year, start.month, start.day + 7 * count! - start.weekday);
  final out = <DateTime>[];
  for (var d = start; !d.isAfter(last) && out.length <= 400; d = DateTime(d.year, d.month, d.day + 1)) {
    if (daily || week.contains(d.weekday)) out.add(d);
  }
  return out;
}
