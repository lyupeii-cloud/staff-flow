import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:staff_flow/src/i18n.dart';

/// Textes de l'écran de développement : l'anglais suffit.
const devOnly = {'googleNotConfigured', 'devSection', 'emailLabel', 'devSignIn'};

Map<String, String> load(String lang) {
  final json = jsonDecode(File('lib/l10n/app_$lang.arb').readAsStringSync()) as Map<String, dynamic>;
  return {for (final e in json.entries) if (!e.key.startsWith('@')) e.key: e.value as String};
}

/// Variables `{nom}` d'un texte, hors syntaxe des pluriels.
Set<String> placeholders(String text) {
  if (text.contains(', plural,')) {
    return {RegExp(r'^\{(\w+), plural,').firstMatch(text)!.group(1)!};
  }
  return {for (final m in RegExp(r'\{(\w+)\}').allMatches(text)) m.group(1)!};
}

void main() {
  final english = load('en');
  final files = Directory('lib/l10n')
      .listSync()
      .map((f) => RegExp(r'app_(\w+)\.arb$').firstMatch(f.path)?.group(1))
      .whereType<String>()
      .toSet();

  test('chaque langue proposée a son fichier, et inversement', () {
    expect(files, {for (final l in appLanguages) l.code});
  });

  for (final lang in files.difference({'en'})) {
    test('$lang : tous les textes, avec les mêmes variables qu\'en anglais', () {
      final t = load(lang);
      final missing = english.keys.toSet().difference(t.keys.toSet()).difference(devOnly);
      expect(missing, isEmpty, reason: 'textes manquants');
      expect(t.keys.toSet().difference(english.keys.toSet()), isEmpty, reason: 'clés inconnues');
      for (final key in t.keys) {
        expect(placeholders(t[key]!), placeholders(english[key]!), reason: key);
        if (t[key]!.contains(', plural,')) {
          expect(t[key], contains('other{'), reason: '$key : le cas « other » est obligatoire');
        }
      }
    });
  }
}
