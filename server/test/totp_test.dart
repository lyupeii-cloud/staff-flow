import 'package:shelf/shelf.dart';
import 'dart:convert';

import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Comptes sans Google : activation par le code de l'employeur et
/// application 2FA, connexion, blocage, codes de secours, nouveau code.
void main() {
  final env = TestEnv();

  late Client boss;
  late String company, publicCode;

  String p(String path) => '/companies/$company$path';

  Map<String, Object?> csv(String text) =>
      {'file': base64Encode(utf8.encode(text)), 'fileName': 'equipe.csv', 'dryRun': false};

  /// Code à 6 chiffres de l'application 2FA, à l'heure du serveur de test.
  String otp(String secret, [int offset = 0]) =>
      TotpService.code(secret, env.clock.now.millisecondsSinceEpoch ~/ 30000 + offset);

  setUp(() async {
    boss = await env.login('boss');
    company = await env.createCompany(boss);
    publicCode = (await boss.ok('GET', p('/billing')))['publicId'];
  });

  Future<String> invite(String name, {String? number}) async {
    await boss.ok('POST', p('/imports'), csv('Nom;Matricule\n$name;${number ?? ''}\n'));
    return ((await boss.ok('GET', p('/invites')))['invites'] as List).firstWhere((i) => i['name'] == name)['code'];
  }

  /// Active le compte : renvoie (secret 2FA, jeton, identifiant SF, codes de secours).
  Future<(String, String, String, List<String>)> activate(String code) async {
    final anon = Client(env.handler);
    final start = await anon.ok('POST', '/auth/activate', {'code': code});
    final secret = start['secret'] as String;
    expect(start['otpauth'], startsWith('otpauth://totp/Staff%20Flow'));
    final done = await anon.ok('POST', '/auth/activate/confirm', {'pending': start['pending'], 'otp': otp(secret)});
    return (secret, done['token'] as String, done['user']['publicId'] as String, (done['backupCodes'] as List).cast<String>());
  }

  test('activation : code de l\'employeur puis application 2FA ; compte dans l\'entreprise, sans Google', () async {
    final code = await invite('Camille Durand', number: 'C-001');
    final anon = Client(env.handler);
    expect((await anon('POST', '/auth/activate', {'code': 'ZZZZZZZZ'})).$1, 404);
    final start = await anon.ok('POST', '/auth/activate', {'code': code});
    expect([start['name'], start['companyName']], ['Camille Durand', 'Boulangerie']);
    expect((await anon('POST', '/auth/activate/confirm', {'pending': start['pending'], 'otp': '000000'})).$1, 400);
    final done = await anon.ok('POST', '/auth/activate/confirm', {'pending': start['pending'], 'otp': otp(start['secret'])});
    expect(done['user']['local'], true);
    expect(done['backupCodes'], hasLength(8));
    // Le code ne sert qu'une fois.
    expect((await anon('POST', '/auth/activate', {'code': code})).$1, 404);
    final members = (await boss.ok('GET', p('/members')))['members'] as List;
    final m = members.firstWhere((m) => m['user']['publicId'] == done['user']['publicId']);
    expect([m['user']['name'], m['employeeNumber']], ['Camille Durand', 'C-001']);
  });

  test('connexion : identifiant SF ou matricule + code entreprise ; un code ne sert qu\'une fois ; codes de secours', () async {
    final (secret, _, sf, backup) = await activate(await invite('Lucas Moreau', number: 'C-002'));
    final a = Client(env.handler);
    env.clock.advance(const Duration(minutes: 1));
    final r = await a.ok('POST', '/auth/totp', {'login': sf.toLowerCase(), 'otp': otp(secret)});
    expect(r['user']['publicId'], sf);
    // Le même code, rejoué : refusé.
    expect((await a('POST', '/auth/totp', {'login': sf, 'otp': otp(secret)})).$1, 401);
    env.clock.advance(const Duration(minutes: 1));
    final byNumber = await a.ok('POST', '/auth/totp', {'login': 'c-002', 'company': publicCode, 'otp': otp(secret)});
    expect(byNumber['user']['publicId'], sf);
    // Code de secours : une seule fois.
    await a.ok('POST', '/auth/totp', {'login': sf, 'otp': backup.first.toLowerCase()});
    expect((await a('POST', '/auth/totp', {'login': sf, 'otp': backup.first})).$1, 401);
  });

  test('création libre : un compte sans entreprise, 5 par jour et par connexion, effacé s\'il ne sert pas', () async {
    final anon = Client(env.handler, ip: '10.1.1.1');
    expect((await anon('POST', '/auth/signup', {'name': ' '})).$1, 400);
    final start = await anon.ok('POST', '/auth/signup', {'name': 'Zoé Martin'});
    final done = await anon.ok('POST', '/auth/activate/confirm', {'pending': start['pending'], 'otp': otp(start['secret'])});
    final me = Client(env.handler)..token = done['token'];
    final m = await me.ok('GET', '/me');
    expect([m['user']['name'], m['user']['local'], m['companies']], ['Zoé Martin', true, isEmpty]);
    // Connexion avec son identifiant SF.
    env.clock.advance(const Duration(minutes: 1));
    await anon.ok('POST', '/auth/totp', {'login': done['user']['publicId'], 'otp': otp(start['secret'])});
    // Elle rejoint une entreprise par le QR code du patron : elle n'est plus effacée.
    for (var i = 0; i < 4; i++) {
      final s = await anon.ok('POST', '/auth/signup', {'name': 'Test $i'});
      await anon.ok('POST', '/auth/activate/confirm', {'pending': s['pending'], 'otp': otp(s['secret'])});
    }
    expect((await anon('POST', '/auth/signup', {'name': 'Un de trop'})).$1, 429);
    await boss.ok('POST', p('/invite'), {'qr': done['user']['publicId']});
    final r = ((await me.ok('GET', '/me'))['pendingJoinRequests'] as List).single['id'];
    await me.ok('POST', '/join-requests/$r/accept');
    env.clock.advance(const Duration(days: 31));
    await env.api.totp.purgeUnused();
    expect((await me('GET', '/me')).$1, 200, reason: 'membre d\'une entreprise : gardé');
    final unused = await env.store.query(env.store.db, "SELECT count(*) FROM users WHERE name LIKE 'Test %'");
    expect(unused.first[0], 0, reason: 'jamais dans une entreprise : effacés');
  });

  test('compte Google : prépare la 2FA puis s\'en sert pour se connecter ; e-mail jamais montré aux collègues', () async {
    final bob = await env.login('bob');
    await env.store.addMember(company, bob.id, Role.employee);
    final start = await bob.ok('POST', '/me/totp');
    expect((await bob('POST', '/me/totp/confirm', {'pending': start['pending'], 'otp': '000000'})).$1, 400);
    final done = await bob.ok('POST', '/me/totp/confirm', {'pending': start['pending'], 'otp': otp(start['secret'])});
    expect(done['backupCodes'], hasLength(8));
    expect((await bob.ok('GET', '/me'))['totp'], true);
    env.clock.advance(const Duration(minutes: 1));
    final r = await Client(env.handler).ok('POST', '/auth/totp', {'login': bob.user['publicId'], 'otp': otp(start['secret'])});
    expect(r['user']['id'], bob.id);
    // Les autres membres ne voient jamais l'adresse Google du patron.
    final members = (await bob.ok('GET', p('/members')))['members'] as List;
    expect(members.every((m) => !(m['user'] as Map).containsKey('email')), isTrue);
    await bob.ok('DELETE', '/me/totp');
    expect((await bob.ok('GET', '/me'))['totp'], false);
  });

  test('3 erreurs depuis un appareil : bloqué 15 minutes, les autres appareils non ; la personne est prévenue', () async {
    final (secret, token, sf, _) = await activate(await invite('Inès Lefèvre'));
    final bad = Client(env.handler, ip: '10.0.0.9');
    for (var i = 0; i < 3; i++) {
      expect((await bad('POST', '/auth/totp', {'login': sf, 'otp': '123456'})).$1, 401);
    }
    expect((await bad('POST', '/auth/totp', {'login': sf, 'otp': otp(secret)})).$1, 429);
    // Un autre appareil n'est pas bloqué.
    env.clock.advance(const Duration(minutes: 1));
    await Client(env.handler, ip: '10.0.0.10').ok('POST', '/auth/totp', {'login': sf, 'otp': otp(secret)});
    await env.api.notifications.settle();
    final me = Client(env.handler)..token = token;
    expect([for (final n in (await me.ok('GET', '/notices'))['notices']) n['kind']], contains('login_blocked'));
    env.clock.advance(const Duration(minutes: 16));
    await bad.ok('POST', '/auth/totp', {'login': sf, 'otp': otp(secret)});
  });

  test('sans Google : pas de création d\'entreprise, il relie d\'abord un compte Google', () async {
    final (_, token, _, _) = await activate(await invite('Hugo Garnier'));
    final me = Client(env.handler)..token = token;
    final r = await me('POST', '/companies', {'name': 'Ma boîte', 'timezone': 'Europe/Paris'});
    expect([r.$1, r.$2['error']['code']], [409, 'google_required']);
    final link = (await me.ok('POST', '/me/link-google'))['switchToken'];
    final google = await env.handler(Request('POST', Uri.parse('http://localhost/api/v1/auth/google'),
        body: jsonEncode({'idToken': 'google:hugo', 'switchToken': link})));
    expect(google.statusCode, 200);
    final after = Client(env.handler)..token = jsonDecode(await google.readAsString())['token'];
    final user = (await after.ok('GET', '/me'))['user'];
    expect([user['local'], user['email']], [null, 'hugo@example.com']);
    await after.ok('POST', '/companies', {'name': 'Ma boîte', 'timezone': 'Europe/Paris'});
  });

  test('téléphone perdu : le patron donne un nouveau code, l\'ancienne application ne sert plus', () async {
    final (oldSecret, token, sf, _) = await activate(await invite('Manon Rousseau'));
    final member = ((await boss.ok('GET', p('/members')))['members'] as List).firstWhere((m) => m['user']['publicId'] == sf);
    final again = await boss.ok('POST', p('/members/${member['user']['id']}/activation-code'));
    expect((await (Client(env.handler)..token = token)('GET', '/me')).$1, 200);
    final (newSecret, _, sf2, _) = await activate(again['code'] as String);
    expect(sf2, sf, reason: 'même compte');
    // Anciennes sessions fermées, ancienne application refusée.
    expect(((await (Client(env.handler)..token = token)('GET', '/me')).$1), 401);
    env.clock.advance(const Duration(minutes: 1));
    expect((await Client(env.handler)('POST', '/auth/totp', {'login': sf, 'otp': otp(oldSecret)})).$1, 401);
    await Client(env.handler).ok('POST', '/auth/totp', {'login': sf, 'otp': otp(newSecret)});
    // Un compte Google ne reçoit pas de code d'activation.
    final bob = await env.login('bob');
    await env.store.addMember(company, bob.id, Role.employee);
    expect((await boss('POST', p('/members/${bob.id}/activation-code'))).$1, 409);
  });
}
