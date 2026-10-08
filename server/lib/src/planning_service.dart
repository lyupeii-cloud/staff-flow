import 'dart:convert';

import 'package:postgres/postgres.dart';

import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'store.dart';

/// Planning (section 4 du cahier des charges) : sites et postes, services,
/// répétition, brouillon puis publication, remplacement.
///
/// Un service garde deux versions : la version de travail, que voient les
/// responsables, et `published`, la dernière version publiée, que voient les
/// salariés. Toute modification met le service « en attente » (`dirty`)
/// jusqu'à la publication suivante.
class PlanningService {
  final Store store;
  final CompanyService companies;

  PlanningService(this.store, this.companies);

  static const maxRangeDays = 62;
  static const maxOccurrences = 400;

  // --- Sites et postes ----------------------------------------------------

  Future<List<CatalogItem>> catalog(User actor, String companyId, CatalogKind kind) async {
    await companies.open(actor, companyId);
    final rows = await store.query(store.db, '''
      SELECT id::text, name, archived_at IS NOT NULL AS archived FROM ${kind.table}
      WHERE company_id = @c::uuid ORDER BY archived, lower(name)''', {'c': companyId});
    return [for (final r in rows) CatalogItem(r[0] as String, r[1] as String, r[2] as bool)];
  }

  Future<CatalogItem> addCatalogItem(
      User actor, String companyId, CatalogKind kind, String name) async {
    await _manager(actor, companyId);
    final rows = await store.query(store.db,
        'INSERT INTO ${kind.table} (company_id, name) VALUES (@c::uuid, @n) RETURNING id::text',
        {'c': companyId, 'n': _name(name)});
    return CatalogItem(rows.first[0] as String, _name(name), false);
  }

  Future<void> updateCatalogItem(User actor, String companyId, CatalogKind kind, String id,
      {String? name, bool? archived}) async {
    await _manager(actor, companyId);
    final rows = await store.query(store.db, '''
      UPDATE ${kind.table} SET
        name = coalesce(@n, name),
        archived_at = CASE WHEN @a::boolean IS NULL THEN archived_at
                           WHEN @a::boolean THEN coalesce(archived_at, now()) ELSE NULL END
      WHERE id = @id::uuid AND company_id = @c::uuid RETURNING id''',
        {'id': id, 'c': companyId, 'n': name == null ? null : _name(name), 'a': archived});
    if (rows.isEmpty) throw ApiError.notFound(kind == CatalogKind.sites ? 'Site introuvable.' : 'Poste introuvable.');
  }

  // --- Services -------------------------------------------------------------

  /// Services du [from] au [to] inclus. Les salariés ne voient que la version
  /// publiée ; les responsables voient la version de travail et son état.
  Future<(List<Shift>, int)> shifts(User actor, String companyId, String from, String to) async {
    final (_, role) = await companies.open(actor, companyId);
    final start = parseDay(from), end = parseDay(to);
    if (end.isBefore(start) || end.difference(start).inDays > maxRangeDays) {
      throw const ApiError.badRequest('Période invalide (62 jours au plus).');
    }
    final params = {'c': companyId, 'from': formatDay(start), 'to': formatDay(end)};
    if (!role.canManage) {
      final rows = await store.query(store.db, '''
        SELECT id::text, series_id::text, published FROM shifts
        WHERE company_id = @c::uuid AND published IS NOT NULL
          AND (published->>'day')::date BETWEEN @from::date AND @to::date''', params);
      final list = [
        for (final r in rows)
          Shift.fromPublished(r[0] as String, r[1] as String?, r[2] as Map<String, dynamic>),
      ]..sort(Shift.compare);
      return (list, 0);
    }
    final rows = await store.query(store.db, '''
      SELECT * FROM shifts
      WHERE company_id = @c::uuid AND day BETWEEN @from::date AND @to::date
      ORDER BY day, start_min''', params);
    final pending = await store.query(
        store.db, 'SELECT count(*) FROM shifts WHERE company_id = @c::uuid AND dirty', {'c': companyId});
    return ([for (final r in rows) Shift.fromRow(r.toColumnMap())], pending.first[0] as int);
  }

  /// Crée un service sur chacun des [days] ; avec [repeat], une série.
  Future<List<Shift>> create(User actor, String companyId, ShiftInput input,
      {required List<DateTime> days, Repeat? repeat}) async {
    await _manager(actor, companyId);
    if (days.isEmpty) throw const ApiError.badRequest('Choisissez au moins un jour.');
    await _checkRefs(companyId, input);
    final dates = repeat == null ? (days.toSet().toList()..sort()) : repeat.occurrences(days);
    if (dates.length > maxOccurrences) {
      throw const ApiError.badRequest('Trop de services d\'un coup (400 au plus).');
    }
    return store.db.runTx((tx) async {
      String? seriesId;
      if (repeat != null) {
        final rows = await store.query(tx, '''
          INSERT INTO shift_series (company_id, rule, created_by)
          VALUES (@c::uuid, @rule::jsonb, @u::uuid) RETURNING id::text''',
            {'c': companyId, 'rule': jsonEncode(repeat.toJson()), 'u': actor.id});
        seriesId = rows.first[0] as String;
      }
      final created = <Shift>[];
      for (final day in dates) {
        final rows = await store.query(tx, '''
          INSERT INTO shifts (company_id, series_id, day, start_min, end_min,
                              user_id, site_id, position_id, note, updated_by)
          VALUES (@c::uuid, @s::uuid, @day::date, @start, @end,
                  @user::uuid, @site::uuid, @pos::uuid, @note, @by::uuid)
          RETURNING *''', {
          'c': companyId,
          's': seriesId,
          'day': formatDay(day),
          ...input.params(),
          'by': actor.id,
        });
        created.add(Shift.fromRow(rows.first.toColumnMap()));
      }
      await store.audit(
          companyId: companyId,
          actorId: actor.id,
          action: 'shift.create',
          details: {'count': created.length, 'seriesId': seriesId},
          tx: tx);
      return created;
    });
  }

  /// Modifie un service. `series` : celui-ci et les suivants de sa série
  /// (sauf ceux déjà modifiés à part). `one` : celui-ci seul, qui sort alors
  /// de sa série sans la casser.
  Future<int> update(User actor, String companyId, String shiftId, ShiftPatch patch,
      {required Scope scope}) async {
    await _manager(actor, companyId);
    final shift = await _find(companyId, shiftId);
    if (scope == Scope.series && patch.day != null) {
      throw const ApiError.badRequest('Le jour se change service par service.');
    }
    final merged = patch.merge(shift);
    await _checkRefs(companyId, merged);
    final sets = '''
      start_min = @start, end_min = @end, user_id = @user::uuid, site_id = @site::uuid,
      position_id = @pos::uuid, note = @note, dirty = true, updated_by = @by::uuid, updated_at = now()''';
    final Result rows;
    if (scope == Scope.series && shift.seriesId != null) {
      rows = await store.query(store.db, '''
        UPDATE shifts SET $sets
        WHERE series_id = @series::uuid AND day >= @day::date AND NOT deleted
          AND (NOT detached OR id = @id::uuid)
        RETURNING id''', {
        ...merged.params(),
        'by': actor.id,
        'series': shift.seriesId,
        'day': formatDay(shift.day),
        'id': shift.id,
      });
    } else {
      rows = await store.query(store.db, '''
        UPDATE shifts SET $sets, day = @day::date, detached = series_id IS NOT NULL
        WHERE id = @id::uuid RETURNING id''', {
        ...merged.params(),
        'by': actor.id,
        'day': formatDay(patch.day ?? shift.day),
        'id': shift.id,
      });
    }
    await store.audit(
        companyId: companyId,
        actorId: actor.id,
        action: 'shift.update',
        details: {'shiftId': shiftId, 'scope': scope.name, 'count': rows.length});
    return rows.length;
  }

  /// Supprime un service (ou la suite de sa série). Un service déjà publié
  /// reste visible des salariés jusqu'à la prochaine publication.
  Future<int> delete(User actor, String companyId, String shiftId, {required Scope scope}) async {
    await _manager(actor, companyId);
    final shift = await _find(companyId, shiftId);
    final where = scope == Scope.series && shift.seriesId != null
        ? 'series_id = @series::uuid AND day >= @day::date AND (NOT detached OR id = @id::uuid)'
        : 'id = @id::uuid';
    final params = {'series': shift.seriesId, 'day': formatDay(shift.day), 'id': shift.id};
    final count = await store.db.runTx((tx) async {
      final dropped = await store.query(
          tx, 'DELETE FROM shifts WHERE $where AND published IS NULL RETURNING id', params);
      final marked = await store.query(tx, '''
        UPDATE shifts SET deleted = true, dirty = true, updated_by = @by::uuid, updated_at = now()
        WHERE $where AND NOT deleted RETURNING id''', {...params, 'by': actor.id});
      return dropped.length + marked.length;
    });
    await store.audit(
        companyId: companyId,
        actorId: actor.id,
        action: 'shift.delete',
        details: {'shiftId': shiftId, 'scope': scope.name, 'count': count});
    return count;
  }

  /// Remplace une personne par une autre sur ses services de la période.
  Future<int> replace(User actor, String companyId,
      {required String fromUserId, required String toUserId, required String from, required String to}) async {
    await _manager(actor, companyId);
    if (await store.roleOf(companyId, toUserId) == null) {
      throw const ApiError.badRequest('Le remplaçant ne fait pas partie de l\'entreprise.');
    }
    final rows = await store.query(store.db, '''
      UPDATE shifts SET user_id = @to::uuid, dirty = true, updated_by = @by::uuid, updated_at = now()
      WHERE company_id = @c::uuid AND user_id = @from::uuid AND NOT deleted
        AND day BETWEEN @start::date AND @end::date
      RETURNING id''', {
      'c': companyId,
      'from': fromUserId,
      'to': toUserId,
      'start': formatDay(parseDay(from)),
      'end': formatDay(parseDay(to)),
      'by': actor.id,
    });
    await store.audit(
        companyId: companyId,
        actorId: actor.id,
        action: 'shift.replace',
        details: {'fromUserId': fromUserId, 'toUserId': toUserId, 'count': rows.length});
    return rows.length;
  }

  /// Publie toutes les modifications en attente. Renvoie le nombre de
  /// services publiés et les personnes concernées (à prévenir).
  Future<(int, Set<String>)> publish(User actor, String companyId) async {
    await _manager(actor, companyId);
    final (count, users) = await store.db.runTx((tx) async {
      final affected = await store.query(tx, '''
        SELECT DISTINCT u FROM shifts,
          LATERAL (VALUES (user_id::text), (published->>'userId')) AS v(u)
        WHERE company_id = @c::uuid AND dirty AND u IS NOT NULL''', {'c': companyId});
      final removed = await store.query(tx,
          'DELETE FROM shifts WHERE company_id = @c::uuid AND dirty AND deleted RETURNING id',
          {'c': companyId});
      final updated = await store.query(tx, '''
        UPDATE shifts SET dirty = false, published = jsonb_build_object(
          'day', day, 'start', start_min, 'end', end_min, 'userId', user_id,
          'siteId', site_id, 'positionId', position_id, 'note', note)
        WHERE company_id = @c::uuid AND dirty RETURNING id''', {'c': companyId});
      return (removed.length + updated.length, {for (final r in affected) r[0] as String});
    });
    await store.audit(
        companyId: companyId,
        actorId: actor.id,
        action: 'planning.publish',
        details: {'count': count, 'users': users.length});
    return (count, users);
  }

  // --- Outils ---------------------------------------------------------------

  Future<void> _manager(User actor, String companyId) async {
    final (company, role) = await companies.open(actor, companyId);
    if (!role.canManage) throw const ApiError.forbidden();
    if (company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
  }

  Future<Shift> _find(String companyId, String shiftId) async {
    final rows = await store.query(store.db,
        'SELECT * FROM shifts WHERE id = @id::uuid AND company_id = @c::uuid AND NOT deleted',
        {'id': shiftId, 'c': companyId});
    if (rows.isEmpty) throw const ApiError.notFound('Service introuvable.');
    return Shift.fromRow(rows.first.toColumnMap());
  }

  /// La personne, le site et le poste doivent appartenir à l'entreprise.
  Future<void> _checkRefs(String companyId, ShiftInput input) async {
    if (input.userId != null && await store.roleOf(companyId, input.userId!) == null) {
      throw const ApiError.badRequest('Cette personne ne fait pas partie de l\'entreprise.');
    }
    for (final (kind, id) in [(CatalogKind.sites, input.siteId), (CatalogKind.positions, input.positionId)]) {
      if (id == null) continue;
      final rows = await store.query(store.db, '''
        SELECT 1 FROM ${kind.table}
        WHERE id = @id::uuid AND company_id = @c::uuid AND archived_at IS NULL''',
          {'id': id, 'c': companyId});
      if (rows.isEmpty) {
        throw ApiError.badRequest(
            kind == CatalogKind.sites ? 'Site inconnu ou archivé.' : 'Poste inconnu ou archivé.');
      }
    }
  }

  static String _name(String name) {
    final t = name.trim();
    if (t.isEmpty || t.length > 80) throw const ApiError.badRequest('Nom entre 1 et 80 caractères.');
    return t;
  }
}

enum CatalogKind {
  sites('sites', 'Site'),
  positions('positions', 'Poste');

  final String table;
  final String label;
  const CatalogKind(this.table, this.label);
}

class CatalogItem {
  final String id;
  final String name;
  final bool archived;

  const CatalogItem(this.id, this.name, this.archived);

  Map<String, Object?> toJson() => {'id': id, 'name': name, 'archived': archived};
}

enum Scope { one, series }

/// Horaires et affectation d'un service. Les minutes comptent depuis minuit,
/// heure locale de l'entreprise ; une fin avant le début passe au lendemain.
class ShiftInput {
  final int start;
  final int end;
  final String? userId;
  final String? siteId;
  final String? positionId;
  final String? note;

  ShiftInput({
    required int start,
    required int end,
    this.userId,
    this.siteId,
    this.positionId,
    this.note,
  })  : start = start,
        end = end <= start ? end + 1440 : end {
    if (start < 0 || start > 1439 || end < 0 || end > 1439) {
      throw const ApiError.badRequest('Heures invalides.');
    }
  }

  Map<String, Object?> params() => {
        'start': start,
        'end': end,
        'user': userId,
        'site': siteId,
        'pos': positionId,
        'note': note,
      };
}

/// Modification partielle : seuls les champs présents changent ;
/// `userId: null` retire la personne du service.
class ShiftPatch {
  final Map<String, dynamic> fields;

  ShiftPatch(this.fields);

  DateTime? get day => fields['day'] == null ? null : parseDay(fields['day'] as String);

  ShiftInput merge(Shift s) {
    T? pick<T>(String key, T? current) => fields.containsKey(key) ? fields[key] as T? : current;
    return ShiftInput(
      start: pick<int>('start', s.start)!,
      end: pick<int>('end', s.end % 1440)!,
      userId: pick('userId', s.userId),
      siteId: pick('siteId', s.siteId),
      positionId: pick('positionId', s.positionId),
      note: pick('note', s.note),
    );
  }
}

/// Répétition d'une série : chaque jour, ou chaque semaine sur certains
/// jours (1 = lundi … 7 = dimanche), jusqu'à une date ou pour un nombre de
/// jours / de semaines.
class Repeat {
  final String freq;
  final Set<int> weekdays;
  final DateTime? until;
  final int? count;

  Repeat({required this.freq, this.weekdays = const {}, this.until, this.count}) {
    if (freq != 'daily' && freq != 'weekly') throw const ApiError.badRequest('Répétition inconnue.');
    if ((until == null) == (count == null)) {
      throw const ApiError.badRequest('Indiquez une date de fin ou un nombre de répétitions.');
    }
    if (count != null && (count! < 1 || count! > 366)) {
      throw const ApiError.badRequest('Nombre de répétitions entre 1 et 366.');
    }
    if (weekdays.any((d) => d < 1 || d > 7)) throw const ApiError.badRequest('Jour de semaine invalide.');
  }

  factory Repeat.fromJson(Map<String, dynamic> j) => Repeat(
        freq: j['freq'] as String,
        weekdays: {for (final d in (j['weekdays'] as List? ?? const [])) d as int},
        until: j['until'] == null ? null : parseDay(j['until'] as String),
        count: j['count'] as int?,
      );

  Map<String, Object?> toJson() => {
        'freq': freq,
        if (weekdays.isNotEmpty) 'weekdays': (weekdays.toList()..sort()),
        if (until != null) 'until': formatDay(until!),
        if (count != null) 'count': count,
      };

  /// Jours de la série. `count` compte des jours (daily) ou des semaines
  /// (weekly). Sans jours de semaine précisés, on reprend ceux de [days].
  List<DateTime> occurrences(List<DateTime> days) {
    final start = days.reduce((a, b) => a.isBefore(b) ? a : b);
    final week = weekdays.isEmpty ? {for (final d in days) d.weekday} : weekdays;
    final last = until ??
        (freq == 'daily'
            ? start.add(Duration(days: count! - 1))
            : start.add(Duration(days: 7 * count! - start.weekday)));
    final out = <DateTime>[];
    for (var d = start; !d.isAfter(last); d = d.add(const Duration(days: 1))) {
      if (freq == 'daily' || week.contains(d.weekday)) out.add(d);
      if (out.length > PlanningService.maxOccurrences) break;
    }
    return out;
  }
}

class Shift {
  final String id;
  final String? seriesId;
  final DateTime day;
  final int start;
  final int end;
  final String? userId;
  final String? siteId;
  final String? positionId;
  final String? note;

  /// draft (jamais publié), published, modified (publié puis modifié),
  /// deleted (publié, supprimé à la prochaine publication).
  final String status;

  const Shift({
    required this.id,
    this.seriesId,
    required this.day,
    required this.start,
    required this.end,
    this.userId,
    this.siteId,
    this.positionId,
    this.note,
    required this.status,
  });

  factory Shift.fromRow(Map<String, dynamic> r) => Shift(
        id: r['id'] as String,
        seriesId: r['series_id'] as String?,
        day: r['day'] as DateTime,
        start: r['start_min'] as int,
        end: r['end_min'] as int,
        userId: r['user_id'] as String?,
        siteId: r['site_id'] as String?,
        positionId: r['position_id'] as String?,
        note: r['note'] as String?,
        status: r['published'] == null
            ? 'draft'
            : r['deleted'] == true
                ? 'deleted'
                : r['dirty'] == true
                    ? 'modified'
                    : 'published',
      );

  factory Shift.fromPublished(String id, String? seriesId, Map<String, dynamic> p) => Shift(
        id: id,
        seriesId: seriesId,
        day: parseDay(p['day'] as String),
        start: p['start'] as int,
        end: p['end'] as int,
        userId: p['userId'] as String?,
        siteId: p['siteId'] as String?,
        positionId: p['positionId'] as String?,
        note: p['note'] as String?,
        status: 'published',
      );

  static int compare(Shift a, Shift b) {
    final d = a.day.compareTo(b.day);
    return d != 0 ? d : a.start.compareTo(b.start);
  }

  Map<String, Object?> toJson() => {
        'id': id,
        'seriesId': seriesId,
        'day': formatDay(day),
        'start': start,
        'end': end,
        'userId': userId,
        'siteId': siteId,
        'positionId': positionId,
        'note': note,
        'status': status,
      };
}

final _dayFormat = RegExp(r'^\d{4}-\d{2}-\d{2}$');

DateTime parseDay(String value) {
  final d = _dayFormat.hasMatch(value) ? DateTime.tryParse('${value}T00:00:00Z') : null;
  if (d == null || formatDay(d) != value) throw ApiError.badRequest('Date invalide : {value}', {'value': value});
  return d;
}

String formatDay(DateTime d) => d.toIso8601String().substring(0, 10);
