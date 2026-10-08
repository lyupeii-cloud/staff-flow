import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;

import 'errors.dart';

/// Identité Google confirmée.
class GoogleIdentity {
  final String sub;
  final String email;
  final String name;
  final String? picture;

  /// Langue du compte Google (« fr », « uk »…), quand le jeton la contient.
  final String? locale;

  const GoogleIdentity(
      {required this.sub, required this.email, required this.name, this.picture, this.locale});
}

abstract class GoogleVerifier {
  /// Vérifie un jeton d'identité Google (ID token) ; lève [ApiError] sinon.
  Future<GoogleIdentity> verify(String idToken);
}

/// Vérification par le point d'accès `tokeninfo` de Google : signature,
/// expiration, émetteur et audience (nos identifiants client OAuth).
class TokenInfoGoogleVerifier implements GoogleVerifier {
  final Set<String> allowedClientIds;
  final http.Client _client;

  TokenInfoGoogleVerifier(this.allowedClientIds, {http.Client? client})
      : _client = client ?? http.Client();

  static const _issuers = {'accounts.google.com', 'https://accounts.google.com'};

  @override
  Future<GoogleIdentity> verify(String idToken) async {
    final res = await _client.get(Uri.https('oauth2.googleapis.com', '/tokeninfo', {'id_token': idToken}));
    if (res.statusCode != 200) throw const ApiError.unauthorized('Jeton Google invalide.');
    final claims = jsonDecode(res.body) as Map<String, dynamic>;
    if (!allowedClientIds.contains(claims['aud']) || !_issuers.contains(claims['iss'])) {
      throw const ApiError.unauthorized('Jeton Google émis pour une autre application.');
    }
    if (claims['email_verified'] != 'true' && claims['email_verified'] != true) {
      throw const ApiError.unauthorized('Adresse Google non vérifiée.');
    }
    final email = claims['email'] as String;
    return GoogleIdentity(
      sub: claims['sub'] as String,
      email: email,
      name: (claims['name'] as String?) ?? email.split('@').first,
      picture: claims['picture'] as String?,
      locale: claims['locale'] as String?,
    );
  }
}

/// Jetons de session émis par notre API après la connexion Google.
class SessionTokens {
  final SecretKey _key;
  final Duration lifetime;

  SessionTokens(String secret, {this.lifetime = const Duration(days: 30)})
      : _key = SecretKey(secret) {
    if (secret.length < 32) {
      throw ArgumentError('Le secret de session doit faire au moins 32 caractères.');
    }
  }

  String issue(String userId) =>
      JWT({}, subject: userId, issuer: 'staff-flow').sign(_key, expiresIn: lifetime);

  /// Renvoie l'identifiant utilisateur du jeton, ou lève 401.
  String verify(String token) {
    try {
      final jwt = JWT.verify(token, _key, issuer: 'staff-flow');
      final sub = jwt.subject;
      if (sub == null) throw const ApiError.unauthorized();
      return sub;
    } on JWTExpiredException {
      throw const ApiError.unauthorized('Session expirée, reconnectez-vous.');
    } on JWTException {
      throw const ApiError.unauthorized('Session invalide.');
    }
  }
}
