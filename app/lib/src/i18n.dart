import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';
import 'models.dart';

export '../l10n/app_localizations.dart';

/// Langues de l'application. Le premier sert quand celle du téléphone ou du
/// compte Google n'est pas proposée.
const supportedLocales = [Locale('en'), Locale('fr'), Locale('uk')];

extension L10nContext on BuildContext {
  L10n get l10n => L10n.of(this);

  /// Code de langue pour les dates (`fr`, `uk`, `en`).
  String get localeName => L10n.of(this).localeName;
}

extension RoleLabel on Role {
  String label(L10n t) => switch (this) {
        Role.owner => t.roleOwner,
        Role.manager => t.roleManager,
        Role.employee => t.roleEmployee,
        Role.extra => t.roleExtra,
      };
}

/// « 7 h 30 », « 7h30 », « 7 год 30 хв ».
String durationLabel(L10n t, int minutes) {
  final h = minutes ~/ 60, m = minutes % 60;
  return m == 0 ? t.durationHours(h) : t.durationHoursMinutes(h, m.toString().padLeft(2, '0'));
}

/// Locale choisie pour un compte Google (« uk », « fr-CA », « en-GB »…), si
/// l'application la propose ; sinon `null` (on garde celle de l'appareil).
Locale? supportedLocaleFor(String? tag) {
  if (tag == null || tag.isEmpty) return null;
  final language = tag.split(RegExp('[-_]')).first.toLowerCase();
  for (final l in supportedLocales) {
    if (l.languageCode == language) return l;
  }
  return null;
}

/// Fuseaux proposés à la création d'une entreprise.
const timezones = [
  'Europe/Kyiv',
  'Europe/Paris',
  'Europe/Brussels',
  'Europe/Zurich',
  'Europe/Luxembourg',
  'Europe/London',
  'Europe/Berlin',
  'Europe/Warsaw',
  'Europe/Bucharest',
  'Europe/Chisinau',
  'Europe/Madrid',
  'Europe/Lisbon',
  'Europe/Rome',
  'America/Toronto',
  'America/Montreal',
  'America/New_York',
  'America/Chicago',
  'America/Los_Angeles',
  'Africa/Casablanca',
  'Africa/Dakar',
  'Indian/Reunion',
  'America/Martinique',
  'Pacific/Noumea',
  'UTC',
];

/// Fuseau proposé par défaut, d'après le pays puis la langue de l'appareil.
String defaultTimezone(Locale locale) {
  const byCountry = {
    'UA': 'Europe/Kyiv',
    'FR': 'Europe/Paris',
    'BE': 'Europe/Brussels',
    'CH': 'Europe/Zurich',
    'LU': 'Europe/Luxembourg',
    'GB': 'Europe/London',
    'DE': 'Europe/Berlin',
    'PL': 'Europe/Warsaw',
    'RO': 'Europe/Bucharest',
    'MD': 'Europe/Chisinau',
    'ES': 'Europe/Madrid',
    'PT': 'Europe/Lisbon',
    'IT': 'Europe/Rome',
    'CA': 'America/Toronto',
    'US': 'America/New_York',
    'MA': 'Africa/Casablanca',
    'SN': 'Africa/Dakar',
  };
  const byLanguage = {'uk': 'Europe/Kyiv', 'fr': 'Europe/Paris', 'en': 'Europe/London'};
  return byCountry[locale.countryCode?.toUpperCase()] ?? byLanguage[locale.languageCode] ?? 'UTC';
}
