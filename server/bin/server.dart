import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:staff_flow_server/staff_flow_server.dart';

/// Variables d'environnement :
/// - `DATABASE_URL` : `postgresql://user:pass@host:5432/base`
/// - `SESSION_SECRET` : au moins 32 caractères
/// - `GOOGLE_CLIENT_IDS` : identifiants client OAuth acceptés, séparés par des virgules
/// - `ALLOWED_ORIGINS` : origines web autorisées (CORS), séparées par des virgules
/// - `FCM_CREDENTIALS_B64` : compte de service Firebase (fichier JSON en base64), pour les
///   notifications sur les téléphones et navigateurs ; absent : avis dans l'application seulement
/// - `TRANSLATE_URL` : adresse de LibreTranslate (ex. http://translate:5000) ; absent : pas de traduction
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

  final dbUrl = env['DATABASE_URL'];
  if (dbUrl == null) {
    stderr.writeln('DATABASE_URL manquant.');
    exit(1);
  }
  final store = Store.connect(dbUrl);
  await store.migrate();

  final devLogin = env['DEV_LOGIN'] == 'true';
  if (devLogin) stderr.writeln('ATTENTION : DEV_LOGIN actif, ne jamais utiliser en production.');

  PushSender? push;
  final fcm = env['FCM_CREDENTIALS_B64'] ?? '';
  if (fcm.isNotEmpty) {
    push = FcmSender.fromJson(utf8.decode(base64.decode(fcm.trim())));
    print('Notifications Firebase actives.');
  }

  final translateUrl = env['TRANSLATE_URL'] ?? '';
  final translator = translateUrl.isEmpty ? null : LibreTranslator(translateUrl);

  final api = Api(
    store: store,
    google: TokenInfoGoogleVerifier(list('GOOGLE_CLIENT_IDS').toSet()),
    tokens: SessionTokens(secret),
    devLogin: devLogin,
    allowedOrigins: list('ALLOWED_ORIGINS').toSet(),
    push: push,
    translator: translator,
  );

  final port = int.parse(env['PORT'] ?? '8080');
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(api.handler);
  final server = await io.serve(handler, InternetAddress.anyIPv4, port);
  print('Staff Flow API sur le port ${server.port}');
}
