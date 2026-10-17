import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Connecteur MCP : un assistant pilote Staff Flow avec une clé API.
void main() {
  final env = TestEnv();

  late Client boss;
  late String company;

  setUp(() async {
    boss = await env.login('boss');
    company = await env.createCompany(boss);
  });

  String p(String path) => '/companies/$company$path';

  var next = 0;
  Future<(int, dynamic)> rpc(String key, String method, [Map<String, Object?>? params]) async {
    final res = await env.handler(Request('POST', Uri.parse('http://localhost/api/v1/mcp'),
        body: jsonEncode({'jsonrpc': '2.0', 'id': ++next, 'method': method, 'params': ?params}),
        headers: {'authorization': 'Bearer $key', 'content-type': 'application/json'}));
    final text = await res.readAsString();
    return (res.statusCode, text.isEmpty ? null : jsonDecode(text));
  }

  Future<Map> call(String key, String tool, [Map<String, Object?> args = const {}]) async =>
      (await rpc(key, 'tools/call', {'name': tool, 'arguments': args})).$2['result'] as Map;

  test('sans clé valide : 401 ; GET : 405', () async {
    expect((await rpc('sfk_bad', 'initialize')).$1, 401);
    final get = await env.handler(Request('GET', Uri.parse('http://localhost/api/v1/mcp')));
    expect(get.statusCode, 405);
  });

  test('initialisation, outils selon les droits de la clé, lecture', () async {
    final key = (await boss.ok('POST', p('/api-keys'), {'name': 'Claude', 'scopes': ['read']}))['key'] as String;
    final init = (await rpc(key, 'initialize', {'protocolVersion': '2025-03-26', 'capabilities': {}}))
        .$2['result'] as Map;
    expect([init['protocolVersion'], init['serverInfo']['name']], ['2025-03-26', 'staff-flow']);
    // Notification : rien à répondre.
    final note = await env.handler(Request('POST', Uri.parse('http://localhost/api/v1/mcp'),
        body: jsonEncode({'jsonrpc': '2.0', 'method': 'notifications/initialized'}),
        headers: {'authorization': 'Bearer $key'}));
    expect(note.statusCode, 202);
    final tools = [for (final t in (await rpc(key, 'tools/list')).$2['result']['tools'] as List) t['name']];
    expect(tools, ['get_company', 'list_members', 'get_shifts', 'get_hours', 'get_absences']);
    final company = await call(key, 'get_company');
    expect(company['isError'], false);
    expect(jsonDecode(company['content'][0]['text'] as String), isA<Map>());
    // Outil d'écriture sans le droit : erreur renvoyée à l'assistant.
    final denied = await call(key, 'publish_schedule');
    expect([denied['isError'], (denied['content'][0]['text'] as String).startsWith('Error 403')], [true, true]);
    expect((await rpc(key, 'nope')).$2['error']['code'], -32601);
  });

  test('API Pro : l\'assistant crée des services en brouillon puis publie', () async {
    final bob = await env.login('bob');
    await env.store.addMember(company, bob.id, Role.employee);
    await boss.ok('PUT', p('/members/${bob.id}/profile'), {'employeeNumber': 'M-7'});
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false});
    await boss.ok('POST', p('/billing/addon'), {'option': 'pro'});
    final key = (await boss.ok('POST', p('/api-keys'), {'name': 'Claude', 'scopes': ['read', 'shifts', 'publish']}))['key']
        as String;
    expect((await rpc(key, 'tools/list')).$2['result']['tools'], hasLength(9));
    final created = await call(key, 'create_shifts', {
      'shifts': [
        {'day': '2026-10-07', 'start': '08:00', 'end': '16:00', 'person': 'M-7'},
      ],
    });
    expect([created['isError'], created['structuredContent']['status']], [false, 'draft']);
    expect((await call(key, 'publish_schedule'))['structuredContent']['published'], 1);
    final shifts = await call(key, 'get_shifts', {'from': '2026-10-05', 'to': '2026-10-11'});
    expect(jsonDecode(shifts['content'][0]['text'] as String), hasLength(1));
  });
}
