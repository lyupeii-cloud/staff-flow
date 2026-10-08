import 'dart:convert';
import 'dart:io';

import 'package:postgres/postgres.dart' show Pool, QueryMode, Sql;
import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

/// Accepte les jetons `google:<sub>` et refuse le reste.
class FakeGoogle implements GoogleVerifier {
  @override
  Future<GoogleIdentity> verify(String idToken) async {
    if (!idToken.startsWith('google:')) throw const ApiError.unauthorized('Jeton Google invalide.');
    final sub = idToken.substring(7);
    return GoogleIdentity(sub: sub, email: '$sub@example.com', name: sub);
  }
}

/// Horloge réglable, pour tester les expirations sans attendre.
class FakeClock {
  DateTime now = DateTime.utc(2026, 10, 5, 8);

  void advance(Duration d) => now = now.add(d);
}

class Client {
  final Handler handler;
  final String ip;
  String? token;
  late Map<String, dynamic> user;

  Client(this.handler, {this.ip = '203.0.113.1'});

  Future<(int, dynamic)> call(String method, String path, [Object? body]) async {
    final res = await handler(Request(
      method,
      Uri.parse('http://localhost/api/v1$path'),
      body: body == null ? null : jsonEncode(body),
      headers: {
        if (token != null) 'authorization': 'Bearer $token',
        'x-forwarded-for': ip,
      },
    ));
    final text = await res.readAsString();
    return (res.statusCode, text.isEmpty ? null : jsonDecode(text));
  }

  /// Appel qui doit réussir ; renvoie le corps.
  Future<dynamic> ok(String method, String path, [Object? body]) async {
    final (status, json) = await call(method, path, body);
    expect(status, inInclusiveRange(200, 299), reason: '$method $path → $status $json');
    return json;
  }

  Future<Client> login(String sub) async {
    final body = await ok('POST', '/auth/google', {'idToken': 'google:$sub'});
    token = body['token'];
    user = body['user'];
    return this;
  }

  String get id => user['id'];
}

/// Environnement de test : une base PostgreSQL vidée avant chaque test.
/// Exige `TEST_DATABASE_URL` (voir `tool/test-server.sh`).
class TestEnv {
  late Pool admin;
  late Store store;
  late Handler handler;
  late FakeClock clock;

  TestEnv() {
    final url = Platform.environment['TEST_DATABASE_URL'];
    if (url == null) {
      throw StateError('TEST_DATABASE_URL manquant : lancer tool/test-server.sh');
    }
    setUpAll(() {
      admin = Pool.withUrl(url);
      store = Store.connect(url);
    });
    tearDownAll(() async {
      await store.close();
      await admin.close();
    });
    setUp(() async {
      await admin.execute('DROP SCHEMA public CASCADE; CREATE SCHEMA public;',
          queryMode: QueryMode.simple);
      await store.migrate();
      clock = FakeClock();
      handler = Api(
        store: store,
        google: FakeGoogle(),
        tokens: SessionTokens('x' * 32),
        allowedOrigins: {'http://localhost:5000'},
        now: () => clock.now,
      ).handler;
    });
  }

  Future<Client> login(String sub, {String ip = '203.0.113.1'}) =>
      Client(handler, ip: ip).login(sub);

  Future<String> createCompany(Client c, [String name = 'Boulangerie']) async {
    final body = await c.ok('POST', '/companies', {'name': name, 'timezone': 'Europe/Paris'});
    return body['company']['id'];
  }

  Future<(String, Map<String, Object?>)> lastAudit(String action) async {
    final rows = await admin.execute(
        Sql.named(
            'SELECT actor_id::text, details FROM audit_log WHERE action = @a ORDER BY id DESC LIMIT 1'),
        parameters: {'a': action});
    return (rows.first[0] as String, Map<String, Object?>.from(rows.first[1] as Map));
  }
}
