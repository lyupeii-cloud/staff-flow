import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final env = TestEnv();

  late Client owner, bob;
  late String company;

  setUp(() async {
    owner = await env.login('owner');
    bob = await env.login('bob', ip: '198.51.100.7');
    company = await env.createCompany(owner);
  });

  Future<String> code(Client c) async => (await c.ok('POST', '/join-codes'))['code'];

  Future<(int, dynamic)> redeem(Client manager, String code, {String role = 'employee'}) =>
      manager('POST', '/companies/$company/join', {'code': code, 'role': role});

  test('le code a 6 chiffres et expire après 2 minutes', () async {
    final body = await bob.ok('POST', '/join-codes');
    expect(body['code'], matches(RegExp(r'^\d{6}$')));
    expect(DateTime.parse(body['expiresAt']), env.clock.now.add(const Duration(minutes: 2)));
  });

  test('code saisi, puis le salarié accepte : il rejoint l\'entreprise', () async {
    final (status, body) = await redeem(owner, await code(bob));
    expect(status, 201);
    expect(body['user']['name'], 'bob');

    // Rien ne change tant que le salarié n'a pas accepté.
    expect((await bob.ok('GET', '/me'))['companies'], isEmpty);
    final invite = (await bob.ok('GET', '/me'))['pendingJoinRequests'].single;
    expect(invite['company']['id'], company);
    expect(invite['role'], 'employee');

    await bob.ok('POST', '/join-requests/${invite['id']}/accept');
    final me = await bob.ok('GET', '/me');
    expect(me['companies'].single['role'], 'employee');
    expect(me['pendingJoinRequests'], isEmpty);
  });

  test('le salarié peut refuser', () async {
    await redeem(owner, await code(bob), role: 'extra');
    final invite = (await bob.ok('GET', '/me'))['pendingJoinRequests'].single;
    expect(invite['role'], 'extra');
    await bob.ok('POST', '/join-requests/${invite['id']}/decline');
    expect((await bob.ok('GET', '/me'))['companies'], isEmpty);
  });

  test('un code ne sert qu\'une fois', () async {
    final c = await code(bob);
    expect((await redeem(owner, c)).$1, 201);
    expect((await redeem(owner, c)).$1, 404);
  });

  test('un code expiré est refusé', () async {
    final c = await code(bob);
    env.clock.advance(const Duration(minutes: 2, seconds: 1));
    expect((await redeem(owner, c)).$1, 404);
  });

  test('générer un nouveau code annule le précédent', () async {
    final first = await code(bob);
    await code(bob);
    expect((await redeem(owner, first)).$1, 404);
  });

  test('un salarié ne peut pas ajouter quelqu\'un', () async {
    final carol = await env.login('carol');
    await env.store.addMember(company, carol.id, Role.employee);
    expect((await redeem(carol, await code(bob))).$1, 403);
  });

  test('on ne peut ajouter que des salariés ou des extras', () async {
    expect((await redeem(owner, await code(bob), role: 'manager')).$1, 400);
  });

  test('ajouter quelqu\'un déjà membre est refusé', () async {
    await env.store.addMember(company, bob.id, Role.employee);
    expect((await redeem(owner, await code(bob))).$1, 409);
  });

  group('après 3 codes erronés', () {
    Future<void> fail3(Client manager) async {
      for (var i = 0; i < 3; i++) {
        expect((await redeem(manager, '000000')).$1, 404);
      }
    }

    test('le responsable est bloqué 2 minutes, même avec un bon code', () async {
      await fail3(owner);
      final (status, body) = await redeem(owner, await code(bob));
      expect(status, 429);
      expect(body['error']['code'], 'too_many_attempts');

      env.clock.advance(const Duration(minutes: 2, seconds: 1));
      expect((await redeem(owner, await code(bob))).$1, 201);
    });

    test('un autre responsable de la même entreprise est bloqué aussi', () async {
      final other = await env.login('other', ip: '192.0.2.99');
      await env.store.addMember(company, other.id, Role.manager);
      await fail3(owner);
      expect((await redeem(other, await code(bob))).$1, 429);
    });

    test('la même connexion (IP) est bloquée pour une autre entreprise', () async {
      final other = await env.login('other'); // même IP que owner
      final otherCompany = await env.createCompany(other, 'Autre');
      await fail3(owner);
      final (status, _) = await other(
          'POST', '/companies/$otherCompany/join', {'code': await code(bob), 'role': 'employee'});
      expect(status, 429);
    });

    test('les tentatives pendant le blocage ne le prolongent pas', () async {
      await fail3(owner);
      env.clock.advance(const Duration(minutes: 1));
      expect((await redeem(owner, '000000')).$1, 429);
      env.clock.advance(const Duration(minutes: 1, seconds: 1));
      expect((await redeem(owner, await code(bob))).$1, 201);
    });

    test('toutes les tentatives sont journalisées', () async {
      await fail3(owner);
      await redeem(owner, '000000');
      final (actor, details) = await env.lastAudit('join.blocked');
      expect(actor, owner.id);
      expect(details['ip'], '203.0.113.1');
    });
  });
}
