import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Sous-responsables, salarié emprunté à un autre site, et personne déjà
/// en service dans l'entreprise sur un créneau.
void main() {
  final env = TestEnv();

  late Client owner, north, south, bob, eva;
  late String company, siteNorth, siteSouth, siteGare;

  String p(String path) => '/companies/$company$path';

  setUp(() async {
    owner = await env.login('owner');
    north = await env.login('north');
    south = await env.login('south');
    bob = await env.login('bob');
    eva = await env.login('eva');
    company = await env.createCompany(owner);
    siteNorth = (await owner.ok('POST', p('/sites'), {'name': 'Nord'}))['id'];
    siteSouth = (await owner.ok('POST', p('/sites'), {'name': 'Sud'}))['id'];
    siteGare = (await owner.ok('POST', p('/sites'), {'name': 'Gare'}))['id'];
    for (final c in [north, south, bob, eva]) {
      await env.store.addMember(company, c.id, Role.employee);
    }
    await owner.ok('PUT', p('/members/${north.id}/role'), {'role': 'manager', 'sites': [siteNorth, siteGare]});
    await owner.ok('PUT', p('/members/${south.id}/role'), {'role': 'manager', 'sites': [siteSouth]});
    await owner.ok('PUT', p('/members/${bob.id}/sites'), {'sites': [siteNorth]});
    await owner.ok('PUT', p('/members/${eva.id}/sites'), {'sites': [siteSouth]});
  });

  Future<Map<String, dynamic>> member(String id) async =>
      ((await owner.ok('GET', p('/members')))['members'] as List).firstWhere((m) => m['user']['id'] == id);

  group('sous-responsable', () {
    test('un responsable nomme un sous-responsable sur une partie de ses sites, et peut le retirer', () async {
      expect((await north('PUT', p('/members/${bob.id}/role'), {'role': 'manager', 'sites': [siteSouth]})).$1, 403,
          reason: 'pas un de ses sites');
      expect((await north('PUT', p('/members/${eva.id}/role'), {'role': 'manager', 'sites': [siteNorth]})).$1, 403,
          reason: 'Eva n\'est pas dans son équipe');
      await north.ok('PUT', p('/members/${bob.id}/role'), {'role': 'manager', 'sites': [siteNorth]});
      final m = await member(bob.id);
      expect([m['role'], m['sites'], m['appointedBy']], ['manager', [siteNorth], north.id]);
      // Le sous-responsable ne gère que son site.
      expect((await bob('POST', p('/shifts'), {'days': ['2026-10-07'], 'start': 480, 'end': 960, 'siteId': siteGare})).$1, 403);
      expect((await bob('POST', p('/shifts'), {'days': ['2026-10-07'], 'start': 480, 'end': 960, 'siteId': siteNorth})).$1, 201);
      // Un autre responsable ne le retire pas ; celui qui l'a nommé, si.
      expect((await south('PUT', p('/members/${bob.id}/role'), {'role': 'employee'})).$1, 403);
      await north.ok('PUT', p('/members/${bob.id}/role'), {'role': 'employee'});
      expect([(await member(bob.id))['role'], (await member(bob.id))['appointedBy']], ['employee', null]);
    });

    test('celui qui l\'a nommé change ses sites : un ou plusieurs des siens', () async {
      await north.ok('PUT', p('/members/${bob.id}/role'), {'role': 'manager', 'sites': [siteNorth]});
      await north.ok('PUT', p('/members/${bob.id}/sites'), {'sites': [siteNorth, siteGare]});
      expect((await member(bob.id))['sites'], unorderedEquals([siteNorth, siteGare]));
      expect((await north('PUT', p('/members/${bob.id}/sites'), {'sites': [siteSouth]})).$1, 403);
      expect((await north('PUT', p('/members/${bob.id}/sites'), {'sites': []})).$1, 400);
      expect((await south('PUT', p('/members/${bob.id}/sites'), {'sites': [siteSouth]})).$1, 403);
    });

    test('le propriétaire nomme toujours qui il veut ; un nommé par le propriétaire n\'a pas de parrain', () async {
      await owner.ok('PUT', p('/members/${bob.id}/role'), {'role': 'manager', 'sites': [siteSouth]});
      expect((await member(bob.id))['appointedBy'], isNull);
      expect((await north('PUT', p('/members/${bob.id}/role'), {'role': 'employee'})).$1, 403);
    });
  });

  group('salarié d\'un autre site', () {
    test('placé par un responsable de site : à valider, puis l\'équipe est prévenue', () async {
      // Le responsable du Sud place Bob (équipe Nord) sur le site Sud.
      final id = (await south.ok('POST', p('/shifts'),
          {'days': ['2026-10-07'], 'start': 480, 'end': 960, 'siteId': siteSouth, 'userId': bob.id}))['shifts'].single['id'];
      await env.api.notifications.settle();
      expect([for (final n in (await owner.ok('GET', '/notices'))['notices']) n['kind']], ['placement_to_approve']);
      expect((await north.ok('GET', '/notices'))['notices'], isEmpty, reason: 'prévenu une fois validé');
      // En attente : ne se publie pas.
      final before = await south.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11'));
      expect([before['pending'], before['shifts'].single['approvalBy']], [0, south.id]);
      await south.ok('POST', p('/publish'));
      expect((await bob.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'], isEmpty);
      // Ni lui-même ni un autre responsable de site ne valident.
      expect((await south('POST', p('/shifts/$id/approval'), {'approve': true})).$1, 403);
      expect((await north('POST', p('/shifts/$id/approval'), {'approve': true})).$1, 403);
      await owner.ok('POST', p('/shifts/$id/approval'), {'approve': true});
      await env.api.notifications.settle();
      expect([for (final n in (await south.ok('GET', '/notices'))['notices']) n['kind']], contains('placement_approved'));
      await south.ok('POST', p('/publish'));
      expect((await bob.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'], hasLength(1));
      // Changer l'heure de ce service publié ne redemande rien.
      await south.ok('PATCH', p('/shifts/$id?scope=one'), {'start': 540});
      expect((await south.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'].single['approvalBy'], isNull);
      final notices = (await north.ok('GET', '/notices'))['notices'] as List;
      final n = notices.singleWhere((n) => n['kind'] == 'staff_borrowed');
      expect([n['data']['name'], n['data']['siteName'], n['data']['day']], ['bob', 'Sud', '2026-10-07']);
      expect([for (final n in (await south.ok('GET', '/notices'))['notices']) n['kind']], isNot(contains('staff_borrowed')));
      expect([for (final n in (await owner.ok('GET', '/notices'))['notices']) n['kind']], isNot(contains('staff_borrowed')),
          reason: 'l\'équipe du Nord a son responsable');
      // Équipe sans responsable de site : le patron est prévenu.
      final zoe = await env.login('zoe');
      await env.store.addMember(company, zoe.id, Role.employee);
      await owner.ok('PUT', p('/members/${zoe.id}/sites'), {'sites': [siteGare]});
      await owner.ok('PUT', p('/members/${north.id}/sites'), {'sites': [siteNorth]});
      await owner.ok('POST', p('/shifts'),
          {'days': ['2026-10-09'], 'start': 480, 'end': 960, 'siteId': siteSouth, 'userId': zoe.id});
      await env.api.notifications.settle();
      expect([for (final n in (await owner.ok('GET', '/notices'))['notices']) n['kind']], isNot(contains('staff_borrowed')),
          reason: 'le patron l\'a placée lui-même');
      final z = (await south.ok('POST', p('/shifts'),
          {'days': ['2026-10-10'], 'start': 480, 'end': 960, 'siteId': siteSouth, 'userId': zoe.id}))['shifts'].single['id'];
      await owner.ok('POST', p('/shifts/$z/approval'), {'approve': true});
      await env.api.notifications.settle();
      expect([for (final n in (await north.ok('GET', '/notices'))['notices']) n['kind']], isNot(contains('placement_to_approve')));
      // Sur son propre site : personne n'est prévenu.
      await north.ok('POST', p('/shifts'),
          {'days': ['2026-10-08'], 'start': 480, 'end': 960, 'siteId': siteNorth, 'userId': bob.id});
      await env.api.notifications.settle();
      expect((await north.ok('GET', '/notices'))['notices'].where((n) => n['kind'] == 'staff_borrowed'), hasLength(1));
    });

    test('refusé : le service reste sans personne ; le supérieur qui a nommé valide aussi', () async {
      final id = (await south.ok('POST', p('/shifts'),
          {'days': ['2026-10-07'], 'start': 480, 'end': 960, 'siteId': siteSouth, 'userId': bob.id}))['shifts'].single['id'];
      await owner.ok('POST', p('/shifts/$id/approval'), {'approve': false});
      final s = (await south.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'].single;
      expect([s['userId'], s['approvalBy']], [null, null]);
      expect((await owner('POST', p('/shifts/$id/approval'), {'approve': true})).$1, 409);
      // Sous-responsable nommé par le Nord, sur la Gare : le Nord valide ses placements.
      final zoe = await env.login('zoe');
      await env.store.addMember(company, zoe.id, Role.employee);
      await owner.ok('PUT', p('/members/${zoe.id}/sites'), {'sites': [siteNorth]});
      await north.ok('PUT', p('/members/${zoe.id}/role'), {'role': 'manager', 'sites': [siteGare]});
      final g = (await zoe.ok('POST', p('/shifts'),
          {'days': ['2026-10-08'], 'start': 480, 'end': 960, 'siteId': siteGare, 'userId': eva.id}))['shifts'].single['id'];
      await env.api.notifications.settle();
      expect([for (final n in (await north.ok('GET', '/notices'))['notices']) n['kind']], contains('placement_to_approve'));
      await north.ok('POST', p('/shifts/$g/approval'), {'approve': true});
    });

    test('déjà en service dans l\'entreprise sur ce créneau : signalé, sans blocage', () async {
      final first = (await owner.ok('POST', p('/shifts'),
          {'days': ['2026-10-07'], 'start': 480, 'end': 960, 'siteId': siteNorth, 'userId': bob.id}))['shifts'].single['id'];
      String q(int start, int end, [String? exclude]) =>
          p('/busy?days=2026-10-07&start=$start&end=$end${exclude == null ? '' : '&exclude=$exclude'}');
      expect((await south.ok('GET', q(900, 1080)))['here'], [bob.id]);
      expect((await south.ok('GET', q(960, 1080)))['here'], isEmpty, reason: 'les services se touchent seulement');
      expect((await owner.ok('GET', q(600, 700, first)))['here'], isEmpty, reason: 'le service en cours de modification');
      // Rien n'est bloqué.
      expect((await south('POST', p('/shifts'),
              {'days': ['2026-10-07'], 'start': 900, 'end': 1080, 'siteId': siteSouth, 'userId': bob.id}))
          .$1, 201);
    });
  });
}
