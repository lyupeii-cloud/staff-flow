import 'dart:io';

import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

void main() {
  test('chaque message d\'erreur du code est traduit dans toutes les langues', () {
    // Littéraux 'texte' (apostrophes échappées comprises) passés à ApiError.
    final literal = RegExp(r"'((?:[^'\\]|\\.)*)'");
    final call = RegExp(r'ApiError(?:\.\w+)?\(([^;]*)', dotAll: true);
    final found = <String>{};
    for (final file in Directory('lib').listSync(recursive: true).whereType<File>()) {
      if (file.path.endsWith('messages.dart')) continue;
      for (final c in call.allMatches(file.readAsStringSync())) {
        for (final l in literal.allMatches(c[1]!)) {
          final text = l[1]!.replaceAll(r"\'", "'");
          // Codes techniques (« bad_request »…) et noms de champ : pas des phrases.
          if (RegExp(r'^[a-z_]+$').hasMatch(text) || !text.contains(' ') && !text.endsWith('.')) continue;
          found.add(text);
        }
      }
    }
    // Messages par défaut des constructeurs.
    found.addAll(['Connexion requise.', 'Action non autorisée.', 'Introuvable.']);
    expect(found.length, greaterThan(40), reason: 'extraction des messages cassée ?');
    final missing = [
      for (final m in found)
        for (final lang in ['en', 'uk'])
          if (messages[m]?[lang] == null) '$lang : $m',
    ];
    expect(missing, isEmpty);
  });

  test('les valeurs sont insérées dans la traduction', () {
    expect(translate('Date invalide : {value}', 'uk', {'value': '2026-13-01'}),
        'Недійсна дата: 2026-13-01');
    expect(translate('Date invalide : {value}', 'fr', {'value': 'x'}), 'Date invalide : x');
  });

  group('choix de la langue', () {
    test('d\'après Accept-Language, avec les priorités', () {
      expect(negotiateLanguage('uk-UA,uk;q=0.9,en;q=0.8'), 'uk');
      expect(negotiateLanguage('fr-FR'), 'fr');
      expect(negotiateLanguage('de-DE,fr;q=0.5,en;q=0.7'), 'en');
      expect(negotiateLanguage('en;q=0.2,uk;q=0.9'), 'uk');
    });

    test('langue inconnue ou absente : anglais', () {
      expect(negotiateLanguage('pl-PL'), 'en');
      expect(negotiateLanguage(null), 'en');
      expect(negotiateLanguage(''), 'en');
    });
  });
}
