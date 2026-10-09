import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final env = TestEnv();

  late Client owner, manager, bob, eva, outsider;
  late String company;

  setUp(() async {
    owner = await env.login('owner');
    manager = await env.login('manager');
    bob = await env.login('bob');
    eva = await env.login('eva');
    outsider = await env.login('outsider');
    company = await env.createCompany(owner);
    await env.store.addMember(company, manager.id, Role.manager);
    await env.store.addMember(company, bob.id, Role.employee);
    await env.store.addMember(company, eva.id, Role.extra);
  });

  Future<List<dynamic>> conversations(Client c) async =>
      (await c.ok('GET', '/companies/$company/conversations'))['conversations'];

  Future<String> groupId(Client c) async => (await conversations(c)).first['id'];

  Future<String> private(Client c, Client other) async =>
      (await c.ok('POST', '/companies/$company/conversations', {'userId': other.id}))['id'];

  Future<dynamic> say(Client c, String conversation, String text) =>
      c.ok('POST', '/conversations/$conversation/messages', {'body': text});

  Future<List<dynamic>> messages(Client c, String conversation, [String query = '']) async =>
      (await c.ok('GET', '/conversations/$conversation/messages$query'))['messages'];

  group('groupe de l\'entreprise', () {
    test('existe d\'office ; tout le monde le voit, y écrit et lit les messages', () async {
      final id = await groupId(bob);
      expect(await groupId(owner), id);
      final sent = await say(bob, id, '  Bonjour à tous  ');
      expect([sent['body'], sent['authorName']], ['Bonjour à tous', 'bob']);
      await say(eva, id, 'Salut !');
      expect([for (final m in await messages(owner, id)) m['body']], ['Bonjour à tous', 'Salut !']);
    });

    test('une personne extérieure n\'y a pas accès', () async {
      final id = await groupId(bob);
      expect((await outsider('GET', '/conversations/$id/messages')).$1, 404);
      expect((await outsider('POST', '/conversations/$id/messages', {'body': 'x'})).$1, 404);
      expect((await outsider('GET', '/companies/$company/conversations')).$1, 404);
    });

    test('un membre retiré perd l\'accès', () async {
      final id = await groupId(bob);
      await owner.ok('DELETE', '/companies/$company/members/${bob.id}');
      expect((await bob('GET', '/conversations/$id/messages')).$1, 404);
    });

    test('le nom donné par le responsable apparaît dans les messages', () async {
      await owner.ok('PUT', '/companies/$company/members/${bob.id}/name', {'name': 'Bob (cuisine)'});
      final id = await groupId(bob);
      expect((await say(bob, id, 'Coucou'))['authorName'], 'Bob (cuisine)');
      expect((await messages(eva, id)).single['authorName'], 'Bob (cuisine)');
    });
  });

  group('conversations privées', () {
    test('un salarié écrit à un responsable ; la conversation est la même des deux côtés', () async {
      final id = await private(bob, manager);
      expect(await private(manager, bob), id);
      await say(bob, id, 'Je serai en retard');
      final list = await conversations(manager);
      final conv = list.firstWhere((c) => c['id'] == id);
      expect([conv['kind'], conv['with']['name'], conv['lastMessage']['body']],
          ['private', 'bob', 'Je serai en retard']);
      // Personne d'autre ne la voit.
      expect((await conversations(eva)).where((c) => c['id'] == id), isEmpty);
      expect((await eva('GET', '/conversations/$id/messages')).$1, 404);
    });

    test('deux salariés ne peuvent pas s\'écrire en privé', () async {
      expect((await bob('POST', '/companies/$company/conversations', {'userId': eva.id})).$1, 403);
    });

    test('pas de conversation avec soi-même ni avec une personne extérieure', () async {
      expect((await bob('POST', '/companies/$company/conversations', {'userId': bob.id})).$1, 404);
      expect((await owner('POST', '/companies/$company/conversations', {'userId': outsider.id})).$1, 404);
    });

    test('on ne peut plus écrire à quelqu\'un qui a quitté l\'entreprise', () async {
      final id = await private(owner, bob);
      await bob.ok('DELETE', '/companies/$company/members/${bob.id}');
      expect((await owner('POST', '/conversations/$id/messages', {'body': 'Tu es là ?'})).$1, 409);
    });
  });

  group('non lus', () {
    test('comptés par entreprise, remis à zéro à la lecture ; ses propres messages ne comptent pas', () async {
      final id = await groupId(bob);
      await say(bob, id, 'Un');
      await say(bob, id, 'Deux');
      expect((await bob.ok('GET', '/me'))['unreadMessages'], isEmpty);
      expect((await eva.ok('GET', '/me'))['unreadMessages'], {company: 2});
      expect((await conversations(eva)).first['unread'], 2);
      final last = (await messages(eva, id)).last['id'];
      await eva.ok('POST', '/conversations/$id/read', {'lastId': last});
      expect((await eva.ok('GET', '/me'))['unreadMessages'], isEmpty);
    });

    test('un nouveau membre ne reçoit pas tout l\'historique en non lus', () async {
      final id = await groupId(bob);
      await say(bob, id, 'Ancien message');
      final zoe = await env.login('zoe');
      env.clock.advance(const Duration(seconds: 1));
      await env.store.addMember(company, zoe.id, Role.employee);
      expect((await zoe.ok('GET', '/me'))['unreadMessages'], isEmpty);
      // Mais il peut lire l'historique du groupe.
      expect((await messages(zoe, id)).single['body'], 'Ancien message');
    });
  });

  test('historique par pages de 50, du plus ancien au plus récent', () async {
    final id = await groupId(bob);
    for (var i = 1; i <= 55; i++) {
      await say(bob, id, 'm$i');
    }
    final page = await messages(eva, id);
    expect([page.length, page.first['body'], page.last['body']], [50, 'm6', 'm55']);
    final older = await messages(eva, id, '?before=${page.first['id']}');
    expect([for (final m in older) m['body']], ['m1', 'm2', 'm3', 'm4', 'm5']);
  });

  test('message vide ou trop long refusé', () async {
    final id = await groupId(bob);
    expect((await bob('POST', '/conversations/$id/messages', {'body': '   '})).$1, 400);
    expect((await bob('POST', '/conversations/$id/messages', {'body': 'x' * 2001})).$1, 400);
  });

  test('message renvoyé après une coupure (même clé) : enregistré une seule fois', () async {
    final id = await groupId(bob);
    for (var i = 0; i < 2; i++) {
      final res = await env.handler(Request('POST', Uri.parse('http://localhost/api/v1/conversations/$id/messages'),
          body: jsonEncode({'body': 'Une fois'}),
          headers: {'authorization': 'Bearer ${bob.token}', 'idempotency-key': 'cle-1'}));
      expect(res.statusCode, 201);
    }
    expect(await messages(eva, id), hasLength(1));
  });

  group('notifications', () {
    Future<void> device(Client c, String token) =>
        c.ok('PUT', '/devices', {'token': token, 'platform': 'android', 'language': 'fr'});

    Future<List<PushMessage>> sent() async {
      await env.api.notifications.settle();
      return env.push.sent;
    }

    test('groupe : tous les autres membres sont prévenus, sans avis dans la cloche', () async {
      await device(owner, 'tel-owner');
      await device(bob, 'tel-bob');
      await device(eva, 'tel-eva');
      await say(bob, await groupId(bob), 'Qui peut me remplacer samedi ?');
      final m = await sent();
      expect(m.map((m) => m.token), unorderedEquals(['tel-owner', 'tel-eva']));
      expect([m.first.title, m.first.body], ['Boulangerie · bob', 'Qui peut me remplacer samedi ?']);
      expect(m.first.data['kind'], 'message');
      expect((await eva.ok('GET', '/notices'))['notices'], isEmpty);
    });

    test('privé : seule l\'autre personne ; famille « messages » coupée : rien', () async {
      await device(manager, 'tel-manager');
      await device(owner, 'tel-owner');
      final id = await private(bob, manager);
      await say(bob, id, 'Bonjour');
      expect((await sent()).single.title, 'bob · Boulangerie');
      env.push.sent.clear();
      await manager.ok('PATCH', '/me/notifications', {'messages': false});
      await say(bob, id, 'Encore moi');
      expect(await sent(), isEmpty);
    });
  });
}
