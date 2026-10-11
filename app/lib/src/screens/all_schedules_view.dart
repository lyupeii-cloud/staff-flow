import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';

/// Couleur d'une entreprise dans « Tous mes plannings » (d'après sa place
/// dans la liste des onglets).
Color companyColor(int index) => const [
      Color(0xFF1A8CFC),
      Color(0xFF2BB673),
      Color(0xFFF2994A),
      Color(0xFF9B51E0),
      Color(0xFFEB5757),
      Color(0xFF00A3A3),
      Color(0xFFD4A20B),
      Color(0xFF6D7A8C),
    ][index % 8];

/// « Tous mes plannings » : ses services publiés de toutes ses entreprises,
/// une couleur par entreprise. Deux services de deux entreprises qui se
/// superposent sont marqués d'un « ! » (rien n'est bloqué).
class AllSchedulesView extends StatefulWidget {
  final Session session;

  const AllSchedulesView({super.key, required this.session});

  @override
  State<AllSchedulesView> createState() => _AllSchedulesViewState();
}

class _AllSchedulesViewState extends State<AllSchedulesView> with AutomaticKeepAliveClientMixin {
  var _from = startOfWeek(DateTime.now());
  List<Map<String, dynamic>> _shifts = const [];
  bool _loading = true;
  Localized? _error;
  int _seenSync = 0;

  L10n get t => context.l10n;
  String get loc => context.localeName;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    widget.session.sync.addListener(_onSync);
    _load();
  }

  @override
  void dispose() {
    widget.session.sync.removeListener(_onSync);
    super.dispose();
  }

  void _onSync() {
    if (widget.session.sync.synced != _seenSync) _load();
  }

  Future<void> _load() async {
    _seenSync = widget.session.sync.synced;
    setState(() => _loading = true);
    final from = formatDay(_from), to = formatDay(addDays(_from, 6));
    try {
      final json = await widget.session.sync.read('my-shifts:$from', '/me/shifts?from=$from&to=$to');
      if (!mounted) return;
      setState(() {
        _shifts = [for (final s in json['shifts']) (s as Map).cast<String, dynamic>()];
        _error = null;
      });
    } on OfflineException {
      if (mounted) setState(() => _error = (t) => t.offlineUnavailable);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = e.describe);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _move(int weeks) {
    setState(() => _from = addDays(_from, 7 * weeks));
    _load();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final companies = widget.session.me?.companies ?? const <Membership>[];
    int indexOf(String id) => companies.indexWhere((m) => m.company.id == id);
    final overlaps = _shifts.where((s) => s['overlap'] == true).length;
    final minutes = _shifts.fold<int>(0, (n, s) => n + (s['end'] as int) - (s['start'] as int));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(onPressed: () => _move(-1), icon: const Icon(Icons.chevron_left)),
              Expanded(
                child: Text(t.weekOf(dayLabel(_from, loc)), textAlign: TextAlign.center, style: theme.textTheme.titleSmall),
              ),
              IconButton(onPressed: () => _move(1), icon: const Icon(Icons.chevron_right)),
            ],
          ),
        ),
        // Légende : une couleur par entreprise.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              for (final (i, m) in companies.indexed)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(radius: 6, backgroundColor: companyColor(i)),
                    const SizedBox(width: 4),
                    Text(m.company.name, style: theme.textTheme.bodySmall),
                  ],
                ),
            ],
          ),
        ),
        if (minutes > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
            child: Text(t.yourHours(durationLabel(t, minutes)), style: theme.textTheme.bodySmall),
          ),
        if (overlaps > 0)
          Card(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            color: theme.colorScheme.errorContainer,
            child: ListTile(
              leading: _Bang(),
              title: Text(t.overlapWarning),
            ),
          ),
        if (_loading) const LinearProgressIndicator(minHeight: 2) else const SizedBox(height: 2),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(_error!(t), style: TextStyle(color: theme.colorScheme.error)),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _load,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
              children: [
                for (var i = 0; i < 7; i++) ..._day(addDays(_from, i), indexOf),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _day(DateTime day, int Function(String) indexOf) {
    final theme = Theme.of(context);
    final shifts = _shifts.where((s) => s['day'] == formatDay(day)).toList();
    final today = sameDay(day, DateTime.now());
    final clash = shifts.any((s) => s['overlap'] == true);
    return [
      Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 4),
        child: Row(
          children: [
            Text(
              dayLabel(day, loc),
              style: theme.textTheme.titleSmall?.copyWith(
                color: today ? theme.colorScheme.primary : null,
                fontWeight: today ? FontWeight.bold : null,
              ),
            ),
            if (clash) ...[const SizedBox(width: 8), _Bang(size: 10)],
          ],
        ),
      ),
      if (shifts.isEmpty) Text(t.noShift, style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor)),
      for (final s in shifts)
        Card(
          margin: const EdgeInsets.symmetric(vertical: 3),
          clipBehavior: Clip.antiAlias,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 6, color: companyColor(indexOf(s['companyId'] as String).clamp(0, 999))),
                Expanded(
                  child: ListTile(
                    // Toucher : le planning de l'entreprise, à ce jour-là.
                    onTap: () => widget.session.openDay.value =
                        (companyId: s['companyId'] as String, day: parseDay(s['day'] as String)),
                    trailing: const Icon(Icons.chevron_right),
                    leading: s['overlap'] == true ? Tooltip(message: t.overlapTooltip, child: _Bang()) : null,
                    title: Text('${timeLabel(s['start'] as int)} – ${timeLabel(s['end'] as int)}'
                        '${(s['end'] as int) > 1440 ? ' (+1)' : ''}  ·  ${s['companyName']}'),
                    subtitle: s['positionName'] == null && s['siteName'] == null
                        ? null
                        : Text([s['positionName'], s['siteName']].whereType<String>().join(' · ')),
                  ),
                ),
              ],
            ),
          ),
        ),
    ];
  }
}

/// Le « ! » rouge des chevauchements.
class _Bang extends StatelessWidget {
  final double size;

  const _Bang({this.size = 12});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: size,
      backgroundColor: scheme.error,
      child: Text('!', style: TextStyle(color: scheme.onError, fontWeight: FontWeight.bold, fontSize: size * 1.3)),
    );
  }
}
