import 'package:flutter_test/flutter_test.dart';
import 'package:staff_flow/src/models.dart';
import 'package:staff_flow/src/offline/ops.dart';

Shift shift(String id, String day,
        {ShiftStatus status = ShiftStatus.published, String? series, bool detached = false, String? user}) =>
    Shift(
      id: id,
      seriesId: series,
      day: parseDay(day),
      start: 480,
      end: 1020,
      userId: user,
      status: status,
      detached: detached,
    );

PendingOp op(String kind, {Map<String, dynamic>? body, Map<String, dynamic> args = const {}}) =>
    PendingOp(
      id: 'op-$kind',
      companyId: 'c',
      kind: kind,
      method: 'POST',
      path: '/',
      body: body,
      args: args,
      createdAt: DateTime(2026, 10, 8),
    );

List<String> days(List<Shift> shifts) => [for (final s in shifts) formatDay(s.day)];

void main() {
  group('répétition, mêmes règles que le serveur', () {
    test('certains jours de la semaine, pendant 2 semaines', () {
      final d = occurrences([parseDay('2026-10-05')], {'freq': 'weekly', 'weekdays': [1, 3], 'count': 2});
      expect([for (final x in d) formatDay(x)], ['2026-10-05', '2026-10-07', '2026-10-12', '2026-10-14']);
    });

    test('sans jours précisés, on reprend ceux choisis', () {
      final d = occurrences([parseDay('2026-10-06'), parseDay('2026-10-09')], {'freq': 'weekly', 'until': '2026-10-16'});
      expect([for (final x in d) formatDay(x)], ['2026-10-06', '2026-10-09', '2026-10-13', '2026-10-16']);
    });

    test('chaque jour, N jours', () {
      expect(occurrences([parseDay('2026-10-05')], {'freq': 'daily', 'count': 4}), hasLength(4));
    });
  });

  group('modifications en attente affichées par-dessus le serveur', () {
    test('une création apparaît tout de suite, en brouillon et en attente', () {
      final r = overlay([], [
        op('create', body: {
          'days': ['2026-10-05'],
          'start': 1320,
          'end': 360,
          'repeat': {'freq': 'daily', 'count': 2},
        }),
      ]);
      expect(days(r), ['2026-10-05', '2026-10-06']);
      expect(r.every((s) => s.pending && s.isLocal && s.status == ShiftStatus.draft), isTrue);
      expect(r.first.end, 30 * 60, reason: 'service de nuit');
    });

    test('modifier un service publié le marque modifié et en attente', () {
      final r = overlay([shift('a', '2026-10-05')], [
        op('update', body: {'start': 600, 'userId': 'bob'}, args: {'shiftId': 'a'}),
      ]);
      expect([r.single.start, r.single.userId, r.single.status, r.single.pending],
          [600, 'bob', ShiftStatus.modified, true]);
    });

    test('« celui-ci et les suivants » épargne le passé et les occurrences modifiées à part', () {
      final r = overlay([
        shift('a', '2026-10-05', series: 's'),
        shift('b', '2026-10-06', series: 's'),
        shift('c', '2026-10-07', series: 's', detached: true),
        shift('d', '2026-10-08', series: 's'),
      ], [
        op('update', body: {'start': 540}, args: {'shiftId': 'b', 'series': true}),
      ]);
      expect([for (final s in r) s.start], [480, 540, 480, 540]);
    });

    test('supprimer : un brouillon disparaît, un service publié est marqué supprimé', () {
      final r = overlay([
        shift('a', '2026-10-05', status: ShiftStatus.draft),
        shift('b', '2026-10-06'),
      ], [
        op('delete', args: {'shiftId': 'a'}),
        op('delete', args: {'shiftId': 'b'}),
      ]);
      expect([for (final s in r) '${s.id}:${s.status.name}'], ['b:deleted']);
    });

    test('publier : les suppressions partent, le reste est publié', () {
      final r = overlay([
        shift('a', '2026-10-05', status: ShiftStatus.deleted),
        shift('b', '2026-10-06', status: ShiftStatus.draft),
      ], [
        op('publish'),
      ]);
      expect([for (final s in r) '${s.id}:${s.status.name}'], ['b:published']);
    });

    test('remplacer une personne sur la période', () {
      final r = overlay([
        shift('a', '2026-10-05', user: 'bob'),
        shift('b', '2026-10-09', user: 'bob'),
      ], [
        op('replace', body: {'fromUserId': 'bob', 'toUserId': 'eva', 'from': '2026-10-05', 'to': '2026-10-06'}),
      ]);
      expect([for (final s in r) s.userId], ['eva', 'bob']);
    });

    test('les modifications s\'appliquent dans l\'ordre où elles ont été faites', () {
      final r = overlay([shift('a', '2026-10-05')], [
        op('update', body: {'start': 600}, args: {'shiftId': 'a'}),
        op('update', body: {'start': 660}, args: {'shiftId': 'a'}),
      ]);
      expect(r.single.start, 660);
    });
  });
}
