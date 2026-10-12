import 'dart:convert';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Préréglages d'horaires, image de l'entreprise.
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
