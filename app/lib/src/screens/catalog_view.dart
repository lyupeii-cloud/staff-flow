import 'package:flutter/material.dart';

import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';
import 'home_screen.dart';
import 'tools_widgets.dart';

/// Sites (magasin A, entrepôt…) et postes (caisse, cuisine…) de l'entreprise.
/// Les sites vont en cascade, sur trois niveaux (région › ville › magasin) ;
/// un responsable de site gère ici les sites en dessous des siens.
class CatalogView extends StatelessWidget {
  final Session session;
  final Membership membership;
  final CompanyData data;
  final VoidCallback onChanged;

  const CatalogView(
      {super.key, required this.session, required this.membership, required this.data, required this.onChanged});

  static const maxDepth = 3;

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
        for (final i in data.positions)
          ListTile(
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
        for (final (s, depth) in tree)
          ListTile(
            contentPadding: EdgeInsets.only(left: 20.0 * depth),
            leading: Icon(depth == 0 ? Icons.account_tree_outlined : Icons.subdirectory_arrow_right, size: 20),
            title: Text(s.name, style: s.archived ? TextStyle(color: theme.disabledColor) : null),
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
