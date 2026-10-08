import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'auth.dart';
import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'store.dart';

/// Construit le gestionnaire HTTP de l'API, sous `/api/v1`.
class Api {
  final Store store;
  final GoogleVerifier google;
  final SessionTokens tokens;
  final CompanyService companies;

  /// Connexion sans Google (`POST /auth/dev`), pour le développement local
  /// uniquement. Ne jamais l'activer en production.
  final bool devLogin;
  final Set<String> allowedOrigins;

  Api({
    required this.store,
    required this.google,
    required this.tokens,
    this.devLogin = false,
    this.allowedOrigins = const {},
  }) : companies = CompanyService(store);

  Handler get handler {
    final v1 = Router(notFoundHandler: _notFound)
      ..post('/auth/google', _loginGoogle)
      ..get('/me', _authed(_me))
      ..post('/companies', _authed(_createCompany))
      ..get('/companies/<id>', _authed(_getCompany))
      ..patch('/companies/<id>', _authed(_updateCompany))
      ..get('/companies/<id>/members', _authed(_members))
      ..put('/companies/<id>/members/<userId>/role', _authed(_setRole))
      ..delete('/companies/<id>/members/<userId>', _authed(_removeMember))
      ..post('/companies/<id>/transfer', _authed(_proposeTransfer))
      ..delete('/companies/<id>/transfer', _authed(_cancelTransfer))
      ..post('/transfers/<id>/accept', _authed((r, u) => _answerTransfer(r, u, accept: true)))
      ..post('/transfers/<id>/decline', _authed((r, u) => _answerTransfer(r, u, accept: false)));
    if (devLogin) v1.post('/auth/dev', _loginDev);

    final root = Router(notFoundHandler: _notFound)
      ..get('/health', (Request _) => _json({'status': 'ok'}))
      ..mount('/api/v1/', v1.call);

    return const Pipeline()
        .addMiddleware(_cors())
        .addMiddleware(_errors())
        .addHandler(root.call);
  }

  // --- Connexion -----------------------------------------------------------

  Future<Response> _loginGoogle(Request req) async {
    final body = await _body(req);
    final idToken = body['idToken'];
    if (idToken is! String || idToken.isEmpty) throw const ApiError.badRequest('idToken manquant.');
    final id = await google.verify(idToken);
    return _session(await store.upsertGoogleUser(
        sub: id.sub, email: id.email, name: id.name, photoUrl: id.picture));
  }

  Future<Response> _loginDev(Request req) async {
    final body = await _body(req);
    final email = body['email'];
    if (email is! String || !email.contains('@')) throw const ApiError.badRequest('email manquant.');
    final name = (body['name'] as String?) ?? email.split('@').first;
    return _session(await store.upsertGoogleUser(sub: 'dev:$email', email: email, name: name));
  }

  Future<Response> _session(User user) async {
    await store.audit(actorId: user.id, action: 'auth.login');
    return _json({'token': tokens.issue(user.id), 'user': user.toJson()});
  }

  // --- Utilisateur ---------------------------------------------------------

  Future<Response> _me(Request req, User user) async => _json({
        'user': user.toJson(),
        'companies': [for (final m in await store.membershipsOf(user.id)) m.toJson()],
        'pendingTransfers': [
          for (final t in await store.pendingTransfersFor(user.id)) t.toJson(),
        ],
      });

  // --- Entreprises ---------------------------------------------------------

  Future<Response> _createCompany(Request req, User user) async {
    final body = await _body(req);
    final company = await companies.create(user,
        name: _string(body, 'name'), timezone: _string(body, 'timezone'));
    return _json(Membership(company, Role.owner).toJson(), status: 201);
  }

  Future<Response> _getCompany(Request req, User user) async {
    final (company, role) = await companies.open(user, req.params['id']!);
    return _json(Membership(company, role).toJson());
  }

  Future<Response> _updateCompany(Request req, User user) async {
    final body = await _body(req);
    final company = await companies.update(user, req.params['id']!,
        name: body['name'] as String?, timezone: body['timezone'] as String?);
    return _json(company.toJson());
  }

  Future<Response> _members(Request req, User user) async => _json({
        'members': [for (final m in await companies.members(user, req.params['id']!)) m.toJson()],
      });

  Future<Response> _setRole(Request req, User user) async {
    final body = await _body(req);
    final Role role;
    try {
      role = Role.parse(_string(body, 'role'));
    } on FormatException catch (e) {
      throw ApiError.badRequest(e.message);
    }
    await companies.setRole(user, req.params['id']!, req.params['userId']!, role);
    return Response(204);
  }

  Future<Response> _removeMember(Request req, User user) async {
    await companies.removeMember(user, req.params['id']!, req.params['userId']!);
    return Response(204);
  }

  // --- Transfert de propriété ---------------------------------------------

  Future<Response> _proposeTransfer(Request req, User user) async {
    final body = await _body(req);
    final t = await companies.proposeTransfer(user, req.params['id']!, _string(body, 'toUserId'));
    return _json(t.toJson(), status: 201);
  }

  Future<Response> _cancelTransfer(Request req, User user) async {
    await companies.cancelTransfer(user, req.params['id']!);
    return Response(204);
  }

  Future<Response> _answerTransfer(Request req, User user, {required bool accept}) async {
    await companies.answerTransfer(user, req.params['id']!, accept: accept);
    return Response(204);
  }

  // --- Outils --------------------------------------------------------------

  static Response _notFound(Request _) =>
      _json(const ApiError.notFound('Route inconnue.').toJson(), status: 404);

  Handler _authed(Future<Response> Function(Request, User) handler) => (Request req) async {
        final header = req.headers['authorization'] ?? '';
        if (!header.startsWith('Bearer ')) throw const ApiError.unauthorized();
        final user = await store.findUser(tokens.verify(header.substring(7)));
        if (user == null) throw const ApiError.unauthorized('Compte introuvable.');
        return handler(req, user);
      };

  Middleware _errors() => (inner) => (req) async {
        try {
          return await inner(req);
        } on ApiError catch (e) {
          return _json(e.toJson(), status: e.status);
        }
      };

  Middleware _cors() => (inner) => (req) async {
        final origin = req.headers['origin'];
        final headers = origin != null && allowedOrigins.contains(origin)
            ? {
                'access-control-allow-origin': origin,
                'access-control-allow-methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
                'access-control-allow-headers': 'authorization, content-type',
                'vary': 'origin',
              }
            : <String, String>{};
        if (req.method == 'OPTIONS') return Response(204, headers: headers);
        final res = await inner(req);
        return res.change(headers: headers);
      };

  static Future<Map<String, dynamic>> _body(Request req) async {
    try {
      final decoded = jsonDecode(await req.readAsString());
      if (decoded is Map<String, dynamic>) return decoded;
    } on FormatException {
      // traité ci-dessous
    }
    throw const ApiError.badRequest('Corps JSON attendu.');
  }

  static String _string(Map<String, dynamic> body, String key) {
    final value = body[key];
    if (value is! String) throw ApiError.badRequest('Champ « $key » manquant.');
    return value;
  }

  static Response _json(Object body, {int status = 200}) => Response(status,
      body: jsonEncode(body), headers: {'content-type': 'application/json; charset=utf-8'});
}
