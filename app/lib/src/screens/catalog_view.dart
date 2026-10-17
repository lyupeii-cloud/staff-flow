import 'package:flutter/material.dart';

import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';
import 'home_screen.dart';
import 'pick_list.dart';
import 'tools_widgets.dart';

/// Sites (magasin A, entrepôt…) et postes (caisse, cuisine…) de l'entreprise.
/// Les sites vont en cascade, sur dix niveaux (région › ville › magasin…) ;
/// un responsable de site gère ici les sites en dessous des siens.
class CatalogView extends StatelessWidget {
  final Session session;
  final Membership membership;
  final CompanyData data;
  final VoidCallback onChanged;

  const CatalogView(
      {super.key, required this.session, required this.membership, required this.data, required this.onChanged});

  static const maxDepth = 10;

  Company get company => membership.company;

  /// Sites attribués à ce responsable (pas ceux d'en dessous) : il ne les renomme pas.
  Set<String> get _ownSites => {
        ...?data.members.where((m) => m.user.id == session.me?.user.id).firstOrNull?.sites,
      };

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (membership.managesAll) ...[
          _positions(context),
          const SizedBox(height: 24),
        ],
        _sites(context),
        if (membership.managesAll) ...[
          const SizedBox(height: 24),
          ToolsSettings(session: session, company: company),
        ] else ...[
          const SizedBox(height: 8),
          Text(t.subSitesOnlyHint, style: Theme.of(context).textTheme.bodySmall),
        ],
      ],
    );
  }

  Widget _header(BuildContext context, String title, VoidCallback? onAdd) {
    final t = context.l10n;
    return Row(
      children: [
        Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
        if (!company.readOnly && onAdd != null)
          TextButton.icon(onPressed: onAdd, icon: const Icon(Icons.add, size: 18), label: Text(t.add)),
      ],
    );
  }

  Widget _positions(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _header(context, t.positions, () => _edit(context, 'positions', null)),
        if (data.positions.isEmpty) Text(t.positionsHint, style: theme.textTheme.bodySmall),
        _Filtered(
          items: [for (final i in data.positions) PickItem(i.id, i.name)],
          build: (item, _) {
            final i = data.positions.firstWhere((p) => p.id == item.id);
            return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(i.name, style: i.archived ? TextStyle(color: theme.disabledColor) : null),
            subtitle: i.archived ? Text(t.archived) : null,
            trailing: company.readOnly
                ? null
                : PopupMenuButton<String>(
                    onSelected: (a) => a == 'rename'
                        ? _edit(context, 'positions', i)
                        : _run(context,
                            () => session.api.updateCatalogItem(company.id, 'positions', i.id, archived: !i.archived)),
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 'rename', child: Text(t.rename)),
                      PopupMenuItem(value: 'archive', child: Text(i.archived ? t.reactivate : t.archive)),
                    ],
                  ),
            );
          },
        ),
      ],
    );
  }

  Widget _sites(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    final mine = membership.managedSites;
    final own = _ownSites;
    final tree = [for (final (s, d) in data.siteTree) if (mine == null || mine.contains(s.id)) (s, d)];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _header(context, t.sites, membership.managesAll ? () => _edit(context, 'sites', null) : null),
        Text(data.sites.isEmpty ? t.sitesHint : t.siteTreeHint, style: theme.textTheme.bodySmall),
        _Filtered(
          items: [for (final (s, d) in tree) PickItem(s.id, s.name, indent: d, selectedText: data.sitePath(s.id))],
          build: (item, flat) {
            final (s, depth) = tree.firstWhere((x) => x.$1.id == item.id);
            return ListTile(
            // Recherche ou tri : liste à plat, chemin complet (Nord › Lille › Gare).
            contentPadding: EdgeInsets.only(left: flat ? 0 : 20.0 * depth),
            leading: Icon(depth == 0 || flat ? Icons.account_tree_outlined : Icons.subdirectory_arrow_right, size: 20),
            title: Text(flat ? item.selectedText ?? s.name : s.name,
                style: s.archived ? TextStyle(color: theme.disabledColor) : null),
            subtitle: s.archived ? Text(t.archived) : null,
            trailing: company.readOnly
                ? null
                : PopupMenuButton<String>(
                    onSelected: (a) => switch (a) {
                      'sub' => _edit(context, 'sites', null, parent: s),
                      'rename' => _edit(context, 'sites', s),
                      'move' => _move(context, s),
                      _ => _run(context, () => session.api.updateCatalogItem(company.id, 'sites', s.id, archived: !s.archived)),
                    },
                    itemBuilder: (_) {
                      // Un responsable de site ne renomme pas les sites qu'on lui a confiés.
                      final editable = membership.managesAll || !own.contains(s.id);
                      return [
                        if (!s.archived && depth + 1 < maxDepth) PopupMenuItem(value: 'sub', child: Text(t.addSubSite)),
                        if (editable) PopupMenuItem(value: 'rename', child: Text(t.rename)),
                        if (membership.managesAll) PopupMenuItem(value: 'move', child: Text(t.moveSite)),
                        if (editable) PopupMenuItem(value: 'archive', child: Text(s.archived ? t.reactivate : t.archive)),
                      ];
                    },
                  ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _edit(BuildContext context, String kind, CatalogItem? item, {CatalogItem? parent}) async {
    final t = context.l10n;
    final name = TextEditingController(text: item?.name);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item != null ? t.rename : (parent != null ? t.subSiteOf(parent.name) : t.add)),
        content: TextField(
          controller: name,
          autofocus: true,
          decoration: InputDecoration(labelText: t.name),
          onSubmitted: (_) => Navigator.pop(context, true),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.save)),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    await _run(
        context,
        () => item == null
            ? session.api.addCatalogItem(company.id, kind, name.text, parentId: parent?.id)
            : session.api.updateCatalogItem(company.id, kind, item.id, name: name.text));
  }

  /// Placer un site (et ce qui est en dessous) sous un autre, ou au premier niveau.
  Future<void> _move(BuildContext context, CatalogItem site) async {
    final t = context.l10n;
    final branch = data.expandSites([site.id]);
    final tree = data.siteTree;
    // Hauteur de sa branche : lui seul = 1.
    int height(String id) {
      final children = data.sites.where((s) => s.parentId == id);
      return 1 + children.fold(0, (h, c) => height(c.id) > h ? height(c.id) : h);
    }
    final h = height(site.id);
    final targets = [
      for (final (s, d) in tree)
        if (!s.archived && !branch.contains(s.id) && d + 1 + h <= maxDepth) (s, d),
    ];
    final picked = await showDialog<({String? id})>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(t.moveSiteTitle(site.name)),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, (id: null)),
            child: Text(t.topLevel, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          for (final (s, d) in targets)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, (id: s.id)),
              child: Padding(padding: EdgeInsets.only(left: 16.0 * d), child: Text(s.name)),
            ),
        ],
      ),
    );
    if (picked == null || picked.id == site.parentId || !context.mounted) return;
    await _run(context, () => session.api.updateCatalogItem(company.id, 'sites', site.id, move: true, parentId: picked.id));
  }

  Future<void> _run(BuildContext context, Future<void> Function() action) async {
    await runAction(context, session, action);
    onChanged();
  }
}

/// Liste de postes ou de sites : à partir de 15, une recherche et un tri
/// (ordre habituel ou par nom) apparaissent, comme dans « Configurations ».
class _Filtered extends StatefulWidget {
  final List<PickItem> items;

  /// [flat] : recherche ou tri en cours (plus d'arbre).
  final Widget Function(PickItem item, bool flat) build;

  const _Filtered({required this.items, required this.build});

  static const threshold = 15;

  @override
  State<_Filtered> createState() => _FilteredState();
}

class _FilteredState extends State<_Filtered> {
  final _query = TextEditingController();
  var _sort = PickSort.natural;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.length < _Filtered.threshold) {
      return Column(children: [for (final i in widget.items) widget.build(i, false)]);
    }
    final t = context.l10n;
    final shown = sortItems(searchItems(widget.items, _query.text), _sort);
    final flat = _query.text.trim().isNotEmpty || _sort != PickSort.natural;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 8),
      Row(children: [
        Expanded(
          child: TextField(
            controller: _query,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
              prefixIcon: const Icon(Icons.search, size: 20),
              hintText: t.pickSearch,
              suffixIcon: _query.text.isEmpty
                  ? null
                  : IconButton(icon: const Icon(Icons.close, size: 18), onPressed: () => setState(_query.clear)),
            ),
          ),
        ),
        PopupMenuButton<PickSort>(
          tooltip: t.pickSortTitle,
          icon: const Icon(Icons.sort),
          onSelected: (s) => setState(() => _sort = s),
          itemBuilder: (_) => [
            for (final s in const [PickSort.natural, PickSort.name])
              CheckedPopupMenuItem(value: s, checked: s == _sort, child: Text(s.label(t))),
          ],
        ),
      ]),
      if (shown.isEmpty)
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: Text(t.pickNoResult, style: Theme.of(context).textTheme.bodySmall)),
        ),
      for (final i in shown) widget.build(i, flat),
    ]);
  }
}
