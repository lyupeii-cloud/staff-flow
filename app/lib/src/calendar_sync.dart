import 'dart:collection';
import 'dart:convert';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import 'api.dart';
import 'dates.dart';
import 'models.dart';

/// Google Agenda sur Android : les services publiés de toutes ses
/// entreprises sont écrits dans un agenda du téléphone (celui du compte
/// Google, synchronisé partout par Google). Ils sont remis à jour à chaque
/// ouverture de l'application et à chaque planning publié.
class CalendarSync {
  static const _enabledKey = 'calendar_device_id';
  static const _eventsKey = 'calendar_device_events';
  static final _plugin = DeviceCalendarPlugin();

  /// Seulement sur Android (sur le web : le lien d'abonnement).
  static bool get supported => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static DateTime? _lastSync;

  /// Agenda choisi, ou `null` si la synchronisation est coupée.
  static Future<String?> calendarId() async =>
      supported ? (await SharedPreferences.getInstance()).getString(_enabledKey) : null;

  /// Agendas modifiables du téléphone, ceux des comptes Google d'abord.
  /// `null` si l'accès à l'agenda est refusé.
  static Future<List<Calendar>?> calendars() async {
    var granted = (await _plugin.hasPermissions()).data ?? false;
    if (!granted) granted = (await _plugin.requestPermissions()).data ?? false;
    if (!granted) return null;
    final UnmodifiableListView<Calendar> all = (await _plugin.retrieveCalendars()).data ?? UnmodifiableListView([]);
    final writable = [for (final c in all) if (c.isReadOnly != true && c.id != null) c];
    int rank(Calendar c) => (c.accountType == 'com.google' ? 0 : 2) + (c.isDefault == true ? 0 : 1);
    writable.sort((a, b) => rank(a).compareTo(rank(b)));
    return writable;
  }

  /// Active la synchronisation vers [calendar] et l'exécute. Renvoie le
  /// nombre de services dans l'agenda.
  static Future<int> enable(Api api, String calendar) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_enabledKey, calendar);
    _lastSync = null;
    return sync(api, force: true);
  }

  /// Coupe la synchronisation et retire les services ajoutés par l'application.
  static Future<void> disable() async {
    final prefs = await SharedPreferences.getInstance();
    final calendar = prefs.getString(_enabledKey);
    if (calendar != null) {
      for (final event in _events(prefs).values) {
        await _plugin.deleteEvent(calendar, event['e'] as String);
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

  /// Met l'agenda à jour (au plus une fois par minute, sauf [force]).
  /// Renvoie le nombre de services à venir dans l'agenda.
  static Future<int> sync(Api api, {bool force = false}) async {
    if (!supported) return 0;
    final prefs = await SharedPreferences.getInstance();
    final calendar = prefs.getString(_enabledKey);
    if (calendar == null) return 0;
    final now = DateTime.now();
    if (!force && _lastSync != null && now.difference(_lastSync!) < const Duration(minutes: 1)) return 0;
    _lastSync = now;
    if (!((await _plugin.hasPermissions()).data ?? false)) return 0;
    final from = addDays(dateOnly(now), -1), to = addDays(dateOnly(now), 60);
    final json = await api.send('GET', '/me/shifts?from=${formatDay(from)}&to=${formatDay(to)}');
    final events = _events(prefs);
    final seen = <String>{};
    for (final s in json['shifts'] as List) {
      final id = s['id'] as String;
      seen.add(id);
      final title = [s['companyName'], s['positionName']].whereType<String>().join(' · ');
      final event = Event(
        calendar,
        eventId: events[id]?['e'] as String?,
        title: title,
        start: tz.TZDateTime.from(DateTime.parse(s['startsAt'] as String), tz.UTC),
        end: tz.TZDateTime.from(DateTime.parse(s['endsAt'] as String), tz.UTC),
        location: s['siteName'] as String?,
        description: 'Staff Flow',
      );
      final created = await _plugin.createOrUpdateEvent(event);
      final eventId = created?.data;
      if (eventId != null) events[id] = {'e': eventId, 'd': s['day']};
    }
    // Services supprimés ou donnés à quelqu'un d'autre sur la période : retirés.
    for (final id in events.keys.toList()) {
      final day = DateTime.tryParse(events[id]!['d'] as String? ?? '');
      final inRange = day != null && !day.isBefore(from) && !day.isAfter(to);
      if (inRange && !seen.contains(id)) {
        await _plugin.deleteEvent(calendar, events[id]!['e'] as String);
        events.remove(id);
      } else if (day != null && day.isBefore(addDays(from, -60))) {
        // Vieux services : on ne les suit plus (ils restent dans l'agenda).
        events.remove(id);
      }
    }
    await prefs.setString(_eventsKey, jsonEncode(events));
    return seen.length;
  }

  /// Nom affiché d'un agenda du téléphone.
  static String label(Calendar c) => [c.name, c.accountName].whereType<String>().toSet().join(' · ');
}
