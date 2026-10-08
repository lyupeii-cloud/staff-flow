import 'dart:io';

import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

/// Messages levés dans le code (texte français passé à ApiError).
Set<String> messagesInCode() {
  final literal = RegExp(r"""(?:'((?:[^'\\]|\\.)*)'|"((?:[^"\\]|\\.)*)")""");
  final call = RegExp(r'ApiError(?:\.\w+)?\(([^;]*)', dotAll: true);
  final found = <String>{'Connexion requise.', 'Action non autorisée.', 'Introuvable.'};
  for (final file in Directory('lib').listSync(recursive: true).whereType<File>()) {
    if (file.path.contains('messages')) continue;
    for (final c in call.allMatches(file.readAsStringSync())) {
      for (final l in literal.allMatches(c[1]!)) {
        final text = (l[1] ?? l[2]!).replaceAll(r"\'", "'");
        // Codes techniques (« bad_request »…) et noms de champ : pas des phrases.
        if (!text.contains(' ') && !text.endsWith('.')) continue;
        found.add(text);
      }
    }
  }
  return found;
}

Set<String> placeholders(String text) =>
    {for (final m in RegExp(r'\{(\w+)\}').allMatches(text)) m.group(1)!};

void main() {
  final inCode = messagesInCode();

  test('l\'extraction trouve bien les messages', () {
    expect(inCode.length, greaterThan(45));
    expect(inCode, contains('Le propriétaire doit transférer l\'entreprise avant de la quitter.'));
  });

  test('l\'anglais (langue par défaut) a tous les messages', () {
    expect(inCode.difference(catalogs['en']!.keys.toSet()), isEmpty);
  });

  test('les messages techniques existent bien dans le code', () {
    expect(technicalMessages.difference(inCode), isEmpty);
  });

  for (final MapEntry(key: lang, value: catalog) in catalogs.entries) {
    test('$lang : chaque message visible est traduit, avec les mêmes variables', () {
      final visible = inCode.difference(technicalMessages);
      expect(visible.difference(catalog.keys.toSet()), isEmpty, reason: 'messages manquants');
      expect(catalog.keys.toSet().difference(inCode), isEmpty, reason: 'messages qui n\'existent plus');
      for (final MapEntry(:key, :value) in catalog.entries) {
        expect(placeholders(value), placeholders(key), reason: key);
      }
    });
  }

  test('le serveur et l\'application proposent les mêmes langues', () {
    final appLanguages = {
      for (final f in Directory('../app/lib/l10n').listSync())
        if (RegExp(r'app_(\w+)\.arb$').firstMatch(f.path) case final m?) m.group(1)!,
    };
    expect(supportedLanguages, appLanguages);
  }, skip: Directory('../app/lib/l10n').existsSync() ? false : 'application absente (tests lancés sans le dossier app)');

  test('les valeurs sont insérées dans la traduction', () {
    expect(translate('{name} fait déjà partie de l\'entreprise.', 'uk', {'name': 'Olena'}),
        'Olena вже є учасником компанії.');
    expect(translate('Date invalide : {value}', 'fr', {'value': 'x'}), 'Date invalide : x');
  });

  test('message technique dans une autre langue : anglais', () {
    expect(translate('Route inconnue.', 'ja'), 'Unknown route.');
  });

  group('choix de la langue', () {
    test('d\'après Accept-Language, avec les priorités', () {
      expect(negotiateLanguage('uk-UA,uk;q=0.9,en;q=0.8'), 'uk');
      expect(negotiateLanguage('fr-FR'), 'fr');
      expect(negotiateLanguage('tr-TR,de;q=0.5,en;q=0.7'), 'en');
      expect(negotiateLanguage('en;q=0.2,ja;q=0.9'), 'ja');
      expect(negotiateLanguage('no-NO'), 'nb');
      expect(negotiateLanguage('tl'), 'fil');
    });

    test('langue non proposée ou absente : anglais', () {
      expect(negotiateLanguage('tr-TR'), 'en');
      expect(negotiateLanguage(null), 'en');
      expect(negotiateLanguage(''), 'en');
    });
  });
}
