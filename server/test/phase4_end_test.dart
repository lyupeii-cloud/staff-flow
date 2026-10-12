import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Fin de la phase 4 : renforts d'une autre entreprise.
void main() {
  final env = TestEnv();

  late Client owner, boss2, bob, eva;
  late String company;

  String p(String path) => '/companies/$company$path';

  setUp(() async {
    owner = await env.login('owner');
    boss2 = await env.login('boss2');
    bob = await env.login('bob');
    eva = await env.login('eva');
    company = await env.createCompany(owner);
    for (final c in [bob, eva]) {
      await env.store.addMember(company, c.id, Role.employee);
    }
    await env.store.addMember(company, boss2.id, Role.manager);
  });

  group('renforts', () {
    test('un responsable ajoute un salarié d\'une autre de ses entreprises', () async {
      final other = (await owner.ok('POST', '/companies', {'name': 'Café', 'timezone': 'Europe/Paris'}))['company']['id'];
      final zoe = await env.login('zoe');
      await env.store.addMember(other, zoe.id, Role.employee);
      await env.store.addMember(other, bob.id, Role.employee);
      final people = (await owner.ok('GET', p('/reinforcements')))['people'] as List;
      expect([for (final x in people) [x['name'], x['companyName']]], [['zoe', 'Café']], reason: 'Bob est déjà là');
      expect((await bob('GET', p('/reinforcements'))).$1, 403);
      expect((await boss2.ok('GET', p('/reinforcements')))['people'], isEmpty, reason: 'pas responsable du Café');
      expect((await owner('POST', p('/reinforcements'), {'userId': eva.id})).$1, 404);
      expect((await owner('POST', p('/reinforcements'), {'userId': zoe.id})).$1, 204);
      final me = (await zoe.ok('GET', '/me'))['companies'] as List;
      expect(me.firstWhere((m) => m['company']['id'] == company)['role'], 'extra');
      await env.api.notifications.settle();
      expect([for (final n in (await zoe.ok('GET', '/notices'))['notices']) n['kind']], contains('reinforcement_added'));
      await owner.ok('POST', p('/shifts'), {'days': ['2026-10-07'], 'start': 480, 'end': 960, 'userId': zoe.id});
    });
  });
}
