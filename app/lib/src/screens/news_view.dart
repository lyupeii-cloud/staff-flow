import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'avatar_widgets.dart';
import 'company_tab.dart';
import 'home_screen.dart';
import 'pick_list.dart';

/// Une annonce du fil d'actualités.
class NewsItem {
  final String id;
  final String? title;
  final String body;
  final Map<String, dynamic> audience;
  final DateTime createdAt;
  final DateTime? editedAt;
  final String authorId;
  final String authorName;
  final String? authorPhoto;
  final Map<String, dynamic>? authorAvatar;
  final bool read;

  /// Pour l'auteur et qui supervise : destinataires et lectures.
  final int? recipients;
  final int? reads;

  NewsItem.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        title = j['title'],
        body = j['body'],
        audience = ((j['audience'] ?? const {}) as Map).cast<String, dynamic>(),
        createdAt = DateTime.parse(j['createdAt']).toLocal(),
        editedAt = j['editedAt'] == null ? null : DateTime.parse(j['editedAt']).toLocal(),
        authorId = j['author']['id'] ?? '',
        authorName = j['author']['name'] ?? '?',
        authorPhoto = j['author']['photoUrl'],
        authorAvatar = (j['author']['avatar'] as Map?)?.cast<String, dynamic>(),
        read = j['read'] == true,
        recipients = j['recipients'],
        reads = j['reads'];
}

/// Fil d'actualités de l'entreprise : annonces du patron et des
/// responsables ; chacun lit et traduit dans sa langue.
class NewsView extends StatefulWidget {
  final Session session;
  final Membership membership;
  final CompanyData data;

  const NewsView({super.key, required this.session, required this.membership, required this.data});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final _items = <NewsItem>[];
  bool _more = false, _loading = true;
  Object? _error;

  /// Traductions affichées (id → titre, texte).
  final _translated = <String, ({String? title, String body})>{};
  final _translating = <String>{};

  Company get company => widget.membership.company;
  L10n get t => context.l10n;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({bool more = false}) async {
    setState(() => (_loading = true, _error = null));
    try {
      final before = more && _items.isNotEmpty ? '?before=${Uri.encodeQueryComponent(_items.last.createdAt.toUtc().toIso8601String())}' : '';
      final r = await widget.session.api.send('GET', '/companies/${company.id}/news$before');
      final page = [for (final i in r['items']) NewsItem.fromJson((i as Map).cast<String, dynamic>())];
      if (!mounted) return;
      setState(() {
        if (!more) _items.clear();
        _items.addAll(page);
        _more = r['more'] == true;
      });
      // Ouvert : tout est lu (la pastille disparaît).
      if (!more &&
          (page.any((i) => !i.read && i.authorId != widget.session.me?.user.id) ||
              (widget.session.me?.unreadNews[company.id] ?? 0) > 0)) {
        await widget.session.api.send('POST', '/companies/${company.id}/news/read');
        await widget.session.refresh();
      }
    } catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _translate(NewsItem n) async {
    if (_translated.containsKey(n.id)) {
      setState(() => _translated.remove(n.id));
      return;
    }
    setState(() => _translating.add(n.id));
    final messenger = ScaffoldMessenger.of(context);
    try {
      final r = await widget.session.api.send('POST', '/companies/${company.id}/news/${n.id}/translate',
          body: {'lang': widget.session.api.language});
      if (mounted) setState(() => _translated[n.id] = (title: r['title'] as String?, body: r['body'] as String));
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      if (mounted) setState(() => _translating.remove(n.id));
    }
  }

  Future<void> _compose([NewsItem? editing]) async {
    final done = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _Composer(session: widget.session, membership: widget.membership, data: widget.data, editing: editing),
    );
    if (done == true) await _load();
  }

  Future<void> _delete(NewsItem n) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialog) => AlertDialog(
        title: Text(t.newsDeleteTitle),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialog, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(dialog, true), child: Text(t.delete)),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await runAction(context, widget.session,
        () => widget.session.api.send('DELETE', '/companies/${company.id}/news/${n.id}'));
    await _load();
  }

  /// « Pour : Maçons, Nord, Bob » (ou « Pour tout le monde »).
  String _audience(NewsItem n) {
    final a = n.audience;
    if (a['everyone'] == true) return t.newsForEveryone;
    final data = widget.data;
    final names = [
      for (final id in (a['positions'] as List? ?? const [])) ?data.positionName(id as String),
      for (final id in (a['sites'] as List? ?? const [])) ?data.siteName(id as String),
      for (final r in (a['roles'] as List? ?? const []))
        switch (r) { 'manager' => t.roleManager, 'extra' => t.roleExtra, _ => t.roleEmployee },
      for (final id in (a['users'] as List? ?? const []))
        ?data.members.where((m) => m.user.id == id).firstOrNull?.user.name,
    ];
    return t.newsFor(names.join(', '));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final me = widget.session.me?.user.id;
    final canPost = widget.membership.role.canManage && !company.readOnly;
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          if (canPost)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FilledButton.icon(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: () => _compose(),
                icon: const Icon(Icons.campaign_outlined),
                label: Text(t.newsNew),
              ),
            ),
          if (_error != null)
            Center(
              child: TextButton.icon(
                onPressed: _load,
                icon: const Icon(Icons.refresh),
                label: Text('${_error is ApiException ? (_error as ApiException).describe(t) : t.serverUnreachable}\n${t.retry}'),
              ),
            ),
          if (!_loading && _error == null && _items.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(children: [
                Icon(Icons.campaign_outlined, size: 48, color: theme.colorScheme.outline),
                const SizedBox(height: 8),
                Text(canPost ? t.newsEmptyManager : t.newsEmpty, textAlign: TextAlign.center),
              ]),
            ),
          for (final n in _items) _card(n, theme, me),
          if (_loading) const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator())),
          if (_more && !_loading)
            TextButton.icon(
              onPressed: () => _load(more: true),
              icon: const Icon(Icons.expand_more),
              label: Text(t.newsOlder),
            ),
        ],
      ),
    );
  }

  Widget _card(NewsItem n, ThemeData theme, String? me) {
    final tr = _translated[n.id];
    final mine = n.authorId == me;
    final owner = widget.membership.role == Role.owner;
    final supervise = widget.membership.managesAll;
    final loc = context.localeName;
    final unread = !n.read && !mine;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: unread ? BorderSide(color: theme.colorScheme.primary, width: 1.5) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            UserAvatar(name: n.authorName, photoUrl: n.authorPhoto, avatar: n.authorAvatar, radius: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(n.authorName, style: theme.textTheme.titleSmall),
                Text(
                  '${dayLabel(n.createdAt, loc)} · ${timeLabel(n.createdAt.hour * 60 + n.createdAt.minute)}'
                  '${n.editedAt != null ? ' · ${t.newsEdited}' : ''}',
                  style: theme.textTheme.bodySmall,
                ),
              ]),
            ),
            if (!mine)
              IconButton(
                tooltip: t.translateAction,
                onPressed: _translating.contains(n.id) ? null : () => _translate(n),
                icon: _translating.contains(n.id)
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : Icon(Icons.translate, color: tr == null ? null : theme.colorScheme.primary),
              ),
            if (mine || owner || supervise)
              PopupMenuButton<String>(
                onSelected: (v) => v == 'edit' ? _compose(n) : _delete(n),
                itemBuilder: (_) => [
                  if (mine || owner) PopupMenuItem(value: 'edit', child: Text(t.newsEdit)),
                  PopupMenuItem(value: 'delete', child: Text(t.delete)),
                ],
              ),
          ]),
          const SizedBox(height: 10),
          if ((tr?.title ?? n.title) != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4, right: 8),
              child: Text(tr?.title ?? n.title!, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SelectableText(tr?.body ?? n.body, style: theme.textTheme.bodyLarge),
          ),
          if (tr != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(t.newsTranslated, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary)),
            ),
          if (mine || supervise) ...[
            const SizedBox(height: 8),
            Wrap(spacing: 12, runSpacing: 4, children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.groups_outlined, size: 16, color: theme.colorScheme.outline),
                const SizedBox(width: 4),
                Flexible(child: Text(_audience(n), style: theme.textTheme.bodySmall)),
              ]),
              if (n.reads != null)
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.done_all, size: 16, color: theme.colorScheme.outline),
                  const SizedBox(width: 4),
                  Text(
                    n.audience['everyone'] == true && (n.recipients ?? 0) == 0
                        ? t.newsReadCount('${n.reads}')
                        : t.newsReadOf('${n.reads}', '${n.recipients}'),
                    style: theme.textTheme.bodySmall,
                  ),
                ]),
            ]),
          ],
        ]),
      ),
    );
  }
}

/// Rédiger (ou corriger) une annonce et choisir ses destinataires.
class _Composer extends StatefulWidget {
  final Session session;
  final Membership membership;
  final CompanyData data;
  final NewsItem? editing;

  const _Composer({required this.session, required this.membership, required this.data, this.editing});

  @override
  State<_Composer> createState() => _ComposerState();
}

class _ComposerState extends State<_Composer> {
  late final _title = TextEditingController(text: widget.editing?.title);
  late final _body = TextEditingController(text: widget.editing?.body);
  bool _everyone = true;
  Set<String> _positions = {}, _sites = {}, _people = {};
  final Set<String> _roles = {};
  bool _saving = false;
  String? _error;

  L10n get t => context.l10n;

  Future<void> _send() async {
    final company = widget.membership.company;
    setState(() => (_saving = true, _error = null));
    try {
      final title = _title.text.trim();
      if (widget.editing case final n?) {
        await widget.session.api.send('PATCH', '/companies/${company.id}/news/${n.id}',
            body: {'title': title.isEmpty ? null : title, 'body': _body.text});
      } else {
        final r = await widget.session.api.send('POST', '/companies/${company.id}/news', body: {
          'title': title.isEmpty ? null : title,
          'body': _body.text,
          'audience': _everyone
              ? {'everyone': true}
              : {
                  'positions': _positions.toList(),
                  'sites': _sites.toList(),
                  'roles': _roles.toList(),
                  'users': _people.toList(),
                },
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.newsSent('${r['recipients']}'))));
        }
      }
      if (mounted) Navigator.pop(context, true);
    } on OfflineException {
      setState(() => _error = t.offlineUnavailable);
    } on ApiException catch (e) {
      setState(() => _error = e.describe(t));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = widget.data;
    final editing = widget.editing != null;
    final mine = widget.membership.managedSites;
    final members = [
      for (final m in data.members)
        if (m.user.id != widget.session.me?.user.id &&
            (mine == null || (m.sites ?? const <String>[]).any(mine.contains)))
          m,
    ];
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(editing ? t.newsEdit : t.newsNew, style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          TextField(
            controller: _title,
            maxLength: 120,
            decoration: InputDecoration(labelText: t.newsTitleField),
          ),
          TextField(
            controller: _body,
            minLines: 4,
            maxLines: 12,
            maxLength: 4000,
            decoration: InputDecoration(labelText: t.newsBodyField, alignLabelWithHint: true),
          ),
          if (!editing) ...[
            const SizedBox(height: 8),
            Text(t.newsRecipients, style: theme.textTheme.labelLarge),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(mine == null ? t.newsForEveryone : t.newsEveryoneMySites),
              value: _everyone,
              onChanged: (v) => setState(() => _everyone = v),
            ),
            if (!_everyone) ...[
              Wrap(spacing: 6, children: [
                for (final (r, label) in [('manager', t.roleManager), ('employee', t.roleEmployee), ('extra', t.roleExtra)])
                  FilterChip(
                    label: Text(label),
                    selected: _roles.contains(r),
                    onSelected: (on) => setState(() => on ? _roles.add(r) : _roles.remove(r)),
                  ),
              ]),
              if (data.positions.any((p) => !p.archived))
                PickList(
                  label: t.positions,
                  multi: true,
                  items: [for (final p in data.positions) if (!p.archived) PickItem(p.id, p.name)],
                  selected: _positions,
                  onChanged: (v) => setState(() => _positions = v),
                  emptyText: '—',
                ),
              if (data.siteTree.isNotEmpty)
                PickList(
                  label: t.sites,
                  multi: true,
                  items: [
                    for (final (s, d) in data.siteTree)
                      if (!s.archived && (mine == null || mine.contains(s.id)))
                        PickItem(s.id, s.name, indent: d, selectedText: data.sitePath(s.id) ?? s.name),
                  ],
                  selected: _sites,
                  onChanged: (v) => setState(() => _sites = v),
                  emptyText: '—',
                ),
              PickList(
                label: t.people,
                multi: true,
                items: [
                  for (final m in members)
                    PickItem(m.user.id, m.user.name,
                        number: m.employeeNumber,
                        sfId: m.user.publicId,
                        detail: [m.role.label(t), ?data.positionName(m.positionId)].join(' · ')),
                ],
                selected: _people,
                onChanged: (v) => setState(() => _people = v),
                sorts: const [PickSort.name, PickSort.number, PickSort.sfId],
                emptyText: '—',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(t.newsTargetHint, style: theme.textTheme.bodySmall),
              ),
            ],
          ],
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
          ],
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: _saving ? null : _send,
              icon: const Icon(Icons.send),
              label: Text(editing ? t.save : t.newsPublish),
            ),
          ]),
        ]),
      ),
    );
  }
}
