import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'notifications.dart';
import 'planning_service.dart' show formatDay, parseDay;
import 'store.dart';

/// Plusieurs employeurs (section 3) : la vue « Tous mes plannings », et
/// l'alerte quand deux services de deux entreprises différentes se
/// superposent. Rien n'est bloqué.
///
/// Confidentialité : seul le salarié voit le détail de ses services ; un
/// responsable apprend seulement qu'une personne est « déjà en service
/// ailleurs » sur un créneau.
class OverlapService {
  final Store store;
  final CompanyService companies;
  final NotificationService notifications;
  final DateTime Function() now;

  OverlapService(this.store, this.companies, this.notifications, {required this.now});

  /// Services publiés des membres actifs, avec leur début et leur fin en
  /// heure réelle (fuseau de chaque entreprise ; fin au-delà de minuit pour
  /// un service de nuit).
  static const _published = '''
    SELECT s.id, s.company_id, (s.published->>'userId')::uuid AS user_id,
      (s.published->>'day')::date AS day, (s.published->>'start')::int AS st, (s.published->>'end')::int AS en,
      s.published->>'siteId' AS site_id, s.published->>'positionId' AS position_id,
      ((s.published->>'day')::date + make_interval(mins => (s.published->>'start')::int)) AT TIME ZONE c.timezone AS t0,
      ((s.published->>'day')::date + make_interval(mins => (s.published->>'end')::int)) AT TIME ZONE c.timezone AS t1
    FROM shifts s
    JOIN companies c ON c.id = s.company_id
    JOIN memberships m ON m.company_id = s.company_id AND m.user_id = (s.published->>'userId')::uuid AND m.left_at IS NULL
    WHERE s.published IS NOT NULL AND s.published->>'userId' IS NOT NULL''';

  /// « Tous mes plannings » : ses services publiés de toutes ses entreprises
  /// sur la période, chacun marqué s'il en chevauche un d'une autre.
  Future<List<Map<String, Object?>>> myShifts(User actor, String from, String to) async {
    final start = parseDay(from), end = parseDay(to);
    if (end.isBefore(start) || end.difference(start).inDays > 62) throw const ApiError.badRequest('Dates invalides.');
    final rows = await store.query(store.db, '''
      WITH p AS ($_published AND s.published->>'userId' = @u)
      SELECT a.id::text, a.company_id::text, c.name, a.day, a.st, a.en, si.name, po.name,
        EXISTS (SELECT 1 FROM p b WHERE b.company_id <> a.company_id AND b.t0 < a.t1 AND a.t0 < b.t1),
        a.t0, a.t1, c.timezone
      FROM p a
      JOIN companies c ON c.id = a.company_id
      LEFT JOIN sites si ON si.id::text = a.site_id
      LEFT JOIN positions po ON po.id::text = a.position_id
      WHERE a.day BETWEEN @from::date AND @to::date
      ORDER BY a.day, a.st''', {'u': actor.id, 'from': formatDay(start), 'to': formatDay(end)});
    return [
      for (final r in rows)
        {
          'id': r[0],
          'companyId': r[1],
          'companyName': r[2],
          'day': formatDay(r[3] as DateTime),
          'start': r[4],
          'end': r[5],
          'siteName': r[6],
          'positionName': r[7],
          'overlap': r[8],
          // Début et fin en heure réelle (agenda du téléphone).
          'startsAt': (r[9] as DateTime).toUtc().toIso8601String(),
          'endsAt': (r[10] as DateTime).toUtc().toIso8601String(),
          'timezone': r[11],
        },
    ];
  }

  /// Responsable : membres de son entreprise déjà en service dans une autre
  /// entreprise sur ce créneau, un des [days] (sans aucun détail).
  /// Personnes qui ont déjà un service dans cette entreprise sur ce créneau
  /// (version de travail), sauf le service [exclude] en cours de modification.
  Future<List<String>> busyHere(User actor, String companyId, List<String> days, int start, int end, String? exclude) async {
    final (_, role) = await companies.open(actor, companyId);
    if (!role.canManage) throw const ApiError.forbidden();
    final valid = [for (final d in days) formatDay(parseDay(d))];
    final rows = await store.query(store.db, '''
      SELECT DISTINCT s.user_id::text FROM shifts s, unnest(@days::text[]) AS d
      WHERE s.company_id = @c::uuid AND NOT s.deleted AND s.user_id IS NOT NULL
        AND (@x::text IS NULL OR s.id::text <> @x::text)
        AND (s.day - d::date) * 1440 + s.start_min < @en AND @st < (s.day - d::date) * 1440 + s.end_min''', {
      'c': companyId,
      'days': valid,
      'st': start,
      'en': end <= start ? end + 1440 : end,
      'x': exclude,
    });
    return [for (final r in rows) r[0] as String];
  }

  Future<List<String>> busyElsewhere(User actor, String companyId, List<String> days, int start, int end) async {
    final (company, role) = await companies.open(actor, companyId);
    if (!role.canManage) throw const ApiError.forbidden();
    if (days.isEmpty || days.length > 400 || start < 0 || start > 1439 || end < 0 || end > 1440) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    final valid = [for (final d in days) formatDay(parseDay(d))];
    final rows = await store.query(store.db, '''
      WITH p AS ($_published),
      slot AS (
        SELECT (d::date + make_interval(mins => @st)) AT TIME ZONE @tz AS t0,
               (d::date + make_interval(mins => @en)) AT TIME ZONE @tz AS t1
        FROM unnest(@days::text[]) AS d)
      SELECT DISTINCT p.user_id::text FROM p, slot
      WHERE p.company_id <> @c::uuid AND p.t0 < slot.t1 AND slot.t0 < p.t1
        AND (p.user_id IN (SELECT user_id FROM memberships WHERE company_id = @c::uuid AND left_at IS NULL)
          -- Renforts possibles : les personnes de ses autres entreprises.
          OR p.user_id IN (SELECT m.user_id FROM memberships mine
            JOIN memberships m ON m.company_id = mine.company_id AND m.left_at IS NULL
            WHERE mine.user_id = @u::uuid AND mine.left_at IS NULL AND mine.role IN ('owner', 'manager')))''', {
      'u': actor.id,
      'c': companyId,
      'tz': company.timezone,
      'days': valid,
      'st': start,
      'en': end <= start ? end + 1440 : end,
    });
    return [for (final r in rows) r[0] as String];
  }

  /// Après une publication (ou un échange validé) dans [companyId] : prévient
  /// chacune des [userIds] d'un nouveau chevauchement avec une autre
  /// entreprise. Chaque paire de services n'est signalée qu'une fois.
  Future<void> notifyNew(String companyId, Iterable<String> userIds) async {
    final users = userIds.toSet().toList();
    if (users.isEmpty) return;
    final rows = await store.query(store.db, '''
      WITH p AS ($_published)
      SELECT a.id::text, b.id::text, a.user_id::text, a.day
      FROM p a JOIN p b ON b.user_id = a.user_id AND b.company_id <> a.company_id AND a.t0 < b.t1 AND b.t0 < a.t1
      WHERE a.company_id = @c::uuid AND a.user_id::text = ANY(@users::text[]) AND a.t1 > @now::timestamptz
      ORDER BY a.day''', {'c': companyId, 'users': users, 'now': now().toIso8601String()});
    final firstDay = <String, DateTime>{};
    for (final r in rows) {
      final inserted = await store.query(store.db, '''
        INSERT INTO overlap_alerts (shift_a, shift_b) VALUES (LEAST(@a::uuid, @b::uuid), GREATEST(@a::uuid, @b::uuid))
        ON CONFLICT DO NOTHING RETURNING shift_a''', {'a': r[0], 'b': r[1]});
      if (inserted.isNotEmpty) firstDay.putIfAbsent(r[2] as String, () => r[3] as DateTime);
    }
    for (final e in firstDay.entries) {
      await notifications.notify([e.key], kind: 'shift_overlap', data: {'day': formatDay(e.value)});
    }
  }
}
