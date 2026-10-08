import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';
import 'shift_editor.dart';
import 'sync_widgets.dart';

enum _Mode { week, month }

/// Planning d'une entreprise, par semaine ou par mois. Les responsables
/// créent et modifient les services puis publient ; les salariés voient
/// la dernière version publiée.
class PlanningView extends StatefulWidget {
  final Session session;
  final Membership membership;
  final CompanyData data;

  const PlanningView({super.key, required this.session, required this.membership, required this.data});

  @override
  State<PlanningView> createState() => _PlanningViewState();
}

class _PlanningViewState extends State<PlanningView> {
  var _mode = _Mode.week;
  var _anchor = dateOnly(DateTime.now());
  late var _selected = _anchor;
  late bool _mineOnly = !widget.membership.role.canManage;

  List<Shift> _shifts = const [];
  int _pending = 0;
  bool _loading = true;
  Localized? _error;

  L10n get t => context.l10n;
  String get loc => context.localeName;
  Company get company => widget.membership.company;
  bool get canEdit => widget.membership.role.canManage && !company.readOnly;
  String get myId => widget.session.me!.user.id;

  DateTime get _from => _mode == _Mode.week ? startOfWeek(_anchor) : startOfMonth(_anchor);
  DateTime get _to => _mode == _Mode.week ? addDays(_from, 6) : endOfMonth(_anchor);

  /// Hors connexion : planning tiré des dernières données gardées.
  bool _stale = false;
  int _seenSync = 0;
  int _seenQueue = 0;

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

  /// Recharge quand des modifications en attente sont parties ou ont été
  /// ajoutées (les modifications en attente s'affichent par-dessus).
  void _onSync() {
    final sync = widget.session.sync;
    if (sync.synced != _seenSync || sync.queue.length != _seenQueue) _load();
  }

  Future<void> _load() async {
    final sync = widget.session.sync;
    _seenSync = sync.synced;
    _seenQueue = sync.queue.length;
    setState(() => _loading = true);
    try {
      final r = await sync.shifts(company.id, _from, _to);
      if (!mounted) return;
      setState(() {
        _shifts = r.shifts;
        _pending = r.pending;
        _stale = r.stale;
        _error = null;
      });
    } on OfflineException {
      if (mounted) setState(() => _error = (t) => t.offlineUnavailable);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = e.describe);
    } catch (_) {
      if (mounted) setState(() => _error = (t) => t.serverUnreachable);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _move(int direction) {
    setState(() {
      _anchor = _mode == _Mode.week
          ? addDays(_anchor, 7 * direction)
          : DateTime(_anchor.year, _anchor.month + direction, 1);
      _selected = _mode == _Mode.week ? startOfWeek(_anchor) : _anchor;
    });
    _load();
  }

  List<Shift> get _visible => _mineOnly ? _shifts.where((s) => s.userId == myId).toList() : _shifts;

  List<Shift> _onDay(DateTime d) => _visible.where((s) => sameDay(s.day, d)).toList();

  String get _title => _mode == _Mode.week ? t.weekOf(dayLabel(_from, loc)) : monthTitle(_anchor, loc);

  Future<void> _publish() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final r = await widget.session.sync.publish(company.id);
      messenger.showSnackBar(
        SnackBar(content: Text(r == null ? t.savedOffline : t.changesPublished(r['published'] as int))),
      );
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
    _load();
  }

  Future<void> _openEditor({Shift? shift, DateTime? day}) async {
    if (shift != null && shift.isLocal) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.pendingNotEditable)));
      return;
    }
    final changed = await showShiftEditor(
      context,
      session: widget.session,
      company: company,
      data: widget.data,
      shift: shift,
      day: day ?? _selected,
    );
    if (changed == true) _load();
  }

  Future<void> _replace() async {
    final changed = await showReplaceDialog(
      context,
      session: widget.session,
      company: company,
      data: widget.data,
      from: _from,
      to: _to,
    );
    if (changed == true) _load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final myMinutes = _shifts
        .where((s) => s.userId == myId && s.status != ShiftStatus.deleted)
        .fold(0, (t, s) => t + s.minutes);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: canEdit
          ? FloatingActionButton.extended(
              onPressed: () => _openEditor(),
              icon: const Icon(Icons.add),
              label: Text(t.shiftButton),
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(onPressed: () => _move(-1), icon: const Icon(Icons.chevron_left)),
                Expanded(
                  child: Text(_title, textAlign: TextAlign.center, style: theme.textTheme.titleSmall),
                ),
                IconButton(onPressed: () => _move(1), icon: const Icon(Icons.chevron_right)),
                PopupMenuButton<String>(
                  tooltip: t.display,
                  onSelected: (v) {
                    switch (v) {
                      case 'week' || 'month':
                        setState(() => _mode = v == 'week' ? _Mode.week : _Mode.month);
                        _load();
                      case 'today':
                        setState(() => _anchor = _selected = dateOnly(DateTime.now()));
                        _load();
                      case 'mine':
                        setState(() => _mineOnly = !_mineOnly);
                      case 'replace':
                        _replace();
                      case 'history':
                        showHistorySheet(
                          context,
                          session: widget.session,
                          company: company,
                          data: widget.data,
                        );
                    }
                  },
                  itemBuilder: (_) => [
                    CheckedPopupMenuItem(value: 'week', checked: _mode == _Mode.week, child: Text(t.week)),
                    CheckedPopupMenuItem(value: 'month', checked: _mode == _Mode.month, child: Text(t.month)),
                    PopupMenuItem(value: 'today', child: Text(t.today)),
                    CheckedPopupMenuItem(value: 'mine', checked: _mineOnly, child: Text(t.onlyMine)),
                    if (canEdit) PopupMenuItem(value: 'replace', child: Text(t.replacePersonMenu)),
                    if (canEdit) PopupMenuItem(value: 'history', child: Text(t.recentChanges)),
                  ],
                ),
              ],
            ),
          ),
          if (_stale)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Row(
                children: [
                  const Icon(Icons.cloud_off, size: 16, color: Colors.orange),
                  const SizedBox(width: 6),
                  Expanded(child: Text(t.offlineCached, style: theme.textTheme.bodySmall)),
                ],
              ),
            ),
          if (canEdit && _pending > 0)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              color: theme.colorScheme.tertiaryContainer,
              child: ListTile(
                leading: const Icon(Icons.edit_calendar),
                title: Text(t.pendingChanges(_pending)),
                subtitle: Text(t.pendingHint),
                trailing: FilledButton(onPressed: _publish, child: Text(t.publish)),
              ),
            ),
          if (myMinutes > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Text(t.yourHours(durationLabel(t, myMinutes)), style: theme.textTheme.bodySmall),
            ),
          if (_loading) const LinearProgressIndicator(minHeight: 2) else const SizedBox(height: 2),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(_error!(t), style: TextStyle(color: theme.colorScheme.error)),
            ),
          Expanded(
            child: RefreshIndicator(onRefresh: _load, child: _mode == _Mode.week ? _weekList() : _month()),
          ),
        ],
      ),
    );
  }

  Widget _weekList() => ListView(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
    children: [for (var i = 0; i < 7; i++) ..._daySection(addDays(_from, i))],
  );

  List<Widget> _daySection(DateTime day) {
    final theme = Theme.of(context);
    final shifts = _onDay(day);
    final today = sameDay(day, DateTime.now());
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
            const Spacer(),
            if (canEdit)
              IconButton(
                visualDensity: VisualDensity.compact,
                tooltip: t.addShiftThisDay,
                onPressed: () => _openEditor(day: day),
                icon: const Icon(Icons.add, size: 20),
              ),
          ],
        ),
      ),
      if (shifts.isEmpty)
        Text(t.noShift, style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor)),
      for (final s in shifts) _shiftCard(s),
    ];
  }

  Widget _shiftCard(Shift s) {
    final theme = Theme.of(context);
    final d = widget.data;
    final who = s.userId == null ? t.unassigned : (d.memberName(s.userId) ?? t.formerMember);
    final details = [
      d.positionName(s.positionId),
      d.siteName(s.siteId),
      s.note,
    ].whereType<String>().where((x) => x.isNotEmpty).join(' · ');
    final deleted = s.status == ShiftStatus.deleted;
    final badge = s.pending
        ? t.pendingBadge
        : switch (s.status) {
            ShiftStatus.draft => t.statusDraft,
            ShiftStatus.modified => t.statusModified,
            ShiftStatus.deleted => t.statusDeleted,
            ShiftStatus.published => null,
          };
    final mine = s.userId == myId;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3),
      color: mine ? theme.colorScheme.primaryContainer : null,
      shape: badge == null
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.colorScheme.tertiary, style: BorderStyle.solid),
            ),
      child: ListTile(
        onTap: canEdit && !deleted ? () => _openEditor(shift: s) : null,
        title: Text(
          '${timeLabel(s.start)} – ${timeLabel(s.end)}${s.end > 1440 ? ' (+1)' : ''}  ·  $who',
          style: deleted ? const TextStyle(decoration: TextDecoration.lineThrough) : null,
        ),
        subtitle: details.isEmpty ? null : Text(details),
        trailing: badge == null
            ? (s.seriesId != null ? const Icon(Icons.repeat, size: 18) : null)
            : Chip(
                label: Text(badge),
                visualDensity: VisualDensity.compact,
                labelStyle: theme.textTheme.labelSmall,
              ),
      ),
    );
  }

  Widget _month() {
    final theme = Theme.of(context);
    final first = startOfWeek(_from);
    final weeks = ((endOfMonth(_anchor).difference(first).inDays + 1) / 7).ceil();
    final selected = _onDay(_selected);
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 96),
      children: [
        Row(
          children: [
            for (var wd = 1; wd <= 7; wd++)
              Expanded(
                child: Center(child: Text(weekdayLetter(wd, loc), style: theme.textTheme.labelSmall)),
              ),
          ],
        ),
        for (var w = 0; w < weeks; w++)
          Row(children: [for (var i = 0; i < 7; i++) Expanded(child: _monthCell(addDays(first, w * 7 + i)))]),
        const Divider(height: 24),
        Text(dayLabel(_selected, loc), style: theme.textTheme.titleSmall),
        if (selected.isEmpty)
          Text(t.noShift, style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor)),
        for (final s in selected) _shiftCard(s),
      ],
    );
  }

  Widget _monthCell(DateTime day) {
    final theme = Theme.of(context);
    final inMonth = day.month == _anchor.month;
    final count = inMonth ? _onDay(day).length : 0;
    final isSelected = sameDay(day, _selected);
    final today = sameDay(day, DateTime.now());
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: inMonth ? () => setState(() => _selected = day) : null,
      child: Container(
        height: 48,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primaryContainer : null,
          borderRadius: BorderRadius.circular(8),
          border: today ? Border.all(color: theme.colorScheme.primary) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${day.day}',
              style: TextStyle(color: inMonth ? null : theme.disabledColor.withValues(alpha: 0.3)),
            ),
            if (count > 0)
              Text(
                count > 3 ? '•••+' : '•' * count,
                style: TextStyle(color: theme.colorScheme.primary, height: 1),
              ),
          ],
        ),
      ),
    );
  }
}
