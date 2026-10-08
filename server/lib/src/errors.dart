import 'messages.dart';

/// Erreur renvoyée au client sous la forme `{"error": {"code", "message"}}`.
///
/// [message] est le texte français, qui sert aussi de clé de traduction
/// (voir `messages.dart`) ; les parties variables s'écrivent `{nom}` et
/// sont fournies dans [args].
class ApiError implements Exception {
  final int status;
  final String code;
  final String message;
  final Map<String, String> args;

  const ApiError(this.status, this.code, this.message, [this.args = const {}]);

  const ApiError.badRequest(String message, [Map<String, String> args = const {}])
      : this(400, 'bad_request', message, args);
  const ApiError.unauthorized([String message = 'Connexion requise.'])
      : this(401, 'unauthorized', message);
  const ApiError.forbidden([String message = 'Action non autorisée.'])
      : this(403, 'forbidden', message);
  const ApiError.notFound([String message = 'Introuvable.', Map<String, String> args = const {}])
      : this(404, 'not_found', message, args);
  const ApiError.conflict(String message, [Map<String, String> args = const {}])
      : this(409, 'conflict', message, args);

  /// Message dans la langue [lang] (`fr`, `en`, `uk`…), avec ses valeurs.
  String localized(String lang) => translate(message, lang, args);

  Map<String, Object?> toJson([String lang = 'fr']) => {
        'error': {'code': code, 'message': localized(lang)},
      };

  @override
  String toString() => 'ApiError($status, $code): ${localized('fr')}';
}
