import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';
import 'models.dart';

export '../l10n/app_localizations.dart';

/// Texte à afficher, produit dans la langue de l'écran au moment de l'afficher.
typedef Localized = String Function(L10n t);

/// Une langue proposée, avec son nom écrit dans cette langue (pour le menu).
class AppLanguage {
  final String code;
  final String nativeName;

  const AppLanguage(this.code, this.nativeName);

  /// `en_GB` → Locale('en', 'GB').
  Locale get locale {
    final parts = code.split('_');
    return Locale(parts.first, parts.length > 1 ? parts[1] : null);
  }
}

/// Langues de l\'application : les pays visés (Ukraine, France, Europe).
/// La première (anglais américain) sert quand celle du téléphone ou du
/// compte Google n'est pas proposée ; elle est toujours là. L'anglais
/// britannique ne change que l'orthographe et le format des dates.
const appLanguages = [
  AppLanguage('en', 'English (US)'),
  AppLanguage('en_GB', 'English (UK)'),
  AppLanguage('fr', 'Français'),
  AppLanguage('uk', 'Українська'),
  AppLanguage('ru', 'Русский'),
  AppLanguage('pl', 'Polski'),
  AppLanguage('ro', 'Română'),
  AppLanguage('de', 'Deutsch'),
  AppLanguage('es', 'Español'),
  AppLanguage('pt', 'Português'),
  AppLanguage('it', 'Italiano'),
];

final supportedLocales = [for (final l in appLanguages) l.locale];

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
  final parts = tag.split(RegExp('[-_]'));
  final language = parts.first.toLowerCase();
  final country = parts.length > 1 ? parts[1].toUpperCase() : null;
  // Langue et pays (en-GB), sinon la langue seule (en-US → en).
  for (final l in supportedLocales) {
    if (l.languageCode == language && l.countryCode != null && l.countryCode == country) return l;
  }
  for (final l in supportedLocales) {
    if (l.languageCode == language && l.countryCode == null) return l;
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
