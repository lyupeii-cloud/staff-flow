import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Formules API : lecture (1 clé), « API Pro » 1 ou 5 clés ; passage de la
/// lecture à Pro, de 1 à 5 clés, baisse au renouvellement, arrêt puis
/// suppression des clés après 30 jours.
void main() {
  final env = TestEnv();

  late Client boss;
  late String company;

  setUp(() async {
    boss = await env.login('boss');
    company = await env.createCompany(boss);
  });

  String p(String path) => '/companies/$company$path';

  Future<int> ext(String key, [String method = 'GET', String path = '/ext/company', Object? body]) async =>
      (await env.handler(Request(method, Uri.parse('http://localhost/api/v1$path'),
              body: body == null ? null : jsonEncode(body), headers: {'authorization': 'Bearer $key'})))
          .statusCode;

  Future<String> newKey(String name, [List<String> scopes = const ['read']]) async =>
      (await boss.ok('POST', p('/api-keys'), {'name': name, 'scopes': scopes}))['key'] as String;

  test('lecture : 1 clé (essai compris) ; Pro remplace la lecture, la même clé reçoit des droits d\'écriture', () async {
    final key = await newKey('Compta');
    expect((await boss('POST', p('/api-keys'), {'name': 'CRM', 'scopes': ['read']})).$1, 409);
    expect((await boss.ok('GET', p('/api-keys')))['limit'], 1);
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false, 'api': true});
    expect((await boss.ok('GET', p('/billing')))['apiOption'], true);
    // Lecture → Pro : l'option lecture s'arrête (comprise), la clé reste.
    await boss.ok('POST', p('/billing/addon'), {'option': 'pro'});
    final b = await boss.ok('GET', p('/billing'));
    expect([b['apiOption'], b['apiProOption'], b['apiProKeys'], b['addons']['api']], [false, true, 1, null]);
    final id = ((await boss.ok('GET', p('/api-keys')))['keys'] as List).single['id'];
    await boss.ok('PATCH', p('/api-keys/$id'), {'scopes': ['read', 'catalog']});
    expect(await ext(key, 'POST', '/ext/positions', {'name': 'Caisse'}), 201);
    // Renouvellement avec Pro : la lecture n'est pas facturée en plus.
    final lines = ((await boss.ok('GET', p('/billing')))['offers']['month-0-1']['lines'] as List).map((l) => l['label']);
    expect(lines, contains('api'));
    final paid = await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false, 'api': true});
    expect(paid['amountCents'], 300 + 1000);
  });

  test('5 clés ; baisse à 1 clé au renouvellement : clés en trop désactivées, le patron choisit', () async {
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false});
    final quote = (await boss.ok('GET', p('/billing')))['addons']['pro5'] as Map;
    expect([quote['lines'].single['unitCents'], quote['lines'].single['label']], [2000, 'pro5Addon']);
    await boss.ok('POST', p('/billing/addon'), {'option': 'pro5'});
    final a = await newKey('A'), b = await newKey('B');
    expect((await boss.ok('GET', p('/api-keys')))['limit'], 5);
    // Déjà 5 clés : rien à changer au renouvellement.
    expect((await boss('PUT', p('/billing/renewal'), {'option': 'proKeys', 'keys': 5})).$1, 204);
    await boss.ok('PUT', p('/billing/renewal'), {'option': 'proKeys', 'keys': 1});
    expect((await boss.ok('GET', p('/billing')))['apiProNextKeys'], 1);
    final renew = await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false});
    expect(renew['amountCents'], 300 + 1000);
    final keys = ((await boss.ok('GET', p('/api-keys')))['keys'] as List).cast<Map>();
    expect([for (final k in keys) k['disabled']], [false, true]);
    expect([await ext(a), await ext(b)], [200, 403]);
    // Réactiver B : il faut d'abord mettre A de côté.
    expect((await boss('PATCH', p('/api-keys/${keys[1]['id']}'), {'enabled': true})).$1, 409);
    await boss.ok('PATCH', p('/api-keys/${keys[0]['id']}'), {'enabled': false});
    await boss.ok('PATCH', p('/api-keys/${keys[1]['id']}'), {'enabled': true});
    expect([await ext(a), await ext(b)], [403, 200]);
  });

  test('option non renouvelée : clés inactives, prévenu 7 jours avant, supprimées après 30 jours ; reprise avant : mêmes clés', () async {
    // Abonnement payé avec la lecture, puis renouvelé sans elle.
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false, 'api': true});
    final key = await newKey('Compta');
    await boss.ok('PUT', p('/billing/renewal'), {'option': 'api', 'renew': false});
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false, 'api': false});
    final end = DateTime.parse((await boss.ok('GET', p('/billing')))['apiUntil'] as String);
    env.clock.advance(end.difference(env.clock.now) + const Duration(hours: 1));
    await env.api.billing.tick();
    expect(await ext(key), 402);
    env.clock.advance(const Duration(days: 23));
    await env.api.billing.tick();
    final kinds = [for (final n in (await boss.ok('GET', '/notices'))['notices'] as List) n['kind']];
    expect(kinds, contains('api_keys_deletion'));
    // Reprise avant la fin : la même clé marche à nouveau.
    await boss.ok('POST', p('/billing/addon'), {'option': 'api'});
    await env.api.billing.tick();
    expect(await ext(key), 200);
    // Arrêtée de nouveau, puis 30 jours : supprimée.
    await boss.ok('PUT', p('/billing/renewal'), {'option': 'api', 'renew': false});
    await boss.ok('POST', p('/billing/checkout'), {'period': 'year', 'cascade': false, 'api': false});
    final end2 = DateTime.parse((await boss.ok('GET', p('/billing')))['apiUntil'] as String);
    env.clock.advance(end2.difference(env.clock.now) + const Duration(hours: 1));
    await env.api.billing.tick();
    env.clock.advance(const Duration(days: 31));
    await env.api.billing.tick();
    expect((await boss.ok('GET', p('/api-keys')))['keys'], isEmpty);
    expect(await ext(key), 401);
  });
}
