import 'package:flutter/material.dart';

import '../models.dart';
import '../session.dart';
import 'company_tab.dart';
import 'home_screen.dart';

/// Sites (magasin A, entrepôt…) et postes (caisse, cuisine…) de l'entreprise.
class CatalogView extends StatelessWidget {
  final Session session;
  final Company company;
  final CompanyData data;
  final VoidCallback onChanged;

  const CatalogView(
      {super.key, required this.session, required this.company, required this.data, required this.onChanged});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(context, 'Postes', 'positions', data.positions,
              'Ce que fait la personne : caisse, cuisine, accueil…'),
          const SizedBox(height: 24),
          _section(context, 'Sites', 'sites', data.sites,
              'Où se passe le service, si l\'entreprise a plusieurs lieux.'),
        ],
      );

  Widget _section(
      BuildContext context, String title, String kind, List<CatalogItem> items, String hint) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
            if (!company.readOnly)
              TextButton.icon(
                onPressed: () => _edit(context, kind, null),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Ajouter'),
              ),
          ],
        ),
        if (items.isEmpty) Text(hint, style: theme.textTheme.bodySmall),
        for (final i in items)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(i.name,
                style: i.archived ? TextStyle(color: theme.disabledColor) : null),
            subtitle: i.archived ? const Text('Archivé') : null,
            trailing: company.readOnly
                ? null
                : PopupMenuButton<String>(
                    onSelected: (a) => a == 'rename'
                        ? _edit(context, kind, i)
                        : _run(context,
                            () => session.api.updateCatalogItem(company.id, kind, i.id, archived: !i.archived)),
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'rename', child: Text('Renommer')),
                      PopupMenuItem(value: 'archive', child: Text(i.archived ? 'Réactiver' : 'Archiver')),
                    ],
                  ),
          ),
      ],
    );
  }

  Future<void> _edit(BuildContext context, String kind, CatalogItem? item) async {
    final name = TextEditingController(text: item?.name);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item == null ? 'Ajouter' : 'Renommer'),
        content: TextField(
          controller: name,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nom'),
          onSubmitted: (_) => Navigator.pop(context, true),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Enregistrer')),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    await _run(
        context,
        () => item == null
            ? session.api.addCatalogItem(company.id, kind, name.text)
            : session.api.updateCatalogItem(company.id, kind, item.id, name: name.text));
  }

  Future<void> _run(BuildContext context, Future<void> Function() action) async {
    await runAction(context, session, action);
    onChanged();
  }
}
