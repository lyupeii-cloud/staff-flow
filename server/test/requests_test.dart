import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Échanges de service en 3 étapes, congés et indisponibilités.
void main() {
  final env = TestEnv();

  late Client owner, north, bob, eva, zoe;
  late String company, siteNorth, siteSouth;

  String p(String path) => '/companies/$company$path';

  setUp(() async {
    owner = await env.login('owner');
    north = await env.login('north');
    bob = await env.login('bob');
    eva = await env.login('eva');
    zoe = await env.login('zoe');
    company = await env.createCompany(owner);
    siteNorth = (await owner.ok('POST', p('/sites'), {'name': 'Nord'}))['id'];
    siteSouth = (await owner.ok('POST', p('/sites'), {'name': 'Sud'}))['id'];
    for (final c in [north, bob, eva, zoe]) {
      await env.store.addMember(company, c.id, Role.employee);
    }
    await owner.ok('PUT', p('/members/${north.id}/role'), {'role': 'manager', 'sites': [siteNorth]});
    // Bob et Eva dans l'équipe du Nord, Zoé dans celle du Sud.
    await owner.ok('PUT', p('/members/${bob.id}/sites'), {'sites': [siteNorth]});
    await owner.ok('PUT', p('/members/${eva.id}/sites'), {'sites': [siteNorth]});
    await owner.ok('PUT', p('/members/${zoe.id}/sites'), {'sites': [siteSouth]});
  });

  /// Service publié de [user] le [day] sur [site].
  Future<String> published(String user, String day, String site) async {
    final s = (await owner.ok('POST', p('/shifts'),
        {'days': [day], 'start': 480, 'end': 960, 'siteId': site, 'userId': user}))['shifts'].single;
    await owner.ok('POST', p('/publish'));
    return s['id'];
  }

  Future<List<String>> kinds(Client c) async {
    await env.api.notifications.settle();
    return [for (final n in (await c.ok('GET', '/notices'))['notices']) n['kind'] as String];
  }

  Future<Map<String, dynamic>> shiftOf(Client c, String id) async {
    final all = (await c.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'];
    return all.firstWhere((s) => s['id'] == id);
  }

  group('échange', () {
    test('proposer, accepter, valider : le planning publié change', () async {
      final shift = await published(bob.id, '2026-10-07', siteNorth);
      final r = await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift, 'peerId': eva.id});
      expect([r['status'], r['canCancel'], r['canAnswer']], ['pending_peer', true, false]);
      expect(await kinds(eva), contains('swap_offer'));
      final seen = (await eva.ok('GET', p('/requests')))['requests'].single;
      expect([seen['canAnswer'], seen['canDecline']], [true, true]);

      final accepted = await eva.ok('POST', '/requests/${r['id']}/accept');
      expect(accepted['status'], 'pending_manager');
      expect(await kinds(north), contains('swap_to_approve'));
      expect(await kinds(owner), contains('swap_to_approve'));
      expect((await bob('POST', '/requests/${r['id']}/approve')).$1, 403);

      final done = await north.ok('POST', '/requests/${r['id']}/approve');
      expect(done['status'], 'approved');
      expect((await shiftOf(owner, shift))['userId'], eva.id);
      expect((await eva.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'], hasLength(1));
      expect(await kinds(bob), contains('request_approved'));
      expect(await kinds(eva), contains('request_approved'));
    });

    test('offre ouverte : proposée à l\'équipe du site, le premier qui accepte la prend', () async {
      final shift = await published(bob.id, '2026-10-07', siteNorth);
      final r = await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift});
      expect(r['openOffer'], true);
      expect(await kinds(eva), contains('swap_offer'));
      expect(await kinds(zoe), isNot(contains('swap_offer')), reason: 'Zoé est au Sud');
      expect((await zoe.ok('GET', p('/requests')))['requests'], isEmpty);
      expect((await zoe('POST', '/requests/${r['id']}/accept')).$1, 403);
      expect((await eva.ok('GET', p('/requests')))['requests'].single['canAnswer'], true);
      final accepted = await eva.ok('POST', '/requests/${r['id']}/accept');
      expect(accepted['peer']['id'], eva.id);
    });

    test('le collègue refuse', () async {
      final shift = await published(bob.id, '2026-10-07', siteNorth);
      final r = await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift, 'peerId': eva.id});
      expect((await zoe('POST', '/requests/${r['id']}/decline')).$1, 403);
      expect((await eva('POST', '/requests/${r['id']}/decline')).$1, 204);
      expect(await kinds(bob), contains('swap_declined'));
      expect((await bob.ok('GET', p('/requests')))['requests'].single['status'], 'refused');
      // Le service peut être proposé de nouveau.
      await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift, 'peerId': zoe.id});
    });

    test('le responsable refuse : le planning ne change pas', () async {
      final shift = await published(bob.id, '2026-10-07', siteNorth);
      final r = await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift, 'peerId': eva.id});
      await eva.ok('POST', '/requests/${r['id']}/accept');
      expect((await north.ok('POST', '/requests/${r['id']}/refuse'))['status'], 'refused');
      expect((await shiftOf(owner, shift))['userId'], bob.id);
      expect(await kinds(bob), contains('request_refused'));
    });

    test('annulation, doublon, service d\'un autre', () async {
      final shift = await published(bob.id, '2026-10-07', siteNorth);
      expect((await eva('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift})).$1, 400);
      final r = await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift, 'peerId': eva.id});
      expect((await bob('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift})).$1, 409);
      expect((await eva('POST', '/requests/${r['id']}/cancel')).$1, 404);
      expect((await bob('POST', '/requests/${r['id']}/cancel')).$1, 204);
      expect((await eva('POST', '/requests/${r['id']}/accept')).$1, 409);
      // On ne se propose pas son propre service.
      expect((await bob('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift, 'peerId': bob.id})).$1, 404);
      // Un responsable peut reprendre un service.
      expect((await bob('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift, 'peerId': north.id})).$1, 201);
    });

    test('service donné à quelqu\'un d\'autre entre-temps : la demande devient sans objet', () async {
      final shift = await published(bob.id, '2026-10-07', siteNorth);
      final r = await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift, 'peerId': eva.id});
      await eva.ok('POST', '/requests/${r['id']}/accept');
      // Un horaire changé ne gêne pas l'échange.
      await owner.ok('PATCH', p('/shifts/$shift'), {'start': 540});
      expect((await bob.ok('GET', '/requests/${r['id']}'))['status'], 'pending_manager');
      await owner.ok('PATCH', p('/shifts/$shift'), {'userId': zoe.id});
      expect((await north('POST', '/requests/${r['id']}/approve')).$1, 409);
      expect((await bob.ok('GET', '/requests/${r['id']}'))['status'], 'expired');
      expect((await north.ok('GET', p('/requests?pending=1')))['requests'], isEmpty);
    });

    test('le responsable tranche sans attendre le collègue, et choisit qui reprend une offre ouverte', () async {
      final shift = await published(bob.id, '2026-10-07', siteNorth);
      final r = await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift});
      final seen = (await north.ok('GET', p('/requests?pending=1')))['requests'].single;
      expect([seen['canDecide'], seen['needsPeer']], [true, true]);
      expect((await north('POST', '/requests/${r['id']}/approve')).$1, 400);
      expect((await north('POST', '/requests/${r['id']}/approve', {'peerId': bob.id})).$1, 404);
      final done = await north.ok('POST', '/requests/${r['id']}/approve', {'peerId': zoe.id});
      expect([done['status'], done['peer']['id']], ['approved', zoe.id]);
      expect((await shiftOf(owner, shift))['userId'], zoe.id);
      expect(await kinds(zoe), contains('request_approved'));
    });

    test('offre ouverte sans salarié dans l\'équipe : proposée aux autres membres', () async {
      for (final c in [eva, zoe]) {
        await owner.ok('DELETE', p('/members/${c.id}'));
      }
      await owner.ok('PUT', p('/members/${north.id}/sites'), {'sites': null});
      final shift = await published(bob.id, '2026-10-07', siteNorth);
      final r = await bob.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift});
      expect(await kinds(north), contains('swap_offer'));
      expect((await north.ok('POST', '/requests/${r['id']}/accept'))['status'], 'pending_manager');
    });

    test('un responsable de site ne valide pas un échange d\'un autre site', () async {
      await owner.ok('PUT', p('/members/${zoe.id}/sites'), {'sites': [siteSouth, siteNorth]});
      final shift = await published(zoe.id, '2026-10-07', siteSouth);
      final r = await zoe.ok('POST', p('/requests'), {'kind': 'swap', 'shiftId': shift, 'peerId': bob.id});
      await bob.ok('POST', '/requests/${r['id']}/accept');
      expect(await kinds(north), isNot(contains('swap_to_approve')));
      expect((await north.ok('GET', p('/requests')))['requests'], isEmpty);
      expect((await north('POST', '/requests/${r['id']}/approve')).$1, 403);
      expect((await owner.ok('POST', '/requests/${r['id']}/approve'))['status'], 'approved');
    });
  });

  group('liste', () {
    test('par pages de 10, la plus récente d\'abord', () async {
      for (var i = 0; i < 12; i++) {
        await bob.ok('POST', p('/requests'), {'kind': 'unavailability', 'weekdays': [1 + i % 7], 'note': 'n$i'});
        env.clock.advance(const Duration(seconds: 1));
      }
      await eva.ok('POST', p('/requests'), {'kind': 'unavailability', 'weekdays': [2]});
      final first = (await bob.ok('GET', p('/requests')))['requests'] as List;
      expect(first, hasLength(10));
      expect(first.first['note'], 'n11');
      final next = (await bob.ok('GET', p('/requests?before=${first.last['createdAt']}')))['requests'] as List;
      expect([for (final r in next) r['note']], ['n1', 'n0']);
      expect((await owner.ok('GET', p('/requests?limit=50')))['requests'], hasLength(13));
    });

    test('une demande d\'un autre n\'est pas lisible', () async {
      final r = await bob.ok('POST', p('/requests'), {'kind': 'unavailability', 'weekdays': [1]});
      expect((await zoe('GET', '/requests/${r['id']}')).$1, 404);
      expect((await north('GET', '/requests/${r['id']}')).$1, 200);
    });
  });

  group('notifications par site', () {
    test('un responsable choisit les sites dont il est prévenu', () async {
      await owner.ok('PUT', p('/members/${north.id}/sites'), {'sites': null});
      expect((await north('PUT', p('/notify-sites'), {'sites': ['x']})).$1, 400);
      expect((await bob('PUT', p('/notify-sites'), {'sites': [siteSouth]})).$1, 403);
      expect((await north('PUT', p('/notify-sites'), {'sites': [siteSouth]})).$1, 204);
      expect((await north.ok('GET', '/me'))['companies'].single['notifySites'], [siteSouth]);
      await bob.ok('POST', p('/requests'), {'kind': 'leave', 'startDay': '2026-10-08', 'endDay': '2026-10-08'});
      await zoe.ok('POST', p('/requests'), {'kind': 'leave', 'startDay': '2026-10-08', 'endDay': '2026-10-08'});
      expect(await kinds(north), ['leave_to_approve'], reason: 'Zoé (Sud) seulement');
      // Il voit et traite quand même toutes les demandes de son périmètre.
      expect((await north.ok('GET', p('/requests?pending=1')))['requests'], hasLength(2));
      await north.ok('PUT', p('/notify-sites'), {'sites': null});
      expect((await north.ok('GET', '/me'))['companies'].single['notifySites'], isNull);
    });
  });

  group('annuler des modifications', () {
    Future<List<dynamic>> week() async => (await owner.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'];

    test('annuler une modification ou tout annuler avant de publier', () async {
      final kept = await published(bob.id, '2026-10-07', siteNorth);
      await owner.ok('PATCH', p('/shifts/$kept'), {'start': 600, 'userId': eva.id});
      await owner.ok('POST', p('/shifts'),
          {'days': ['2026-10-08'], 'start': 480, 'end': 960, 'siteId': siteNorth});
      expect((await owner.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['pending'], 2);

      expect((await owner.ok('POST', p('/shifts/$kept/revert')))['reverted'], true);
      final s = (await week()).firstWhere((s) => s['id'] == kept);
      expect([s['start'], s['userId'], s['status']], [480, bob.id, 'published']);
      expect((await owner.ok('POST', p('/shifts/$kept/revert')))['reverted'], false);

      await owner.ok('DELETE', p('/shifts/$kept'));
      expect((await owner.ok('POST', p('/discard')))['discarded'], 2);
      expect([for (final s in await week()) s['id']], [kept], reason: 'le brouillon disparaît, la suppression est annulée');
      expect((await owner.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['pending'], 0);
      expect((await bob('POST', p('/discard'))).$1, 403);
    });

    test('un responsable de site n\'annule que ses sites', () async {
      await owner.ok('POST', p('/shifts'), {'days': ['2026-10-08'], 'start': 480, 'end': 960, 'siteId': siteNorth});
      final south = (await owner.ok('POST', p('/shifts'),
          {'days': ['2026-10-08'], 'start': 480, 'end': 960, 'siteId': siteSouth}))['shifts'].single['id'];
      expect((await north('POST', p('/shifts/$south/revert'))).$1, 403);
      expect((await north.ok('POST', p('/discard')))['discarded'], 1);
      expect([for (final s in await week()) s['id']], [south]);
    });
  });

  group('absences', () {
    test('congé : demandé, validé, visible dans les absences', () async {
      expect((await bob('POST', p('/requests'), {'kind': 'leave', 'startDay': '2026-10-10', 'endDay': '2026-10-08'})).$1,
          400);
      final r = await bob.ok('POST', p('/requests'),
          {'kind': 'leave', 'startDay': '2026-10-08', 'endDay': '2026-10-10', 'note': 'Mariage'});
      expect(r['status'], 'pending_manager');
      expect(await kinds(north), contains('leave_to_approve'));
      expect((await bob('POST', '/requests/${r['id']}/approve')).$1, 403);
      expect((await owner.ok('GET', p('/absences?from=2026-10-05&to=2026-10-11')))['absences'], isEmpty);
      await north.ok('POST', '/requests/${r['id']}/approve');
      expect(await kinds(bob), contains('request_approved'));
      final abs = (await owner.ok('GET', p('/absences?from=2026-10-05&to=2026-10-11')))['absences'].single;
      expect([abs['requester']['id'], abs['startDay'], abs['endDay'], abs['note']],
          [bob.id, '2026-10-08', '2026-10-10', 'Mariage']);
      expect((await owner.ok('GET', p('/absences?from=2026-10-12&to=2026-10-18')))['absences'], isEmpty);
      // Un salarié ne voit que les siennes.
      expect((await eva.ok('GET', p('/absences?from=2026-10-05&to=2026-10-11')))['absences'], isEmpty);
      expect((await bob.ok('GET', p('/absences?from=2026-10-05&to=2026-10-11')))['absences'], hasLength(1));
      expect((await owner('GET', p('/absences?from=x&to=y'))).$1, 400);
    });

    test('indisponibilité : jours de la semaine, sans fin', () async {
      expect((await zoe('POST', p('/requests'), {'kind': 'unavailability'})).$1, 400);
      final r = await zoe.ok('POST', p('/requests'), {'kind': 'unavailability', 'weekdays': [3, 1, 3, 9]});
      expect(r['weekdays'], [1, 3]);
      // Zoé est au Sud : le responsable du Nord n'est pas concerné.
      expect(await kinds(north), isNot(contains('unavailability_to_approve')));
      expect(await kinds(owner), contains('unavailability_to_approve'));
      expect((await north('POST', '/requests/${r['id']}/approve')).$1, 403);
      await owner.ok('POST', '/requests/${r['id']}/approve');
      final abs = (await owner.ok('GET', p('/absences?from=2027-01-01&to=2027-01-07')))['absences'].single;
      expect(abs['weekdays'], [1, 3]);
    });

    test('un responsable ne valide pas sa propre demande, le propriétaire si', () async {
      final r = await north.ok('POST', p('/requests'), {'kind': 'leave', 'startDay': '2026-10-08', 'endDay': '2026-10-08'});
      expect(r['canDecide'], false);
      expect((await north('POST', '/requests/${r['id']}/approve')).$1, 403);
      expect(await kinds(owner), contains('leave_to_approve'));
      final o = await owner.ok('POST', p('/requests'), {'kind': 'leave', 'startDay': '2026-10-09', 'endDay': '2026-10-09'});
      expect(o['canDecide'], true);
      await owner.ok('POST', '/requests/${o['id']}/approve');
    });
  });
}
