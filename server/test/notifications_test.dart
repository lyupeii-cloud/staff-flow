import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final env = TestEnv();

  late Client owner, manager, bob, eva;
  late String company;

  setUp(() async {
    owner = await env.login('owner');
    manager = await env.login('manager');
    bob = await env.login('bob');
    eva = await env.login('eva');
    company = await env.createCompany(owner);
    await env.store.addMember(company, manager.id, Role.manager);
    await env.store.addMember(company, bob.id, Role.employee);
    await env.store.addMember(company, eva.id, Role.employee);
  });

  Future<void> device(Client c, String token, {String language = 'fr'}) =>
      c.ok('PUT', '/devices', {'token': token, 'platform': 'android', 'language': language});

  Future<List<PushMessage>> sent() async {
    await env.api.notifications.settle();
    return env.push.sent;
  }

  Future<void> shift(Client c, String? userId, {String day = '2026-10-06'}) =>
      c.ok('POST', '/companies/$company/shifts', {'days': [day], 'start': 480, 'end': 960, 'userId': userId});

  group('publication du planning', () {
    test('une seule notification par salarié concerné, dans sa langue', () async {
      await device(bob, 'tel-bob');
      await device(eva, 'tel-eva', language: 'uk');
      await shift(owner, bob.id);
      await shift(owner, bob.id, day: '2026-10-07');
      await shift(owner, eva.id);
      await owner.ok('POST', '/companies/$company/publish');

      final messages = await sent();
      expect(messages.map((m) => m.token), unorderedEquals(['tel-bob', 'tel-eva']));
      final toBob = messages.firstWhere((m) => m.token == 'tel-bob');
      expect([toBob.title, toBob.body], ['Boulangerie', 'Votre planning a été publié ou modifié.']);
      expect(toBob.data['kind'], 'schedule_published');
      expect(toBob.data['companyId'], company);
      expect(messages.firstWhere((m) => m.token == 'tel-eva').body, 'Ваш графік опубліковано або змінено.');
    });

    test('les salariés qui ne sont pas concernés ne reçoivent rien', () async {
      await device(bob, 'tel-bob');
      await device(eva, 'tel-eva');
      await shift(owner, bob.id);
      await owner.ok('POST', '/companies/$company/publish');
      expect((await sent()).map((m) => m.token), ['tel-bob']);
    });

    test('un salarié retiré d\'un service est prévenu aussi', () async {
      await shift(owner, bob.id);
      await owner.ok('POST', '/companies/$company/publish');
      await device(bob, 'tel-bob');
      await device(eva, 'tel-eva');
      final s = (await owner.ok('GET', '/companies/$company/shifts?from=2026-10-06&to=2026-10-06'))['shifts'].single;
      await owner.ok('PATCH', '/companies/$company/shifts/${s['id']}', {'userId': eva.id});
      await owner.ok('POST', '/companies/$company/publish');
      expect((await sent()).map((m) => m.token), unorderedEquals(['tel-bob', 'tel-eva']));
    });

    test('l\'avis apparaît aussi dans la cloche, même sans téléphone enregistré', () async {
      await shift(owner, bob.id);
      await owner.ok('POST', '/companies/$company/publish');
      final notices = (await bob.ok('GET', '/notices'))['notices'];
      expect(notices.single['kind'], 'schedule_published');
      expect((await bob.ok('GET', '/me'))['unreadNotices'], 1);
      expect(await sent(), isEmpty);
    });
  });

  group('choix des notifications', () {
    test('toutes activées par défaut ; une famille coupée ne sonne plus', () async {
      expect((await bob.ok('GET', '/me'))['notificationPrefs']['planning'], isTrue);
      final prefs = await bob.ok('PATCH', '/me/notifications', {'planning': false});
      expect([prefs['planning'], prefs['messages']], [false, true]);

      await device(bob, 'tel-bob');
      await shift(owner, bob.id);
      await owner.ok('POST', '/companies/$company/publish');
      expect(await sent(), isEmpty);
      // L'avis reste visible dans l'application.
      expect((await bob.ok('GET', '/notices'))['notices'], hasLength(1));
    });

    test('une famille inconnue est refusée', () async {
      expect((await bob('PATCH', '/me/notifications', {'pirate': true})).$1, 400);
      expect((await bob('PATCH', '/me/notifications', {'planning': 'non'})).$1, 400);
    });
  });

  group('appareils', () {
    test('plusieurs appareils par personne ; la déconnexion en retire un', () async {
      await device(bob, 'tel-bob');
      await bob.ok('PUT', '/devices', {'token': 'pc-bob', 'platform': 'web', 'language': 'fr'});
      await bob.ok('POST', '/devices/forget', {'token': 'tel-bob'});
      await shift(owner, bob.id);
      await owner.ok('POST', '/companies/$company/publish');
      expect((await sent()).map((m) => m.token), ['pc-bob']);
    });

    test('un téléphone partagé ne reçoit que pour le dernier compte connecté', () async {
      await device(bob, 'tel-commun');
      await device(eva, 'tel-commun');
      await shift(owner, bob.id);
      await owner.ok('POST', '/companies/$company/publish');
      expect(await sent(), isEmpty);
    });

    test('un jeton refusé par Firebase est oublié', () async {
      await device(bob, 'tel-perime');
      env.push.invalid.add('tel-perime');
      await shift(owner, bob.id);
      await owner.ok('POST', '/companies/$company/publish');
      await sent();
      env.push.invalid.clear();
      await shift(owner, bob.id, day: '2026-10-08');
      await owner.ok('POST', '/companies/$company/publish');
      expect(await sent(), isEmpty);
    });

    test('plateforme inconnue refusée', () async {
      expect((await bob('PUT', '/devices', {'token': 't', 'platform': 'ios'})).$1, 400);
    });
  });

  group('autres événements', () {
    test('invitation à rejoindre une entreprise', () async {
      final newcomer = await env.login('zoe');
      await device(newcomer, 'tel-zoe');
      await owner.ok('POST', '/companies/$company/invite', {'qr': newcomer.user['publicId']});
      final m = (await sent()).single;
      expect([m.title, m.body, m.data['kind']],
          ['Boulangerie', 'Cette entreprise veut vous ajouter à son équipe.', 'join_invite']);
    });

    test('proposition de transfert de propriété', () async {
      await device(manager, 'tel-manager', language: 'en');
      await owner.ok('POST', '/companies/$company/transfer', {'toUserId': manager.id});
      expect((await sent()).single.body, 'owner offers to make you the owner of the company.');
    });

    test('modification remplacée par un autre responsable', () async {
      await device(manager, 'tel-manager');
      await shift(manager, bob.id);
      final s = (await owner.ok('GET', '/companies/$company/shifts?from=2026-10-06&to=2026-10-06'))['shifts'].single;
      // Le propriétaire modifie une version plus ancienne que celle du responsable.
      await manager.ok('PATCH', '/companies/$company/shifts/${s['id']}', {'start': 540, 'baseVersion': s['version']});
      await owner.ok('PATCH', '/companies/$company/shifts/${s['id']}', {'start': 600, 'baseVersion': s['version']});
      final m = (await sent()).single;
      expect(m.title, 'Un autre responsable a modifié ce planning');
      expect(m.body, 'Boulangerie · owner a remplacé votre modification.');
    });
  });
}
