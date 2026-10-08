import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';

/// Crée un service ([shift] nul) ou modifie [shift]. Renvoie `true` si le
/// planning a changé.
Future<bool?> showShiftEditor(
  BuildContext context, {
  required Session session,
  required Company company,
  required CompanyData data,
  Shift? shift,
  required DateTime day,
}) => showModalBottomSheet<bool>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) => _ShiftEditor(session: session, company: company, data: data, shift: shift, day: day),
);

enum _Repeat { none, daily, weekly }

enum _End { count, until }

class _ShiftEditor extends StatefulWidget {
  final Session session;
  final Company company;
  final CompanyData data;
  final Shift? shift;
  final DateTime day;

  const _ShiftEditor({
    required this.session,
    required this.company,
    required this.data,
    this.shift,
    required this.day,
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
  late String? _siteId = s?.siteId;
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
  String? _error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final members = widget.data.members;
    final sites = widget.data.sites.where((i) => !i.archived || i.id == _siteId).toList();
    final positions = widget.data.positions.where((i) => !i.archived || i.id == _positionId).toList();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(editing ? 'Modifier le service' : 'Nouveau service', style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            if (editing && s!.seriesId != null) ...[
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(value: false, label: Text('Ce service')),
                  ButtonSegment(value: true, label: Text('Celui-ci et les suivants')),
                ],
                selected: {_series},
                onSelectionChanged: (v) => setState(() => _series = v.first),
              ),
              const SizedBox(height: 12),
            ],
            _label('Jour${_days.length > 1 ? 's' : ''}'),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final d in _days)
                  InputChip(
                    label: Text(dayLabel(d)),
                    onPressed: editing && _series ? null : () => _pickDay(replace: d),
                    onDeleted: !editing && _days.length > 1 ? () => setState(() => _days.remove(d)) : null,
                  ),
                if (!editing)
                  ActionChip(
                    avatar: const Icon(Icons.add, size: 18),
                    label: const Text('Autre jour'),
                    onPressed: () => _pickDay(),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _timeButton('Début', _start, (v) => _start = v)),
                const SizedBox(width: 12),
                Expanded(child: _timeButton('Fin', _end, (v) => _end = v)),
              ],
            ),
            if (_end <= _start) Text('Se termine le lendemain.', style: theme.textTheme.bodySmall),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              initialValue: _userId,
              decoration: const InputDecoration(labelText: 'Personne'),
              items: [
                const DropdownMenuItem(value: null, child: Text('Non attribué')),
                for (final m in members)
                  DropdownMenuItem(value: m.user.id, child: Text('${m.user.name} · ${m.role.label}')),
              ],
              onChanged: (v) => setState(() => _userId = v),
            ),
            if (positions.isNotEmpty)
              DropdownButtonFormField<String?>(
                initialValue: _positionId,
                decoration: const InputDecoration(labelText: 'Poste'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('—')),
                  for (final p in positions) DropdownMenuItem(value: p.id, child: Text(p.name)),
                ],
                onChanged: (v) => setState(() => _positionId = v),
              ),
            if (sites.isNotEmpty)
              DropdownButtonFormField<String?>(
                initialValue: _siteId,
                decoration: const InputDecoration(labelText: 'Site'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('—')),
                  for (final p in sites) DropdownMenuItem(value: p.id, child: Text(p.name)),
                ],
                onChanged: (v) => setState(() => _siteId = v),
              ),
            TextField(
              controller: _note,
              decoration: const InputDecoration(labelText: 'Note (facultatif)'),
            ),
            if (!editing) ..._repeatFields(),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                if (editing)
                  TextButton.icon(
                    onPressed: _saving ? null : _delete,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Supprimer'),
                    style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
                  ),
                const Spacer(),
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
                const SizedBox(width: 8),
                FilledButton(onPressed: _saving ? null : _save, child: const Text('Enregistrer')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _repeatFields() => [
    const SizedBox(height: 16),
    _label('Répétition'),
    SegmentedButton<_Repeat>(
      segments: const [
        ButtonSegment(value: _Repeat.none, label: Text('Aucune')),
        ButtonSegment(value: _Repeat.daily, label: Text('Chaque jour')),
        ButtonSegment(value: _Repeat.weekly, label: Text('Chaque semaine')),
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
              label: Text(weekdayShort[d - 1]),
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
                const Text('Pendant '),
                SizedBox(
                  width: 56,
                  child: TextField(
                    controller: _count,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onTap: () => setState(() => _endKind = _End.count),
                  ),
                ),
                Text(_repeat == _Repeat.daily ? ' jours' : ' semaines'),
              ],
            ),
            Row(
              children: [
                const Radio<_End>(value: _End.until),
                const Text('Jusqu\'au '),
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
                  child: Text(longDate(_until)),
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
      initialDate: replace ?? _days.last,
      firstDate: DateTime(2020),
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
    final api = widget.session.api;
    final companyId = widget.company.id;
    await _run(() async {
      if (editing) {
        final patch = _fields();
        if (!_series && !sameDay(_days.first, s!.day)) patch['day'] = formatDay(_days.first);
        await api.updateShift(companyId, s!.id, patch, series: _series);
      } else {
        await api.createShifts(companyId, {
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
    await _run(() => widget.session.api.deleteShift(widget.company.id, s!.id, series: _series));
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => (_saving = true, _error = null));
    try {
      await action();
      if (mounted) Navigator.pop(context, true);
    } on ApiException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = 'Serveur injoignable.');
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
          title: const Text('Remplacer une personne'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              who('Remplacer', fromId, (v) => fromId = v),
              who('Par', toId, (v) => toId = v),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.date_range),
                label: Text('Du ${dayLabel(range.start)} au ${dayLabel(range.end)}'),
                onPressed: () async {
                  final r = await showDateRangePicker(
                    context: context,
                    initialDateRange: range,
                    firstDate: DateTime(2020),
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
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
            FilledButton(
              onPressed: fromId == null || toId == null || fromId == toId
                  ? null
                  : () async {
                      try {
                        final n = await session.api.replace(
                          company.id,
                          fromUserId: fromId!,
                          toUserId: toId!,
                          from: range.start,
                          to: range.end,
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$n service${n > 1 ? 's' : ''} modifié${n > 1 ? 's' : ''}.'),
                          ),
                        );
                        Navigator.pop(context, true);
                      } on ApiException catch (e) {
                        setState(() => error = e.message);
                      }
                    },
              child: const Text('Remplacer'),
            ),
          ],
        );
      },
    ),
  );
}
