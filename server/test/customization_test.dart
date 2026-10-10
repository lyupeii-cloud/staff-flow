import 'dart:convert';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Préréglages d'horaires, groupes en sourdine, groupe de l'entreprise,
/// image de l'entreprise.
void main() {
  final env = TestEnv();

  late Client owner, manager, bob;
  late String company;

  String p(String path) => '/companies/$company$path';

  setUp(() async {
    owner = await env.login('owner');
    manager = await env.login('manager');
    bob = await env.login('bob');
    company = await env.createCompany(owner);
    await env.store.addMember(company, manager.id, Role.manager);
    await env.store.addMember(company, bob.id, Role.employee);
  });

  Future<Map<String, dynamic>> myCompany(Client c) async => (await c.ok('GET', '/me'))['companies'].single['company'];

  test('préréglages d\'horaires : définis par un responsable, vus de tous', () async {
    final presets = [
      {'name': 'Matin', 'start': 360, 'end': 840},
      {'name': 'Nuit', 'start': 1320, 'end': 360},
    ];
    await manager.ok('PUT', p('/presets'), {'presets': presets});
    expect((await myCompany(bob))['shiftPresets'], presets);
    expect((await bob('PUT', p('/presets'), {'presets': []})).$1, 403);
    expect((await manager('PUT', p('/presets'), {
      'presets': [
        {'name': '', 'start': 0, 'end': 60},
      ],
    }))
        .$1, 400);
    expect((await manager('PUT', p('/presets'), {
      'presets': [
        {'name': 'X', 'start': 0, 'end': 1440},
      ],
    }))
        .$1, 400);
  });

  group('messagerie', () {
    Future<void> device(Client c, String token) =>
        c.ok('PUT', '/devices', {'token': token, 'platform': 'android', 'language': 'fr'});

    Future<String> groupId(Client c) async =>
        ((await c.ok('GET', p('/conversations')))['conversations'] as List).firstWhere((c) => c['kind'] == 'group')['id'];

    test('une conversation en sourdine ne sonne plus, pour cette personne seulement', () async {
      await device(bob, 'tel-bob');
      await device(manager, 'tel-manager');
      final g = await groupId(bob);
      await bob.ok('PUT', '/conversations/$g/mute', {'muted': true});
      final list = (await bob.ok('GET', p('/conversations')))['conversations'] as List;
      expect(list.firstWhere((c) => c['id'] == g)['muted'], true);
      await owner.ok('POST', '/conversations/$g/messages', {'body': 'Bonjour'});
      await env.api.notifications.settle();
      expect(env.push.sent.map((m) => m.token), ['tel-manager']);
      await bob.ok('PUT', '/conversations/$g/mute', {'muted': false});
      await owner.ok('POST', '/conversations/$g/messages', {'body': 'Re'});
      await env.api.notifications.settle();
      expect(env.push.sent.map((m) => m.token), containsAll(['tel-bob']));
    });

    test('le patron seul coupe, rétablit ou vide le groupe de l\'entreprise', () async {
      final g = await groupId(bob);
      await bob.ok('POST', '/conversations/$g/messages', {'body': 'Salut'});
      expect((await manager('PUT', p('/group'), {'enabled': false})).$1, 403);
      expect((await manager('POST', p('/group/reset'))).$1, 403);
      await owner.ok('PUT', p('/group'), {'enabled': false});
      expect((await myCompany(bob))['groupEnabled'], false);
      expect(((await bob.ok('GET', p('/conversations')))['conversations'] as List).where((c) => c['kind'] == 'group'), isEmpty);
      expect((await bob('POST', '/conversations/$g/messages', {'body': 'Encore'})).$1, 409);
      await owner.ok('PUT', p('/group'), {'enabled': true});
      await owner.ok('POST', p('/group/reset'));
      expect((await bob.ok('GET', '/conversations/$g/messages'))['messages'], isEmpty);
    });
  });

  test('messagerie : désactivée à la création, le patron seul l\'active ou la coupe entièrement', () async {
    final fresh = (await owner.ok('POST', '/companies', {'name': 'Neuve', 'timezone': 'Europe/Paris'}))['company'];
    expect(fresh['messagingEnabled'], false);
    final id = fresh['id'];
    await env.store.addMember(id, bob.id, Role.employee);
    await env.store.addMember(id, manager.id, Role.manager);
    expect((await bob('GET', '/companies/$id/conversations')).$1, 409);
    expect((await manager('PUT', '/companies/$id/messaging', {'enabled': true})).$1, 403);
    await owner.ok('PUT', '/companies/$id/messaging', {'enabled': true});
    final g = ((await bob.ok('GET', '/companies/$id/conversations'))['conversations'] as List).single['id'];
    await manager.ok('POST', '/conversations/$g/messages', {'body': 'Bonjour'});
    expect((await bob.ok('GET', '/me'))['unreadMessages'], isNotEmpty);
    // Coupée : plus rien, ni lecture, ni envoi, ni pastille.
    await owner.ok('PUT', '/companies/$id/messaging', {'enabled': false});
    expect((await bob('GET', '/conversations/$g/messages')).$1, 409);
    expect((await manager('POST', '/conversations/$g/messages', {'body': 'Re'})).$1, 409);
    expect((await bob('POST', '/companies/$id/conversations', {'userId': manager.id})).$1, 409);
    expect((await bob.ok('GET', '/me'))['unreadMessages'], isEmpty);
  });

  group('image de l\'entreprise', () {
    String png(int w, int h) => base64Encode(img.encodePng(img.Image(width: w, height: h)));

    test('le patron charge un PNG : réduit, servi aux membres', () async {
      final r = await owner.ok('PUT', p('/logo'), {'png': png(600, 300)});
      expect(r['logoVersion'], 1);
      expect((await myCompany(bob))['logoVersion'], 1);
      final res = await env.handler(Request('GET', Uri.parse('http://localhost/api/v1/companies/$company/logo'),
          headers: {'authorization': 'Bearer ${bob.token}'}));
      expect(res.headers['content-type'], 'image/png');
      final served = img.decodePng(Uint8List.fromList(await res.read().expand((b) => b).toList()))!;
      expect([served.width, served.height], [192, 96]);
    });

    test('PNG seulement, 1 Mo au plus, patron seulement', () async {
      expect((await manager('PUT', p('/logo'), {'png': png(10, 10)})).$1, 403);
      final jpeg = base64Encode(img.encodeJpg(img.Image(width: 10, height: 10)));
      expect((await owner('PUT', p('/logo'), {'png': jpeg})).$1, 400);
      final fake = base64Encode([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 1, 2, 3, 4]);
      expect((await owner('PUT', p('/logo'), {'png': fake})).$1, 400);
      expect((await owner('PUT', p('/logo'), {'png': 'pas du base64 !'})).$1, 400);
      await owner.ok('PUT', p('/logo'), {'png': png(50, 50)});
      await owner.ok('PUT', p('/logo'), {'png': null});
      expect((await myCompany(bob))['logoVersion'], 0);
      // Une nouvelle image ne reprend jamais le numéro d'une ancienne (cache des appareils).
      expect((await owner.ok('PUT', p('/logo'), {'png': png(20, 20)}))['logoVersion'], 3);
      expect((await myCompany(bob))['logoVersion'], 3);
      await owner.ok('PUT', p('/logo'), {'png': null});
      expect((await bob('GET', p('/logo'))).$1, 404);
      final outsider = await env.login('outsider');
      expect((await outsider('GET', p('/logo'))).$1, 404);
    });
  });
}
