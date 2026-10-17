import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
import 'dates.dart';
import 'models.dart';

/// Agenda du téléphone où l'on peut écrire.
class PhoneCalendar {
  final String id;
  final String? name, account, accountType;
  final bool primary;

  PhoneCalendar.fromMap(Map<dynamic, dynamic> m)
      : id = m['id'] as String,
        name = m['name'] as String?,
        account = m['account'] as String?,
        accountType = m['accountType'] as String?,
        primary = m['primary'] == true;

  bool get isGoogle => accountType == 'com.google';
}

/// Google Agenda sur Android : les services publiés de toutes ses
/// entreprises sont écrits dans un agenda du téléphone (celui du compte
/// Google, synchronisé partout par Google). Ils sont remis à jour à chaque
/// ouverture de l'application et à chaque planning publié ; un service
/// retiré disparaît de l'agenda.
class CalendarSync {
  static const _enabledKey = 'calendar_device_id';
  static const _eventsKey = 'calendar_device_events';
  static const _channel = MethodChannel('staff_flow/calendar');

  /// Seulement sur Android (sur le web : le lien d'abonnement).
  static bool get supported => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static DateTime? _lastSync;
  static Future<int>? _running;
  static Timer? _pending;

  /// Planning modifié : mise à jour de l'agenda 2 minutes après la dernière
  /// modification reçue (plusieurs changements d'affilée = une seule mise à
  /// jour, sans multiplier les écritures vers Google).
  static void schedule(Api api) {
    if (!supported) return;
    _pending?.cancel();
    _pending = Timer(const Duration(minutes: 2), () {
      _pending = null;
      sync(api, force: true).then((_) {}, onError: (_) {});
    });
  }

  /// Agenda choisi, ou `null` si la synchronisation est coupée.
  static Future<String?> calendarId() async =>
      supported ? (await SharedPreferences.getInstance()).getString(_enabledKey) : null;

  /// Agendas modifiables du téléphone, ceux des comptes Google d'abord
  /// (l'agenda principal en tête). `null` si l'accès est refusé.
  static Future<List<PhoneCalendar>?> calendars() async {
    final granted = await _channel.invokeMethod<bool>('requestPermission') ?? false;
    if (!granted) return null;
    final raw = await _channel.invokeListMethod<Map<dynamic, dynamic>>('calendars') ?? const [];
    final all = [for (final m in raw) PhoneCalendar.fromMap(m)];
    int rank(PhoneCalendar c) => (c.isGoogle ? 0 : 2) + (c.primary ? 0 : 1);
    all.sort((a, b) => rank(a).compareTo(rank(b)));
    return all;
  }

  /// Active la synchronisation vers [calendar] et l'exécute. Renvoie le
  /// nombre de services dans l'agenda.
  static Future<int> enable(Api api, String calendar) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_enabledKey, calendar);
    // Les événements déjà suivis sont mis à jour (pas de doublon).
    _lastSync = null;
    return sync(api, force: true);
  }

  /// Coupe la synchronisation et retire les services ajoutés par l'application.
  static Future<void> disable() async {
    final prefs = await SharedPreferences.getInstance();
    for (final event in _events(prefs).values) {
      try {
        await _channel.invokeMethod('delete', {'eventId': event['e']});
      } on PlatformException {
        // Déjà supprimé.
      }
    }
    await prefs.remove(_enabledKey);
    await prefs.remove(_eventsKey);
  }

  /// Services → événements : identifiant du service → {e: événement, d: jour}.
  static Map<String, Map<String, dynamic>> _events(SharedPreferences prefs) {
    final raw = prefs.getString(_eventsKey);
    if (raw == null) return {};
    return {for (final e in (jsonDecode(raw) as Map).entries) e.key as String: (e.value as Map).cast<String, dynamic>()};
  }

  /// Met l'agenda à jour (au plus une fois toutes les 30 secondes, sauf
  /// [force]). Renvoie le nombre de services à venir dans l'agenda.
  static Future<int> sync(Api api, {bool force = false, Duration minInterval = const Duration(seconds: 30)}) async {
    if (!supported) return 0;
    // Une seule mise à jour à la fois.
    final running = _running;
    if (running != null) return running;
    final now = DateTime.now();
    if (!force && _lastSync != null && now.difference(_lastSync!) < minInterval) return 0;
    final future = _sync(api);
    _running = future;
    try {
      return await future;
    } finally {
      _running = null;
    }
  }

  static Future<int> _sync(Api api) async {
    final prefs = await SharedPreferences.getInstance();
    final calendar = prefs.getString(_enabledKey);
    if (calendar == null) return 0;
    if (!(await _channel.invokeMethod<bool>('hasPermission') ?? false)) return 0;
    _lastSync = DateTime.now();
    final from = addDays(dateOnly(_lastSync!), -1), to = addDays(dateOnly(_lastSync!), 60);
    final json = await api.send('GET', '/me/shifts?from=${formatDay(from)}&to=${formatDay(to)}');
    final events = _events(prefs);
    final seen = <String>{};
    for (final s in json['shifts'] as List) {
      final id = s['id'] as String;
      seen.add(id);
      final eventId = await _channel.invokeMethod<String>('upsert', {
        'event': {
          'calendarId': calendar,
          'eventId': events[id]?['e'],
          'title': [s['companyName'], s['positionName']].whereType<String>().join(' · '),
          'start': DateTime.parse(s['startsAt'] as String).millisecondsSinceEpoch,
          'end': DateTime.parse(s['endsAt'] as String).millisecondsSinceEpoch,
          'location': s['siteName'],
          // Fuseau de l'entreprise : Google affiche la bonne heure partout.
          'timezone': s['timezone'],
          'description': 'Staff Flow',
        },
      });
      if (eventId != null) events[id] = {'e': eventId, 'd': s['day']};
    }
    // Services retirés (supprimés ou donnés à quelqu'un d'autre) : effacés de l'agenda.
    for (final id in events.keys.toList()) {
      final day = parseDay(events[id]!['d'] as String);
      if (!day.isBefore(from) && !day.isAfter(to) && !seen.contains(id)) {
        try {
          await _channel.invokeMethod('delete', {'eventId': events[id]!['e']});
        } on PlatformException {
          // Déjà supprimé à la main.
        }
        events.remove(id);
      } else if (day.isBefore(addDays(from, -60))) {
        events.remove(id); // Vieux services : on ne les suit plus.
      }
    }
    await prefs.setString(_eventsKey, jsonEncode(events));
    return seen.length;
  }

  /// Nom affiché d'un agenda du téléphone.
  static String label(PhoneCalendar c) => [c.name, c.account].whereType<String>().toSet().join(' · ');
}
