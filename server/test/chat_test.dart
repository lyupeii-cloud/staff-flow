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

  group('groupes créés par un responsable', () {
    Future<String> team(Client c, String name, List<Client> people) async =>
        (await c.ok('POST', '/companies/$company/groups', {
          'name': name,
          'userIds': [for (final p in people) p.id],
        }))['id'];

    test('seules les personnes choisies (et le responsable) le voient et y écrivent', () async {
      final id = await team(manager, 'Cuisine', [bob]);
      final conv = (await conversations(bob)).firstWhere((c) => c['id'] == id);
      expect([conv['kind'], conv['name']], ['team', 'Cuisine']);
      expect(conv['memberIds'], unorderedEquals([manager.id, bob.id]));
      await say(bob, id, 'Il manque des œufs');
      expect((await messages(manager, id)).single['body'], 'Il manque des œufs');
      // Eva n'en fait pas partie, le propriétaire non plus.
      expect((await conversations(eva)).where((c) => c['id'] == id), isEmpty);
      expect((await eva('GET', '/conversations/$id/messages')).$1, 404);
      expect((await owner('POST', '/conversations/$id/messages', {'body': 'x'})).$1, 404);
    });

    test('un salarié ne crée pas de groupe ; une personne extérieure ne peut pas être ajoutée', () async {
      expect((await bob('POST', '/companies/$company/groups', {'name': 'X', 'userIds': [eva.id]})).$1, 403);
      expect((await manager('POST', '/companies/$company/groups', {'name': 'X', 'userIds': [outsider.id]})).$1, 404);
      expect((await manager('POST', '/companies/$company/groups', {'name': ' ', 'userIds': [bob.id]})).$1, 400);
    });

    test('renommer, ajouter et retirer des personnes', () async {
      final id = await team(manager, 'Cuisine', [bob]);
      await say(bob, id, 'Avant l\'arrivée d\'Eva');
      env.clock.advance(const Duration(seconds: 1));
      await owner.ok('PATCH', '/conversations/$id', {'name': 'Équipe du matin', 'userIds': [manager.id, eva.id]});
      final conv = (await conversations(eva)).firstWhere((c) => c['id'] == id);
      expect(conv['name'], 'Équipe du matin');
      // Eva lit l'historique, sans que les anciens messages comptent comme non lus.
      expect((await messages(eva, id)).single['body'], 'Avant l\'arrivée d\'Eva');
      expect(conv['unread'], 0);
      // Bob a été retiré.
      expect((await bob('GET', '/conversations/$id/messages')).$1, 404);
      expect((await bob('PATCH', '/conversations/$id', {'name': 'Pirate'})).$1, 403);
    });

    test('notification aux membres du groupe seulement', () async {
      await owner.ok('PUT', '/devices', {'token': 'tel-owner', 'platform': 'android', 'language': 'fr'});
      await bob.ok('PUT', '/devices', {'token': 'tel-bob', 'platform': 'android', 'language': 'fr'});
      await eva.ok('PUT', '/devices', {'token': 'tel-eva', 'platform': 'android', 'language': 'fr'});
      final id = await team(manager, 'Cuisine', [bob, eva]);
      await say(eva, id, 'Je suis là');
      await env.api.notifications.settle();
      expect(env.push.sent.map((m) => m.token), ['tel-bob']);
      expect(env.push.sent.single.title, 'Cuisine · eva');
    });
  });

  group('réponses, citations et traduction', () {
    test('répondre à un message : l\'extrait du message d\'origine accompagne la réponse', () async {
      final id = await groupId(bob);
      final question = await say(bob, id, 'Qui peut me remplacer samedi ?');
      final answer = await eva.ok('POST', '/conversations/$id/messages',
          {'body': 'Moi !', 'replyTo': question['id']});
      expect(answer['replyTo'], {
        'id': question['id'],
        'authorId': bob.id,
        'authorName': 'bob',
        'body': 'Qui peut me remplacer samedi ?',
      });
      expect((await messages(owner, id)).last['replyTo']['id'], question['id']);
    });

    test('on ne répond pas à un message d\'une autre conversation', () async {
      final other = await say(bob, await private(bob, manager), 'Privé');
      final (status, _) = await eva('POST', '/conversations/${await groupId(eva)}/messages',
          {'body': 'x', 'replyTo': other['id']});
      expect(status, 404);
    });

    test('citer une personne avec « # » : son nom dans l\'entreprise est gardé avec le message', () async {
      await owner.ok('PUT', '/companies/$company/members/${bob.id}/name', {'name': 'Bob (cuisine)'});
      final id = await groupId(eva);
      final m = await eva.ok('POST', '/conversations/$id/messages',
          {'body': '#Bob (cuisine) tu as vu ?', 'mentions': [bob.id]});
      expect(m['mentions'], [
        {'id': bob.id, 'name': 'Bob (cuisine)'}
      ]);
    });

    test('on ne cite que quelqu\'un qui voit la conversation', () async {
      final conv = await private(bob, manager);
      expect((await bob('POST', '/conversations/$conv/messages', {'body': '#eva', 'mentions': [eva.id]})).$1, 404);
    });

    test('les derniers messages d\'une personne (bulle de la personne citée)', () async {
      final id = await groupId(bob);
      for (var i = 1; i <= 12; i++) {
        await say(bob, id, 'Bob $i');
        await say(eva, id, 'Eva $i');
      }
      final last = (await owner.ok('GET', '/conversations/$id/messages?author=${bob.id}&limit=10'))['messages'];
      expect([for (final m in last) m['body']], [for (var i = 3; i <= 12; i++) 'Bob $i']);
    });

    test('traduction dans la langue demandée, gardée pour la fois suivante', () async {
      final id = await groupId(bob);
      final m = await say(bob, id, 'Я запізнюся');
      final first = await eva.ok('POST', '/messages/${m['id']}/translate', {'lang': 'fr'});
      expect(first['text'], '[fr] Я запізнюся');
      await owner.ok('POST', '/messages/${m['id']}/translate', {'lang': 'fr-FR'});
      expect(env.translator.calls, 1);
      // Codes de l'application → codes du traducteur.
      expect((await eva.ok('POST', '/messages/${m['id']}/translate', {'lang': 'zh'}))['text'], startsWith('[zh-Hans]'));
      expect((await eva.ok('POST', '/messages/${m['id']}/translate', {'lang': 'fil'}))['text'], startsWith('[tl]'));
    });

    test('langue non prise en charge, traducteur en panne, message d\'une autre conversation', () async {
      final m = await say(bob, await groupId(bob), 'Salut');
      expect((await eva('POST', '/messages/${m['id']}/translate', {'lang': 'kk'})).$1, 422);
      env.translator.down = true;
      expect((await eva('POST', '/messages/${m['id']}/translate', {'lang': 'uk'})).$1, 409);
      env.translator.down = false;
      expect((await outsider('POST', '/messages/${m['id']}/translate', {'lang': 'uk'})).$1, 404);
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
