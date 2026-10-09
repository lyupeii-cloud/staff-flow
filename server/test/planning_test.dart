import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final env = TestEnv();

  late Client boss, bob, carol;
  late String company;

  setUp(() async {
    boss = await env.login('boss');
    bob = await env.login('bob');
    carol = await env.login('carol');
    company = await env.createCompany(boss);
    await env.store.addMember(company, bob.id, Role.employee);
    await env.store.addMember(company, carol.id, Role.employee);
  });

  String p(String path) => '/companies/$company$path';

  Future<List<dynamic>> create(Map<String, Object?> body) async =>
      (await boss.ok('POST', p('/shifts'), body))['shifts'];

  Future<Map<String, dynamic>> week(Client c, [String from = '2026-10-05', String to = '2026-10-11']) async =>
      await c.ok('GET', p('/shifts?from=$from&to=$to'));

  Map<String, Object?> shift(List<String> days, {String? user, int start = 480, int end = 1020}) =>
      {'days': days, 'start': start, 'end': end, 'userId': user};

  group('sites et postes', () {
    test('le responsable crée, renomme et archive ; un salarié lit seulement', () async {
      final caisse = await boss.ok('POST', p('/positions'), {'name': 'Caisse'});
      await boss.ok('POST', p('/positions'), {'name': 'Cuisine'});
      await boss.ok('PATCH', p('/positions/${caisse['id']}'), {'name': 'Caisse 1', 'archived': true});
      final items = (await bob.ok('GET', p('/positions')))['items'];
      expect([for (final i in items) '${i['name']}:${i['archived']}'], ['Cuisine:false', 'Caisse 1:true']);
      expect((await bob('POST', p('/sites'), {'name': 'Magasin A'})).$1, 403);
    });

    test('un poste archivé ne peut plus être affecté', () async {
      final pos = await boss.ok('POST', p('/positions'), {'name': 'Caisse'});
      await boss.ok('PATCH', p('/positions/${pos['id']}'), {'archived': true});
      final (status, _) = await boss('POST', p('/shifts'), {...shift(['2026-10-05']), 'positionId': pos['id']});
      expect(status, 400);
    });

    test('un poste d\'une autre entreprise est refusé', () async {
      final other = await env.createCompany(boss, 'Autre');
      final pos = await boss.ok('POST', '/companies/$other/positions', {'name': 'Caisse'});
      final (status, _) = await boss('POST', p('/shifts'), {...shift(['2026-10-05']), 'positionId': pos['id']});
      expect(status, 400);
    });
  });

  group('création', () {
    test('un service par jour choisi, avec site et poste', () async {
      final site = await boss.ok('POST', p('/sites'), {'name': 'Magasin A'});
      final pos = await boss.ok('POST', p('/positions'), {'name': 'Caisse'});
      final created = await create({
        ...shift(['2026-10-06', '2026-10-05'], user: bob.id),
        'siteId': site['id'],
        'positionId': pos['id'],
      });
      expect([for (final s in created) s['day']], ['2026-10-05', '2026-10-06']);
      expect(created.first, containsPair('positionId', pos['id']));
      expect(created.first['status'], 'draft');
    });

    test('un service de nuit se termine le lendemain', () async {
      final s = (await create(shift(['2026-10-05'], start: 22 * 60, end: 6 * 60))).single;
      expect(s['end'], 30 * 60);
    });

    test('on ne peut pas affecter quelqu\'un d\'extérieur', () async {
      final stranger = await env.login('stranger');
      expect((await boss('POST', p('/shifts'), shift(['2026-10-05'], user: stranger.id))).$1, 400);
    });

    test('un salarié ne crée pas de service', () async {
      expect((await bob('POST', p('/shifts'), shift(['2026-10-05']))).$1, 403);
    });

    test('heures ou dates invalides : 400', () async {
      expect((await boss('POST', p('/shifts'), shift(['2026-13-01']))).$1, 400);
      expect((await boss('POST', p('/shifts'), shift(['2026-10-05'], start: 1500))).$1, 400);
      expect((await boss('POST', p('/shifts'), {'days': ['2026-10-05'], 'start': '8h'})).$1, 400);
    });
  });

  group('répétition', () {
    test('certains jours de la semaine, pendant 2 semaines', () async {
      final created = await create({
        ...shift(['2026-10-05']),
        'repeat': {'freq': 'weekly', 'weekdays': [1, 3], 'count': 2},
      });
      expect([for (final s in created) s['day']],
          ['2026-10-05', '2026-10-07', '2026-10-12', '2026-10-14']);
      expect(created.map((s) => s['seriesId']).toSet(), hasLength(1));
    });

    test('sans jours précisés, on reprend ceux choisis', () async {
      final created = await create({
        ...shift(['2026-10-06', '2026-10-09']),
        'repeat': {'freq': 'weekly', 'until': '2026-10-16'},
      });
      expect([for (final s in created) s['day']],
          ['2026-10-06', '2026-10-09', '2026-10-13', '2026-10-16']);
    });

    test('chaque jour jusqu\'à une date', () async {
      final created = await create({
        ...shift(['2026-10-05']),
        'repeat': {'freq': 'daily', 'until': '2026-10-08'},
      });
      expect(created, hasLength(4));
    });

    test('répétition sans fin : refusée', () async {
      final (status, _) =
          await boss('POST', p('/shifts'), {...shift(['2026-10-05']), 'repeat': {'freq': 'daily'}});
      expect(status, 400);
    });

    test('modifier une occurrence seule ne casse pas la série', () async {
      final created = await create({
        ...shift(['2026-10-05'], user: bob.id),
        'repeat': {'freq': 'daily', 'count': 3},
      });
      await boss.ok('PATCH', p('/shifts/${created[1]['id']}?scope=one'), {'start': 600});
      await boss.ok('PATCH', p('/shifts/${created[0]['id']}?scope=series'), {'userId': carol.id, 'end': 960});

      final shifts = (await week(boss))['shifts'];
      expect([for (final s in shifts) '${s['start']}-${s['end']}'], ['480-960', '600-1020', '480-960']);
      // L'occurrence modifiée à part garde sa personne ; les autres changent.
      expect([for (final s in shifts) s['userId']], [carol.id, bob.id, carol.id]);
      expect(shifts.map((s) => s['seriesId']).toSet(), hasLength(1));
    });

    test('« cette occurrence et les suivantes » ne touche pas le passé', () async {
      final created = await create({...shift(['2026-10-05']), 'repeat': {'freq': 'daily', 'count': 3}});
      await boss.ok('PATCH', p('/shifts/${created[1]['id']}?scope=series'), {'start': 540});
      expect([for (final s in (await week(boss))['shifts']) s['start']], [480, 540, 540]);
    });

    test('supprimer la suite de la série', () async {
      final created = await create({...shift(['2026-10-05']), 'repeat': {'freq': 'daily', 'count': 4}});
      final body = await boss.ok('DELETE', p('/shifts/${created[2]['id']}?scope=series'));
      expect(body['deleted'], 2);
      expect((await week(boss))['shifts'], hasLength(2));
    });

    test('déplacer toute une série d\'un jour : refusé', () async {
      final created = await create({...shift(['2026-10-05']), 'repeat': {'freq': 'daily', 'count': 2}});
      final (status, _) =
          await boss('PATCH', p('/shifts/${created[0]['id']}?scope=series'), {'day': '2026-10-06'});
      expect(status, 400);
    });
  });

  group('brouillon et publication', () {
    test('les salariés ne voient rien avant la publication', () async {
      await create(shift(['2026-10-05'], user: bob.id));
      expect((await week(bob))['shifts'], isEmpty);
      expect((await week(boss))['pending'], 1);

      final pub = await boss.ok('POST', p('/publish'));
      expect(pub, {'published': 1, 'notifiedUsers': 1});
      final seen = (await week(bob))['shifts'].single;
      expect(seen['userId'], bob.id);
      expect(seen['status'], 'published');
      expect((await week(boss))['pending'], 0);
    });

    test('une modification reste invisible jusqu\'à la publication suivante', () async {
      final id = (await create(shift(['2026-10-05'], user: bob.id))).single['id'];
      await boss.ok('POST', p('/publish'));
      await boss.ok('PATCH', p('/shifts/$id'), {'start': 600, 'day': '2026-10-06'});

      expect((await week(boss))['shifts'].single['status'], 'modified');
      final seen = (await week(bob))['shifts'].single;
      expect([seen['day'], seen['start']], ['2026-10-05', 480]);

      await boss.ok('POST', p('/publish'));
      final after = (await week(bob))['shifts'].single;
      expect([after['day'], after['start']], ['2026-10-06', 600]);
    });

    test('un service publié puis supprimé disparaît à la publication', () async {
      final id = (await create(shift(['2026-10-05'], user: bob.id))).single['id'];
      await boss.ok('POST', p('/publish'));
      await boss.ok('DELETE', p('/shifts/$id'));
      expect((await week(boss))['shifts'].single['status'], 'deleted');
      expect((await week(bob))['shifts'], hasLength(1));
      await boss.ok('POST', p('/publish'));
      expect((await week(bob))['shifts'], isEmpty);
      expect((await week(boss))['shifts'], isEmpty);
    });

    test('un brouillon supprimé disparaît tout de suite', () async {
      final id = (await create(shift(['2026-10-05']))).single['id'];
      await boss.ok('DELETE', p('/shifts/$id'));
      expect((await week(boss))['pending'], 0);
    });

    test('la publication prévient l\'ancienne et la nouvelle personne', () async {
      final id = (await create(shift(['2026-10-05'], user: bob.id))).single['id'];
      await boss.ok('POST', p('/publish'));
      await boss.ok('PATCH', p('/shifts/$id'), {'userId': carol.id});
      expect((await boss.ok('POST', p('/publish')))['notifiedUsers'], 2);
    });
  });

  group('remplacement', () {
    test('remplace une personne sur la période, pas en dehors', () async {
      await create({...shift(['2026-10-05'], user: bob.id), 'repeat': {'freq': 'daily', 'count': 5}});
      final body = await boss.ok('POST', p('/shifts/replace'),
          {'fromUserId': bob.id, 'toUserId': carol.id, 'from': '2026-10-06', 'to': '2026-10-08'});
      expect(body['replaced'], 3);
      expect([for (final s in (await week(boss))['shifts']) s['userId'] == bob.id ? 'b' : 'c'].join(),
          'bcccb');
    });

    test('le remplaçant doit faire partie de l\'entreprise', () async {
      final stranger = await env.login('stranger');
      final (status, _) = await boss('POST', p('/shifts/replace'),
          {'fromUserId': bob.id, 'toUserId': stranger.id, 'from': '2026-10-05', 'to': '2026-10-11'});
      expect(status, 400);
    });
  });

  group('jours de plus d\'un mois en lecture seule', () {
    // Aujourd'hui (horloge de test) : 5 octobre 2026 → modifiable à partir du 5 septembre.
    test('création refusée avant la limite, acceptée à partir de la limite', () async {
      expect((await boss('POST', p('/shifts'), shift(['2026-09-04'], user: bob.id))).$1, 409);
      expect((await boss('POST', p('/shifts'), shift(['2026-09-05'], user: bob.id))).$1, 201);
    });

    test('un service devenu trop ancien ne se modifie, ne se supprime ni ne s\'annule plus', () async {
      final s = (await create(shift(['2026-09-20'], user: bob.id))).single;
      await boss.ok('POST', p('/publish'));
      env.clock.advance(const Duration(days: 40));
      expect((await boss('PATCH', p('/shifts/${s['id']}'), {'start': 540})).$1, 409);
      expect((await boss('DELETE', p('/shifts/${s['id']}'))).$1, 409);
      final history = (await boss.ok('GET', p('/history?shiftId=${s['id']}')))['entries'];
      expect((await boss('POST', p('/history/${history.first['id']}/undo'))).$1, 409);
      // Il reste visible.
      expect((await week(bob, '2026-09-20', '2026-09-20'))['shifts'], hasLength(1));
    });

    test('déplacer un service vers un jour trop ancien est refusé', () async {
      final s = (await create(shift(['2026-10-06'], user: bob.id))).single;
      expect((await boss('PATCH', p('/shifts/${s['id']}'), {'day': '2026-08-01'})).$1, 409);
    });

    test('le remplacement épargne les jours trop anciens', () async {
      // Créés il y a deux mois, quand ces jours étaient encore modifiables.
      env.clock.advance(const Duration(days: -60));
      await create(shift(['2026-08-01'], user: bob.id));
      await create(shift(['2026-09-01'], user: bob.id));
      await create(shift(['2026-09-10'], user: bob.id));
      env.clock.advance(const Duration(days: 60));
      await boss.ok('POST', p('/shifts/replace'),
          {'fromUserId': bob.id, 'toUserId': carol.id, 'from': '2026-08-01', 'to': '2026-09-30'});
      final all = (await week(boss, '2026-08-01', '2026-09-30'))['shifts'];
      expect({for (final s in all) s['day']: s['userId']},
          {'2026-08-01': bob.id, '2026-09-01': bob.id, '2026-09-10': carol.id});
    });
  });

  group('consultation', () {
    test('période trop longue ou à l\'envers : 400', () async {
      expect((await boss('GET', p('/shifts?from=2026-10-01&to=2026-12-31'))).$1, 400);
      expect((await boss('GET', p('/shifts?from=2026-10-10&to=2026-10-01'))).$1, 400);
    });

    test('une personne extérieure ne voit pas le planning', () async {
      final stranger = await env.login('stranger');
      expect((await stranger('GET', p('/shifts?from=2026-10-05&to=2026-10-11'))).$1, 404);
    });

    test('un service d\'une autre entreprise est introuvable', () async {
      final other = await env.createCompany(boss, 'Autre');
      final id = (await create(shift(['2026-10-05']))).single['id'];
      expect((await boss('PATCH', '/companies/$other/shifts/$id', {'start': 600})).$1, 404);
    });
  });
}
