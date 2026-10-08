import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:staff_flow_server/staff_flow_server.dart';

/// Variables d'environnement :
/// - `DATABASE_URL` : `postgresql://user:pass@host:5432/base` (absente : stockage en mémoire)
/// - `SESSION_SECRET` : au moins 32 caractères
/// - `GOOGLE_CLIENT_IDS` : identifiants client OAuth acceptés, séparés par des virgules
/// - `ALLOWED_ORIGINS` : origines web autorisées (CORS), séparées par des virgules
/// - `DEV_LOGIN=true` : connexion sans Google, développement local uniquement
/// - `PORT` : 8080 par défaut
Future<void> main() async {
  final env = Platform.environment;
  List<String> list(String key) =>
      (env[key] ?? '').split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

  final secret = env['SESSION_SECRET'];
  if (secret == null) {
    stderr.writeln('SESSION_SECRET manquant.');
    exit(1);
  }

  final Store store;
  final dbUrl = env['DATABASE_URL'];
  if (dbUrl == null) {
    stderr.writeln('DATABASE_URL absent : stockage en mémoire, données perdues à l\'arrêt.');
    store = MemoryStore();
  } else {
    final pg = PostgresStore.connect(dbUrl);
    await pg.migrate();
    store = pg;
  }

  final devLogin = env['DEV_LOGIN'] == 'true';
  if (devLogin) stderr.writeln('ATTENTION : DEV_LOGIN actif, ne jamais utiliser en production.');

  final api = Api(
    store: store,
    google: TokenInfoGoogleVerifier(list('GOOGLE_CLIENT_IDS').toSet()),
    tokens: SessionTokens(secret),
    devLogin: devLogin,
    allowedOrigins: list('ALLOWED_ORIGINS').toSet(),
  );

  final port = int.parse(env['PORT'] ?? '8080');
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(api.handler);
  final server = await io.serve(handler, InternetAddress.anyIPv4, port);
  print('Staff Flow API sur le port ${server.port}');
}
