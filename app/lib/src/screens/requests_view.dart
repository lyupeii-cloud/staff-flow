import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';

/// Demandes de l'entreprise : d'abord celles qui attendent une réponse de la
/// personne connectée, puis toutes les autres (les siennes, et pour un
/// responsable celles de son périmètre), 10 par 10 en faisant défiler.
class RequestsView extends StatefulWidget {
  final Session session;
  final Membership membership;
  final CompanyData data;

  /// Demande à mettre en évidence (notification touchée, icône du planning).
  final String? focus;

  const RequestsView({super.key, required this.session, required this.membership, required this.data, this.focus});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  /// En attente et à traiter par la personne connectée.
  List<StaffRequest> _toHandle = const [];

  /// Toutes les autres, les plus récentes d'abord, page par page.
  final List<StaffRequest> _history = [];
  StaffRequest? _focused;
  bool _loaded = false, _hasMore = true, _loadingMore = false;
  Localized? _error;
  int _seenSync = 0;
  final _scroll = ScrollController();

  static const _page = 10;

  L10n get t => context.l10n;
  Company get company => widget.membership.company;
  String get _base => '/companies/${company.id}/requests';

  @override
  void initState() {
    super.initState();
    widget.session.sync.addListener(_onSync);
    _scroll.addListener(_onScroll);
    _load();
  }

  @override
  void dispose() {
    widget.session.sync.removeListener(_onSync);
    _scroll.dispose();
    super.dispose();
  }

  void _onSync() {
    if (widget.session.sync.synced != _seenSync) _load();
  }

  /// Près du bas de la liste : les 10 suivantes.
  void _onScroll() {
    if (_scroll.position.extentAfter < 300) _more();
  }

  List<StaffRequest> _parse(dynamic json) => [for (final r in json['requests']) StaffRequest.fromJson(r)];

  Future<void> _load() async {
    _seenSync = widget.session.sync.synced;
    final sync = widget.session.sync;
    try {
      final pending = _parse(await sync.read('requests-pending:${company.id}', '$_base?pending=1'));
      final first = _parse(await sync.read('requests:${company.id}', '$_base?limit=$_page'));
      StaffRequest? focused;
      final focus = widget.focus;
      if (focus != null) {
        focused = [...pending, ...first].where((r) => r.id == focus).firstOrNull ??
            StaffRequest.fromJson(await widget.session.api.send('GET', '/requests/$focus'));
      }
      if (!mounted) return;
      setState(() {
        _focused = focused;
        _toHandle = [for (final r in pending) if ((r.canAnswer || r.canDecide) && r.id != focused?.id) r];
        _history
          ..clear()
          ..addAll(_withoutShown(first));
        _hasMore = first.length == _page;
        _loaded = true;
        _error = null;
      });
    } on OfflineException {
      if (mounted) setState(() => _error = (t) => t.offlineUnavailable);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = e.describe);
    }
  }

  Iterable<StaffRequest> _withoutShown(List<StaffRequest> page) {
    final shown = {?_focused?.id, for (final r in _toHandle) r.id, for (final r in _history) r.id};
    return page.where((r) => !shown.contains(r.id));
  }

  Future<void> _more() async {
    if (!_loaded || !_hasMore || _loadingMore) return;
    final before = _history.isEmpty ? null : _history.last.createdAt.toUtc().toIso8601String();
    setState(() => _loadingMore = true);
    try {
      final page = _parse(await widget.session.api
          .send('GET', '$_base?limit=$_page${before == null ? '' : '&before=${Uri.encodeQueryComponent(before)}'}'));
      if (!mounted) return;
      setState(() {
        _history.addAll(_withoutShown(page));
        _hasMore = page.length == _page;
      });
    } catch (_) {
      // Réessayé au prochain défilement.
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  Future<void> _act(StaffRequest r, String action, [Map<String, dynamic>? body]) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await widget.session.api.send('POST', '/requests/${r.id}/$action', body: body);
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
    await _load();
  }

  /// Valider un échange : sans collègue désigné, le responsable choisit qui
  /// reprend le service.
  Future<void> _approve(StaffRequest r) async {
    if (!r.needsPeer) return _act(r, 'approve');
    final people = [for (final m in widget.data.members) if (m.user.id != r.requesterId) m];
    final peer = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(t.choosePeer),
        children: [
          for (final m in people)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, m.user.id),
              child: Text('${m.user.name} · ${m.role.label(t)}'),
            ),
        ],
      ),
    );
    if (peer != null) await _act(r, 'approve', {'peerId': peer});
  }

  Future<void> _new() async {
    final kind = await showModalBottomSheet<RequestKind>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.beach_access),
              title: Text(t.requestLeave),
              onTap: () => Navigator.pop(context, RequestKind.leave),
            ),
            ListTile(
              leading: const Icon(Icons.event_busy),
              title: Text(t.requestUnavailability),
              onTap: () => Navigator.pop(context, RequestKind.unavailability),
            ),
            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: Text(t.requestSwap),
              subtitle: Text(t.swapHint),
              enabled: false,
            ),
          ],
        ),
      ),
    );
    if (kind == null || !mounted) return;
    final sent = await showAbsenceRequest(context, session: widget.session, company: company, kind: kind);
    if (sent == true) _load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget title(String text) => Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Text(text, style: theme.textTheme.titleSmall),
        );
    final focused = _focused;
    final empty = _loaded && focused == null && _toHandle.isEmpty && _history.isEmpty;
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: company.readOnly
          ? null
          : FloatingActionButton.extended(
              onPressed: _new,
              icon: const Icon(Icons.add),
              label: Text(t.newRequest),
            ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          controller: _scroll,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
          children: [
            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_error!(t), style: TextStyle(color: theme.colorScheme.error)),
              ),
            if (!_loaded && _error == null)
              const Padding(padding: EdgeInsets.all(32), child: Center(child: CircularProgressIndicator())),
            if (empty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text('${t.noRequests}\n\n${t.swapHint}', textAlign: TextAlign.center),
              ),
            if (focused != null) ...[const SizedBox(height: 8), _card(focused, highlight: true)],
            if (_toHandle.isNotEmpty) title(t.requestsToHandle),
            for (final r in _toHandle) _card(r),
            if (_history.isNotEmpty) title(t.requestsHistory),
            for (final r in _history) _card(r),
            if (_loadingMore) const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }

  Widget _card(StaffRequest r, {bool highlight = false}) {
    final theme = Theme.of(context);
    final loc = context.localeName;
    final lines = <String>[
      ...requestDetails(t, loc, r, widget.data),
      if (r.note != null) '« ${r.note} »',
    ];
    final (statusText, statusColor) = switch (r.status) {
      'pending_peer' => (t.statusPendingPeer, theme.colorScheme.tertiary),
      'pending_manager' => (t.statusPendingManager, theme.colorScheme.tertiary),
      'approved' => (t.statusApproved, Colors.green.shade700),
      'refused' => (t.statusRefused, theme.colorScheme.error),
      'expired' => (t.statusExpired, theme.disabledColor),
      _ => (t.statusCancelled, theme.disabledColor),
    };
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: highlight
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: theme.colorScheme.primary, width: 2),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(requestIcon(r.kind), color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('${r.requesterName} · ${requestKindLabel(t, r.kind)}', style: theme.textTheme.titleSmall),
                ),
                Flexible(
                  child: Text(statusText,
                      textAlign: TextAlign.end, style: theme.textTheme.labelSmall?.copyWith(color: statusColor)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36, top: 4),
              child: Text(lines.join('\n'), style: theme.textTheme.bodySmall),
            ),
            if (r.canAnswer || r.canDecline || r.canDecide || r.canCancel)
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 8,
                children: [
                  if (r.canCancel) TextButton(onPressed: () => _act(r, 'cancel'), child: Text(t.cancelRequest)),
                  if (r.canDecline) TextButton(onPressed: () => _act(r, 'decline'), child: Text(t.decline)),
                  // Un responsable qui reprend le service valide l'échange du même coup.
                  if (r.canAnswer)
                    FilledButton(
                      onPressed: () => r.canDecide
                          ? _act(r, 'approve', {'peerId': widget.session.me!.user.id})
                          : _act(r, 'accept'),
                      child: Text(t.acceptSwap),
                    ),
                  if (r.canDecide && !r.canAnswer)
                    TextButton(onPressed: () => _act(r, 'refuse'), child: Text(t.decline)),
                  if (r.canDecide) FilledButton(onPressed: () => _approve(r), child: Text(t.approve)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

IconData requestIcon(RequestKind kind) => switch (kind) {
      RequestKind.swap => Icons.swap_horiz,
      RequestKind.leave => Icons.beach_access,
      RequestKind.unavailability => Icons.event_busy,
    };

String requestKindLabel(L10n t, RequestKind kind) => switch (kind) {
      RequestKind.swap => t.requestSwap,
      RequestKind.leave => t.requestLeave,
      RequestKind.unavailability => t.requestUnavailability,
    };

/// Détails d'une demande : le service proposé et à qui, ou la période et
/// les jours d'absence.
List<String> requestDetails(L10n t, String loc, StaffRequest r, CompanyData? data) {
  final period = r.startDay == null || r.endDay == null
      ? null
      : sameDay(r.startDay!, r.endDay!)
          ? longDate(r.startDay!, loc)
          : t.periodLabel(dayLabel(r.startDay!, loc), dayLabel(r.endDay!, loc));
  return switch (r.kind) {
    RequestKind.swap => [
        if (r.shiftDay != null)
          [
            '${dayLabel(r.shiftDay!, loc)}  ${timeLabel(r.shiftStart ?? 0)} – ${timeLabel(r.shiftEnd ?? 0)}',
            ?data?.siteName(r.siteId),
          ].join(' · '),
        r.peerName != null ? t.swapToPeer(r.peerName!) : t.swapToTeam,
      ],
    _ => [
        if (r.weekdays != null) t.everyWeekdays(r.weekdays!.map((d) => weekdayShort(d, loc)).join(', ')),
        ?period,
      ],
  };
}

/// Demande de congé ou d'indisponibilité. Renvoie `true` une fois envoyée.
Future<bool?> showAbsenceRequest(BuildContext context,
        {required Session session, required Company company, required RequestKind kind}) =>
    showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _AbsenceForm(session: session, company: company, kind: kind),
    );

class _AbsenceForm extends StatefulWidget {
  final Session session;
  final Company company;
  final RequestKind kind;

  const _AbsenceForm({required this.session, required this.company, required this.kind});

  @override
  State<_AbsenceForm> createState() => _AbsenceFormState();
}

class _AbsenceFormState extends State<_AbsenceForm> {
  DateTimeRange? _range;
  final _weekdays = <int>{};
  final _note = TextEditingController();
  bool _sending = false;
  Localized? _error;

  bool get leave => widget.kind == RequestKind.leave;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickRange() async {
    final today = dateOnly(DateTime.now());
    final r = await showDateRangePicker(
      context: context,
      firstDate: today,
      lastDate: DateTime(today.year + 2),
      initialDateRange: _range,
    );
    if (r != null) setState(() => _range = r);
  }

  bool get _ready => leave ? _range != null : (_range != null || _weekdays.isNotEmpty);

  Future<void> _send() async {
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await widget.session.api.send('POST', '/companies/${widget.company.id}/requests', body: {
        'kind': widget.kind.name,
        if (_range != null) 'startDay': formatDay(_range!.start),
        if (_range != null) 'endDay': formatDay(_range!.end),
        if (_weekdays.isNotEmpty) 'weekdays': (_weekdays.toList()..sort()),
        'note': _note.text,
      });
      if (mounted) Navigator.pop(context, true);
    } on OfflineException {
      setState(() => _error = (t) => t.offlineUnavailable);
    } on ApiException catch (e) {
      setState(() => _error = e.describe);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    final theme = Theme.of(context);
    final range = _range;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(leave ? t.requestLeave : t.requestUnavailability, style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            if (!leave) ...[
              Text(t.unavailableEveryWeek, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                children: [
                  for (var d = 1; d <= 7; d++)
                    FilterChip(
                      label: Text(weekdayShort(d, loc)),
                      selected: _weekdays.contains(d),
                      onSelected: (on) => setState(() => on ? _weekdays.add(d) : _weekdays.remove(d)),
                    ),
                ],
              ),
              const SizedBox(height: 12),
            ],
            OutlinedButton.icon(
              onPressed: _pickRange,
              icon: const Icon(Icons.date_range),
              label: Text(range == null
                  ? (leave ? t.choosePeriod : t.choosePeriodOptional)
                  : t.periodLabel(dayLabel(range.start, loc), dayLabel(range.end, loc))),
            ),
            if (range != null && !leave)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () => setState(() => _range = null), child: Text(t.clearPeriod)),
              ),
            const SizedBox(height: 12),
            TextField(
              controller: _note,
              maxLength: 500,
              decoration: InputDecoration(labelText: t.noteOptional),
            ),
            if (_error != null) Text(_error!(t), style: TextStyle(color: theme.colorScheme.error)),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _ready && !_sending ? _send : null,
              child: Text(t.sendRequest),
            ),
          ],
        ),
      ),
    );
  }
}

/// Propose un de ses services publiés à un collègue, ou à toute l'équipe.
/// Renvoie `true` une fois la proposition envoyée.
Future<bool?> showSwapOffer(BuildContext context,
        {required Session session, required Membership membership, required CompanyData data, required Shift shift}) =>
    showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _SwapForm(session: session, membership: membership, data: data, shift: shift),
    );

class _SwapForm extends StatefulWidget {
  final Session session;
  final Membership membership;
  final CompanyData data;
  final Shift shift;

  const _SwapForm({required this.session, required this.membership, required this.data, required this.shift});

  @override
  State<_SwapForm> createState() => _SwapFormState();
}

class _SwapFormState extends State<_SwapForm> {
  String? _peer;
  final _note = TextEditingController();
  bool _sending = false;
  Localized? _error;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await widget.session.api.send('POST', '/companies/${widget.membership.company.id}/requests', body: {
        'kind': 'swap',
        'shiftId': widget.shift.id,
        'peerId': ?_peer,
        'note': _note.text,
      });
      if (mounted) Navigator.pop(context, true);
    } on OfflineException {
      setState(() => _error = (t) => t.offlineUnavailable);
    } on ApiException catch (e) {
      setState(() => _error = e.describe);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    final theme = Theme.of(context);
    final s = widget.shift;
    final me = widget.session.me!.user.id;
    final colleagues = [
      for (final m in widget.data.members)
        if (m.user.id != me) m,
    ];
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(t.proposeSwap, style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              [
                '${dayLabel(s.day, loc)}  ${timeLabel(s.start)} – ${timeLabel(s.end)}',
                ?widget.data.siteName(s.siteId),
              ].join(' · '),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              initialValue: _peer,
              decoration: InputDecoration(labelText: t.swapWith, helperText: t.swapWithHint),
              items: [
                DropdownMenuItem(value: null, child: Text(t.swapToTeam)),
                for (final m in colleagues)
                  DropdownMenuItem(value: m.user.id, child: Text('${m.user.name} · ${m.role.label(t)}')),
              ],
              onChanged: (v) => setState(() => _peer = v),
            ),
            const SizedBox(height: 8),
            Text(t.swapSteps, style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            TextField(
              controller: _note,
              maxLength: 500,
              decoration: InputDecoration(labelText: t.noteOptional),
            ),
            if (_error != null) Text(_error!(t), style: TextStyle(color: theme.colorScheme.error)),
            const SizedBox(height: 8),
            FilledButton(onPressed: _sending ? null : _send, child: Text(t.sendRequest)),
          ],
        ),
      ),
    );
  }
}
