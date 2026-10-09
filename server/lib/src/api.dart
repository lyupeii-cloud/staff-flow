import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'auth.dart';
import 'chat_service.dart';
import 'company_service.dart';
import 'errors.dart';
import 'join_service.dart';
import 'messages.dart';
import 'notice_service.dart';
import 'notifications.dart';
import 'models.dart';
import 'planning_service.dart';
import 'request_service.dart';
import 'store.dart';
import 'translator.dart';

/// Construit le gestionnaire HTTP de l'API, sous `/api/v1`.
class Api {
  final Store store;
  final GoogleVerifier google;
  final SessionTokens tokens;
  final CompanyService companies;
  late final NotificationService notifications = NotificationService(store, push: push);
  late final PlanningService planning = PlanningService(store, companies, notifications, now: now);
  late final ChatService chat = ChatService(store, companies, notifications);
  late final RequestService requests = RequestService(store, companies, planning, notifications);
  late final JoinService joins = JoinService(store, companies, now: now);
  late final NoticeService notices = NoticeService(store, now: now);

  /// Horloge (UTC), remplaçable dans les tests.
  final DateTime Function() now;

  /// Connexion sans Google (`POST /auth/dev`), pour le développement local
  /// uniquement. Ne jamais l'activer en production.
  final bool devLogin;
  final Set<String> allowedOrigins;

  /// Envoi des notifications (Firebase) ; `null` : avis dans l'application seulement.
  final PushSender? push;

  /// Traduction des messages (LibreTranslate) ; `null` : pas de traduction.
  final Translator? translator;

  Api({
    required this.store,
    required this.google,
    required this.tokens,
    this.devLogin = false,
    this.allowedOrigins = const {},
    this.push,
    this.translator,
    DateTime Function()? now,
  })  : companies = CompanyService(store),
        now = now ?? (() => DateTime.now().toUtc());

  Handler get handler {
    final v1 = Router(notFoundHandler: _notFound)
      ..post('/auth/google', _loginGoogle)
      ..get('/me', _authed(_me))
      ..patch('/me', _authed(_updateMe))
      ..post('/companies', _authed(_createCompany))
      ..get('/companies/<id>', _authed(_getCompany))
      ..patch('/companies/<id>', _authed(_updateCompany))
      ..get('/companies/<id>/members', _authed(_members))
      ..put('/companies/<id>/members/<userId>/role', _authed(_setRole))
      ..put('/companies/<id>/members/<userId>/name', _authed(_renameMember))
      ..put('/companies/<id>/members/<userId>/sites', _authed(_setMemberSites))
      ..delete('/companies/<id>/members/<userId>', _authed(_removeMember))
      ..post('/companies/<id>/transfer', _authed(_proposeTransfer))
      ..delete('/companies/<id>/transfer', _authed(_cancelTransfer))
      ..post('/transfers/<id>/accept', _authed((r, u) => _answerTransfer(r, u, accept: true)))
      ..post('/transfers/<id>/decline', _authed((r, u) => _answerTransfer(r, u, accept: false)))
      // Ajout par code à 6 chiffres
      ..post('/join-codes', _authed(_createJoinCode))
      ..post('/companies/<id>/join', _authed(_redeemJoinCode))
      ..post('/companies/<id>/invite', _authed(_inviteByQr))
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
      ..post('/companies/<id>/publish', _authed(_publish))
      ..post('/companies/<id>/discard', _authed((r, u) async =>
          _json({'discarded': await planning.discard(u, r.params['id']!)})))
      ..post('/companies/<id>/shifts/<shiftId>/revert', _authed((r, u) async =>
          _json({'reverted': await planning.revert(u, r.params['id']!, r.params['shiftId']!)})))
      ..put('/companies/<id>/notify-sites', _authed(_notifySites))
      // Historique, annulation, avis
      ..get('/companies/<id>/history', _authed(_history))
      ..post('/companies/<id>/history/<entryId>/undo', _authed(_undo))
      ..get('/notices', _authed(_notices))
      ..post('/notices/read', _authed(_readNotices))
      ..delete('/notices', _authed(_deleteNotices))
      ..put('/me/notice-retention', _authed(_setRetention))
      // Notifications sur l'appareil
      ..put('/devices', _authed(_registerDevice))
      ..post('/devices/forget', _authed(_forgetDevice))
      ..get('/me/notifications', _authed(_getPrefs))
      ..patch('/me/notifications', _authed(_setPrefs))
      // Messagerie
      ..get('/companies/<id>/conversations', _authed(_conversations))
      ..post('/companies/<id>/conversations', _authed(_openConversation))
      ..get('/conversations/<id>/messages', _authed(_messages))
      ..post('/conversations/<id>/messages', _authed(_sendMessage))
      ..post('/conversations/<id>/read', _authed(_readMessages))
      ..post('/messages/<id>/translate', _authed(_translateMessage))
      ..post('/companies/<id>/groups', _authed(_createGroup))
      // Demandes : échange, congé, indisponibilité
      ..get('/companies/<id>/requests', _authed(_requests))
      ..get('/requests/<id>', _authed((r, u) async => _json(await requests.one(u, r.params['id']!))))
      ..post('/companies/<id>/requests', _authed(_createRequest))
      ..get('/companies/<id>/absences', _authed(_absences))
      ..post('/requests/<id>/accept', _authed((r, u) async => _json(await requests.accept(u, r.params['id']!))))
      ..post('/requests/<id>/decline', _authed((r, u) async {
        await requests.decline(u, r.params['id']!);
        return Response(204);
      }))
      ..post('/requests/<id>/approve', _authed((r, u) async {
        final text = await r.readAsString();
        final peer = text.trim().isEmpty ? null : (jsonDecode(text) as Map?)?['peerId'];
        return _json(await requests.decide(u, r.params['id']!, approve: true, peerId: peer is String ? peer : null));
      }))
      ..post('/requests/<id>/refuse', _authed((r, u) async => _json(await requests.decide(u, r.params['id']!, approve: false))))
      ..post('/requests/<id>/cancel', _authed((r, u) async {
        await requests.cancel(u, r.params['id']!);
        return Response(204);
      }))
      ..patch('/conversations/<id>', _authed(_updateGroup));
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
        sub: id.sub, email: id.email, name: id.name, photoUrl: id.picture, locale: id.locale));
  }

  Future<Response> _loginDev(Request req) async {
    final body = await _body(req);
    final email = body['email'];
    if (email is! String || !email.contains('@')) throw const ApiError.badRequest('email manquant.');
    final name = (body['name'] as String?) ?? email.split('@').first;
    // `locale` simule la langue d'un compte Google.
    return _session(await store.upsertGoogleUser(
        sub: 'dev:$email', email: email, name: name, locale: body['locale'] as String?));
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
        'unreadNotices': await notices.unreadCount(user.id),
        'notificationPrefs': await notifications.prefs(user.id),
        'noticeRetention': await notices.retention(user.id),
        'unreadMessages': await chat.unreadByCompany(user.id),
      });

  /// La personne choisit le nom affiché partout (vide : celui de Google).
  Future<Response> _updateMe(Request req, User user) async {
    final body = await _body(req);
    final name = body['name'];
    if (name is! String?) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final updated = await store.setCustomName(user.id, CompanyService.personName(name));
    await store.audit(actorId: user.id, action: 'user.name', details: {'name': updated.name});
    return _json(updated.toJson());
  }

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
    await companies.setRole(user, req.params['id']!, req.params['userId']!, role, sites: _optionalIds(body['sites']));
    return Response(204);
  }

  Future<Response> _renameMember(Request req, User user) async {
    final body = await _body(req);
    final name = body['name'];
    if (name is! String?) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    await companies.renameMember(user, req.params['id']!, req.params['userId']!, name);
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
    await notifications.notify([t.toUserId],
        companyId: t.companyId, kind: 'transfer_offer', data: {'byName': user.name});
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
        sites: _optionalIds(body['sites']),
        ip: _clientIp(req));
    await _notifyInvite(request, invited, user);
    return _json({'request': request.toJson(), 'user': invited.toJson()}, status: 201);
  }

  Future<Response> _inviteByQr(Request req, User user) async {
    final body = await _body(req);
    final (request, invited) = await joins.inviteByQr(user, req.params['id']!,
        qr: _string(body, 'qr'),
        role: _role((body['role'] as String?) ?? 'employee'),
        sites: _optionalIds(body['sites']),
        ip: _clientIp(req));
    await _notifyInvite(request, invited, user);
    return _json({'request': request.toJson(), 'user': invited.toJson()}, status: 201);
  }

  Future<void> _notifyInvite(JoinRequest request, User invited, User manager) =>
      notifications.notify([invited.id],
          companyId: request.company.id,
          kind: 'join_invite',
          data: {'requestId': request.id, 'role': request.role.name, 'byName': manager.name});

  Future<Response> _answerJoin(Request req, User user, {required bool accept}) async {
    final companyId = await joins.answer(user, req.params['id']!, accept: accept);
    if (accept) {
      // Les responsables le voient tout de suite (et peuvent le placer au planning).
      final managers = [
        for (final m in await store.members(companyId))
          if (m.role.canManage && m.user.id != user.id) m.user.id,
      ];
      await notifications.notify(managers,
          companyId: companyId, kind: 'member_joined', data: {'name': user.name});
    }
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
    final baseVersion = body.remove('baseVersion');
    final count = await _input(() => planning.update(
        user, req.params['id']!, req.params['shiftId']!, ShiftPatch(body),
        scope: _scope(req), baseVersion: baseVersion as int?));
    return _json({'updated': count});
  }

  Future<Response> _deleteShift(Request req, User user) async {
    final count = await planning.delete(user, req.params['id']!, req.params['shiftId']!,
        scope: _scope(req), baseVersion: int.tryParse(req.url.queryParameters['baseVersion'] ?? ''));
    return _json({'deleted': count});
  }

  Future<Response> _history(Request req, User user) async {
    final q = req.url.queryParameters;
    final entries = await planning.history(user, req.params['id']!,
        shiftId: q['shiftId'], limit: int.tryParse(q['limit'] ?? '') ?? 100);
    return _json({'entries': [for (final e in entries) e.toJson()]});
  }

  Future<Response> _undo(Request req, User user) async {
    final id = int.tryParse(req.params['entryId']!);
    if (id == null) throw const ApiError.notFound();
    return _json({'changed': await planning.undo(user, req.params['id']!, id)});
  }

  Future<Response> _notices(Request req, User user) async =>
      _json({'notices': [for (final n in await notices.list(user.id)) n.toJson()]});

  Future<Response> _readNotices(Request req, User user) async {
    await notices.markAllRead(user.id);
    return Response(204);
  }

  Future<Response> _deleteNotices(Request req, User user) async {
    await notices.deleteAll(user.id);
    return Response(204);
  }

  Future<Response> _setRetention(Request req, User user) async {
    await notices.setRetention(user.id, _string(await _body(req), 'value'));
    return Response(204);
  }

  // --- Messagerie ------------------------------------------------------------

  Future<Response> _conversations(Request req, User user) async =>
      _json({'conversations': await chat.conversations(user, req.params['id']!)});

  Future<Response> _openConversation(Request req, User user) async {
    final body = await _body(req);
    final id = await chat.openPrivate(user, req.params['id']!, _string(body, 'userId'));
    return _json({'id': id});
  }

  Future<Response> _messages(Request req, User user) async {
    final q = req.url.queryParameters;
    final limit = int.tryParse(q['limit'] ?? '');
    return _json({
      'messages': await chat.messages(user, req.params['id']!,
          before: int.tryParse(q['before'] ?? ''), author: q['author'], limit: limit ?? 50),
    });
  }

  Future<Response> _sendMessage(Request req, User user) async {
    final body = await _body(req);
    final replyTo = body['replyTo'];
    if (replyTo is! int?) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    return _json(
        await chat.send(user, req.params['id']!, _string(body, 'body'),
            replyTo: replyTo, mentions: body.containsKey('mentions') ? _ids(body['mentions']) : const []),
        status: 201);
  }

  /// Traduction dans la langue demandée (celle de l'application).
  Future<Response> _translateMessage(Request req, User user) async {
    final id = int.tryParse(req.params['id']!);
    if (id == null) throw const ApiError.notFound('Message introuvable.');
    final t = translator;
    if (t == null) throw const ApiError(409, 'translation_unavailable', 'Traduction momentanément indisponible.');
    final lang = (await _body(req))['lang'];
    if (lang is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    return _json({'text': await chat.translate(user, id, lang, t)});
  }

  /// `?pending=1` : toutes les demandes en attente ; sinon une page de
  /// l'historique (`limit`, `before`).
  Future<Response> _requests(Request req, User user) async {
    final q = req.url.queryParameters;
    final id = req.params['id']!;
    if (q['pending'] == '1') return _json({'requests': await requests.pending(user, id)});
    final before = q['before'];
    if (before != null && DateTime.tryParse(before) == null) throw const ApiError.badRequest('Dates invalides.');
    return _json({
      'requests': await requests.list(user, id, before: before, limit: int.tryParse(q['limit'] ?? '') ?? 10),
    });
  }

  Future<Response> _notifySites(Request req, User user) async {
    final body = await _body(req);
    final sites = body['sites'];
    if (sites != null && (sites is! List || sites.any((s) => s is! String))) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    await companies.setNotifySites(user, req.params['id']!, sites == null ? null : (sites as List).cast<String>());
    return Response(204);
  }

  Future<Response> _createRequest(Request req, User user) async =>
      _json(await requests.create(user, req.params['id']!, await _body(req)), status: 201);

  Future<Response> _absences(Request req, User user) async {
    final q = req.url.queryParameters;
    final from = q['from'], to = q['to'];
    if (from == null || to == null) throw const ApiError.badRequest('Paramètres from et to requis.');
    try {
      parseDay(from);
      parseDay(to);
    } on FormatException {
      throw const ApiError.badRequest('Dates invalides.');
    }
    return _json({'absences': await requests.absences(user, req.params['id']!, from, to)});
  }

  static List<String>? _optionalIds(Object? value) => value == null ? null : _ids(value);

  Future<Response> _setMemberSites(Request req, User user) async {
    final body = await _body(req);
    await companies.setSites(user, req.params['id']!, req.params['userId']!, _optionalIds(body['sites']));
    return Response(204);
  }

  static List<String> _ids(Object? value) {
    if (value is! List || value.any((v) => v is! String)) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    return value.cast<String>();
  }

  Future<Response> _createGroup(Request req, User user) async {
    final body = await _body(req);
    final id = await chat.createTeam(user, req.params['id']!, _string(body, 'name'), _ids(body['userIds']));
    return _json({'id': id}, status: 201);
  }

  Future<Response> _updateGroup(Request req, User user) async {
    final body = await _body(req);
    final name = body['name'];
    if (name is! String?) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    await chat.updateTeam(user, req.params['id']!,
        name: name, userIds: body.containsKey('userIds') ? _ids(body['userIds']) : null);
    return Response(204);
  }

  Future<Response> _readMessages(Request req, User user) async {
    final last = (await _body(req))['lastId'];
    if (last is! int) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    await chat.markRead(user, req.params['id']!, last);
    return Response(204);
  }

  // --- Notifications sur l'appareil -----------------------------------------

  Future<Response> _registerDevice(Request req, User user) async {
    final body = await _body(req);
    await notifications.registerDevice(
        user.id, _string(body, 'token'), _string(body, 'platform'), body['language'] as String?);
    return Response(204);
  }

  /// À la déconnexion : l'appareil ne reçoit plus rien pour ce compte.
  Future<Response> _forgetDevice(Request req, User user) async {
    await notifications.forgetDevice(user.id, _string(await _body(req), 'token'));
    return Response(204);
  }

  Future<Response> _getPrefs(Request req, User user) async => _json(await notifications.prefs(user.id));

  Future<Response> _setPrefs(Request req, User user) async =>
      _json(await notifications.setPrefs(user.id, await _body(req)));

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
    // Une seule notification par personne concernée (section 4).
    await notifications.notify(users.where((u) => u != user.id),
        companyId: req.params['id'], kind: 'schedule_published');
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
    } on FormatException {
      throw ApiError.badRequest('Rôle inconnu : {value}', {'value': value});
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

  static Response _notFound(Request req) => _json(
      const ApiError.notFound('Route inconnue.').toJson(negotiateLanguage(req.headers['accept-language'])),
      status: 404);

  Handler _authed(Future<Response> Function(Request, User) handler) => (Request req) async {
        final header = req.headers['authorization'] ?? '';
        if (!header.startsWith('Bearer ')) throw const ApiError.unauthorized();
        final user = await store.findUser(tokens.verify(header.substring(7)));
        if (user == null) throw const ApiError.unauthorized('Compte introuvable.');
        final key = req.headers['idempotency-key'];
        if (key == null || req.method == 'GET') return handler(req, user);
        return _once(user, key, () => handler(req, user));
      };

  /// Requête rejouée par l'application après une coupure réseau : si la même
  /// clé a déjà été traitée pour cet utilisateur, on renvoie la même réponse
  /// sans refaire la modification.
  Future<Response> _once(User user, String key, Future<Response> Function() run) async {
    final seen = await store.query(store.db,
        'SELECT status, body FROM idempotency_keys WHERE user_id = @u::uuid AND key = @k',
        {'u': user.id, 'k': key});
    if (seen.isNotEmpty) {
      return Response(seen.first[0] as int,
          body: seen.first[1] as String,
          headers: {'content-type': 'application/json; charset=utf-8', 'idempotent-replay': 'true'});
    }
    // Seules les réussites sont mémorisées : une requête refusée est
    // simplement réévaluée si elle revient.
    final res = await run();
    final body = await res.readAsString();
    if (res.statusCode < 300) await _remember(user, key, res.statusCode, body);
    return res.change(body: body);
  }

  Future<void> _remember(User user, String key, int status, String body) async {
    await store.query(store.db, '''
      INSERT INTO idempotency_keys (user_id, key, status, body) VALUES (@u::uuid, @k, @s, @b)
      ON CONFLICT DO NOTHING''', {'u': user.id, 'k': key, 's': status, 'b': body});
    await store.query(store.db,
        "DELETE FROM idempotency_keys WHERE created_at < now() - interval '7 days'");
  }

  Middleware _errors() => (inner) => (req) async {
        try {
          return await inner(req);
        } on ApiError catch (e) {
          return _json(e.toJson(negotiateLanguage(req.headers['accept-language'])), status: e.status);
        }
      };

  Middleware _cors() => (inner) => (req) async {
        final origin = req.headers['origin'];
        final headers = origin != null && allowedOrigins.contains(origin)
            ? {
                'access-control-allow-origin': origin,
                'access-control-allow-methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
                'access-control-allow-headers': 'authorization, content-type, accept-language, idempotency-key',
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
    if (value is! String) throw ApiError.badRequest('Champ « {field} » manquant.', {'field': key});
    return value;
  }

  static Response _json(Object body, {int status = 200}) => Response(status,
      body: jsonEncode(body), headers: {'content-type': 'application/json; charset=utf-8'});
}
