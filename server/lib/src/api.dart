import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'auth.dart';
import 'company_service.dart';
import 'errors.dart';
import 'join_service.dart';
import 'models.dart';
import 'planning_service.dart';
import 'store.dart';

/// Construit le gestionnaire HTTP de l'API, sous `/api/v1`.
class Api {
  final Store store;
  final GoogleVerifier google;
  final SessionTokens tokens;
  final CompanyService companies;
  late final PlanningService planning = PlanningService(store, companies);
  late final JoinService joins = JoinService(store, companies, now: now);

  /// Horloge (UTC), remplaçable dans les tests.
  final DateTime Function() now;

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
    DateTime Function()? now,
  })  : companies = CompanyService(store),
        now = now ?? (() => DateTime.now().toUtc());

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
      ..post('/transfers/<id>/decline', _authed((r, u) => _answerTransfer(r, u, accept: false)))
      // Ajout par code à 6 chiffres
      ..post('/join-codes', _authed(_createJoinCode))
      ..post('/companies/<id>/join', _authed(_redeemJoinCode))
      ..post('/join-requests/<id>/accept', _authed((r, u) => _answerJoin(r, u, accept: true)))
      ..post('/join-requests/<id>/decline', _authed((r, u) => _answerJoin(r, u, accept: false)))
      // Planning
      ..get('/companies/<id>/<kind|sites|positions>', _authed(_catalog))
      ..post('/companies/<id>/<kind|sites|positions>', _authed(_addCatalogItem))
      ..patch('/companies/<id>/<kind|sites|positions>/<itemId>', _authed(_updateCatalogItem))
      ..get('/companies/<id>/shifts', _authed(_shifts))
      ..post('/companies/<id>/shifts', _authed(_createShifts))
      ..post('/companies/<id>/shifts/replace', _authed(_replace))
      ..patch('/companies/<id>/shifts/<shiftId>', _authed(_updateShift))
      ..delete('/companies/<id>/shifts/<shiftId>', _authed(_deleteShift))
      ..post('/companies/<id>/publish', _authed(_publish));
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
        'pendingJoinRequests': [for (final j in await joins.pendingFor(user)) j.toJson()],
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
    final role = _role(_string(body, 'role'));
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

  // --- Ajout par code à 6 chiffres ---------------------------------------

  Future<Response> _createJoinCode(Request req, User user) async {
    final (code, expires) = await joins.createCode(user);
    return _json({'code': code, 'expiresAt': expires.toIso8601String()}, status: 201);
  }

  Future<Response> _redeemJoinCode(Request req, User user) async {
    final body = await _body(req);
    final (request, invited) = await joins.redeem(user, req.params['id']!,
        code: _string(body, 'code'),
        role: _role((body['role'] as String?) ?? 'employee'),
        ip: _clientIp(req));
    return _json({'request': request.toJson(), 'user': invited.toJson()}, status: 201);
  }

  Future<Response> _answerJoin(Request req, User user, {required bool accept}) async {
    await joins.answer(user, req.params['id']!, accept: accept);
    return Response(204);
  }

  // --- Planning -----------------------------------------------------------

  static CatalogKind _kind(Request req) => CatalogKind.values.byName(req.params['kind']!);

  Future<Response> _catalog(Request req, User user) async => _json({
        'items': [
          for (final i in await planning.catalog(user, req.params['id']!, _kind(req))) i.toJson(),
        ],
      });

  Future<Response> _addCatalogItem(Request req, User user) async {
    final body = await _body(req);
    final item =
        await planning.addCatalogItem(user, req.params['id']!, _kind(req), _string(body, 'name'));
    return _json(item.toJson(), status: 201);
  }

  Future<Response> _updateCatalogItem(Request req, User user) async {
    final body = await _body(req);
    await planning.updateCatalogItem(user, req.params['id']!, _kind(req), req.params['itemId']!,
        name: body['name'] as String?, archived: body['archived'] as bool?);
    return Response(204);
  }

  Future<Response> _shifts(Request req, User user) async {
    final q = req.url.queryParameters;
    final from = q['from'], to = q['to'];
    if (from == null || to == null) throw const ApiError.badRequest('Paramètres from et to requis.');
    final (shifts, pending) = await planning.shifts(user, req.params['id']!, from, to);
    return _json({'shifts': [for (final s in shifts) s.toJson()], 'pending': pending});
  }

  Future<Response> _createShifts(Request req, User user) async {
    final body = await _body(req);
    final days = body['days'];
    if (days is! List || days.any((d) => d is! String)) {
      throw const ApiError.badRequest('Champ « days » : liste de dates attendue.');
    }
    final repeat = body['repeat'];
    final created = await _input(() => planning.create(user, req.params['id']!, _shiftInput(body),
        days: [for (final d in days) parseDay(d as String)],
        repeat: repeat is Map<String, dynamic> ? Repeat.fromJson(repeat) : null));
    return _json({'shifts': [for (final s in created) s.toJson()]}, status: 201);
  }

  Future<Response> _updateShift(Request req, User user) async {
    final body = await _body(req);
    final count = await _input(() => planning.update(
        user, req.params['id']!, req.params['shiftId']!, ShiftPatch(body),
        scope: _scope(req)));
    return _json({'updated': count});
  }

  Future<Response> _deleteShift(Request req, User user) async {
    final count =
        await planning.delete(user, req.params['id']!, req.params['shiftId']!, scope: _scope(req));
    return _json({'deleted': count});
  }

  Future<Response> _replace(Request req, User user) async {
    final body = await _body(req);
    final count = await planning.replace(user, req.params['id']!,
        fromUserId: _string(body, 'fromUserId'),
        toUserId: _string(body, 'toUserId'),
        from: _string(body, 'from'),
        to: _string(body, 'to'));
    return _json({'replaced': count});
  }

  Future<Response> _publish(Request req, User user) async {
    final (count, users) = await planning.publish(user, req.params['id']!);
    return _json({'published': count, 'notifiedUsers': users.length});
  }

  static ShiftInput _shiftInput(Map<String, dynamic> body) => ShiftInput(
        start: body['start'] as int,
        end: body['end'] as int,
        userId: body['userId'] as String?,
        siteId: body['siteId'] as String?,
        positionId: body['positionId'] as String?,
        note: body['note'] as String?,
      );

  static Scope _scope(Request req) =>
      req.url.queryParameters['scope'] == 'series' ? Scope.series : Scope.one;

  /// Un champ du mauvais type dans le corps devient une erreur 400.
  static Future<T> _input<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on TypeError {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
  }

  static Role _role(String value) {
    try {
      return Role.parse(value);
    } on FormatException catch (e) {
      throw ApiError.badRequest(e.message);
    }
  }

  /// Adresse du client : Caddy la transmet dans X-Forwarded-For.
  static String _clientIp(Request req) {
    final forwarded = req.headers['x-forwarded-for'];
    if (forwarded != null && forwarded.isNotEmpty) return forwarded.split(',').first.trim();
    final info = req.context['shelf.io.connection_info'];
    return info is HttpConnectionInfo ? info.remoteAddress.address : 'inconnue';
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
