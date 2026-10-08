import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';

/// Un onglet par entreprise dont l'utilisateur est membre (section 3).
class HomeScreen extends StatelessWidget {
  final Session session;

  const HomeScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final me = session.me!;
    final companies = me.companies;
    return DefaultTabController(
      key: ValueKey(companies.map((m) => m.company.id).join(',')),
      length: companies.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Staff Flow'),
          actions: [
            IconButton(
              tooltip: 'Nouvelle entreprise',
              icon: const Icon(Icons.add_business),
              onPressed: () => createCompany(context, session),
            ),
            _ProfileMenu(session: session),
          ],
          bottom: companies.isEmpty
              ? null
              : TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [for (final m in companies) Tab(text: m.company.name)],
                ),
        ),
        body: Column(
          children: [
            for (final t in me.pendingTransfers) _TransferBanner(session: session, transfer: t),
            Expanded(
              child: companies.isEmpty
                  ? _NoCompany(session: session)
                  : TabBarView(
                      children: [
                        for (final m in companies)
                          CompanyTab(key: ValueKey(m.company.id), session: session, membership: m),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

const timezones = [
  'Europe/Paris',
  'Europe/Brussels',
  'Europe/Zurich',
  'Europe/Luxembourg',
  'Europe/London',
  'Europe/Berlin',
  'Europe/Madrid',
  'Europe/Rome',
  'America/Toronto',
  'America/Montreal',
  'America/New_York',
  'America/Los_Angeles',
  'Africa/Casablanca',
  'Africa/Dakar',
  'Indian/Reunion',
  'America/Martinique',
  'Pacific/Noumea',
  'UTC',
];

Future<void> createCompany(BuildContext context, Session session) async {
  final name = TextEditingController();
  var timezone = timezones.first;
  final created = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Nouvelle entreprise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: timezone,
              decoration: const InputDecoration(labelText: 'Fuseau horaire'),
              items: [for (final z in timezones) DropdownMenuItem(value: z, child: Text(z))],
              onChanged: (z) => setState(() => timezone = z!),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Annuler')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Créer')),
        ],
      ),
    ),
  );
  if (created != true || !context.mounted) return;
  await runAction(context, session, () => session.api.createCompany(name.text, timezone));
}

/// Lance une action de l'API, affiche l'erreur éventuelle, puis recharge `/me`.
Future<void> runAction(BuildContext context, Session session, Future<void> Function() action,
    {String? success}) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await action();
    if (success != null) messenger.showSnackBar(SnackBar(content: Text(success)));
  } on ApiException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
  } catch (_) {
    messenger.showSnackBar(const SnackBar(content: Text('Serveur injoignable.')));
  }
  await session.refresh().catchError((_) {});
}

class _NoCompany extends StatelessWidget {
  final Session session;

  const _NoCompany({required this.session});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.storefront, size: 48),
              const SizedBox(height: 12),
              const Text('Vous ne faites partie d\'aucune entreprise.', textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text('Créez la vôtre, ou donnez votre identifiant ${session.me!.user.publicId} '
                  'à votre responsable.',
                  textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => createCompany(context, session),
                icon: const Icon(Icons.add_business),
                label: const Text('Créer une entreprise'),
              ),
            ],
          ),
        ),
      );
}

class _TransferBanner extends StatelessWidget {
  final Session session;
  final Transfer transfer;

  const _TransferBanner({required this.session, required this.transfer});

  @override
  Widget build(BuildContext context) {
    final company = session.me!.companies
        .where((m) => m.company.id == transfer.companyId)
        .firstOrNull
        ?.company
        .name;
    return MaterialBanner(
      content: Text('On vous propose de devenir propriétaire de « ${company ?? 'une entreprise'} ».'),
      actions: [
        TextButton(
          onPressed: () => runAction(context, session,
              () => session.api.answerTransfer(transfer.id, accept: false)),
          child: const Text('Refuser'),
        ),
        FilledButton(
          onPressed: () => runAction(
              context, session, () => session.api.answerTransfer(transfer.id, accept: true),
              success: 'Vous êtes maintenant propriétaire.'),
          child: const Text('Accepter'),
        ),
      ],
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  final Session session;

  const _ProfileMenu({required this.session});

  @override
  Widget build(BuildContext context) {
    final user = session.me!.user;
    return PopupMenuButton<String>(
      tooltip: 'Mon compte',
      icon: CircleAvatar(
        radius: 16,
        backgroundImage: user.photoUrl == null ? null : NetworkImage(user.photoUrl!),
        child: user.photoUrl == null ? Text(user.name.characters.first.toUpperCase()) : null,
      ),
      onSelected: (v) {
        if (v == 'copy') {
          Clipboard.setData(ClipboardData(text: user.publicId));
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Identifiant copié.')));
        } else if (v == 'logout') {
          session.signOut();
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(enabled: false, child: Text('${user.name}\n${user.email}')),
        PopupMenuItem(value: 'copy', child: Text('Mon identifiant : ${user.publicId}')),
        const PopupMenuItem(value: 'logout', child: Text('Se déconnecter')),
      ],
    );
  }
}
