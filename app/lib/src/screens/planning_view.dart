import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';
import 'requests_view.dart';
import 'shift_editor.dart';
import 'sync_widgets.dart';
import 'tools_widgets.dart';

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

  /// Congés et indisponibilités validés de la période.
  List<StaffRequest> _absences = const [];

  /// Alertes légales de la période (responsables) : avertissements.
  List<Map<String, dynamic>> _alerts = const [];

  Future<List<Map<String, dynamic>>> _loadAlerts() async {
    if (!canEdit || company.legalRules == null) return const [];
    try {
      final json = await widget.session.api
          .send('GET', '/companies/${company.id}/alerts?from=${formatDay(_from)}&to=${formatDay(_to)}');
      return [for (final a in json['alerts']) (a as Map).cast<String, dynamic>()];
    } catch (_) {
      return _alerts;
    }
  }

  /// Alertes d'un service : celles de son jour, et celle de sa semaine.
  List<Map<String, dynamic>> _alertsFor(Shift s) => [
        for (final a in _alerts)
          if (a['userId'] == s.userId &&
              (a['day'] == formatDay(s.day) ||
                  (a['kind'] == 'week' && sameDay(startOfWeek(parseDay(a['day'])), startOfWeek(s.day)))))
            a
      ];

  void _showAlerts() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              Text(t.legalAlerts, style: Theme.of(context).textTheme.titleLarge),
              Text(t.legalAlertsHint, style: Theme.of(context).textTheme.bodySmall),
              for (final a in _alerts)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.warning_amber, color: Colors.orange),
                  title: Text(legalAlertText(t, a, widget.data)),
                  subtitle: Text(dayLabel(parseDay(a['day']), loc)),
                ),
            ],
          ),
        ),
      );

  /// Demandes en attente (échanges, congés, indisponibilités) : signalées
  /// par une icône qui ouvre la demande.
  List<StaffRequest> _requests = const [];
  int _pending = 0;
  bool _loading = true;
  Localized? _error;

  L10n get t => context.l10n;
  String get loc => context.localeName;
  Company get company => widget.membership.company;
  bool get canEdit => widget.membership.role.canManage && !company.readOnly;
  String get myId => widget.session.me!.user.id;

  DateTime get _from => _mode == _Mode.week ? startOfWeek(_anchor) : startOfMonth(_anchor);
  DateTime get _to => _mode == _Mode.week ? addDays(_from, 7 * (1 + _extraWeeks) - 1) : endOfMonth(_anchor);

  /// Vue par semaine : semaines ajoutées en faisant défiler vers le bas
  /// (8 semaines au plus à la fois).
  int _extraWeeks = 0;
  final _weekScroll = ScrollController();

  void _onWeekScroll() {
    if (_mode != _Mode.week || _loading || _extraWeeks >= 7) return;
    if (_weekScroll.position.extentAfter < 200) {
      setState(() => _extraWeeks++);
      _load();
    }
  }

  /// Hors connexion : planning tiré des dernières données gardées.
  bool _stale = false;
  int _seenSync = 0;
  int _seenQueue = 0;

  @override
  void initState() {
    super.initState();
    widget.session.sync.addListener(_onSync);
    _weekScroll.addListener(_onWeekScroll);
    _load();
  }

  @override
  void dispose() {
    widget.session.sync.removeListener(_onSync);
    _weekScroll.dispose();
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
      // En parallèle : le serveur est loin (chaque aller-retour compte).
      final absencesF = _loadAbsences(), requestsF = _loadRequests(), alertsF = _loadAlerts();
      final r = await sync.shifts(company.id, _from, _to);
      final absences = await absencesF;
      final requests = await requestsF;
      final alerts = await alertsF;
      if (!mounted) return;
      setState(() {
        _alerts = alerts;
        _shifts = r.shifts;
        _absences = absences;
        _requests = requests;
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

  Future<List<StaffRequest>> _loadAbsences() async {
    final from = formatDay(_from), to = formatDay(_to);
    try {
      final json = await widget.session.sync
          .read('absences:${company.id}:$from:$to', '/companies/${company.id}/absences?from=$from&to=$to');
      return [for (final a in json['absences']) StaffRequest.fromJson(a)];
    } catch (_) {
      return _absences;
    }
  }

  Future<List<StaffRequest>> _loadRequests() async {
    try {
      final json = await widget.session.sync
          .read('requests-pending:${company.id}', '/companies/${company.id}/requests?pending=1');
      return [for (final r in json['requests']) StaffRequest.fromJson(r)];
    } catch (_) {
      return _requests;
    }
  }

  void _openRequest(StaffRequest r) =>
      widget.session.openRequest.value = (companyId: company.id, requestId: r.id);

  /// Icône d'une demande en attente : la touche ouvre la demande.
  Widget _requestIcon(StaffRequest r) => IconButton(
        visualDensity: VisualDensity.compact,
        tooltip: t.pendingRequestTooltip,
        onPressed: () => _openRequest(r),
        icon: Icon(Icons.pending_actions, size: 20, color: Theme.of(context).colorScheme.tertiary),
      );

  Future<void> _discardAll() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(t.discardConfirm('$_pending')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.discardAll)),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final r = await widget.session.sync.discard(company.id);
      messenger.showSnackBar(SnackBar(
          content: Text(r == null ? t.savedOffline : t.changesDiscarded('${r['discarded']}'))));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
    _load();
  }

  Future<void> _revert(Shift s) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await widget.session.sync.revert(company.id, s.id);
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
    _load();
  }

  /// La même personne a un autre service qui chevauche celui-ci.
  bool _doubleBooked(Shift s) {
    if (s.userId == null || s.status == ShiftStatus.deleted) return false;
    final start = s.day.millisecondsSinceEpoch ~/ 60000 + s.start, end = start + s.minutes;
    return _shifts.any((o) {
      if (o.id == s.id || o.userId != s.userId || o.status == ShiftStatus.deleted) return false;
      final os = o.day.millisecondsSinceEpoch ~/ 60000 + o.start;
      return os < end && start < os + o.minutes;
    });
  }

  List<StaffRequest> _absentOn(DateTime day) => _absences.where((a) => a.covers(day)).toList();

  bool _isAbsent(String? userId, DateTime day) =>
      userId != null && _absences.any((a) => a.requesterId == userId && a.covers(day));

  /// Salarié : proposer un de ses services publiés à venir.
  Future<void> _offer(Shift s) async {
    final sent = await showSwapOffer(context,
        session: widget.session, membership: widget.membership, data: widget.data, shift: s);
    if (sent == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.requestSent)));
    }
  }

  void _move(int direction) {
    setState(() {
      _extraWeeks = 0;
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
      onlySites: widget.membership.managedSites,
      absences: _absences,
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
                        setState(() {
                          _mode = v == 'week' ? _Mode.week : _Mode.month;
                          _extraWeeks = 0;
                        });
                        _load();
                      case 'today':
                        setState(() {
                          _anchor = _selected = dateOnly(DateTime.now());
                          _extraWeeks = 0;
                        });
                        _load();
                      case 'mine':
                        setState(() => _mineOnly = !_mineOnly);
                      case 'replace':
                        _replace();
                      case 'totals':
                        showTotalsSheet(context, session: widget.session, membership: widget.membership, from: _from, to: _to);
                      case 'print':
                        choosePrint(context, widget.session, widget.membership, _from, _to);
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
                    if (widget.membership.role.canManage) PopupMenuItem(value: 'totals', child: Text(t.hoursTotals)),
                    PopupMenuItem(value: 'print', child: Text(t.printPdf)),
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
          if (canEdit && _pending > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _discardAll,
                  icon: const Icon(Icons.undo, size: 18),
                  label: Text(t.discardAll),
                ),
              ),
            ),
          if (_alerts.isNotEmpty)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              color: Colors.orange.withValues(alpha: 0.15),
              child: ListTile(
                dense: true,
                leading: const Icon(Icons.warning_amber, color: Colors.orange),
                title: Text(t.legalAlertsCount('${_alerts.length}')),
                trailing: const Icon(Icons.chevron_right),
                onTap: _showAlerts,
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
    controller: _weekScroll,
    physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
    children: [
      for (var i = 0; i < 7 * (1 + _extraWeeks); i++) ...[
        // Début d'une semaine ajoutée en défilant.
        if (i > 0 && i % 7 == 0)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(t.weekOf(dayLabel(addDays(_from, i), loc)), style: Theme.of(context).textTheme.labelLarge),
              ),
              const Expanded(child: Divider()),
            ]),
          ),
        ..._daySection(addDays(_from, i)),
      ],
      if (_extraWeeks < 7)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: Icon(Icons.keyboard_double_arrow_down, color: Theme.of(context).disabledColor)),
        ),
    ],
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
            if (canEdit && !isEditableDay(day))
              Tooltip(
                message: t.readOnlyPastDays,
                triggerMode: TooltipTriggerMode.tap,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.lock_outline, size: 18, color: theme.disabledColor),
                ),
              )
            else if (canEdit)
              IconButton(
                visualDensity: VisualDensity.compact,
                tooltip: t.addShiftThisDay,
                onPressed: () => _openEditor(day: day),
                icon: const Icon(Icons.add, size: 20),
              ),
          ],
        ),
      ),
      for (final a in _absentOn(day))
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            children: [
              Icon(requestIcon(a.kind), size: 16, color: theme.colorScheme.tertiary),
              const SizedBox(width: 6),
              Expanded(
                child: Text('${a.requesterName} · ${requestKindLabel(t, a.kind)}',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.tertiary)),
              ),
            ],
          ),
        ),
      for (final r in _requests.where((r) => r.kind != RequestKind.swap && r.covers(day)))
        Row(
          children: [
            Expanded(
              child: Text('${r.requesterName} · ${requestKindLabel(t, r.kind)} · ${t.statusPendingManager}',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.tertiary)),
            ),
            _requestIcon(r),
          ],
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
    final request = _requests.where((r) => r.shiftId == s.id).firstOrNull;
    final legal = deleted ? const <Map<String, dynamic>>[] : _alertsFor(s);
    final revertable = canEdit && badge != null && !s.pending && widget.membership.canEditSite(s.siteId);
    final absent = !deleted && (_isAbsent(s.userId, s.day) || _doubleBooked(s));
    final canOffer = !canEdit && mine && !s.pending && s.status == ShiftStatus.published &&
        !dateOnly(s.day).isBefore(dateOnly(DateTime.now())) && !company.readOnly;
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
        onTap: canEdit && !deleted
            ? () => !widget.membership.canEditSite(s.siteId)
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.notYourSite)))
                : isEditableDay(s.day)
                    ? _openEditor(shift: s)
                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.readOnlyPastDays)))
            : canOffer
                ? () => request != null ? _openRequest(request) : _offer(s)
                : null,
        leading: absent
            ? Tooltip(
                message: _doubleBooked(s) ? t.busyHere : t.absentThatDay,
                triggerMode: TooltipTriggerMode.tap,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: theme.colorScheme.error,
                  child: Text('!', style: TextStyle(color: theme.colorScheme.onError, fontWeight: FontWeight.bold)),
                ),
              )
            : null,
        title: Text(
          '${timeLabel(s.start)} – ${timeLabel(s.end)}${s.end > 1440 ? ' (+1)' : ''}  ·  $who',
          style: deleted ? const TextStyle(decoration: TextDecoration.lineThrough) : null,
        ),
        subtitle: details.isEmpty ? null : Text(details),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ?(request == null ? null : _requestIcon(request)),
            if (legal.isNotEmpty)
              Tooltip(
                message: legal.map((a) => legalAlertText(t, a, widget.data)).join('\n'),
                triggerMode: TooltipTriggerMode.tap,
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.warning_amber, size: 20, color: Colors.orange),
                ),
              ),
            if (badge == null)
              ?(canOffer && request == null
                  ? Tooltip(message: t.proposeSwap, child: const Icon(Icons.swap_horiz, size: 18))
                  : s.seriesId != null
                      ? const Icon(Icons.repeat, size: 18)
                      : null)
            else
              Chip(
                label: Text(badge),
                visualDensity: VisualDensity.compact,
                labelStyle: theme.textTheme.labelSmall,
              ),
            if (revertable)
              IconButton(
                visualDensity: VisualDensity.compact,
                tooltip: t.revertChange,
                onPressed: () => _revert(s),
                icon: const Icon(Icons.undo, size: 20),
              ),
          ],
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
    final away = inMonth && _absentOn(day).isNotEmpty;
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
            if (away) Icon(Icons.event_busy, size: 10, color: theme.colorScheme.tertiary),
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
