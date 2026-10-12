/// Traductions des messages d'erreur de l'API, une langue par fichier dans
/// `messages/`. La clé est le texte français tel qu'il est écrit dans le code ;
/// `{nom}` marque une valeur insérée. Les messages techniques (qu'un utilisateur
/// de l'application ne voit pas) n'existent qu'en anglais ; les autres langues
/// se rabattent alors sur l'anglais. Un test vérifie ces règles.
library;

import 'messages/de.dart';
import 'messages/en.dart';
import 'messages/es.dart';
import 'messages/it.dart';
import 'messages/pl.dart';
import 'messages/pt.dart';
import 'messages/ro.dart';
import 'messages/ru.dart';
import 'messages/uk.dart';

/// Toutes les langues de l'application (le français est le texte du code).
const catalogs = <String, Map<String, String>>{
  'en': en, 'uk': uk, 'ru': ru, 'pl': pl, 'ro': ro, 'de': de, 'es': es, 'pt': pt, 'it': it,
};

final supportedLanguages = {'fr', ...catalogs.keys};

/// Codes que les navigateurs ou Google emploient pour nos langues.
const _aliases = <String, String>{};

/// Messages techniques : erreurs de programmation ou cas que l'interface
/// empêche ; ils restent en anglais pour les autres langues.
const technicalMessages = {
  'idToken manquant.',
  'email manquant.',
  'Route inconnue.',
  'Clé API invalide.',
  'Période invalide (5 ans au plus).',
  'Corps JSON attendu.',
  'Champ « {field} » manquant.',
  'Champ manquant ou de mauvais type.',
  'Paramètres from et to requis.',
  'Champ « days » : liste de dates attendue.',
  'Jeton Google émis pour une autre application.',
  'Rôle inconnu : {value}',
  'Rôle attendu : salarié ou extra.',
  'Répétition inconnue.',
  'Jour de semaine invalide.',
  'Période invalide (62 jours au plus).',
  'Fuseau horaire invalide : {value}',
  'Date invalide : {value}',
  'Heures invalides.',
  'Le jour se change service par service.',
  'Indiquez une date de fin ou un nombre de répétitions.',
  'Message vide ou trop long (2000 caractères au plus).',
};

/// Langue de réponse d'après l'en-tête `Accept-Language` (`uk-UA,uk;q=0.9,en;q=0.8`).
/// Par défaut : anglais.
String negotiateLanguage(String? acceptLanguage) {
  if (acceptLanguage == null) return 'en';
  final ranked = <(String, double)>[];
  for (final part in acceptLanguage.split(',')) {
    final pieces = part.trim().split(';');
    var lang = pieces.first.trim().toLowerCase().split(RegExp('[-_]')).first;
    lang = _aliases[lang] ?? lang;
    var q = 1.0;
    for (final p in pieces.skip(1)) {
      final kv = p.trim().split('=');
      if (kv.length == 2 && kv[0] == 'q') q = double.tryParse(kv[1]) ?? 0;
    }
    if (lang.isNotEmpty) ranked.add((lang, q));
  }
  ranked.sort((a, b) => b.$2.compareTo(a.$2));
  for (final (lang, q) in ranked) {
    if (q > 0 && supportedLanguages.contains(lang)) return lang;
  }
  return 'en';
}

String translate(String french, String lang, [Map<String, String> args = const {}]) {
  var text = lang == 'fr' ? french : (catalogs[lang]?[french] ?? en[french] ?? french);
  args.forEach((k, v) => text = text.replaceAll('{$k}', v));
  return text;
}
