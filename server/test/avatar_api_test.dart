import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Avatars et photos masquées ; option « accès API » et clés API ;
/// entreprises jamais payées supprimées sans trace.
void main() {
  final env = TestEnv();

  Future<(int, String, Map<String, String>)> ext(String path, String? key) async {
    final res = await env.handler(Request('GET', Uri.parse('http://localhost/api/v1$path'),
        headers: {if (key != null) 'authorization': 'Bearer $key'}));
    return (res.statusCode, await res.readAsString(), res.headers);
  }

  test('avatar choisi, et photos Google masquées par le patron', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, eva.id, Role.employee);
    expect((await eva('PUT', '/me/avatar', {'avatar': {'icon': 'inconnu', 'color': 1}})).$1, 400);
    final me = await eva.ok('PUT', '/me/avatar', {'avatar': {'icon': 'pets', 'color': 3}});
    expect(me['avatar'], {'icon': 'pets', 'color': 3});
    await env.admin.execute("UPDATE users SET photo_url = 'https://photo' WHERE id = '${eva.id}'");
    Future<Map> member() async => ((await boss.ok('GET', '/companies/$company/members'))['members'] as List)
        .firstWhere((m) => m['user']['id'] == eva.id)['user'] as Map;
    expect((await member())['photoUrl'], 'https://photo');
    expect((await eva('PUT', '/companies/$company/photos', {'hidden': true})).$1, 403, reason: 'patron seulement');
    await boss.ok('PUT', '/companies/$company/photos', {'hidden': true});
    expect([(await member())['photoUrl'], (await member())['avatar']['icon']], [null, 'pets']);
    expect((await boss.ok('GET', '/me'))['companies'].single['company']['hidePhotos'], true);
    await eva.ok('PUT', '/me/avatar', {'avatar': null});
    expect((await member())['avatar'], isNull);
  });

  test('clés API : lecture du planning publié, CSV, révocation, option payante', () async {
    final boss = await env.login('boss');
    final bob = await env.login('bob');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, bob.id, Role.employee);
    await boss.ok('POST', '/companies/$company/shifts', {'days': ['2026-10-06'], 'start': 480, 'end': 960, 'userId': bob.id});
    await boss.ok('POST', '/companies/$company/publish');
    expect((await bob('POST', '/companies/$company/api-keys', {'name': 'Compta'})).$1, 403);
    final created = await boss.ok('POST', '/companies/$company/api-keys', {'name': 'Compta'});
    final key = created['key'] as String;
    expect(key, matches(RegExp(r'^sfk_[a-z0-9]{8}_[a-z0-9]{32}$')));
    final keys = (await boss.ok('GET', '/companies/$company/api-keys'))['keys'] as List;
    expect([keys.single['name'], keys.single.containsKey('key')], ['Compta', false]);
    // Sans clé, ou fausse clé : refusé.
    expect((await ext('/ext/shifts', null)).$1, 401);
    expect((await ext('/ext/shifts', 'sfk_aaaaaaaa_${'b' * 32}')).$1, 401);
    final (status, body, _) = await ext('/ext/shifts?from=2026-10-01&to=2026-10-31', key);
    expect(status, 200);
    final shift = (jsonDecode(body)['data'] as List).single;
    expect([shift['day'], shift['start'], shift['end'], shift['minutes'], shift['userName']],
        ['2026-10-06', '08:00', '16:00', 480, 'bob']);
    final totals = jsonDecode((await ext('/ext/totals?from=2026-10-01&to=2026-10-31', key)).$2)['data'] as List;
    expect(totals.single['minutes'], 480, reason: 'heures publiées');
    final (_, csv, headers) = await ext('/ext/members?format=csv', key);
    expect(headers['content-type'], startsWith('text/csv'));
    expect(csv, contains('bob'));
    expect(jsonDecode((await ext('/ext/company', key)).$2)['data']['name'], 'Boulangerie');
    // Fin de l'essai sans l'option : la clé ne lit plus rien.
    env.clock.advance(const Duration(days: 3));
    await env.api.billing.tick();
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false, 'api': false});
    expect((await ext('/ext/shifts', key)).$1, 402);
    // Avec l'option payée (prix de l'option sur sa ligne, sans remise).
    final b = await boss.ok('GET', '/companies/$company/billing');
    final offer = b['offers']['year-0-1'];
    expect([for (final l in offer['lines']) l['label']], contains('api'));
    expect(offer['price'], b['offers']['year-0-0']['price'] + 300 * 12);
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false, 'api': true});
    expect((await boss.ok('GET', '/companies/$company/billing'))['apiOption'], true);
    expect((await ext('/ext/shifts', key)).$1, 200);
    // Révoquée : plus d'accès.
    await boss.ok('DELETE', '/companies/$company/api-keys/${keys.single['id']}');
    expect((await ext('/ext/shifts', key)).$1, 401);
  });

  test('entreprise jamais payée : supprimée sans laisser de trace', () async {
    final boss = await env.login('boss');
    final company = await env.createCompany(boss);
    await boss.ok('POST', '/companies/$company/sites', {'name': 'Nord'});
    final before = await env.admin.execute("SELECT count(*) FROM audit_log WHERE company_id = '$company'");
    expect(before.first[0], greaterThan(0));
    env.clock.advance(const Duration(days: 3));
    await env.api.billing.tick();
    env.clock.advance(const Duration(days: 16));
    await env.api.billing.tick();
    final traces = await env.admin.execute('''
      SELECT (SELECT count(*) FROM companies WHERE id = '$company')
        + (SELECT count(*) FROM audit_log WHERE company_id = '$company' OR details->>'companyId' = '$company')
        + (SELECT count(*) FROM invoices WHERE company_id = '$company')''');
    expect(traces.first[0], 0);
  });
}
