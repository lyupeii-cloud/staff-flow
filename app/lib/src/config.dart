/// Réglages passés à la compilation avec `--dart-define`.
class Config {
  /// Adresse de l'API. Vide = même origine que le site web (production).
  static const apiUrl = String.fromEnvironment('API_URL');

  /// Identifiant client OAuth « Application Web » de Google Cloud.
  /// Sur Android, il sert de `serverClientId` pour obtenir un jeton
  /// d'identité destiné à notre serveur.
  static const googleWebClientId = String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');

  /// Connexion sans Google par adresse e-mail, si le serveur l'autorise.
  static const devLogin = bool.fromEnvironment('DEV_LOGIN');
}
