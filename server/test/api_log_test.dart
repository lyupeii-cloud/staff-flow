import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Journaux des clés API : appels, recherche, archives, export, alertes.
void main() {
  final env = TestEnv();

  late Client boss;
  late String company;

  setUp(() async {
    boss = await env.login('boss');
    company = await env.createCompany(boss);
  });

  String p(String path) => '/companies/$company$path';

  Future<(int, dynamic)> ext(String method, String path, String key, [Object? body, String ip = '198.51.100.7']) async {
    final res = await env.handler(Request(method, Uri.parse('http://localhost/api/v1$path'),
        body: body == null ? null : jsonEncode(body), headers: {'authorization': 'Bearer $key', 'x-forwarded-for': ip}));
    final text = await res.readAsString();
    return (res.statusCode, text.isEmpty ? null : jsonDecode(text));
  }

  Future<String> proKey(List<String> scopes) async {
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false});
    await boss.ok('POST', p('/billing/addon'), {'option': 'pro'});
    return (await boss.ok('POST', p('/api-keys'), {'name': 'ERP', 'scopes': scopes}))['key'] as String;
  }

  Future<List> logs([String query = '']) async => (await boss.ok('GET', p('/api-logs$query')))['logs'] as List;

  test('chaque appel est noté : avant / après, échecs, recherche et filtres ; accès réservé', () async {
    final bob = await env.login('bob');
    await env.store.addMember(company, bob.id, Role.employee);
    await boss.ok('PUT', p('/members/${bob.id}/profile'), {'employeeNumber': 'M-7'});
    final key = await proKey(['read', 'shifts']);
    final created = await ext('POST', '/ext/shifts', key, {
      'shifts': [
        {'day': '2026-10-20', 'start': '08:00', 'end': '16:00', 'person': 'M-7'},
      ],
    });
    final id = (created.$2['data']['created'] as List).single;
    await ext('PATCH', '/ext/shifts/$id', key, {'start': '09:00'});
    await ext('GET', '/ext/members', key);
    expect((await ext('POST', '/ext/publish', key)).$1, 403);
    final all = await logs();
    expect([for (final l in all) l['action']], ['schedule.publish', 'read.members', 'shift.update', 'shifts.create']);
    final update = all[2] as Map;
    expect([update['details']['before'], update['details']['after'], update['kind'], update['source']], [
      {'start': '08:00'},
      {'start': '09:00'},
      'write',
      'api'
    ]);
    expect((all[3]['details']['shifts'] as List).single['person'], contains('M-7'));
    final refused = all.first as Map;
    expect([refused['ok'], refused['status'], refused['errorCode'], refused['ip']], [false, 403, 'scope_missing', '198.51.100.7']);
    expect(refused['error'], isNotEmpty);
    // Recherche (matricule) et filtres.
    expect([for (final l in await logs('?q=m-7')) l['action']], ['shift.update', 'shifts.create']);
    expect(await logs('?kind=read'), hasLength(1));
    expect(await logs('?result=error'), hasLength(1));
    // Compteurs de la clé.
    final stats = ((await boss.ok('GET', p('/api-keys')))['keys'] as List).single['stats'] as Map;
    expect([stats['today'], stats['month'], stats['lastFailureAt'] != null], [4, 4, true]);
    // Responsable sans l'abonnement : pas de journaux.
    final m = await env.login('m');
    await env.store.addMember(company, m.id, Role.manager);
    expect((await m('GET', p('/api-logs'))).$1, 403);
  });

  test('assistant MCP et webhooks dans le même journal', () async {
    final key = await proKey(['read']);
    await env.handler(Request('POST', Uri.parse('http://localhost/api/v1/mcp'),
        body: jsonEncode({'jsonrpc': '2.0', 'id': 1, 'method': 'tools/call', 'params': {'name': 'get_company'}}),
        headers: {'authorization': 'Bearer $key'}));
    final hook = await boss.ok('POST', p('/webhooks'), {'url': 'https://erp.example.com/x', 'events': ['member.joined']});
    await boss.ok('POST', p('/webhooks/${hook['id']}/test'));
    final all = await logs();
    expect([for (final l in all) '${l['source']} ${l['action']}'], ['webhook webhook.ping', 'mcp read.company']);
  });

  test('mois anciens archivés : toujours consultables et cherchables ; export ZIP ; supprimés après 3 ans', () async {
    final key = await proKey(['read']);
    await ext('GET', '/ext/company', key);
    final first = (await boss.ok('GET', p('/api-logs/months')))['months'] as List;
    final month = first.first['month'] as String;
    env.clock.advance(const Duration(days: 30 * 14));
    await env.api.apiLogs.archive();
    final months = (await boss.ok('GET', p('/api-logs/months')))['months'] as List;
    expect(months.firstWhere((m) => m['month'] == month), {'month': month, 'count': 1, 'archived': true});
    expect([for (final l in await logs('?month=$month')) l['action']], ['read.company']);
    // Recherche dans tout l'historique (sans mois).
    expect(await logs('?q=company'), hasLength(1));
    // Export de l'année : un CSV par mois.
    final link = await boss.ok('POST', p('/api-logs/export'), {'year': int.parse(month.substring(0, 4))});
    final res = await env.handler(Request('GET', Uri.parse('http://localhost${link['path']}')));
    final zip = ZipDecoder().decodeBytes(await res.read().expand((x) => x).toList());
    expect(zip.files.single.name, '$month.csv');
    expect(utf8.decode(zip.files.single.content as List<int>), contains('read.company'));
    env.clock.advance(const Duration(days: 365 * 3));
    await env.api.apiLogs.archive();
    expect(((await boss.ok('GET', p('/api-logs/months')))['months'] as List).where((m) => m['month'] == month), isEmpty);
  });

  test('alertes au patron : échecs répétés, nouvelle adresse IP', () async {
    final key = await proKey(['read']);
    await ext('GET', '/ext/company', key, null, '198.51.100.1');
    for (var i = 0; i < 10; i++) {
      await ext('POST', '/ext/publish', key, null, '198.51.100.1');
    }
    await ext('GET', '/ext/company', key, null, '203.0.113.99');
    final kinds = [for (final n in (await boss.ok('GET', '/notices'))['notices'] as List) n['kind']];
    expect(kinds, containsAll(['api_failing', 'api_new_ip']));
    expect(kinds.where((k) => k == 'api_failing'), hasLength(1));
  });
}
