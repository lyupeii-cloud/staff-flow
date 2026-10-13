import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'tools_widgets.dart';

/// Journaux des clés API : un mois à la fois (glisser pour changer), recherche
/// et filtres, recherche dans tout l'historique (archives comprises) et
/// téléchargement d'une année. Patron et responsables qui gèrent l'abonnement.
class ApiLogsPage extends StatefulWidget {
  final Session session;
  final Company company;

  /// Clé choisie d'avance (depuis la liste des clés).
  final String? keyId;

  const ApiLogsPage({super.key, required this.session, required this.company, this.keyId});

  static Future<void> open(BuildContext context, Session session, Company company, {String? keyId}) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ApiLogsPage(session: session, company: company, keyId: keyId),
        ),
      );

  @override
  State<ApiLogsPage> createState() => _ApiLogsPageState();
}

class _ApiLogsPageState extends State<ApiLogsPage> {
  String get _base => '/companies/${widget.company.id}';

  List<Map> _months = [];
  int _month = 0;
  List<Map> _keys = [];
  final _rows = <Map>[];
  bool _more = false, _loading = true, _all = false;
  Object? _error;
  final _search = TextEditingController();
  Timer? _debounce;
  late String? _key = widget.keyId;
  String? _source, _kind, _result;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    try {
      final r = await Future.wait([
        widget.session.api.send('GET', '$_base/api-logs/months'),
        widget.session.api.send('GET', '$_base/api-keys'),
      ]);
      _months = (r[0]['months'] as List).cast<Map>();
      _keys = (r[1]['keys'] as List).cast<Map>();
    } catch (e) {
      if (mounted) setState(() => _error = e);
      return;
    }
    await _load();
  }

  /// Recherche dans tout l'historique : seulement avec un texte.
  bool get _everywhere => _all && _search.text.trim().isNotEmpty;

  Future<void> _load({bool next = false}) async {
    final generation = ++_generation;
    setState(() {
      _loading = true;
      _error = null;
      if (!next) _rows.clear();
    });
    try {
      final q = {
        if (!_everywhere && _months.isNotEmpty) 'month': _months[_month]['month'] as String,
        if (_search.text.trim().isNotEmpty) 'q': _search.text.trim(),
        'key': ?_key,
        'source': ?_source,
        'kind': ?_kind,
        'result': ?_result,
        if (next && _rows.isNotEmpty) 'before': '${_rows.last['id']}',
      };
      final r = await widget.session.api.send('GET', Uri(path: '$_base/api-logs', queryParameters: q).toString());
      if (!mounted || generation != _generation) return;
      setState(() {
        _rows.addAll((r['logs'] as List).cast<Map>());
        _more = r['more'] == true;
      });
    } catch (e) {
      if (mounted && generation == _generation) setState(() => _error = e);
    } finally {
      if (mounted && generation == _generation) setState(() => _loading = false);
    }
  }

  void _goMonth(int delta) {
    final i = _month + delta;
    if (i < 0 || i >= _months.length || _everywhere) return;
    setState(() => _month = i);
    _load();
  }

  Future<void> _export() async {
    final t = context.l10n;
    final years = {for (final m in _months) int.parse((m['month'] as String).substring(0, 4))}.toList()..sort();
    final year = await showDialog<int>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(t.lgExport),
        children: [
          for (final y in years.reversed)
            SimpleDialogOption(onPressed: () => Navigator.pop(context, y), child: Text('$y')),
        ],
      ),
    );
    if (year == null || !mounted) return;
    try {
      final r = await widget.session.api.send('POST', '$_base/api-logs/export', body: {'year': year});
      if (mounted) await openUrl(context, serverUrl(r['path'] as String));
    } on ApiException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
  }

  // --- Libellés ---------------------------------------------------------------

  static String actionLabel(L10n t, String a) => switch (a) {
    'shifts.create' => t.lgActShiftsCreate,
    'shift.update' => t.lgActShiftUpdate,
    'shift.delete' => t.lgActShiftDelete,
    'schedule.publish' => t.lgActPublish,
    'members.import' => t.lgActImport,
    'member.profile' => t.lgActProfile,
    'position.create' => t.lgActPosition,
    'site.create' => t.lgActSite,
    'announcement.publish' => t.lgActNews,
    'request.approve' => t.lgActApprove,
    'request.refuse' => t.lgActRefuse,
    _ when a.startsWith('read.') => '${t.lgActRead} · ${a.substring(5)}',
    _ when a.startsWith('webhook.') => '${t.lgActWebhook} · ${a.substring(8)}',
    _ => a,
  };

  static String fieldLabel(L10n t, String f) => switch (f) {
    'day' => t.lgFDay,
    'start' => t.lgFStart,
    'end' => t.lgFEnd,
    'person' => t.lgFPerson,
    'site' => t.lgFSite,
    'position' => t.lgFPosition,
    'note' => t.lgFNote,
    'employeeNumber' => t.lgFNumber,
    _ => f,
  };

  String _sourceLabel(L10n t, String? s) => switch (s) {
    'mcp' => t.lgSourceMcp,
    'webhook' => t.lgSourceWebhook,
    _ => t.lgSourceApi,
  };

  /// Résumé d'une ligne : la personne, le jour, le nom…
  static String summary(Map l) {
    final d = (l['details'] as Map?) ?? const {};
    String? shift(Object? s) => s is Map
        ? [s['person'], s['day'], '${s['start'] ?? ''}–${s['end'] ?? ''}'].whereType<String>().join(' · ')
        : null;
    return switch (l['action']) {
          'shifts.create' => [
            '${d['count'] ?? ''}',
            shift((d['shifts'] as List?)?.firstOrNull),
          ].whereType<String>().join(' · '),
          'shift.update' => shift(d['shift']),
          'shift.delete' => shift(d['before']),
          'schedule.publish' => '${d['published'] ?? ''}',
          'members.import' => '${d['count'] ?? ''}',
          'member.profile' || 'request.approve' || 'request.refuse' => d['person'] as String?,
          'position.create' || 'site.create' => d['name'] as String?,
          'announcement.publish' => d['title'] as String?,
          _ when d['url'] != null => d['url'] as String?,
          _ when d['count'] != null => '${d['count']}',
          _ => null,
        } ??
        '';
  }

  // --- Affichage ----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    final theme = Theme.of(context);
    final month = _months.isEmpty ? null : _months[_month];
    return Scaffold(
      appBar: AppBar(
        title: Text(t.lgTitle),
        actions: [
          if (_months.isNotEmpty)
            IconButton(tooltip: t.lgExport, icon: const Icon(Icons.download_outlined), onPressed: _export),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: t.lgSearch,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
                    isDense: true,
                    suffixIcon: _search.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _search.clear();
                              _load();
                            },
                          ),
                  ),
                  onChanged: (_) {
                    _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 400), _load);
                    setState(() {});
                  },
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    _menu<String?>(
                      t,
                      icon: Icons.key_outlined,
                      value: _key,
                      all: t.lgAllKeys,
                      items: {for (final k in _keys) k['id'] as String: '${k['name']}'},
                      onSelected: (v) => _key = v,
                    ),
                    _menu<String?>(
                      t,
                      icon: Icons.hub_outlined,
                      value: _source,
                      all: t.lgAllSources,
                      items: {'api': t.lgSourceApi, 'mcp': t.lgSourceMcp, 'webhook': t.lgSourceWebhook},
                      onSelected: (v) => _source = v,
                    ),
                    _menu<String?>(
                      t,
                      icon: Icons.swap_vert,
                      value: _kind,
                      all: t.lgAllKinds,
                      items: {'read': t.lgKindRead, 'write': t.lgKindWrite},
                      onSelected: (v) => _kind = v,
                    ),
                    _menu<String?>(
                      t,
                      icon: Icons.rule,
                      value: _result,
                      all: t.lgAllResults,
                      items: {'ok': t.lgOk, 'error': t.lgError},
                      onSelected: (v) => _result = v,
                    ),
                  ],
                ),
              ),
              CheckboxListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                controlAffinity: ListTileControlAffinity.leading,
                value: _all,
                title: Text(t.lgAllHistory),
                onChanged: (v) {
                  setState(() => _all = v == true);
                  if (_search.text.trim().isNotEmpty) _load();
                },
              ),
              // Mois : flèches, ou glisser sur la liste.
              if (_everywhere)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(t.lgResults, style: theme.textTheme.titleSmall),
                )
              else if (month != null)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _month < _months.length - 1 ? () => _goMonth(1) : null,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(_monthTitle(month['month'] as String, loc), style: theme.textTheme.titleMedium),
                          if (month['archived'] == true)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.inventory_2_outlined, size: 14, color: theme.colorScheme.outline),
                                const SizedBox(width: 4),
                                Text(t.lgArchived, style: theme.textTheme.bodySmall),
                              ],
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _month > 0 ? () => _goMonth(-1) : null,
                    ),
                  ],
                ),
              const Divider(height: 1),
              Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (d) {
                    final v = d.primaryVelocity ?? 0;
                    if (v > 300) _goMonth(1);
                    if (v < -300) _goMonth(-1);
                  },
                  child: RefreshIndicator(
                    onRefresh: () => _load(),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 24),
                      children: [
                        if (_rows.isEmpty && !_loading && _error == null)
                          Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(child: Text(t.lgNone, style: theme.textTheme.bodySmall)),
                          ),
                        for (final l in _rows) _tile(t, loc, theme, l),
                        if (_error != null)
                          TextButton.icon(
                            onPressed: () => _months.isEmpty ? _start() : _load(),
                            icon: const Icon(Icons.refresh),
                            label: Text(_error is ApiException ? (_error as ApiException).describe(t) : t.retry),
                          ),
                        if (_loading)
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        if (_more && !_loading)
                          Center(
                            child: TextButton(onPressed: () => _load(next: true), child: Text(t.lgMore)),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _monthTitle(String month, String loc) {
    final s = DateFormat.yMMMM(loc).format(DateTime.parse('$month-01'));
    return s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
  }

  Widget _menu<T>(
    L10n t, {
    required IconData icon,
    required String? value,
    required String all,
    required Map<String, String> items,
    required void Function(String?) onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<String>(
        onSelected: (v) {
          setState(() => onSelected(v.isEmpty ? null : v));
          _load();
        },
        itemBuilder: (_) => [
          PopupMenuItem(value: '', child: Text(all)),
          for (final e in items.entries) PopupMenuItem(value: e.key, child: Text(e.value)),
        ],
        child: Chip(
          avatar: Icon(icon, size: 18),
          label: Text(value == null ? all : (items[value] ?? all)),
          shape: const StadiumBorder(),
          backgroundColor: value == null ? null : Theme.of(context).colorScheme.secondaryContainer,
        ),
      ),
    );
  }

  Widget _tile(L10n t, String loc, ThemeData theme, Map l) {
    final ok = l['ok'] == true;
    final at = DateTime.parse(l['at'] as String).toLocal();
    final when = DateFormat.MMMd(loc).add_Hms().format(at);
    final sum = summary(l);
    return ListTile(
      leading: Icon(switch (l['source']) {
        'mcp' => Icons.smart_toy_outlined,
        'webhook' => Icons.webhook_outlined,
        _ => l['kind'] == 'write' ? Icons.edit_note : Icons.visibility_outlined,
      }, color: ok ? null : theme.colorScheme.error),
      title: Text(actionLabel(t, l['action'] as String? ?? '')),
      subtitle: Text(
        [
          '$when · ${l['keyName'] ?? _sourceLabel(t, l['source'] as String?)}',
          if (sum.isNotEmpty) sum,
          if (!ok) '${l['status']} · ${l['error'] ?? ''}',
        ].join('\n'),
      ),
      isThreeLine: sum.isNotEmpty || !ok,
      trailing: ok ? null : Icon(Icons.error_outline, color: theme.colorScheme.error),
      onTap: () => _details(t, loc, theme, l),
    );
  }

  void _details(L10n t, String loc, ThemeData theme, Map l) {
    final d = (l['details'] as Map?) ?? const {};
    final at = DateTime.parse(l['at'] as String).toLocal();
    Widget line(String label, Object? value) => value == null || '$value'.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 120, child: Text(label, style: theme.textTheme.bodySmall)),
                Expanded(child: SelectableText('$value')),
              ],
            ),
          );
    String fields(Object? m) => m is Map
        ? [
            for (final e in m.entries)
              if (e.value != null) '${fieldLabel(t, '${e.key}')} : ${e.value}',
          ].join('\n')
        : m is List
        ? m.map(fields).join('\n')
        : '${m ?? ''}';
    final before = d['before'], after = d['after'];
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.95,
        builder: (context, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.all(16),
          children: [
            Text(actionLabel(t, l['action'] as String? ?? ''), style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            line(t.lgFDate, DateFormat.yMMMMd(loc).add_Hms().format(at)),
            line(t.lgFKey, [l['keyName'], l['keyPrefix']].whereType<String>().join(' · ')),
            line(t.lgFSource, _sourceLabel(t, l['source'] as String?)),
            line('HTTP', '${l['method'] ?? ''} ${l['path'] ?? ''}'.trim()),
            line(t.lgFStatus, '${l['status']} · ${l['durationMs']} ms'),
            line('IP', l['ip']),
            if (l['ok'] != true) line(t.lgError, l['error']),
            const Divider(),
            if (before is Map && after is Map && (before.isNotEmpty || after.isNotEmpty)) ...[
              if (d['shift'] != null || d['person'] != null) Text(fields(d['shift'] ?? {'person': d['person']})),
              const SizedBox(height: 8),
              Table(
                columnWidths: const {0: IntrinsicColumnWidth()},
                children: [
                  TableRow(
                    children: [
                      const SizedBox(),
                      Text(t.lgBefore, style: theme.textTheme.labelLarge),
                      Text(t.lgAfter, style: theme.textTheme.labelLarge),
                    ],
                  ),
                  for (final k in {...before.keys, ...after.keys})
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12, top: 4),
                          child: Text(fieldLabel(t, '$k'), style: theme.textTheme.bodySmall),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${before[k] ?? '—'}',
                            style: const TextStyle(decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 4), child: Text('${after[k] ?? '—'}')),
                      ],
                    ),
                ],
              ),
            ] else
              for (final e in d.entries)
                line(fieldLabel(t, '${e.key}'), e.value is Map || e.value is List ? fields(e.value) : e.value),
          ],
        ),
      ),
    );
  }
}
