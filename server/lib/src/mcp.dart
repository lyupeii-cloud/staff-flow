import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'api_access.dart';
import 'errors.dart';

/// Connecteur MCP (Model Context Protocol) : un assistant (Claude…) ou un
/// logiciel compatible pilote Staff Flow avec une clé API. Transport HTTP
/// « streamable » simplifié : chaque POST porte un message JSON-RPC 2.0 et
/// reçoit sa réponse en JSON. Chaque outil appelle l'API `/ext` avec la
/// même clé : mêmes droits, mêmes contrôles, même historique.
class McpServer {
  final Handler api;
  final ApiAccessService access;

  McpServer(this.api, this.access);

  static const protocol = '2025-06-18';
  static const _versions = {'2024-11-05', '2025-03-26', '2025-06-18'};

  static Map<String, Object?> _obj(Map<String, Object?> props, [List<String> required = const []]) =>
      {'type': 'object', 'properties': props, if (required.isNotEmpty) 'required': required};
  static const _day = {'type': 'string', 'description': 'Date AAAA-MM-JJ / YYYY-MM-DD'};
  static const _str = {'type': 'string'};
  static const _period = {
    'from': {'type': 'string', 'description': 'YYYY-MM-DD (default: company creation)'},
    'to': {'type': 'string', 'description': 'YYYY-MM-DD (default: today)'},
  };
  static final _shift = _obj({
    'day': _day,
    'start': {'type': 'string', 'description': 'HH:MM'},
    'end': {'type': 'string', 'description': 'HH:MM (before start = next day)'},
    'person': {'type': 'string', 'description': 'SF ID (SF-…) or employee number; omit for an open shift'},
    'site': {'type': 'string', 'description': 'site name or id'},
    'position': {'type': 'string', 'description': 'position name or id'},
    'note': _str,
  }, ['day', 'start', 'end']);

  /// Outils : nom, droit de la clé, description, schéma, appel à l'API.
  static final List<McpTool> tools = [
    McpTool('get_company', 'read', 'Company: name, time zone, sites and positions.', _obj({}),
        (a) => ('GET', '/ext/company', null)),
    McpTool('list_members', 'read', 'People of the company (current and former), with role and dates.', _obj({}),
        (a) => ('GET', '/ext/members', null)),
    McpTool('get_shifts', 'read', 'Published shifts over a period.', _obj(_period),
        (a) => ('GET', '/ext/shifts?${_q(a, ['from', 'to'])}', null)),
    McpTool('get_hours', 'read', 'Published hours per person over a period.', _obj(_period),
        (a) => ('GET', '/ext/totals?${_q(a, ['from', 'to'])}', null)),
    McpTool('get_absences', 'read', 'Approved leave and unavailability over a period.', _obj(_period),
        (a) => ('GET', '/ext/absences?${_q(a, ['from', 'to'])}', null)),
    McpTool(
        'create_shifts',
        'shifts',
        'Create shifts. They arrive as drafts that managers can adjust and publish, unless publish is true '
            '(needs the publish permission).',
        _obj({
          'shifts': {'type': 'array', 'items': _shift},
          'publish': {'type': 'boolean', 'description': 'publish at once (default false: draft)'},
        }, ['shifts']),
        (a) => ('POST', '/ext/shifts', {'shifts': a['shifts'], 'publish': a['publish'] == true})),
    McpTool(
        'update_shift',
        'shifts',
        'Edit a shift (it goes back to draft). Only the given fields change.',
        _obj({
          'id': _str,
          'day': _day,
          'start': _str,
          'end': _str,
          'person': _str,
          'site': _str,
          'position': _str,
          'note': _str,
        }, ['id']),
        (a) => ('PATCH', '/ext/shifts/${a['id']}', {...a}..remove('id'))),
    McpTool('delete_shift', 'shifts', 'Delete a shift.', _obj({'id': _str}, ['id']),
        (a) => ('DELETE', '/ext/shifts/${a['id']}', null)),
    McpTool('publish_schedule', 'publish', 'Publish all draft changes: employees see them and are notified.', _obj({}),
        (a) => ('POST', '/ext/publish', null)),
    McpTool(
        'import_employees',
        'members',
        'Add employees: each gets a personal invitation code and QR code to activate their account.',
        _obj({
          'rows': {
            'type': 'array',
            'items': _obj({'name': _str, 'number': _str, 'position': _str, 'site': _str}, ['name']),
          },
          'dryRun': {'type': 'boolean', 'description': 'preview only'},
        }, ['rows']),
        (a) => ('POST', '/ext/members/import', {'rows': a['rows'], 'dryRun': a['dryRun'] == true})),
    McpTool('list_invitations', 'members', 'Pending invitations with their code and QR link.', _obj({}),
        (a) => ('GET', '/ext/invites', null)),
    McpTool(
        'set_employee_profile',
        'members',
        'Set the employee number and usual position of a person.',
        _obj({'person': _str, 'employeeNumber': _str, 'position': _str}, ['person']),
        (a) => (
              'PUT',
              '/ext/members/${Uri.encodeComponent('${a['person']}')}/profile',
              {'employeeNumber': a['employeeNumber'], 'position': a['position']}
            )),
    McpTool('create_position', 'catalog', 'Create a position (job).', _obj({'name': _str}, ['name']),
        (a) => ('POST', '/ext/positions', {'name': a['name']})),
    McpTool('create_site', 'catalog', 'Create a site, optionally under a parent site.',
        _obj({'name': _str, 'parent': _str}, ['name']), (a) => ('POST', '/ext/sites', {'name': a['name'], 'parent': a['parent']})),
    McpTool(
        'post_announcement',
        'news',
        'Post an announcement to the news feed: for everyone, or for positions, sites, roles or people.',
        _obj({
          'title': _str,
          'body': _str,
          'audience': _obj({
            'everyone': {'type': 'boolean'},
            'positions': {'type': 'array', 'items': _str},
            'sites': {'type': 'array', 'items': _str},
            'roles': {'type': 'array', 'items': _str},
            'users': {'type': 'array', 'items': _str},
          }),
        }, ['body']),
        (a) => ('POST', '/ext/news', {'title': a['title'], 'body': a['body'], 'audience': a['audience'] ?? {'everyone': true}})),
    McpTool('list_pending_requests', 'requests', 'Pending requests: shift swaps, leave, unavailability.', _obj({}),
        (a) => ('GET', '/ext/requests', null)),
    McpTool(
        'decide_request',
        'requests',
        'Approve or refuse a pending request.',
        _obj({'id': _str, 'approve': {'type': 'boolean'}}, ['id', 'approve']),
        (a) => ('POST', '/ext/requests/${a['id']}/${a['approve'] == true ? 'approve' : 'refuse'}', null)),
  ];

  static String _q(Map<String, dynamic> a, List<String> keys) =>
      [for (final k in keys) if (a[k] is String) '$k=${Uri.encodeQueryComponent(a[k] as String)}'].join('&');

  Future<Response> handle(Request req) async {
    if (req.method != 'POST') {
      return Response(405, headers: {'allow': 'POST'}, body: 'POST JSON-RPC messages to this address.');
    }
    final auth = req.headers['authorization'] ?? req.headers['x-api-key'];
    final ApiKey key;
    try {
      key = await access.key(auth);
    } on ApiError catch (e) {
      return Response(e.status, body: jsonEncode({'error': e.code}), headers: {
        'content-type': 'application/json',
        if (e.status == 401) 'www-authenticate': 'Bearer realm="Staff Flow"',
      });
    }
    final Object? msg;
    try {
      msg = jsonDecode(await req.readAsString());
    } on FormatException {
      return _rpcError(null, -32700, 'Parse error');
    }
    if (msg is! Map) return _rpcError(null, -32600, 'Invalid request');
    final id = msg['id'];
    final method = msg['method'];
    // Notification (sans id) : rien à répondre.
    if (id == null) return Response(202);
    final params = (msg['params'] as Map?)?.cast<String, dynamic>() ?? const {};
    switch (method) {
      case 'initialize':
        final wanted = params['protocolVersion'];
        return _result(id, {
          'protocolVersion': _versions.contains(wanted) ? wanted : protocol,
          'capabilities': {
            'tools': {'listChanged': false},
          },
          'serverInfo': {'name': 'staff-flow', 'title': 'Staff Flow', 'version': '1.0.0'},
          'instructions': 'Staff Flow: team scheduling for ${key.company.name}. '
              'Times are in the company time zone (${key.company.timezone}). '
              'Shifts created here are drafts unless published; managers review them in the app.',
        });
      case 'ping':
        return _result(id, {});
      case 'tools/list':
        // Seulement les outils permis par cette clé.
        return _result(id, {
          'tools': [
            for (final t in tools)
              if (key.scopes.contains(t.scope))
                {'name': t.name, 'description': t.description, 'inputSchema': t.schema},
          ],
        });
      case 'tools/call':
        final tool = tools.where((t) => t.name == params['name']).firstOrNull;
        if (tool == null) return _rpcError(id, -32602, 'Unknown tool: ${params['name']}');
        final args = (params['arguments'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{};
        final (verb, path, body) = tool.call(args);
        final res = await api(Request(verb, Uri.parse('http://localhost/api/v1$path'),
            body: body == null ? null : jsonEncode(body),
            headers: {
              'authorization': auth!,
              'content-type': 'application/json',
              if (req.headers['accept-language'] != null) 'accept-language': req.headers['accept-language']!,
            }));
        final text = await res.readAsString();
        final ok = res.statusCode < 400;
        Object? data;
        try {
          data = jsonDecode(text);
        } on FormatException {
          data = text;
        }
        final shown = ok && data is Map && data.containsKey('data') ? data['data'] : data;
        return _result(id, {
          'content': [
            {
              'type': 'text',
              'text': ok
                  ? const JsonEncoder.withIndent(' ').convert(shown)
                  : 'Error ${res.statusCode}: ${data is Map ? (data['error']?['message'] ?? text) : text}',
            },
          ],
          if (ok && shown is Map) 'structuredContent': shown,
          'isError': !ok,
        });
      default:
        return _rpcError(id, -32601, 'Method not found: $method');
    }
  }

  static Response _result(Object id, Object result) =>
      Response.ok(jsonEncode({'jsonrpc': '2.0', 'id': id, 'result': result}), headers: {'content-type': 'application/json'});

  static Response _rpcError(Object? id, int code, String message) => Response.ok(
      jsonEncode({'jsonrpc': '2.0', 'id': id, 'error': {'code': code, 'message': message}}),
      headers: {'content-type': 'application/json'});
}

class McpTool {
  final String name, scope, description;
  final Map<String, Object?> schema;
  final (String, String, Object?) Function(Map<String, dynamic>) call;

  McpTool(this.name, this.scope, this.description, this.schema, this.call);
}
