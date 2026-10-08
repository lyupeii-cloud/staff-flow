import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart';
import 'models.dart';

class ApiException implements Exception {
  final int status;
  final String message;

  ApiException(this.status, this.message);

  @override
  String toString() => message;
}

/// Client de l'API Staff Flow (`/api/v1`).
class Api {
  final http.Client _http;
  String? token;

  Api({http.Client? client}) : _http = client ?? http.Client();

  Uri _uri(String path) => Uri.parse('${Config.apiUrl}/api/v1$path');

  Future<dynamic> _send(String method, String path, [Object? body]) async {
    final req = http.Request(method, _uri(path))
      ..headers['content-type'] = 'application/json';
    if (token != null) req.headers['authorization'] = 'Bearer $token';
    if (body != null) req.body = jsonEncode(body);
    final res = await http.Response.fromStream(await _http.send(req));
    final decoded = res.body.isEmpty ? null : jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode >= 400) {
      final error = decoded is Map ? decoded['error'] : null;
      final message = error is Map ? error['message'] as String? : null;
      throw ApiException(res.statusCode, message ?? 'Erreur ${res.statusCode}');
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

  Future<Me> me() async => Me.fromJson(await _send('GET', '/me'));

  Future<Membership> createCompany(String name, String timezone) async =>
      Membership.fromJson(await _send('POST', '/companies', {'name': name, 'timezone': timezone}));

  Future<void> updateCompany(String id, {String? name, String? timezone}) =>
      _send('PATCH', '/companies/$id', {'name': ?name, 'timezone': ?timezone});

  Future<List<Member>> members(String companyId) async {
    final j = await _send('GET', '/companies/$companyId/members');
    return [for (final m in j['members']) Member.fromJson(m)];
  }

  Future<void> setRole(String companyId, String userId, Role role) =>
      _send('PUT', '/companies/$companyId/members/$userId/role', {'role': role.name});

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

  Future<void> answerJoin(String requestId, {required bool accept}) =>
      _send('POST', '/join-requests/$requestId/${accept ? 'accept' : 'decline'}');

  // --- Planning ------------------------------------------------------------

  /// [kind] : `sites` ou `positions`.
  Future<List<CatalogItem>> catalog(String companyId, String kind) async {
    final j = await _send('GET', '/companies/$companyId/$kind');
    return [for (final i in j['items']) CatalogItem.fromJson(i)];
  }

  Future<void> addCatalogItem(String companyId, String kind, String name) =>
      _send('POST', '/companies/$companyId/$kind', {'name': name});

  Future<void> updateCatalogItem(String companyId, String kind, String id,
          {String? name, bool? archived}) =>
      _send('PATCH', '/companies/$companyId/$kind/$id', {'name': ?name, 'archived': ?archived});

  /// Services de la période et nombre de modifications non publiées.
  Future<(List<Shift>, int)> shifts(String companyId, DateTime from, DateTime to) async {
    final j = await _send(
        'GET', '/companies/$companyId/shifts?from=${formatDay(from)}&to=${formatDay(to)}');
    return ([for (final s in j['shifts']) Shift.fromJson(s)], j['pending'] as int);
  }

  Future<int> createShifts(String companyId, Map<String, Object?> body) async {
    final j = await _send('POST', '/companies/$companyId/shifts', body);
    return (j['shifts'] as List).length;
  }

  Future<void> updateShift(String companyId, String shiftId, Map<String, Object?> patch,
          {bool series = false}) =>
      _send('PATCH', '/companies/$companyId/shifts/$shiftId?scope=${series ? 'series' : 'one'}',
          patch);

  Future<void> deleteShift(String companyId, String shiftId, {bool series = false}) =>
      _send('DELETE', '/companies/$companyId/shifts/$shiftId?scope=${series ? 'series' : 'one'}');

  Future<int> replace(String companyId,
      {required String fromUserId, required String toUserId, required DateTime from, required DateTime to}) async {
    final j = await _send('POST', '/companies/$companyId/shifts/replace', {
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'from': formatDay(from),
      'to': formatDay(to),
    });
    return j['replaced'] as int;
  }

  Future<int> publish(String companyId) async =>
      (await _send('POST', '/companies/$companyId/publish'))['published'] as int;
}
