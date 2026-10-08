/// Erreur renvoyée au client sous la forme `{"error": {"code", "message"}}`.
class ApiError implements Exception {
  final int status;
  final String code;
  final String message;

  const ApiError(this.status, this.code, this.message);

  const ApiError.badRequest(String message) : this(400, 'bad_request', message);
  const ApiError.unauthorized([String message = 'Connexion requise.'])
      : this(401, 'unauthorized', message);
  const ApiError.forbidden([String message = 'Action non autorisée.'])
      : this(403, 'forbidden', message);
  const ApiError.notFound([String message = 'Introuvable.']) : this(404, 'not_found', message);
  const ApiError.conflict(String message) : this(409, 'conflict', message);

  Map<String, Object?> toJson() => {
        'error': {'code': code, 'message': message},
      };

  @override
  String toString() => 'ApiError($status, $code): $message';
}
