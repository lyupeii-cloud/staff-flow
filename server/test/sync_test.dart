import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final env = TestEnv();

  late Client alice, bruno, emma;
  late String company;

  setUp(() async {
    alice = await env.login('alice'); // propriétaire
    bruno = await env.login('bruno'); // responsable
    emma = await env.login('emma'); // salariée
    company = await env.createCompany(alice);
    await env.store.addMember(company, bruno.id, Role.manager);
    await env.store.addMember(company, emma.id, Role.employee);
  });

  String p(String path) => '/companies/$company$path';

  Future<Map<String, dynamic>> createOne(Client c, {int start = 480}) async =>
      (await c.ok('POST', p('/shifts'), {'days': ['2026-10-05'], 'start': start, 'end': 1020}))['shifts'][0];

  Future<List<dynamic>> week(Client c) async =>
      (await c.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'];

  Future<List<dynamic>> history(Client c, [String? shiftId]) async =>
      (await c.ok('GET', p('/history${shiftId == null ? '' : '?shiftId=$shiftId'}')))['entries'];

  group('versions', () {
    test('chaque modification augmente la version', () async {
      final s = await createOne(alice);
      expect(s['version'], 1);
      await alice.ok('PATCH', p('/shifts/${s['id']}'), {'start': 540});
      await alice.ok('PATCH', p('/shifts/${s['id']}'), {'start': 600});
      expect((await week(alice)).single['version'], 3);
    });
  });

  group('historique', () {
    test('création, modification, suppression : qui, quoi, avant et après', () async {
      final s = await createOne(alice);
      await bruno.ok('PATCH', p('/shifts/${s['id']}'), {'start': 540, 'userId': emma.id});
      await alice.ok('DELETE', p('/shifts/${s['id']}'));

      final entries = await history(alice, s['id']);
      expect([for (final e in entries) e['action']], ['delete', 'update', 'create']);
      expect([for (final e in entries) e['actor']['name']], ['alice', 'bruno', 'alice']);
      final update = entries[1];
      expect(update['before']['start'], 480);
      expect(update['after']['start'], 540);
      expect(update['after']['userId'], emma.id);
      expect(entries[0]['after'], isNull, reason: 'brouillon supprimé : il n\'existe plus');
    });

    test('un salarié ne voit pas l\'historique', () async {
      expect((await emma('GET', p('/history'))).$1, 403);
    });
  });

  group('annulation', () {
    test('annuler une modification remet le service comme avant', () async {
      final s = await createOne(alice);
      await bruno.ok('PATCH', p('/shifts/${s['id']}'), {'start': 600, 'userId': emma.id});
      final entry = (await history(alice, s['id'])).first;
      expect((await alice.ok('POST', p('/history/${entry['id']}/undo')))['changed'], isTrue);
      final now = (await week(alice)).single;
      expect([now['start'], now['userId']], [480, null]);
      // L'annulation elle-même figure dans l'historique, et peut être annulée.
      final undo = (await history(alice, s['id'])).first;
      expect(undo['action'], 'undo');
      await alice.ok('POST', p('/history/${undo['id']}/undo'));
      expect((await week(alice)).single['start'], 600);
    });

    test('annuler deux fois la même modification ne change plus rien', () async {
      final s = await createOne(alice);
      await alice.ok('PATCH', p('/shifts/${s['id']}'), {'start': 600});
      final entry = (await history(alice, s['id'])).first;
      await alice.ok('POST', p('/history/${entry['id']}/undo'));
      expect((await alice.ok('POST', p('/history/${entry['id']}/undo')))['changed'], isFalse);
    });

    test('annuler une création supprime le service', () async {
      final s = await createOne(alice);
      final entry = (await history(alice, s['id'])).single;
      await alice.ok('POST', p('/history/${entry['id']}/undo'));
      expect(await week(alice), isEmpty);
    });

    test('annuler la suppression d\'un brouillon le recrée, avec le même identifiant', () async {
      final s = await createOne(alice, start: 420);
      await alice.ok('DELETE', p('/shifts/${s['id']}'));
      final entry = (await history(alice, s['id'])).first;
      await alice.ok('POST', p('/history/${entry['id']}/undo'));
      final back = (await week(alice)).single;
      expect([back['id'], back['start'], back['status']], [s['id'], 420, 'draft']);
    });

    test('annuler la suppression d\'un service publié le rétablit', () async {
      final s = await createOne(alice);
      await alice.ok('POST', p('/publish'));
      await alice.ok('DELETE', p('/shifts/${s['id']}'));
      expect((await week(alice)).single['status'], 'deleted');
      final entry = (await history(alice, s['id'])).first;
      await alice.ok('POST', p('/history/${entry['id']}/undo'));
      expect((await week(alice)).single['status'], 'modified');
    });

    test('une entrée d\'une autre entreprise est introuvable', () async {
      final other = await env.createCompany(alice, 'Autre');
      final s = await createOne(alice);
      final entry = (await history(alice, s['id'])).single;
      expect((await alice('POST', '/companies/$other/history/${entry['id']}/undo')).$1, 404);
    });
  });

  group('conflit entre responsables', () {
    test('la modification la plus récente gagne, l\'autre responsable est prévenu', () async {
      final s = await createOne(alice);
      // Bruno et Alice partent tous deux de la version 1 (par exemple hors connexion).
      await alice.ok('PATCH', p('/shifts/${s['id']}'), {'start': 540, 'baseVersion': 1});
      await bruno.ok('PATCH', p('/shifts/${s['id']}'), {'start': 600, 'baseVersion': 1});

      expect((await week(alice)).single['start'], 600);
      expect((await alice.ok('GET', '/me'))['unreadNotices'], 1);
      expect((await bruno.ok('GET', '/me'))['unreadNotices'], 0);

      final notice = (await alice.ok('GET', '/notices'))['notices'].single;
      expect(notice['kind'], 'shift_overwritten');
      expect(notice['data']['byName'], 'bruno');
      expect(notice['data']['shift']['start'], 540, reason: 'la version d\'Alice, remplacée');
      expect(notice['read'], isFalse);

      await alice.ok('POST', '/notices/read');
      expect((await alice.ok('GET', '/me'))['unreadNotices'], 0);
    });

    test('pas d\'avis si la version est à jour, ou si c\'est sa propre modification', () async {
      final s = await createOne(alice);
      await alice.ok('PATCH', p('/shifts/${s['id']}'), {'start': 540, 'baseVersion': 1});
      await alice.ok('PATCH', p('/shifts/${s['id']}'), {'start': 560, 'baseVersion': 1});
      await bruno.ok('PATCH', p('/shifts/${s['id']}'), {'start': 600, 'baseVersion': 3});
      expect((await alice.ok('GET', '/me'))['unreadNotices'], 0);
    });

    test('une suppression sur une version dépassée prévient aussi', () async {
      final s = await createOne(bruno);
      await bruno.ok('PATCH', p('/shifts/${s['id']}'), {'start': 540});
      await alice.ok('DELETE', p('/shifts/${s['id']}?baseVersion=1'));
      expect((await bruno.ok('GET', '/me'))['unreadNotices'], 1);
    });
  });

  group('requêtes rejouées après une coupure', () {
    Future<(int, String, String?)> post(Client c, String path, Object body, String key) async {
      final res = await env.handler(Request('POST', Uri.parse('http://localhost/api/v1$path'),
          body: jsonEncode(body),
          headers: {'authorization': 'Bearer ${c.token}', 'idempotency-key': key}));
      return (res.statusCode, await res.readAsString(), res.headers['idempotent-replay']);
    }

    test('la même création envoyée deux fois n\'est faite qu\'une fois', () async {
      final body = {'days': ['2026-10-05', '2026-10-06'], 'start': 480, 'end': 1020};
      final first = await post(alice, p('/shifts'), body, 'cle-123');
      final again = await post(alice, p('/shifts'), body, 'cle-123');
      expect(first.$1, 201);
      expect(again.$1, 201);
      expect(again.$2, first.$2, reason: 'même réponse');
      expect(again.$3, 'true');
      expect(await week(alice), hasLength(2));
    });

    test('la clé est propre à chaque utilisateur', () async {
      final body = {'days': ['2026-10-05'], 'start': 480, 'end': 1020};
      await post(alice, p('/shifts'), body, 'meme-cle');
      await post(bruno, p('/shifts'), body, 'meme-cle');
      expect(await week(alice), hasLength(2));
    });

    test('une requête refusée n\'est pas mémorisée', () async {
      final bad = {'days': ['2026-10-05'], 'start': 480, 'end': 1020, 'userId': '00000000-0000-0000-0000-000000000000'};
      expect((await post(alice, p('/shifts'), bad, 'cle-x')).$1, 400);
      // Rejouée, elle est réévaluée (et refusée de nouveau), pas servie depuis la mémoire.
      final replay = await post(alice, p('/shifts'), bad, 'cle-x');
      expect([replay.$1, replay.$3], [400, null]);
    });
  });
}
