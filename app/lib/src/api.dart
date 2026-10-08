import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart';
import 'i18n.dart';
import 'models.dart';

class ApiException implements Exception {
  final int status;

  /// Message du serveur, déjà dans la langue envoyée (Accept-Language).
  final String? serverMessage;

  ApiException(this.status, this.serverMessage);

  String describe(L10n t) => serverMessage ?? t.errorStatus(status);

  @override
  String toString() => serverMessage ?? 'HTTP $status';
}

/// Pas de réseau, ou serveur injoignable : la requête n'a pas abouti.
class OfflineException implements Exception {
  @override
  String toString() => 'offline';
}

/// Client de l'API Staff Flow (`/api/v1`).
class Api {
  final http.Client _http;
  String? token;

  /// Langue de l'application, transmise au serveur pour ses messages.
  String language = 'en';

  Api({http.Client? client}) : _http = client ?? http.Client();

  Uri _uri(String path) => Uri.parse('${Config.apiUrl}/api/v1$path');

  /// Appel direct ; [idempotencyKey] protège une modification rejouée
  /// (file d'attente hors connexion) contre une double application.
  Future<dynamic> send(String method, String path, {Object? body, String? idempotencyKey}) =>
      _send(method, path, body, idempotencyKey);

  /// Le serveur répond-il ? (Sans session : simple test de connexion.)
  Future<bool> ping() async {
    try {
      final res = await _http.get(Uri.parse('${Config.apiUrl}/health')).timeout(const Duration(seconds: 8));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<dynamic> _send(String method, String path, [Object? body, String? idempotencyKey]) async {
    final req = http.Request(method, _uri(path))
      ..headers['content-type'] = 'application/json; charset=utf-8'
      ..headers['accept-language'] = language;
    if (token != null) req.headers['authorization'] = 'Bearer $token';
    if (idempotencyKey != null) req.headers['idempotency-key'] = idempotencyKey;
    if (body != null) req.body = jsonEncode(body);
    final http.Response res;
    try {
      res = await http.Response.fromStream(await _http.send(req)).timeout(const Duration(seconds: 20));
    } on TimeoutException {
      throw OfflineException();
    } on http.ClientException {
      throw OfflineException();
    }
    if (res.statusCode >= 500) throw OfflineException();
    final decoded = res.body.isEmpty ? null : jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode >= 400) {
      final error = decoded is Map ? decoded['error'] : null;
      final message = error is Map ? error['message'] as String? : null;
      throw ApiException(res.statusCode, message);
    }
    return decoded;
  }

  Future<(String, User)> loginGoogle(String idToken) async {
    final j = await _send('POST', '/auth/google', {'idToken': idToken});
    return (j['token'] as String, User.fromJson(j['user']));
  }

  Future<(String, User)> loginDev(String email) async {
    final j = await _send('POST', '/auth/dev', {'email': email});
    return (j['token'] as String, User.fromJson(j['user']));
  }


  Future<Membership> createCompany(String name, String timezone) async =>
      Membership.fromJson(await _send('POST', '/companies', {'name': name, 'timezone': timezone}));

  Future<void> updateCompany(String id, {String? name, String? timezone}) =>
      _send('PATCH', '/companies/$id', {'name': ?name, 'timezone': ?timezone});


  Future<void> setRole(String companyId, String userId, Role role) =>
      _send('PUT', '/companies/$companyId/members/$userId/role', {'role': role.name});

  /// Nom de la personne dans l'entreprise ; `null` : son propre nom.
  Future<void> renameMember(String companyId, String userId, String? name) =>
      _send('PUT', '/companies/$companyId/members/$userId/name', {'name': name});

  /// Nom affiché partout ; `null` : celui de Google.
  Future<void> setMyName(String? name) => _send('PATCH', '/me', {'name': name});

  Future<void> removeMember(String companyId, String userId) =>
      _send('DELETE', '/companies/$companyId/members/$userId');

  Future<void> proposeTransfer(String companyId, String toUserId) =>
      _send('POST', '/companies/$companyId/transfer', {'toUserId': toUserId});

  Future<void> cancelTransfer(String companyId) => _send('DELETE', '/companies/$companyId/transfer');

  Future<void> answerTransfer(String transferId, {required bool accept}) =>
      _send('POST', '/transfers/$transferId/${accept ? 'accept' : 'decline'}');

  // --- Code à 6 chiffres ---------------------------------------------------

  Future<(String, DateTime)> createJoinCode() async {
    final j = await _send('POST', '/join-codes');
    return (j['code'] as String, DateTime.parse(j['expiresAt']));
  }

  /// Renvoie le nom de la personne invitée.
  Future<String> redeemJoinCode(String companyId, String code, Role role) async {
    final j = await _send('POST', '/companies/$companyId/join', {'code': code, 'role': role.name});
    return j['user']['name'] as String;
  }

  /// QR code permanent scanné par le responsable ; renvoie le nom de la personne.
  Future<String> inviteByQr(String companyId, String qr, Role role) async {
    final j = await _send('POST', '/companies/$companyId/invite', {'qr': qr, 'role': role.name});
    return j['user']['name'] as String;
  }

  Future<void> answerJoin(String requestId, {required bool accept}) =>
      _send('POST', '/join-requests/$requestId/${accept ? 'accept' : 'decline'}');

  // --- Sites et postes ------------------------------------------------------

  Future<void> addCatalogItem(String companyId, String kind, String name) =>
      _send('POST', '/companies/$companyId/$kind', {'name': name});

  Future<void> updateCatalogItem(String companyId, String kind, String id,
          {String? name, bool? archived}) =>
      _send('PATCH', '/companies/$companyId/$kind/$id', {'name': ?name, 'archived': ?archived});

  // Planning (services, publication, remplacement) : voir offline/sync.dart,
  // qui gère aussi le mode hors connexion.
}
