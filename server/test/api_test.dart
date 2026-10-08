import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final env = TestEnv();
  Future<Client> login(String sub) => env.login(sub);
  Future<String> createCompany(Client c, [String name = 'Boulangerie']) =>
      env.createCompany(c, name);

  group('connexion', () {
    test('un jeton Google valide crée le compte avec un identifiant unique', () async {
      final alice = await login('alice');
      expect(alice.user['publicId'], matches(RegExp(r'^SF-[A-Z2-9]{8}$')));
      final (status, me) = await alice('GET', '/me');
      expect(status, 200);
      expect(me['user']['email'], 'alice@example.com');
      expect(me['companies'], isEmpty);
    });

    test('se reconnecter garde le même compte', () async {
      final first = await login('alice');
      final second = await login('alice');
      expect(second.id, first.id);
      expect(second.user['publicId'], first.user['publicId']);
    });

    test('un jeton Google invalide est refusé', () async {
      final (status, body) = await Client(env.handler)('POST', '/auth/google', {'idToken': 'faux'});
      expect(status, 401);
      expect(body['error']['code'], 'unauthorized');
    });

    test('sans session, l\'API répond 401', () async {
      final (status, _) = await Client(env.handler)('GET', '/me');
      expect(status, 401);
    });

    test('la connexion de développement est fermée par défaut', () async {
      final (status, _) = await Client(env.handler)('POST', '/auth/dev', {'email': 'a@b.c'});
      expect(status, 404);
    });
  });

  group('entreprises', () {
    test('le créateur devient propriétaire et voit un onglet par entreprise', () async {
      final alice = await login('alice');
      await createCompany(alice, 'Boulangerie');
      await createCompany(alice, 'Café');
      final (_, me) = await alice('GET', '/me');
      expect([for (final m in me['companies']) m['company']['name']], ['Boulangerie', 'Café']);
      expect([for (final m in me['companies']) m['role']], ['owner', 'owner']);
    });

    test('un fuseau horaire invalide est refusé', () async {
      final alice = await login('alice');
      final (status, _) =
          await alice('POST', '/companies', {'name': 'X', 'timezone': 'Paris'});
      expect(status, 400);
    });

    test('une personne extérieure ne voit pas l\'entreprise', () async {
      final alice = await login('alice');
      final bob = await login('bob');
      final id = await createCompany(alice);
      expect((await bob('GET', '/companies/$id')).$1, 404);
      expect((await bob('GET', '/companies/$id/members')).$1, 404);
    });

    test('un salarié ne peut pas renommer l\'entreprise, un responsable si', () async {
      final alice = await login('alice');
      final bob = await login('bob');
      final carol = await login('carol');
      final id = await createCompany(alice);
      await env.store.addMember(id, bob.id, Role.employee);
      await env.store.addMember(id, carol.id, Role.manager);
      expect((await bob('PATCH', '/companies/$id', {'name': 'Pirate'})).$1, 403);
      final (status, body) = await carol('PATCH', '/companies/$id', {'name': 'Boulangerie Dupont'});
      expect(status, 200);
      expect(body['name'], 'Boulangerie Dupont');
    });

    test('une personne a un rôle différent dans chaque entreprise', () async {
      final alice = await login('alice');
      final bob = await login('bob');
      final a = await createCompany(alice, 'Chez Alice');
      final b = await createCompany(bob, 'Chez Bob');
      await env.store.addMember(a, bob.id, Role.employee);
      final (_, me) = await bob('GET', '/me');
      final roles = {for (final m in me['companies']) m['company']['id']: m['role']};
      expect(roles, {a: 'employee', b: 'owner'});
    });
  });

  group('rôles et membres', () {
    late Client owner, manager, employee;
    late String id;

    setUp(() async {
      owner = await login('owner');
      manager = await login('manager');
      employee = await login('employee');
      id = await createCompany(owner);
      await env.store.addMember(id, manager.id, Role.manager);
      await env.store.addMember(id, employee.id, Role.employee);
    });

    Future<int> setRole(Client actor, Client target, String role) async =>
        (await actor('PUT', '/companies/$id/members/${target.id}/role', {'role': role})).$1;

    test('seul le propriétaire nomme un responsable', () async {
      expect(await setRole(manager, employee, 'manager'), 403);
      expect(await setRole(owner, employee, 'manager'), 204);
      expect(await env.store.roleOf(id, employee.id), Role.manager);
    });

    test('un responsable peut passer un salarié en extra', () async {
      expect(await setRole(manager, employee, 'extra'), 204);
      expect(await env.store.roleOf(id, employee.id), Role.extra);
    });

    test('la propriété ne se donne pas par changement de rôle', () async {
      expect(await setRole(owner, manager, 'owner'), 409);
      expect(await setRole(manager, owner, 'employee'), 409);
    });

    test('un responsable retire un salarié mais pas un autre responsable', () async {
      expect((await manager('DELETE', '/companies/$id/members/${employee.id}')).$1, 204);
      expect(await env.store.roleOf(id, employee.id), isNull);
      final other = await login('other');
      await env.store.addMember(id, other.id, Role.manager);
      expect((await manager('DELETE', '/companies/$id/members/${other.id}')).$1, 403);
    });

    test('un salarié peut quitter l\'entreprise, le propriétaire non', () async {
      expect((await employee('DELETE', '/companies/$id/members/${employee.id}')).$1, 204);
      expect((await employee('GET', '/me')).$2['companies'], isEmpty);
      expect((await owner('DELETE', '/companies/$id/members/${owner.id}')).$1, 409);
    });

    test('un membre retiré puis réintégré retrouve l\'entreprise', () async {
      await owner('DELETE', '/companies/$id/members/${employee.id}');
      await env.store.addMember(id, employee.id, Role.employee);
      expect(await env.store.roleOf(id, employee.id), Role.employee);
    });

    test('les actions sensibles sont journalisées', () async {
      await setRole(owner, employee, 'manager');
      final (actorId, details) = await env.lastAudit('member.role');
      expect(actorId, owner.id);
      expect(details, {'userId': employee.id, 'from': 'employee', 'to': 'manager'});
    });
  });

  group('transfert de propriété', () {
    late Client owner, manager, employee;
    late String id;

    setUp(() async {
      owner = await login('owner');
      manager = await login('manager');
      employee = await login('employee');
      id = await createCompany(owner);
      await env.store.addMember(id, manager.id, Role.manager);
      await env.store.addMember(id, employee.id, Role.employee);
    });

    Future<(int, dynamic)> propose(Client to) =>
        owner('POST', '/companies/$id/transfer', {'toUserId': to.id});

    test('le responsable désigné accepte et devient propriétaire', () async {
      final (status, transfer) = await propose(manager);
      expect(status, 201);
      final (_, me) = await manager('GET', '/me');
      expect(me['pendingTransfers'].single['id'], transfer['id']);

      expect((await manager('POST', '/transfers/${transfer['id']}/accept')).$1, 204);
      expect(await env.store.roleOf(id, manager.id), Role.owner);
      expect(await env.store.roleOf(id, owner.id), Role.manager);
    });

    test('un refus ne change rien', () async {
      final (_, transfer) = await propose(manager);
      expect((await manager('POST', '/transfers/${transfer['id']}/decline')).$1, 204);
      expect(await env.store.roleOf(id, owner.id), Role.owner);
    });

    test('on ne transfère qu\'à un responsable de l\'entreprise', () async {
      expect((await propose(employee)).$1, 400);
    });

    test('un seul transfert en attente à la fois, annulable', () async {
      await propose(manager);
      expect((await propose(manager)).$1, 409);
      expect((await owner('DELETE', '/companies/$id/transfer')).$1, 204);
      expect((await propose(manager)).$1, 201);
    });

    test('seul le destinataire peut répondre', () async {
      final (_, transfer) = await propose(manager);
      expect((await employee('POST', '/transfers/${transfer['id']}/accept')).$1, 404);
      expect((await owner('POST', '/transfers/${transfer['id']}/accept')).$1, 404);
    });

    test('le transfert tombe si le destinataire n\'est plus responsable', () async {
      final (_, transfer) = await propose(manager);
      await env.store.setRole(id, manager.id, Role.employee);
      expect((await manager('POST', '/transfers/${transfer['id']}/accept')).$1, 409);
      expect(await env.store.roleOf(id, owner.id), Role.owner);
    });
  });

  group('CORS', () {
    test('seules les origines autorisées reçoivent les en-têtes', () async {
      Future<Response> preflight(String origin) async => env.handler(Request(
          'OPTIONS', Uri.parse('http://localhost/api/v1/me'),
          headers: {'origin': origin}));
      expect((await preflight('http://localhost:5000')).headers['access-control-allow-origin'],
          'http://localhost:5000');
      expect((await preflight('https://evil.example')).headers['access-control-allow-origin'],
          isNull);
    });
  });
}
