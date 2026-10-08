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
}
