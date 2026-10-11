import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api.dart';
import '../calendar_sync.dart';
import '../config.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';

/// Adresse complète d'un chemin du serveur (`/api/v1/…`).
String serverUrl(String path) => '${Config.apiUrl.isEmpty ? Uri.base.origin : Config.apiUrl}$path';

Future<void> _open(BuildContext context, String url) async {
  final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication, webOnlyWindowName: '_blank');
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.serverUnreachable)));
  }
}

/// Export (Excel, CSV) ou page imprimable de la période, ouvert dans le
/// navigateur : il télécharge le fichier, ou affiche la page à imprimer ou
/// enregistrer en PDF.
Future<void> openExport(BuildContext context, Session session, Company company, String format, DateTime from, DateTime to,
    {bool own = false}) async {
  final t = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  try {
    final r = await session.api.send('POST', '/companies/${company.id}/exports', body: {
      'format': format,
      'from': formatDay(from),
      'to': formatDay(to),
      'scope': own ? 'own' : 'team',
      'lang': context.localeName,
    });
    if (!context.mounted) return;
    await _open(context, serverUrl('${r['path']}?lang=${context.localeName}'));
  } on OfflineException {
    messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
  } on ApiException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
  }
}

/// Imprimer ou PDF : un responsable imprime l'équipe ; un salarié choisit
/// son planning ou celui de l'équipe si le responsable le permet.
Future<void> choosePrint(BuildContext context, Session session, Membership membership, DateTime from, DateTime to) async {
  final t = context.l10n;
  final company = membership.company;
  if (membership.role.canManage || company.printScope != 'team') {
    return openExport(context, session, company, 'print', from, to, own: !membership.role.canManage);
  }
  final own = await showModalBottomSheet<bool>(
    context: context,
    builder: (context) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(leading: const Icon(Icons.person), title: Text(t.printMine), onTap: () => Navigator.pop(context, true)),
        ListTile(leading: const Icon(Icons.group), title: Text(t.printTeamOption), onTap: () => Navigator.pop(context, false)),
      ]),
    ),
  );
  if (own != null && context.mounted) await openExport(context, session, company, 'print', from, to, own: own);
}

// --- Alertes légales ---------------------------------------------------------

/// Modèles par pays : des points de départ, à vérifier et modifier.
const legalPresets = <String, Map<String, int>>{
  'FR': {'maxDayMin': 600, 'maxWeekMin': 2880, 'minRestMin': 660, 'maxConsecutiveDays': 6},
  'BE': {'maxDayMin': 660, 'maxWeekMin': 3000, 'minRestMin': 660, 'maxConsecutiveDays': 6},
  'CH': {'maxDayMin': 720, 'maxWeekMin': 3000, 'minRestMin': 660, 'maxConsecutiveDays': 6},
  'CA': {'maxDayMin': 720, 'maxWeekMin': 2880, 'minRestMin': 480, 'maxConsecutiveDays': 6},
};

String presetName(L10n t, String code) => switch (code) {
      'FR' => t.countryFrance,
      'BE' => t.countryBelgium,
      'CH' => t.countrySwitzerland,
      _ => t.countryCanada,
    };

/// Texte d'une alerte légale renvoyée par le serveur.
String legalAlertText(L10n t, Map<String, dynamic> a, CompanyData data) {
  final name = data.memberName(a['userId']) ?? t.formerMember;
  final value = a['value'] as int, limit = a['limit'] as int;
  return switch (a['kind']) {
    'day' => t.alertDay(name, durationLabel(t, value), durationLabel(t, limit)),
    'week' => t.alertWeek(name, durationLabel(t, value), durationLabel(t, limit)),
    'rest' => t.alertRest(name, durationLabel(t, value), durationLabel(t, limit)),
    _ => t.alertConsecutive(name, '$value', '$limit'),
  };
}

/// Réglages du responsable : alertes légales.
class ToolsSettings extends StatelessWidget {
  final Session session;
  final Company company;

  const ToolsSettings({super.key, required this.session, required this.company});

  Future<void> _save(BuildContext context, Map<String, dynamic> body) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await session.api.send('PATCH', '/companies/${company.id}', body: body);
      await session.refresh();
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    final rules = company.legalRules;
    final lines = rules == null
        ? [t.noLegalRules]
        : [
            if (rules['maxDayMin'] != null) '${t.maxDayLabel} : ${durationLabel(t, rules['maxDayMin']!)}',
            if (rules['maxWeekMin'] != null) '${t.maxWeekLabel} : ${durationLabel(t, rules['maxWeekMin']!)}',
            if (rules['minRestMin'] != null) '${t.minRestLabel} : ${durationLabel(t, rules['minRestMin']!)}',
            if (rules['maxConsecutiveDays'] != null) '${t.maxConsecutiveLabel} : ${rules['maxConsecutiveDays']}',
          ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          Expanded(child: Text(t.legalAlerts, style: theme.textTheme.titleMedium)),
          if (!company.readOnly)
            TextButton.icon(
              onPressed: () async {
                final result = await showDialog<({Map<String, int>? rules})>(
                  context: context,
                  builder: (_) => _RulesDialog(initial: rules),
                );
                if (result != null && context.mounted) await _save(context, {'legalRules': result.rules});
              },
              icon: const Icon(Icons.tune, size: 18),
              label: Text(t.changeSettings),
            ),
        ]),
        Text(t.legalAlertsHint, style: theme.textTheme.bodySmall),
        const SizedBox(height: 6),
        for (final l in lines) Text('• $l'),
      ],
    );
  }
}

/// Réglages de l'entreprise (onglet « Management ») : fuseau horaire et
/// droit d'impression des salariés.
class CompanySettings extends StatelessWidget {
  final Session session;
  final Company company;

  const CompanySettings({super.key, required this.session, required this.company});

  Future<void> _save(BuildContext context, Map<String, dynamic> body) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await session.api.send('PATCH', '/companies/${company.id}', body: body);
      await session.refresh();
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          Expanded(child: Text(t.companyTimezone, style: theme.textTheme.titleMedium)),
          if (!company.readOnly)
            TextButton.icon(
              onPressed: () => chooseTimezone(context, session, company),
              icon: const Icon(Icons.public, size: 18),
              label: Text(t.changeSettings),
            ),
        ]),
        Text(company.timezone),
        Text(t.companyTimezoneHint, style: theme.textTheme.bodySmall),
        const SizedBox(height: 24),
        Text(t.printRights, style: theme.textTheme.titleMedium),
        RadioGroup<String>(
          groupValue: company.printScope,
          onChanged: (v) {
            if (v != null && !company.readOnly) _save(context, {'printScope': v});
          },
          child: Column(children: [
            RadioListTile(contentPadding: EdgeInsets.zero, value: 'own', title: Text(t.printOwn)),
            RadioListTile(contentPadding: EdgeInsets.zero, value: 'team', title: Text(t.printTeam)),
          ]),
        ),
      ],
    );
  }
}

class _RulesDialog extends StatefulWidget {
  final Map<String, int>? initial;

  const _RulesDialog({this.initial});

  @override
  State<_RulesDialog> createState() => _RulesDialogState();
}

class _RulesDialogState extends State<_RulesDialog> {
  static const _keys = ['maxDayMin', 'maxWeekMin', 'minRestMin', 'maxConsecutiveDays'];
  late final _fields = {
    for (final k in _keys)
      k: TextEditingController(text: _show(k, widget.initial?[k])),
  };

  /// Heures (avec décimales) pour les durées, jours pour les jours d'affilée.
  static String _show(String key, int? v) {
    if (v == null) return '';
    if (key == 'maxConsecutiveDays') return '$v';
    final h = v / 60;
    return h == h.roundToDouble() ? '${h.round()}' : h.toStringAsFixed(1);
  }

  void _apply(Map<String, int> preset) {
    for (final k in _keys) {
      _fields[k]!.text = _show(k, preset[k]);
    }
  }

  @override
  void dispose() {
    for (final c in _fields.values) {
      c.dispose();
    }
    super.dispose();
  }

  Map<String, int>? _rules() {
    final out = <String, int>{};
    for (final k in _keys) {
      final v = double.tryParse(_fields[k]!.text.replaceAll(',', '.').trim());
      if (v == null || v <= 0) continue;
      out[k] = k == 'maxConsecutiveDays' ? v.round() : (v * 60).round();
    }
    return out.isEmpty ? null : out;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final labels = {
      'maxDayMin': t.maxDayLabel,
      'maxWeekMin': t.maxWeekLabel,
      'minRestMin': t.minRestLabel,
      'maxConsecutiveDays': t.maxConsecutiveLabel,
    };
    return AlertDialog(
      title: Text(t.legalAlerts),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(t.legalPreset, style: Theme.of(context).textTheme.labelLarge),
          Wrap(spacing: 6, children: [
            for (final code in legalPresets.keys)
              ActionChip(label: Text(presetName(t, code)), onPressed: () => setState(() => _apply(legalPresets[code]!))),
            ActionChip(label: Text(t.presetNone), onPressed: () => setState(() => _apply(const {}))),
          ]),
          Text(t.presetsCheck, style: Theme.of(context).textTheme.bodySmall),
          for (final k in _keys)
            TextField(
              controller: _fields[k],
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
              decoration: InputDecoration(labelText: labels[k], helperText: t.emptyNoAlert),
            ),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
        FilledButton(onPressed: () => Navigator.pop(context, (rules: _rules())), child: Text(t.save)),
      ],
    );
  }
}

// --- Fuseau horaire ---------------------------------------------------------------

/// Choix du fuseau de l'entreprise parmi ceux du monde (base IANA du
/// serveur, heure d'été comprise) ; celui du téléphone est proposé en tête.
Future<void> chooseTimezone(BuildContext context, Session session, Company company) async {
  final t = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  final List<Map<String, dynamic>> zones;
  try {
    zones = [for (final z in (await session.api.send('GET', '/timezones'))['timezones']) (z as Map).cast<String, dynamic>()];
  } on OfflineException {
    messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    return;
  }
  if (!context.mounted) return;
  final device = await deviceTimezone();
  if (!context.mounted) return;
  final chosen = await showDialog<String>(
    context: context,
    builder: (context) => _TimezoneDialog(zones: zones, current: company.timezone, device: device),
  );
  if (chosen == null || chosen == company.timezone) return;
  try {
    await session.api.send('PATCH', '/companies/${company.id}', body: {'timezone': chosen});
    await session.refresh();
  } on OfflineException {
    messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
  } on ApiException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
  }
}

class _TimezoneDialog extends StatefulWidget {
  final List<Map<String, dynamic>> zones;
  final String current;
  final String? device;

  const _TimezoneDialog({required this.zones, required this.current, this.device});

  @override
  State<_TimezoneDialog> createState() => _TimezoneDialogState();
}

class _TimezoneDialogState extends State<_TimezoneDialog> {
  var _query = '';

  static String _utc(int m) =>
      'UTC${m < 0 ? '−' : '+'}${m.abs() ~/ 60}${m.abs() % 60 == 0 ? '' : ':${(m.abs() % 60).toString().padLeft(2, '0')}'}';

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final q = _query.toLowerCase().replaceAll(' ', '_');
    final device = widget.device;
    final list = [
      for (final z in widget.zones)
        if (q.isEmpty || (z['name'] as String).toLowerCase().contains(q)) z,
    ];
    // Celui du téléphone en premier.
    list.sort((a, b) => (a['name'] == device ? 0 : 1).compareTo(b['name'] == device ? 0 : 1));
    return AlertDialog(
      title: Text(t.companyTimezone),
      content: SizedBox(
        width: 400,
        height: 420,
        child: Column(children: [
          TextField(
            autofocus: true,
            decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: t.searchCity),
            onChanged: (v) => setState(() => _query = v),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final z = list[i];
                final name = z['name'] as String;
                return ListTile(
                  dense: true,
                  selected: name == widget.current,
                  title: Text(name.replaceAll('_', ' ')),
                  subtitle: name == device ? Text(t.thisPhone) : null,
                  trailing: Text(_utc(z['offset'] as int)),
                  onTap: () => Navigator.pop(context, name),
                );
              },
            ),
          ),
        ]),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel))],
    );
  }
}

// --- Totaux d'heures ------------------------------------------------------------

/// Heures par personne sur la période affichée (brouillons compris), avec
/// les exports pour la paie (planning publié).
Future<void> showTotalsSheet(BuildContext context,
    {required Session session, required Membership membership, required DateTime from, required DateTime to}) {
  final t = context.l10n;
  final company = membership.company;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => FutureBuilder(
      future: session.api.send('GET', '/companies/${company.id}/totals?from=${formatDay(from)}&to=${formatDay(to)}'),
      builder: (context, snap) {
        final theme = Theme.of(context);
        final loc = context.localeName;
        final rows = snap.hasData ? [for (final r in snap.data['totals']) (r as Map).cast<String, dynamic>()] : const <Map<String, dynamic>>[];
        Widget group(String title, Iterable<Map<String, dynamic>> people) {
          final list = people.toList();
          if (list.isEmpty) return const SizedBox.shrink();
          final sum = list.fold<int>(0, (m, r) => m + (r['minutes'] as int));
          return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Text('$title · ${durationLabel(t, sum)}', style: theme.textTheme.titleSmall),
            ),
            for (final r in list)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(r['name'] as String),
                subtitle: Text(t.shiftsCount('${r['shifts']}')),
                trailing: Text(durationLabel(t, r['minutes'] as int), style: theme.textTheme.titleSmall),
              ),
          ]);
        }

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          builder: (context, scroll) => ListView(
            controller: scroll,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
              Text(t.hoursTotals, style: theme.textTheme.titleLarge),
              Text('${dayLabel(from, loc)} – ${dayLabel(to, loc)}', style: theme.textTheme.bodySmall),
              Text(t.totalsHint, style: theme.textTheme.bodySmall),
              if (snap.hasError) Text('${snap.error}', style: TextStyle(color: theme.colorScheme.error)),
              if (!snap.hasData && !snap.hasError) const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator())),
              group(t.employeesSection, rows.where((r) => r['role'] != 'extra')),
              group(t.extrasSection, rows.where((r) => r['role'] == 'extra')),
              const SizedBox(height: 16),
              Wrap(spacing: 8, runSpacing: 8, children: [
                FilledButton.tonalIcon(
                  onPressed: () => openExport(context, session, company, 'xlsx', from, to),
                  icon: const Icon(Icons.table_chart),
                  label: const Text('Excel'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => openExport(context, session, company, 'csv', from, to),
                  icon: const Icon(Icons.description),
                  label: const Text('CSV'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => openExport(context, session, company, 'print', from, to),
                  icon: const Icon(Icons.print),
                  label: Text(t.printPdf),
                ),
              ]),
            ],
          ),
        );
      },
    ),
  );
}

// --- Google Agenda ----------------------------------------------------------------

/// Google Agenda, en option : un lien d'agenda personnel, que Google ajoute
/// en un clic et met à jour tout seul. Désactiver coupe le lien.
Future<void> showCalendarDialog(BuildContext context, Session session) => showDialog(
      context: context,
      builder: (context) => _CalendarDialog(session: session),
    );

class _CalendarDialog extends StatefulWidget {
  final Session session;

  const _CalendarDialog({required this.session});

  @override
  State<_CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<_CalendarDialog> {
  bool? _on;
  bool _busy = false;

  /// Sur le web : lien à ajouter dans Google Agenda.
  String? get _path => widget.session.me?.calendarPath;

  @override
  void initState() {
    super.initState();
    if (CalendarSync.supported) {
      CalendarSync.calendarId().then((id) {
        if (mounted) setState(() => _on = id != null);
      });
    } else {
      _on = _path != null;
    }
  }

  /// Un seul interrupteur : sur Android, les services sont écrits dans
  /// l'agenda Google du téléphone ; sur le web, un lien d'agenda est créé.
  Future<void> _toggle(bool on) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      if (CalendarSync.supported) {
        if (!on) {
          await CalendarSync.disable();
        } else {
          final calendars = await CalendarSync.calendars();
          if (!mounted) return;
          if (calendars == null || calendars.isEmpty) {
            messenger.showSnackBar(SnackBar(content: Text(calendars == null ? t.calendarDenied : t.calendarNone)));
            return;
          }
          // Plusieurs comptes Google : on demande lequel ; sinon le premier.
          final google = [for (final c in calendars) if (c.isGoogle && c.primary) c];
          final choices = google.isNotEmpty ? google : calendars;
          final chosen = choices.length == 1
              ? choices.single.id
              : await showDialog<String>(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text(t.chooseCalendar),
                    children: [
                      for (final c in choices)
                        SimpleDialogOption(
                          onPressed: () => Navigator.pop(context, c.id),
                          child: Text(CalendarSync.label(c)),
                        ),
                    ],
                  ),
                );
          if (chosen == null) return;
          final count = await CalendarSync.enable(widget.session.api, chosen);
          messenger.showSnackBar(SnackBar(content: Text(t.calendarSynced('$count'))));
        }
      } else {
        await widget.session.api.send('PUT', '/me/calendar', body: {'enabled': on});
        await widget.session.refresh();
      }
      if (mounted) setState(() => _on = on);
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final path = _path;
    final webLink = !CalendarSync.supported && _on == true && path != null;
    return AlertDialog(
      title: Text(t.googleCalendar),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: _on ?? false,
          title: Text(t.calendarEnabled),
          subtitle: Text(CalendarSync.supported ? t.calendarOnPhoneHint : t.calendarLinkHint),
          onChanged: _busy || _on == null ? null : _toggle,
        ),
        // Sur le web, Google Agenda doit encore accepter le lien (une fois).
        if (webLink)
          FilledButton.icon(
            onPressed: () => _open(context,
                'https://calendar.google.com/calendar/render?cid=${Uri.encodeComponent(serverUrl(path).replaceFirst(RegExp('^https?'), 'webcal'))}'),
            icon: const Icon(Icons.event),
            label: Text(t.addToGoogle),
          ),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(t.close))],
    );
  }
}

/// Fuseau IANA du téléphone ou de l'ordinateur (`null` si inconnu).
Future<String?> deviceTimezone() async {
  try {
    return (await FlutterTimezone.getLocalTimezone()).identifier;
  } catch (_) {
    return null;
  }
}
