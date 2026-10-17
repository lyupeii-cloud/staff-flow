import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Limites : débit par clé, par entreprise et par adresse IP ; taille des requêtes.
void main() {
  final env = TestEnv();

  late Client boss;
  late String company;

  setUp(() async {
    boss = await env.login('boss');
    company = await env.createCompany(boss);
  });

  String p(String path) => '/companies/$company$path';

  Future<Response> ext(String method, String path, String key, [Object? body]) async => env.handler(Request(
      method, Uri.parse('http://localhost/api/v1$path'),
      body: body == null ? null : jsonEncode(body), headers: {'authorization': 'Bearer $key'}));

  /// « API Pro » 5 clés (plusieurs clés dans les tests).
  Future<void> pro5() async {
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false});
    await boss.ok('POST', p('/billing/addon'), {'option': 'pro5'});
  }

  test('lectures par minute et par clé : 429 avec l\'attente, une seule ligne de journal', () async {
    await boss.ok('PUT', '/admin/settings/apiReadPerMinute', {'value': 3});
    await pro5();
    final key = (await boss.ok('POST', p('/api-keys'), {'name': 'ERP', 'scopes': ['read']}))['key'] as String;
    final first = await ext('GET', '/ext/company', key);
    expect([first.statusCode, first.headers['x-ratelimit-limit'], first.headers['x-ratelimit-remaining']], [200, '3', '2']);
    await ext('GET', '/ext/company', key);
    await ext('GET', '/ext/company', key);
    final refused = await ext('GET', '/ext/company', key);
    expect(refused.statusCode, 429);
    expect(int.parse(refused.headers['retry-after']!), inInclusiveRange(1, 60));
    await ext('GET', '/ext/company', key);
    final logs = (await boss.ok('GET', p('/api-logs?result=error')))['logs'] as List;
    expect([logs.length, logs.single['status']], [1, 429]);
    // Une minute plus tard : de nouveau accepté.
    env.clock.advance(const Duration(seconds: 61));
    expect((await ext('GET', '/ext/company', key)).statusCode, 200);
    // Une autre clé n'est pas touchée.
    final other = (await boss.ok('POST', p('/api-keys'), {'name': 'CRM', 'scopes': ['read']}))['key'] as String;
    expect((await ext('GET', '/ext/company', other)).statusCode, 200);
  });

  test('toutes les clés d\'une entreprise : limite commune', () async {
    await boss.ok('PUT', '/admin/settings/apiCompanyPerMinute', {'value': 2});
    await pro5();
    final a = (await boss.ok('POST', p('/api-keys'), {'name': 'A', 'scopes': ['read']}))['key'] as String;
    final b = (await boss.ok('POST', p('/api-keys'), {'name': 'B', 'scopes': ['read']}))['key'] as String;
    await ext('GET', '/ext/company', a);
    await ext('GET', '/ext/company', b);
    expect((await ext('GET', '/ext/company', a)).statusCode, 429);
  });

  test('connexions : essais limités par adresse IP', () async {
    await boss.ok('PUT', '/admin/settings/authPerMinute', {'value': 3});
    final codes = [
      for (var i = 0; i < 4; i++)
        (await env.handler(Request('POST', Uri.parse('http://localhost/api/v1/auth/activate'),
                body: jsonEncode({'code': 'ZZZZZZZZ'}), headers: {'x-forwarded-for': '198.51.100.9'})))
            .statusCode
    ];
    expect(codes.last, 429);
    // Une autre adresse n'est pas bloquée.
    final other = await env.handler(Request('POST', Uri.parse('http://localhost/api/v1/auth/activate'),
        body: jsonEncode({'code': 'ZZZZZZZZ'}), headers: {'x-forwarded-for': '198.51.100.10'}));
    expect(other.statusCode, isNot(429));
  });

  test('requête trop volumineuse : 413', () async {
    final big = 'x' * (1 << 20);
    final (status, _) = await boss('POST', p('/positions'), {'name': big});
    expect(status, 413);
  });
}
