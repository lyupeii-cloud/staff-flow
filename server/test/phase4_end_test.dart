import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Fin de la phase 4 : demandes dans les conversations, renforts d'une
/// autre entreprise, suppression des groupes.
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

  Future<String> published(String user, String day) async {
    final s = (await owner.ok('POST', p('/shifts'), {'days': [day], 'start': 480, 'end': 960, 'userId': user}))['shifts']
        .single;
    await owner.ok('POST', p('/publish'));
    return s['id'];
  }

  /// Cartes de demandes vues par [c], conversation par conversation (nom).
  Future<Map<String, List<dynamic>>> cards(Client c) async {
    final out = <String, List<dynamic>>{};
    for (final conv in (await c.ok('GET', p('/conversations')))['conversations']) {
      final messages = (await c.ok('GET', '/conversations/${conv['id']}/messages'))['messages'] as List;
      final found = [for (final m in messages) if (m['requestId'] != null) m['request']];
      if (found.isNotEmpty) out[conv['kind'] == 'group' ? 'group' : conv['with']?['name'] ?? '?'] = found;
    }
    return out;
  }

  group('demandes dans les conversations', () {
    test('échange proposé à un collègue : dans la conversation privée, avec les boutons', () async {
      final s = await published(bob.id, '2026-10-07');
      final r = await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': s, 'peerId': eva.id});
      final seen = await cards(eva);
      expect(seen.keys, ['bob']);
      expect([seen['bob']!.single['id'], seen['bob']!.single['canAnswer']], [r['id'], true]);
      await eva.ok('POST', '/requests/${r['id']}/accept');
      expect((await cards(eva))['bob']!.single['status'], 'pending_manager');
    });

    test('offre à toute l\'équipe : dans le groupe ; congé : chez chaque responsable', () async {
      final s = await published(bob.id, '2026-10-07');
      await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': s});
      expect((await cards(eva))['group']!.single['canAnswer'], true);
      await eva.ok('POST', p('/requests'), {'kind': 'leave', 'startDay': '2026-10-10', 'endDay': '2026-10-11'});
      final ownerCards = await cards(owner);
      expect(ownerCards['eva']!.single['canDecide'], true);
      expect((await cards(boss2))['eva'], hasLength(1));
      // Bob ne voit pas le congé d'Eva (rien dans le groupe à ce sujet).
      expect((await cards(bob))['group']!.where((r) => r?['kind'] == 'leave'), isEmpty);
    });
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

  group('groupes', () {
    test('tout responsable peut supprimer un groupe, pas un salarié', () async {
      final g = (await owner.ok('POST', p('/groups'), {'name': 'Cuisine', 'userIds': [bob.id]}))['id'];
      await bob.ok('POST', '/conversations/$g/messages', {'body': 'salut'});
      expect((await bob('DELETE', '/conversations/$g')).$1, 403);
      expect((await boss2('DELETE', '/conversations/$g')).$1, 204);
      expect((await bob('GET', '/conversations/$g/messages')).$1, 404);
      final group = (await owner.ok('GET', p('/conversations')))['conversations'].first['id'];
      expect((await owner('DELETE', '/conversations/$group')).$1, 404, reason: 'le groupe général reste');
    });
  });
}
