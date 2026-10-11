import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Sites en cascade : trois niveaux, un responsable d'un site gère aussi
/// ceux qui sont en dessous.
void main() {
  final env = TestEnv();

  late Client owner, region, city, bob, eva;
  late String company, nord, lille, gare, sud;

  String p(String path) => '/companies/$company$path';

  Future<String> site(Client c, String name, [String? parent]) async =>
      (await c.ok('POST', p('/sites'), {'name': name, 'parentId': ?parent}))['id'];

  setUp(() async {
    owner = await env.login('owner');
    region = await env.login('region');
    city = await env.login('city');
    bob = await env.login('bob');
    eva = await env.login('eva');
    company = await env.createCompany(owner);
    nord = await site(owner, 'Nord');
    lille = await site(owner, 'Lille', nord);
    gare = await site(owner, 'Gare de Lille', lille);
    sud = await site(owner, 'Sud');
    for (final c in [region, city, bob, eva]) {
      await env.store.addMember(company, c.id, Role.employee);
    }
    await owner.ok('PUT', p('/members/${region.id}/role'), {'role': 'manager', 'sites': [nord]});
    await owner.ok('PUT', p('/members/${bob.id}/sites'), {'sites': [gare]});
    await owner.ok('PUT', p('/members/${eva.id}/sites'), {'sites': [sud]});
  });

  test('trois niveaux au plus, sans boucle ; les sites gardent leur parent', () async {
    expect((await owner('POST', p('/sites'), {'name': 'Quai', 'parentId': gare})).$1, 400);
    expect((await owner('PATCH', p('/sites/$nord'), {'parentId': gare})).$1, 400, reason: 'sous lui-même');
    expect((await owner('PATCH', p('/sites/$nord'), {'parentId': sud})).$1, 400, reason: '4 niveaux');
    await owner.ok('PATCH', p('/sites/$lille'), {'parentId': sud});
    final items = (await owner.ok('GET', p('/sites')))['items'] as List;
    expect(items.firstWhere((s) => s['id'] == lille)['parentId'], sud);
    expect(items.firstWhere((s) => s['id'] == nord)['parentId'], isNull);
  });

  test('le responsable d\'un site gère tout ce qui est en dessous', () async {
    // /me : ses sites comprennent ceux d'en dessous.
    final me = (await region.ok('GET', '/me'))['companies'].single;
    expect(me['sites'], unorderedEquals([nord, lille, gare]));
    // Il planifie sur la Gare, gère Bob (équipe Gare)… mais pas le Sud.
    expect((await region('POST', p('/shifts'),
            {'days': ['2026-10-07'], 'start': 480, 'end': 960, 'siteId': gare, 'userId': bob.id}))
        .$1, 201);
    expect((await region('POST', p('/shifts'), {'days': ['2026-10-07'], 'start': 480, 'end': 960, 'siteId': sud})).$1,
        403);
    await region.ok('PUT', p('/members/${bob.id}/role'), {'role': 'extra'});
    // Il ajoute des sous-sites sous les siens, renomme ceux d'en dessous, pas le sien ni un premier niveau.
    final quai = await site(region, 'Lille Europe', lille);
    expect((await region('POST', p('/sites'), {'name': 'Est'})).$1, 403);
    expect((await region('POST', p('/sites'), {'name': 'X', 'parentId': sud})).$1, 403);
    await region.ok('PATCH', p('/sites/$quai'), {'name': 'Lille-Europe'});
    expect((await region('PATCH', p('/sites/$nord'), {'name': 'Nord-Est'})).$1, 403);
    expect((await region('PATCH', p('/sites/$lille'), {'parentId': null})).$1, 403, reason: 'déplacer : patron');
    // Sous-responsable sur une branche plus basse.
    await owner.ok('PUT', p('/members/${city.id}/sites'), {'sites': [lille]});
    await region.ok('PUT', p('/members/${city.id}/role'), {'role': 'manager', 'sites': [lille]});
    expect((await city.ok('GET', '/me'))['companies'].single['sites'], unorderedEquals([lille, gare, quai]));
  });

  test('archiver un site archive ce qui est en dessous ; le réactiver réactive au-dessus', () async {
    await owner.ok('PATCH', p('/sites/$nord'), {'archived': true});
    var items = (await owner.ok('GET', p('/sites')))['items'] as List;
    expect([for (final s in items) if (s['archived'] == true) s['id']], unorderedEquals([nord, lille, gare]));
    await owner.ok('PATCH', p('/sites/$gare'), {'archived': false});
    items = (await owner.ok('GET', p('/sites')))['items'] as List;
    expect([for (final s in items) if (s['archived'] == true) s['id']], isEmpty);
  });

  test('équipe sur un site parent : pas « d\'un autre site » en dessous ; le responsable au-dessus valide', () async {
    await owner.ok('PUT', p('/members/${city.id}/role'), {'role': 'manager', 'sites': [lille]});
    // Équipe Nord placée à la Gare par le responsable de Lille : c'est sa région, rien à valider.
    await owner.ok('PUT', p('/members/${bob.id}/sites'), {'sites': [nord]});
    await city.ok('POST', p('/shifts'),
        {'days': ['2026-10-09'], 'start': 480, 'end': 960, 'siteId': gare, 'userId': bob.id});
    await owner.ok('PUT', p('/members/${bob.id}/sites'), {'sites': [gare]});
    // Le responsable de Lille place Eva (équipe Sud) à la Gare : à valider…
    final id = (await city.ok('POST', p('/shifts'),
        {'days': ['2026-10-07'], 'start': 480, 'end': 960, 'siteId': gare, 'userId': eva.id}))['shifts'].single['id'];
    expect(((await city.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'] as List).firstWhere((s) => s['id'] == id)['approvalBy'], city.id);
    // … par le responsable du Nord, au-dessus de lui.
    await env.api.notifications.settle();
    expect([for (final n in (await region.ok('GET', '/notices'))['notices']) n['kind']], contains('placement_to_approve'));
    await region.ok('POST', p('/shifts/$id/approval'), {'approve': true});
    // Le responsable du Nord place Bob (équipe Gare) à Lille : dans son périmètre, rien à valider.
    await region.ok('POST', p('/shifts'),
        {'days': ['2026-10-08'], 'start': 480, 'end': 960, 'siteId': lille, 'userId': bob.id});
    final shifts = (await region.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'] as List;
    expect([for (final s in shifts) s['approvalBy']], [null, null, null]);
  });
}
