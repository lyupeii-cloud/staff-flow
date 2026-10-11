import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pointycastle/export.dart' as pc;
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

/// Paire de clés RSA jetable, créée pour le test.
(RSAPrivateKey, RSAPublicKey) testKeys() {
  final seed = Random.secure();
  final random = pc.FortunaRandom()
    ..seed(pc.KeyParameter(Uint8List.fromList(List.generate(32, (_) => seed.nextInt(256)))));
  final generator = pc.RSAKeyGenerator()
    ..init(pc.ParametersWithRandom(
        pc.RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 64), random));
  final pair = generator.generateKeyPair();
  return (
    RSAPrivateKey.raw(pair.privateKey),
    RSAPublicKey.raw(pair.publicKey),
  );
}

void main() {
  final (privateKey, publicKey) = testKeys();
  const account = {
    'project_id': 'staff-flow-test',
    'client_email': 'push@staff-flow-test.iam.gserviceaccount.com',
    'token_uri': 'https://oauth2.example/token',
  };

  test('compte de service signé, puis message envoyé à Firebase', () async {
    final requests = <http.Request>[];
    final sender = FcmSender(account, signingKey: privateKey, client: MockClient((req) async {
      requests.add(req);
      if (req.url.toString() == 'https://oauth2.example/token') {
        return http.Response(jsonEncode({'access_token': 'acces-1', 'expires_in': 3600}), 200);
      }
      return http.Response('{}', 200);
    }));

    final message = PushMessage('jeton-tel', 'Boulangerie', 'Votre planning a été publié ou modifié.',
        {'kind': 'schedule_published', 'tag': 'planning-c1'});
    expect(await sender.send(message), PushOutcome.sent);
    expect(await sender.send(message), PushOutcome.sent);

    // Un seul jeton d'accès pour les deux envois.
    expect(requests.where((r) => r.url.host == 'oauth2.example'), hasLength(1));
    final assertion = requests.first.bodyFields['assertion']!;
    final jwt = JWT.verify(assertion, publicKey);
    expect(jwt.issuer, account['client_email']);
    expect(jwt.payload['scope'], 'https://www.googleapis.com/auth/firebase.messaging');
    expect(jwt.payload['aud'], 'https://oauth2.example/token');

    final send = requests[1];
    expect(send.url.toString(), 'https://fcm.googleapis.com/v1/projects/staff-flow-test/messages:send');
    expect(send.headers['authorization'], 'Bearer acces-1');
    final body = jsonDecode(send.body)['message'];
    expect(body['token'], 'jeton-tel');
    expect(body['notification'], {'title': 'Boulangerie', 'body': 'Votre planning a été publié ou modifié.'});
    expect(body['data']['kind'], 'schedule_published');
    expect(body['android']['notification']['channel_id'], 'staff_flow');
  });

  test('appareil désinscrit : jeton invalide ; autre erreur : échec', () async {
    var status = 404;
    final sender = FcmSender(account, signingKey: privateKey, client: MockClient((req) async {
      if (req.url.host == 'oauth2.example') return http.Response('{"access_token":"a"}', 200);
      return http.Response('{"error":{"status":"UNREGISTERED"}}', status);
    }));
    const m = PushMessage('t', 'a', 'b', {});
    expect(await sender.send(m), PushOutcome.invalidToken);
    status = 500;
    expect(await sender.send(m), PushOutcome.failed);
  });
}
