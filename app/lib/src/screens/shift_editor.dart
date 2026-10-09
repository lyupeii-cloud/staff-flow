import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';
import 'sync_widgets.dart';

/// Crée un service ([shift] nul) ou modifie [shift]. Renvoie `true` si le
/// planning a changé.
Future<bool?> showShiftEditor(
  BuildContext context, {
  required Session session,
  required Company company,
  required CompanyData data,
  Shift? shift,
  required DateTime day,
  Set<String>? onlySites,
  List<StaffRequest> absences = const [],
}) => showModalBottomSheet<bool>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) =>
      _ShiftEditor(
          session: session, company: company, data: data, shift: shift, day: day, onlySites: onlySites, absences: absences),
);

enum _Repeat { none, daily, weekly }

enum _End { count, until }

class _ShiftEditor extends StatefulWidget {
  final Session session;
  final Company company;
  final CompanyData data;
  final Shift? shift;
  final DateTime day;

  /// Responsable de site : sites qu'il peut choisir.
  final Set<String>? onlySites;

  /// Congés et indisponibilités validés : signalés par « ! » dans le choix
  /// de la personne (rien n'est bloqué).
  final List<StaffRequest> absences;

  const _ShiftEditor({
    required this.session,
    required this.company,
    required this.data,
    this.shift,
    required this.day,
    this.onlySites,
    this.absences = const [],
  });

  @override
  State<_ShiftEditor> createState() => _ShiftEditorState();
}

class _ShiftEditorState extends State<_ShiftEditor> {
  late final Shift? s = widget.shift;
  bool get editing => s != null;

  late List<DateTime> _days = [s?.day ?? widget.day];
  late int _start = s?.start ?? 9 * 60;
  late int _end = (s?.end ?? 17 * 60) % 1440;
  late String? _userId = s?.userId;
  // Responsable de site : un de ses sites, obligatoirement.
  late String? _siteId = s?.siteId ?? widget.onlySites?.firstOrNull;
  late String? _positionId = s?.positionId;
  late final _note = TextEditingController(text: s?.note);

  var _repeat = _Repeat.none;
  late final Set<int> _weekdays = {widget.day.weekday};
  var _endKind = _End.count;
  final _count = TextEditingController(text: '4');
  late DateTime _until = addDays(widget.day, 27);

  /// Modification : toute la suite de la série plutôt que ce service seul.
  var _series = false;

  bool _saving = false;
  Localized? _error;

  L10n get t => context.l10n;
  String get loc => context.localeName;

  /// Personnes déjà en service dans une autre entreprise sur ce créneau
  /// (le serveur ne dit rien de plus).
  Set<String> _busy = const {};
  String? _busyChecked;

  /// Relit [_busy] quand les jours ou l'horaire changent.
  void _checkBusy() {
    final key = '${_days.map(formatDay).join(',')}|$_start|$_end';
    if (key == _busyChecked) return;
    _busyChecked = key;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final r = await widget.session.api.send('GET',
            '/companies/${widget.company.id}/busy?days=${_days.map(formatDay).join(',')}&start=$_start&end=$_end');
        if (mounted && key == _busyChecked) setState(() => _busy = {for (final u in r['userIds']) u as String});
      } catch (_) {
        // Hors connexion : pas d'indication.
      }
    });
  }

  /// Absence validée de [userId] un des jours choisis.
  bool _absent(String? userId) =>
      userId != null && widget.absences.any((a) => a.requesterId == userId && _days.any(a.covers));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final members = widget.data.members;
    _checkBusy();
    final only = widget.onlySites;
    final sites = widget.data.sites
        .where((i) => (!i.archived || i.id == _siteId) && (only == null || only.contains(i.id)))
        .toList();
    final positions = widget.data.positions.where((i) => !i.archived || i.id == _positionId).toList();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text(editing ? t.editShift : t.newShift, style: theme.textTheme.titleLarge)),
                if (editing)
                  TextButton.icon(
                    onPressed: () => showHistorySheet(context,
                        session: widget.session, company: widget.company, data: widget.data, shiftId: s!.id),
                    icon: const Icon(Icons.history, size: 18),
                    label: Text(t.history),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (editing && s!.seriesId != null) ...[
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment(value: false, label: Text(t.thisShift)),
                  ButtonSegment(value: true, label: Text(t.thisAndFollowing)),
                ],
                selected: {_series},
                onSelectionChanged: (v) => setState(() => _series = v.first),
              ),
              const SizedBox(height: 12),
            ],
            _label(t.daysLabel(_days.length)),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final d in _days)
                  InputChip(
                    label: Text(dayLabel(d, loc)),
                    onPressed: editing && _series ? null : () => _pickDay(replace: d),
                    onDeleted: !editing && _days.length > 1 ? () => setState(() => _days.remove(d)) : null,
                  ),
                if (!editing)
                  ActionChip(
                    avatar: const Icon(Icons.add, size: 18),
                    label: Text(t.otherDay),
                    onPressed: () => _pickDay(),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _timeButton(t.start, _start, (v) => _start = v)),
                const SizedBox(width: 12),
                Expanded(child: _timeButton(t.end, _end, (v) => _end = v)),
              ],
            ),
            if (_end <= _start) Text(t.endsNextDay, style: theme.textTheme.bodySmall),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              initialValue: _userId,
              decoration: InputDecoration(labelText: t.person),
              items: [
                DropdownMenuItem(value: null, child: Text(t.unassigned)),
                for (final m in members)
                  DropdownMenuItem(
                    value: m.user.id,
                    child: Text(
                        '${_absent(m.user.id) || _busy.contains(m.user.id) ? '! ' : ''}${m.user.name} · ${m.role.label(t)}',
                        style: _absent(m.user.id) || _busy.contains(m.user.id)
                            ? TextStyle(color: theme.colorScheme.error)
                            : null),
                  ),
              ],
              onChanged: (v) => setState(() => _userId = v),
            ),
            if (_absent(_userId))
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('! ${t.absentThatDay}', style: TextStyle(color: theme.colorScheme.error)),
              ),
            if (_busy.contains(_userId))
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('! ${t.busyElsewhere}', style: TextStyle(color: theme.colorScheme.error)),
              ),
            if (positions.isNotEmpty)
              DropdownButtonFormField<String?>(
                initialValue: _positionId,
                decoration: InputDecoration(labelText: t.position),
                items: [
                  const DropdownMenuItem(value: null, child: Text('—')),
                  for (final p in positions) DropdownMenuItem(value: p.id, child: Text(p.name)),
                ],
                onChanged: (v) => setState(() => _positionId = v),
              ),
            if (sites.isNotEmpty)
              DropdownButtonFormField<String?>(
                initialValue: _siteId,
                decoration: InputDecoration(labelText: t.site),
                items: [
                  if (only == null) const DropdownMenuItem(value: null, child: Text('—')),
                  for (final p in sites) DropdownMenuItem(value: p.id, child: Text(p.name)),
                ],
                onChanged: (v) => setState(() => _siteId = v),
              ),
            TextField(
              controller: _note,
              decoration: InputDecoration(labelText: t.noteOptional),
            ),
            if (!editing) ..._repeatFields(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!(t), style: TextStyle(color: theme.colorScheme.error)),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                if (editing)
                  TextButton.icon(
                    onPressed: _saving ? null : _delete,
                    icon: const Icon(Icons.delete_outline),
                    label: Text(t.delete),
                    style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
                  ),
                const Spacer(),
                TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
                const SizedBox(width: 8),
                FilledButton(onPressed: _saving ? null : _save, child: Text(t.save)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _repeatFields() => [
    const SizedBox(height: 16),
    _label(t.repetition),
    SegmentedButton<_Repeat>(
      segments: [
        ButtonSegment(value: _Repeat.none, label: Text(t.repeatNone)),
        ButtonSegment(value: _Repeat.daily, label: Text(t.repeatDaily)),
        ButtonSegment(value: _Repeat.weekly, label: Text(t.repeatWeekly)),
      ],
      selected: {_repeat},
      onSelectionChanged: (v) => setState(() {
        _repeat = v.first;
        _weekdays
          ..clear()
          ..addAll(_days.map((d) => d.weekday));
      }),
    ),
    if (_repeat == _Repeat.weekly) ...[
      const SizedBox(height: 8),
      Wrap(
        spacing: 4,
        children: [
          for (var d = 1; d <= 7; d++)
            FilterChip(
              label: Text(weekdayShort(d, loc)),
              selected: _weekdays.contains(d),
              onSelected: (on) => setState(() => on ? _weekdays.add(d) : _weekdays.remove(d)),
            ),
        ],
      ),
    ],
    if (_repeat != _Repeat.none) ...[
      const SizedBox(height: 8),
      RadioGroup<_End>(
        groupValue: _endKind,
        onChanged: (v) => setState(() => _endKind = v!),
        child: Column(
          children: [
            Row(
              children: [
                const Radio<_End>(value: _End.count),
                Text(t.repeatForPrefix),
                SizedBox(
                  width: 56,
                  child: TextField(
                    controller: _count,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onTap: () => setState(() => _endKind = _End.count),
                  ),
                ),
                Text(_repeat == _Repeat.daily ? t.repeatDaysSuffix : t.repeatWeeksSuffix),
              ],
            ),
            Row(
              children: [
                const Radio<_End>(value: _End.until),
                Text(t.repeatUntilPrefix),
                TextButton(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _until,
                      firstDate: _days.first,
                      lastDate: addDays(_days.first, 366),
                    );
                    if (d != null) setState(() => (_until = d, _endKind = _End.until));
                  },
                  child: Text(longDate(_until, loc)),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ];

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: Theme.of(context).textTheme.labelLarge),
  );

  Widget _timeButton(String label, int minutes, void Function(int) set) => OutlinedButton(
    onPressed: () async {
      final t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60),
        builder: (context, child) =>
            MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
      );
      if (t != null) setState(() => set(t.hour * 60 + t.minute));
    },
    child: Text('$label  ${timeLabel(minutes)}'),
  );

  Future<void> _pickDay({DateTime? replace}) async {
    final d = await showDatePicker(
      context: context,
      initialDate: _notBefore(replace ?? _days.last, editableFrom()),
      firstDate: editableFrom(),
      lastDate: DateTime(DateTime.now().year + 3),
    );
    if (d == null) return;
    setState(() {
      if (replace != null) _days.remove(replace);
      if (!_days.any((x) => sameDay(x, d))) _days = [..._days, d]..sort();
    });
  }

  Map<String, Object?> _fields() => {
    'start': _start,
    'end': _end,
    'userId': _userId,
    'siteId': _siteId,
    'positionId': _positionId,
    'note': _note.text.trim().isEmpty ? null : _note.text.trim(),
  };

  Future<void> _save() async {
    final sync = widget.session.sync;
    final companyId = widget.company.id;
    await _run(() async {
      if (editing) {
        final patch = _fields();
        if (!_series && !sameDay(_days.first, s!.day)) patch['day'] = formatDay(_days.first);
        return sync.updateShift(companyId, s!, patch, series: _series);
      } else {
        return sync.createShifts(companyId, {
          ..._fields(),
          'days': [for (final d in _days) formatDay(d)],
          if (_repeat != _Repeat.none)
            'repeat': {
              'freq': _repeat == _Repeat.daily ? 'daily' : 'weekly',
              if (_repeat == _Repeat.weekly) 'weekdays': _weekdays.toList()..sort(),
              if (_endKind == _End.count) 'count': int.tryParse(_count.text) ?? 0,
              if (_endKind == _End.until) 'until': formatDay(_until),
            },
        });
      }
    });
  }

  Future<void> _delete() async {
    await _run(() => widget.session.sync.deleteShift(widget.company.id, s!, series: _series));
  }

  /// [action] renvoie la réponse du serveur, ou `null` si la modification a
  /// été gardée sur l'appareil faute de réseau (elle partira plus tard).
  Future<void> _run(Future<dynamic> Function() action) async {
    setState(() => (_saving = true, _error = null));
    try {
      final result = await action();
      if (result == null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.savedOffline)));
      }
      if (mounted) Navigator.pop(context, true);
    } on ApiException catch (e) {
      setState(() => _error = e.describe);
    } catch (_) {
      setState(() => _error = (t) => t.serverUnreachable);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

/// Remplace une personne par une autre sur ses services d'une période.
Future<bool?> showReplaceDialog(
  BuildContext context, {
  required Session session,
  required Company company,
  required CompanyData data,
  required DateTime from,
  required DateTime to,
}) {
  final t = context.l10n;
  final loc = context.localeName;
  String? fromId, toId;
  var range = DateTimeRange(start: from, end: to);
  String? error;
  return showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        DropdownButtonFormField<String> who(String label, String? value, void Function(String?) set) =>
            DropdownButtonFormField<String>(
              initialValue: value,
              decoration: InputDecoration(labelText: label),
              items: [
                for (final m in data.members) DropdownMenuItem(value: m.user.id, child: Text(m.user.name)),
              ],
              onChanged: (v) => setState(() => set(v)),
            );
        return AlertDialog(
          title: Text(t.replacePersonTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              who(t.replaceFrom, fromId, (v) => fromId = v),
              who(t.replaceBy, toId, (v) => toId = v),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.date_range),
                label: Text(t.dateRange(dayLabel(range.start, loc), dayLabel(range.end, loc))),
                onPressed: () async {
                  final r = await showDateRangePicker(
                    context: context,
                    initialDateRange: DateTimeRange(
                        start: _notBefore(range.start, editableFrom()),
                        end: _notBefore(range.end, editableFrom())),
                    firstDate: editableFrom(),
                    lastDate: DateTime(DateTime.now().year + 3),
                  );
                  if (r != null) setState(() => range = r);
                },
              ),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
            FilledButton(
              onPressed: fromId == null || toId == null || fromId == toId
                  ? null
                  : () async {
                      try {
                        final r = await session.sync.replace(company.id, {
                          'fromUserId': fromId!,
                          'toUserId': toId!,
                          'from': formatDay(range.start),
                          'to': formatDay(range.end),
                        });
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(r == null ? t.savedOffline : t.shiftsChanged(r['replaced'] as int)),
                          ),
                        );
                        Navigator.pop(context, true);
                      } on ApiException catch (e) {
                        setState(() => error = e.describe(t));
                      }
                    },
              child: Text(t.replaceButton),
            ),
          ],
        );
      },
    ),
  );
}

/// Le calendrier refuse une date initiale avant la première date permise.
DateTime _notBefore(DateTime d, DateTime first) => d.isBefore(first) ? first : d;
