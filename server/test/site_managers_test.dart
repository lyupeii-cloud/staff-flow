import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Responsables de toute l'entreprise ou d'un ou plusieurs sites.
void main() {
  final env = TestEnv();

  late Client owner, general, north, bob, eva, zoe;
  late String company, siteNorth, siteSouth;

  String p(String path) => '/companies/$company$path';

  setUp(() async {
    owner = await env.login('owner');
    general = await env.login('general');
    north = await env.login('north');
    bob = await env.login('bob');
    eva = await env.login('eva');
    zoe = await env.login('zoe');
    company = await env.createCompany(owner);
    siteNorth = (await owner.ok('POST', p('/sites'), {'name': 'Nord'}))['id'];
    siteSouth = (await owner.ok('POST', p('/sites'), {'name': 'Sud'}))['id'];
    for (final c in [general, north, bob, eva]) {
      await env.store.addMember(company, c.id, Role.employee);
    }
    // Responsable de toute l'entreprise, et responsable du site Nord.
    await owner.ok('PUT', p('/members/${general.id}/role'), {'role': 'manager'});
    await owner.ok('PUT', p('/members/${north.id}/role'), {'role': 'manager', 'sites': [siteNorth]});
    // Bob est dans l'équipe du Nord, Eva dans celle du Sud.
    await owner.ok('PUT', p('/members/${bob.id}/sites'), {'sites': [siteNorth]});
    await owner.ok('PUT', p('/members/${eva.id}/sites'), {'sites': [siteSouth]});
  });

  Map<String, Object?> shift(String day, {String? site, String? user}) =>
      {'days': [day], 'start': 480, 'end': 960, 'siteId': site, 'userId': user};

  test('les sites de chacun apparaissent dans les membres et dans /me', () async {
    final members = {
      for (final m in (await owner.ok('GET', p('/members')))['members']) m['user']['id']: m['sites'],
    };
    expect(members[north.id], [siteNorth]);
    expect(members[general.id], isNull);
    expect(members[bob.id], [siteNorth]);
    final me = (await north.ok('GET', '/me'))['companies'].single;
    expect([me['role'], me['sites']], ['manager', [siteNorth]]);
  });

  group('planning', () {
    test('un responsable de site crée, modifie et supprime seulement sur ses sites', () async {
      expect((await north('POST', p('/shifts'), shift('2026-10-06', site: siteNorth, user: eva.id))).$1, 201);
      expect((await north('POST', p('/shifts'), shift('2026-10-06', site: siteSouth))).$1, 403);
      expect((await north('POST', p('/shifts'), shift('2026-10-06'))).$1, 403, reason: 'site obligatoire');
      final south = (await general.ok('POST', p('/shifts'), shift('2026-10-07', site: siteSouth)))['shifts'].single;
      expect((await north('PATCH', p('/shifts/${south['id']}'), {'start': 540})).$1, 403);
      expect((await north('DELETE', p('/shifts/${south['id']}'))).$1, 403);
      final mine = (await north.ok('POST', p('/shifts'), shift('2026-10-08', site: siteNorth)))['shifts'].single;
      // On ne déplace pas un service vers un site qu'on ne gère pas.
      expect((await north('PATCH', p('/shifts/${mine['id']}'), {'siteId': siteSouth})).$1, 403);
      expect((await north('PATCH', p('/shifts/${mine['id']}'), {'start': 600})).$1, 200);
    });

    test('il voit tout le planning mais ne publie que ses sites', () async {
      await north.ok('POST', p('/shifts'), shift('2026-10-06', site: siteNorth, user: bob.id));
      await general.ok('POST', p('/shifts'), shift('2026-10-06', site: siteSouth, user: eva.id));
      final view = await north.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11'));
      expect([view['shifts'].length, view['pending']], [2, 1]);
      expect((await north.ok('POST', p('/publish')))['published'], 1);
      expect((await general.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['pending'], 1);
      // Bob voit son service publié ; celui d'Eva attend encore.
      expect((await bob.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'], hasLength(1));
    });

    test('le remplacement ne touche que ses sites', () async {
      await general.ok('POST', p('/shifts'), shift('2026-10-06', site: siteNorth, user: bob.id));
      await general.ok('POST', p('/shifts'), shift('2026-10-07', site: siteSouth, user: bob.id));
      await north.ok('POST', p('/shifts/replace'),
          {'fromUserId': bob.id, 'toUserId': eva.id, 'from': '2026-10-05', 'to': '2026-10-11'});
      final all = (await owner.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'];
      expect({for (final s in all) s['day']: s['userId']}, {'2026-10-06': eva.id, '2026-10-07': bob.id});
    });

    test('sites et postes : réservés à qui gère toute l\'entreprise', () async {
      expect((await north('POST', p('/positions'), {'name': 'Caisse'})).$1, 403);
      expect((await general('POST', p('/positions'), {'name': 'Caisse'})).$1, 201);
      expect((await north('PATCH', p(''), {'name': 'Pirate'})).$1, 403);
    });
  });

  group('équipe', () {
    test('un responsable de site gère son équipe, pas celle des autres sites', () async {
      expect((await north('PUT', p('/members/${bob.id}/role'), {'role': 'extra'})).$1, 204);
      expect((await north('PUT', p('/members/${eva.id}/role'), {'role': 'extra'})).$1, 403);
      expect((await north('PUT', p('/members/${eva.id}/name'), {'name': 'X'})).$1, 403);
      expect((await north('DELETE', p('/members/${eva.id}'))).$1, 403);
      expect((await north('DELETE', p('/members/${bob.id}'))).$1, 204);
    });

    test('il ajoute ou retire ses propres sites à un salarié, sans toucher aux autres', () async {
      await north.ok('PUT', p('/members/${eva.id}/sites'), {'sites': [siteNorth]});
      final members = {
        for (final m in (await owner.ok('GET', p('/members')))['members']) m['user']['id']: m['sites'],
      };
      expect((members[eva.id] as List).toSet(), {siteNorth, siteSouth});
      expect((await north('PUT', p('/members/${eva.id}/sites'), {'sites': [siteSouth]})).$1, 403);
      // Seul le propriétaire change les sites d'un responsable.
      expect((await general('PUT', p('/members/${north.id}/sites'), {'sites': [siteSouth]})).$1, 403);
      expect((await owner('PUT', p('/members/${north.id}/sites'), {'sites': null})).$1, 204);
    });

    test('il invite dans ses sites ; la personne rejoint son équipe en acceptant', () async {
      expect((await north('POST', p('/invite'), {'qr': zoe.user['publicId']})).$1, 400);
      expect((await north('POST', p('/invite'), {'qr': zoe.user['publicId'], 'sites': [siteSouth]})).$1, 403);
      await north.ok('POST', p('/invite'), {'qr': zoe.user['publicId'], 'sites': [siteNorth]});
      final invite = (await zoe.ok('GET', '/me'))['pendingJoinRequests'].single;
      await zoe.ok('POST', '/join-requests/${invite['id']}/accept');
      expect((await zoe.ok('GET', '/me'))['companies'].single['sites'], [siteNorth]);
    });

    test('un responsable de toute l\'entreprise invite sans préciser de site', () async {
      await general.ok('POST', p('/invite'), {'qr': zoe.user['publicId']});
      final invite = (await zoe.ok('GET', '/me'))['pendingJoinRequests'].single;
      await zoe.ok('POST', '/join-requests/${invite['id']}/accept');
      expect((await zoe.ok('GET', '/me'))['companies'].single['sites'], isNull);
    });

    test('le nouveau propriétaire couvre toute l\'entreprise', () async {
      final t = await owner.ok('POST', p('/transfer'), {'toUserId': north.id});
      await north.ok('POST', '/transfers/${t['id']}/accept');
      expect((await north.ok('GET', '/me'))['companies'].single['sites'], isNull);
      expect((await north('POST', p('/positions'), {'name': 'Caisse'})).$1, 201);
    });
  });
}
