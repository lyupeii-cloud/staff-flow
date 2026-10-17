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
    eva = await env.login('eva', ip: '198.51.100.9');
    company = await env.createCompany(owner);
    await env.store.addMember(company, manager.id, Role.manager);
    await env.store.addMember(company, bob.id, Role.employee);
  });

  Future<Map<String, dynamic>> member(Client viewer, Client who) async =>
      (await viewer.ok('GET', '/companies/$company/members'))['members']
          .firstWhere((m) => m['user']['id'] == who.id);

  group('nom choisi par la personne', () {
    test('remplace le nom Google partout, et survit à la reconnexion', () async {
      final user = await bob.ok('PATCH', '/me', {'name': '  Bob Martin '});
      expect([user['name'], user['googleName']], ['Bob Martin', 'bob']);
      await env.login('bob');
      expect((await bob.ok('GET', '/me'))['user']['name'], 'Bob Martin');
      expect((await member(owner, bob))['user']['name'], 'Bob Martin');
    });

    test('vide : on revient au nom Google', () async {
      await bob.ok('PATCH', '/me', {'name': 'Bob Martin'});
      expect((await bob.ok('PATCH', '/me', {'name': ''}))['name'], 'bob');
    });

    test('un nom trop long est refusé', () async {
      expect((await bob('PATCH', '/me', {'name': 'x' * 121})).$1, 400);
    });
  });

  group('nom donné par un responsable dans l\'entreprise', () {
    test('le responsable renomme un salarié ; seule cette entreprise le voit', () async {
      await manager.ok('PUT', '/companies/$company/members/${bob.id}/name', {'name': 'Bob (cuisine)'});
      final m = await member(bob, bob);
      expect([m['user']['name'], m['nameInCompany']], ['Bob (cuisine)', 'Bob (cuisine)']);
      // Ailleurs, c'est toujours son nom à lui.
      expect((await bob.ok('GET', '/me'))['user']['name'], 'bob');
      final (_, details) = await env.lastAudit('member.name');
      expect(details, {'userId': bob.id, 'name': 'Bob (cuisine)'});
    });

    test('le nom de l\'entreprise passe avant celui choisi par la personne, et s\'efface', () async {
      await bob.ok('PATCH', '/me', {'name': 'Bob Martin'});
      await owner.ok('PUT', '/companies/$company/members/${bob.id}/name', {'name': 'Bobby'});
      expect((await member(owner, bob))['user']['name'], 'Bobby');
      await owner.ok('PUT', '/companies/$company/members/${bob.id}/name', {'name': null});
      expect((await member(owner, bob))['user']['name'], 'Bob Martin');
    });

    test('mêmes règles que les rôles : un salarié ne renomme personne, un responsable pas le propriétaire',
        () async {
      expect((await bob('PUT', '/companies/$company/members/${manager.id}/name', {'name': 'X'})).$1, 403);
      expect((await bob('PUT', '/companies/$company/members/${bob.id}/name', {'name': 'X'})).$1, 403);
      expect((await manager('PUT', '/companies/$company/members/${owner.id}/name', {'name': 'X'})).$1, 403);
      expect((await manager('PUT', '/companies/$company/members/${manager.id}/name', {'name': 'Chef'})).$1, 204);
      expect((await owner('PUT', '/companies/$company/members/${eva.id}/name', {'name': 'X'})).$1, 404);
    });
  });

  group('ajout par QR code', () {
    Future<(int, dynamic)> scan(Client c, String qr, {String role = 'employee'}) =>
        c('POST', '/companies/$company/invite', {'qr': qr, 'role': role});

    test('le QR code contient l\'identifiant ; la personne doit accepter', () async {
      final qr = 'https://staff-flow.vercane.com/u/${eva.user['publicId']}';
      final (status, body) = await scan(manager, qr, role: 'extra');
      expect(status, 201);
      expect(body['user']['id'], eva.id);
      expect((await eva.ok('GET', '/me'))['companies'], isEmpty);
      final invite = (await eva.ok('GET', '/me'))['pendingJoinRequests'].single;
      expect(invite['role'], 'extra');
      await eva.ok('POST', '/join-requests/${invite['id']}/accept');
      expect((await member(owner, eva))['role'], 'extra');
    });

    test('le QR code est permanent : il resservira dans une autre entreprise', () async {
      final qr = eva.user['publicId'] as String;
      expect((await scan(owner, qr)).$1, 201);
      final other = await env.createCompany(bob, 'Café');
      expect((await bob('POST', '/companies/$other/invite', {'qr': qr})).$1, 201);
    });

    test('déjà membre, salarié qui scanne, identifiant inconnu', () async {
      expect((await scan(owner, bob.user['publicId'])).$1, 409);
      expect((await scan(bob, eva.user['publicId'])).$1, 403);
      expect((await scan(owner, 'SF-ZZZZZZZZ')).$1, 404);
      expect((await scan(owner, 'n\'importe quoi')).$1, 404);
    });

    test('on ne peut pas essayer des identifiants au hasard', () async {
      for (var i = 0; i < 3; i++) {
        await scan(owner, 'SF-2222222$i');
      }
      expect((await scan(owner, eva.user['publicId'])).$1, 429);
    });
  });
}
