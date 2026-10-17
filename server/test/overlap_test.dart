import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Plusieurs employeurs : « Tous mes plannings », chevauchements entre
/// entreprises, personnes déjà en service ailleurs.
void main() {
  final env = TestEnv();

  late Client claire, dan, bob;
  late String paris, kyiv;

  setUp(() async {
    claire = await env.login('claire');
    dan = await env.login('dan');
    bob = await env.login('bob');
    // Paris (UTC+2 en octobre) et Kyiv (UTC+3) : une heure d'écart.
    paris = await env.createCompany(claire, 'Boulangerie');
    kyiv = (await dan.ok('POST', '/companies', {'name': 'Café', 'timezone': 'Europe/Kyiv'}))['company']['id'];
    await env.store.addMember(paris, bob.id, Role.employee);
    await env.store.addMember(kyiv, bob.id, Role.employee);
  });

  Future<String> shift(Client boss, String company, String day, int start, int end) async {
    final s = (await boss.ok('POST', '/companies/$company/shifts',
        {'days': [day], 'start': start, 'end': end, 'userId': bob.id}))['shifts'].single;
    await boss.ok('POST', '/companies/$company/publish');
    return s['id'];
  }

  Future<List<String>> kinds(Client c) async {
    await env.api.notifications.settle();
    return [for (final n in (await c.ok('GET', '/notices'))['notices']) n['kind'] as String];
  }

  Future<List<dynamic>> mine() async => (await bob.ok('GET', '/me/shifts?from=2026-10-05&to=2026-10-11'))['shifts'];

  test('tous mes plannings : les services de chaque entreprise, sans chevauchement', () async {
    await shift(claire, paris, '2026-10-07', 540, 1020); // 07:00–15:00 UTC
    await shift(dan, kyiv, '2026-10-07', 1080, 1200); // 15:00–17:00 UTC : se touchent seulement
    final all = await mine();
    expect([for (final s in all) s['companyName']], ['Boulangerie', 'Café']);
    expect([for (final s in all) s['overlap']], [false, false]);
    expect([all.first['startsAt'], all.first['endsAt']], ['2026-10-07T07:00:00.000Z', '2026-10-07T15:00:00.000Z']);
    expect(await kinds(bob), isNot(contains('shift_overlap')));
    // Personne d'autre ne voit ces services.
    expect((await claire.ok('GET', '/me/shifts?from=2026-10-05&to=2026-10-11'))['shifts'], isEmpty);
    expect((await bob('GET', '/me/shifts?from=2026-10-05&to=2027-01-01')).$1, 400);
  });

  test('chevauchement : marqué des deux côtés, et le salarié est prévenu une seule fois', () async {
    await shift(claire, paris, '2026-10-07', 540, 1020); // 07:00–15:00 UTC
    expect(await kinds(bob), isNot(contains('shift_overlap')));
    await shift(dan, kyiv, '2026-10-07', 1020, 1200); // 14:00–17:00 UTC
    expect([for (final s in await mine()) s['overlap']], [true, true]);
    final notices = (await bob.ok('GET', '/notices'))['notices'];
    final overlap = notices.where((n) => n['kind'] == 'shift_overlap').single;
    expect(overlap['data']['day'], '2026-10-07');
    // Une nouvelle publication ne prévient pas de nouveau pour la même paire.
    await claire.ok('POST', '/companies/$paris/publish');
    await dan.ok('POST', '/companies/$kyiv/publish');
    expect((await kinds(bob)).where((k) => k == 'shift_overlap'), hasLength(1));
    // Les responsables ne sont pas prévenus.
    expect(await kinds(claire), isNot(contains('shift_overlap')));
  });

  test('service de nuit : le chevauchement du lendemain est vu', () async {
    await shift(dan, kyiv, '2026-10-07', 1320, 360); // 22:00–06:00 Kyiv = 19:00–03:00 UTC
    await shift(claire, paris, '2026-10-08', 240, 480); // 04:00–08:00 Paris = 02:00–06:00 UTC
    expect([for (final s in await mine()) s['overlap']], [true, true]);
    expect(await kinds(bob), contains('shift_overlap'));
  });

  test('déjà en service ailleurs : le responsable le sait, sans détail', () async {
    await shift(dan, kyiv, '2026-10-07', 1020, 1200); // 14:00–17:00 UTC
    String q(int start, int end) => '/companies/$paris/busy?days=2026-10-06,2026-10-07&start=$start&end=$end';
    expect((await claire.ok('GET', q(600, 700)))['userIds'], isEmpty);
    expect((await claire.ok('GET', q(900, 1000)))['userIds'], [bob.id]);
    expect((await bob('GET', q(900, 1000))).$1, 403);
    expect((await claire('GET', '/companies/$paris/busy?days=x&start=1&end=2')).$1, 400);
  });

  test('échange validé : la personne qui reprend est prévenue d\'un chevauchement', () async {
    final eva = await env.login('eva');
    await env.store.addMember(paris, eva.id, Role.employee);
    await shift(dan, kyiv, '2026-10-07', 1020, 1200);
    final s = (await claire.ok('POST', '/companies/$paris/shifts',
        {'days': ['2026-10-07'], 'start': 540, 'end': 1020, 'userId': eva.id}))['shifts'].single['id'];
    await claire.ok('POST', '/companies/$paris/publish');
    final r = await eva.ok('POST', '/companies/$paris/requests', {'kind': 'swap', 'shiftId': s, 'peerId': bob.id});
    await claire.ok('POST', '/requests/${r['id']}/approve');
    expect(await kinds(bob), contains('shift_overlap'));
  });

  test('le patron peut reprendre un service proposé à toute l\'équipe', () async {
    final eva = await env.login('eva');
    await env.store.addMember(paris, eva.id, Role.employee);
    final s = (await claire.ok('POST', '/companies/$paris/shifts',
        {'days': ['2026-10-07'], 'start': 540, 'end': 1020, 'userId': eva.id}))['shifts'].single['id'];
    await claire.ok('POST', '/companies/$paris/publish');
    final r = await eva.ok('POST', '/companies/$paris/requests', {'kind': 'swap', 'shiftId': s});
    final seen = (await claire.ok('GET', '/companies/$paris/requests?pending=1'))['requests'].single;
    expect([seen['canAnswer'], seen['canDecide']], [true, true]);
    expect((await claire.ok('POST', '/requests/${r['id']}/accept'))['peer']['id'], claire.id);
  });
}
