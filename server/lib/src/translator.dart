import 'dart:convert';

import 'package:http/http.dart' as http;

/// Traduction d'un message dans la langue de la personne qui le lit.
abstract class Translator {
  /// Codes des langues que le traducteur sait produire.
  Future<Set<String>> languages();

  /// [to] : un code renvoyé par [languages]. La langue d'origine est devinée.
  Future<String> translate(String text, String to);
}

/// LibreTranslate, installé sur le même serveur (service « translate » de
/// Docker Compose) : les messages ne sortent pas du serveur.
class LibreTranslator implements Translator {
  final Uri base;
  final http.Client _http;
  Set<String>? _languages;
  DateTime _checked = DateTime(0);

  LibreTranslator(String url, {http.Client? client})
      : base = Uri.parse(url),
        _http = client ?? http.Client();

  @override
  Future<Set<String>> languages() async {
    // Relu toutes les heures : de nouvelles langues peuvent être installées.
    if (_languages != null && DateTime.now().difference(_checked) < const Duration(hours: 1)) return _languages!;
    final res = await _http.get(base.resolve('/languages')).timeout(const Duration(seconds: 10));
    if (res.statusCode != 200) throw StateError('LibreTranslate : ${res.statusCode}');
    _languages = {for (final l in jsonDecode(res.body) as List) (l as Map)['code'] as String};
    _checked = DateTime.now();
    return _languages!;
  }

  @override
  Future<String> translate(String text, String to) async {
    final res = await _http
        .post(base.resolve('/translate'),
            headers: {'content-type': 'application/json'},
            body: jsonEncode({'q': text, 'source': 'auto', 'target': to, 'format': 'text'}))
        .timeout(const Duration(seconds: 30));
    if (res.statusCode != 200) throw StateError('LibreTranslate : ${res.statusCode} ${res.body}');
    return (jsonDecode(utf8.decode(res.bodyBytes)) as Map)['translatedText'] as String;
  }
}

/// Code de langue de l'application → code du traducteur, parmi [available].
String? translatorLanguage(String lang, Set<String> available) {
  final base = lang.toLowerCase().split(RegExp('[-_]')).first;
  final candidates = switch (base) {
    'fil' => ['tl', 'fil'],
    'zh' => ['zh-Hans', 'zh'],
    'no' || 'nn' => ['nb'],
    'pt' => ['pt', 'pt-BR'],
    _ => [base],
  };
  return candidates.where(available.contains).firstOrNull;
}
