import 'package:flutter/material.dart';

import '../api.dart';
import '../session.dart';

/// Administration de la plateforme (section 10 du cahier des charges) :
/// tableau de bord, tarifs et réglages modifiables en direct, journal.
///
/// Réservée aux administrateurs (adresses inscrites dans la configuration du
/// serveur). Écrite en français seulement : elle ne sert qu'à l'éditeur.
class AdminPage extends StatelessWidget {
  final Session session;

  const AdminPage({super.key, required this.session});

  static Future<void> open(BuildContext context, Session session) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => AdminPage(session: session)));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Administration'),
          bottom: const TabBar(tabs: [
            Tab(icon: Icon(Icons.insights), text: 'Activité'),
            Tab(icon: Icon(Icons.euro), text: 'Tarifs'),
            Tab(icon: Icon(Icons.history), text: 'Journal'),
          ]),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: TabBarView(children: [
              _Overview(session: session),
              _Settings(session: session),
              _Log(session: session),
            ]),
          ),
        ),
      ),
    );
  }
}

String euros(num cents) => '${(cents / 100).toStringAsFixed(2).replaceAll('.', ',')} €';

/// Libellés des réglages, par groupe.
const _groups = {
  'pricing': 'Abonnement',
  'options': 'Options',
  'extras': 'Extras',
  'durations': 'Durées',
};
const _labels = {
  'basePrice': 'Prix de base par mois',
  'includedStaff': 'Salariés inclus dans le prix de base',
  'tierSize': 'Taille d\'une tranche (salariés)',
  'tier1Price': 'Ajout par tranche : palier 1',
  'tier1End': 'Fin du palier 1 (salariés)',
  'tier2Price': 'Ajout par tranche : palier 2',
  'tier2End': 'Fin du palier 2 (salariés)',
  'tier3Price': 'Ajout par tranche : au-delà du palier 2',
  'annualMonths': 'Mois payés pour une année',
  'cascadeOptionPrice': 'Option « sites en cascade » par mois',
  'cascadeIncludedFrom': 'Option incluse à partir de (salariés)',
  'adRemovalPrice': 'Retrait de la publicité (achat unique)',
  'extrasIncluded': 'Extras inclus avec le prix de base',
  'extrasPercent': 'Extras ensuite (% de l\'effectif)',
  'extraMinDays': 'Durée minimale d\'un extra (jours)',
  'trialDays': 'Essai gratuit (jours)',
  'graceDays': 'Période de grâce (jours)',
  'priceNoticeDays': 'Préavis avant un changement de prix (jours)',
};

/// Nature de chaque réglage (pour afficher le journal).
const _kinds = {
  'basePrice': 'cents', 'tier1Price': 'cents', 'tier2Price': 'cents', 'tier3Price': 'cents',
  'cascadeOptionPrice': 'cents', 'adRemovalPrice': 'cents', 'extrasPercent': 'percent',
};

String _format(String kind, num value) => switch (kind) {
      'cents' => euros(value),
      'percent' => '$value %',
      _ => '$value',
    };

/// Charge une adresse de l'administration et affiche le résultat.
class _Loader extends StatefulWidget {
  final Session session;
  final String path;
  final Widget Function(BuildContext, Map<String, dynamic>, VoidCallback reload) builder;

  const _Loader({required this.session, required this.path, required this.builder});

  @override
  State<_Loader> createState() => _LoaderState();
}

class _LoaderState extends State<_Loader> with AutomaticKeepAliveClientMixin {
  late Future<Map<String, dynamic>> _data = _load();

  Future<Map<String, dynamic>> _load() async =>
      (await widget.session.api.send('GET', widget.path) as Map).cast<String, dynamic>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    void reload() => setState(() {
          _data = _load();
        });
    return FutureBuilder(
      future: _data,
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: TextButton.icon(
              onPressed: reload,
              icon: const Icon(Icons.refresh),
              label: Text(snap.error is OfflineException ? 'Hors connexion. Réessayer' : '${snap.error}\nRéessayer'),
            ),
          );
        }
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return RefreshIndicator(
          onRefresh: () async => reload(),
          child: widget.builder(context, snap.data!, reload),
        );
      },
    );
  }
}

class _Overview extends StatelessWidget {
  final Session session;

  const _Overview({required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _Loader(
      session: session,
      path: '/admin/overview',
      builder: (context, o, _) {
        Widget stat(String label, Object value, {String? sub}) => SizedBox(
              width: 168,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('$value', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                    Text(label),
                    if (sub != null) Text(sub, style: theme.textTheme.bodySmall),
                  ]),
                ),
              ),
            );
        final bands = (o['companiesBySize'] as Map).cast<String, dynamic>();
        return ListView(padding: const EdgeInsets.all(16), children: [
          Wrap(spacing: 8, runSpacing: 8, children: [
            stat('Utilisateurs', o['users'], sub: '+${o['usersLast30Days']} en 30 jours'),
            stat('Entreprises', o['companies'], sub: '+${o['companiesLast30Days']} en 30 jours'),
            stat('Entreprises actives', o['activeCompanies'], sub: '${o['readOnlyCompanies']} en lecture seule'),
            stat('Membres', o['memberships']),
            stat('Services (30 jours)', o['shiftsLast30Days']),
            stat('Messages (30 jours)', o['messagesLast30Days']),
          ]),
          const SizedBox(height: 16),
          Card(
            color: theme.colorScheme.primaryContainer,
            child: ListTile(
              leading: const Icon(Icons.savings_outlined),
              title: Text('Revenu théorique : ${euros(o['theoreticalMonthlyCents'])} par mois'),
              subtitle: const Text('Si chaque entreprise active payait son abonnement mensuel (sans options). '
                  'Abonnements, revenus réels, essais et périodes de grâce s\'afficheront ici une fois le paiement en place.'),
            ),
          ),
          const SizedBox(height: 16),
          Text('Entreprises actives par taille (salariés, sans les extras)', style: theme.textTheme.titleMedium),
          if (bands.isEmpty) const Text('Aucune.'),
          for (final e in bands.entries) ListTile(dense: true, title: Text(e.key), trailing: Text('${e.value}')),
        ]);
      },
    );
  }
}

class _Settings extends StatelessWidget {
  final Session session;

  const _Settings({required this.session});

  Future<void> _edit(BuildContext context, Map s, VoidCallback reload) async {
    final kind = s['kind'] as String;
    final cents = kind == 'cents';
    final field = TextEditingController(
        text: cents ? (s['value'] / 100).toStringAsFixed(2).replaceAll('.', ',') : '${s['value']}');
    final messenger = ScaffoldMessenger.of(context);
    final value = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_labels[s['key']] ?? s['key']),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: field,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(suffixText: cents ? '€' : (kind == 'percent' ? '%' : null)),
          ),
          const SizedBox(height: 8),
          Text('Valeur du fichier : ${_format(kind, s['fileValue'])}. '
              'Limites : ${_format(kind, s['min'])} à ${_format(kind, s['max'])}.'),
          const SizedBox(height: 4),
          const Text('Le nouveau prix s\'applique aussitôt aux nouveaux abonnements.'),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          FilledButton(
            onPressed: () {
              final n = double.tryParse(field.text.trim().replaceAll(',', '.').replaceAll(' ', ''));
              if (n == null) return;
              Navigator.pop(context, cents ? (n * 100).round() : n.round());
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
    if (value == null) return;
    await _send(messenger, () => session.api.send('PUT', '/admin/settings/${s['key']}', body: {'value': value}));
    reload();
  }

  Future<void> _send(ScaffoldMessengerState messenger, Future<void> Function() action) async {
    try {
      await action();
    } on OfflineException {
      messenger.showSnackBar(const SnackBar(content: Text('Hors connexion.')));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _Loader(
      session: session,
      path: '/admin/settings',
      builder: (context, data, reload) {
        final settings = [for (final s in data['settings']) (s as Map).cast<String, dynamic>()];
        return ListView(padding: const EdgeInsets.all(16), children: [
          _Quote(session: session, key: ValueKey(settings.map((s) => s['value']).join(','))),
          for (final g in _groups.entries) ...[
            const SizedBox(height: 16),
            Text(g.value, style: theme.textTheme.titleMedium),
            for (final s in settings.where((s) => s['group'] == g.key))
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(_labels[s['key']] ?? s['key']),
                subtitle: s['overridden'] == true
                    ? Text('Modifié (fichier : ${_format(s['kind'], s['fileValue'])})',
                        style: TextStyle(color: theme.colorScheme.tertiary))
                    : null,
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(_format(s['kind'], s['value']), style: const TextStyle(fontWeight: FontWeight.w700)),
                  IconButton(
                    tooltip: 'Modifier',
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => _edit(context, s, reload),
                  ),
                  if (s['overridden'] == true)
                    IconButton(
                      tooltip: 'Revenir à la valeur du fichier',
                      icon: const Icon(Icons.restart_alt),
                      onPressed: () async {
                        await _send(ScaffoldMessenger.of(context),
                            () => session.api.send('DELETE', '/admin/settings/${s['key']}'));
                        reload();
                      },
                    ),
                ]),
              ),
          ],
        ]);
      },
    );
  }
}

/// Simulation : le prix d'une entreprise avec les réglages en vigueur.
class _Quote extends StatefulWidget {
  final Session session;

  const _Quote({super.key, required this.session});

  @override
  State<_Quote> createState() => _QuoteState();
}

class _QuoteState extends State<_Quote> {
  final _staff = TextEditingController(text: '60');
  bool _cascade = false;
  Map<String, dynamic>? _quote;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _staff.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final staff = int.tryParse(_staff.text.trim());
    if (staff == null) return;
    try {
      final q = await widget.session.api.send('GET', '/admin/quote?staff=$staff&cascade=${_cascade ? 1 : 0}');
      if (mounted) setState(() => _quote = (q as Map).cast<String, dynamic>());
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final q = _quote;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Simulation', style: Theme.of(context).textTheme.titleMedium),
          Row(children: [
            SizedBox(
              width: 120,
              child: TextField(
                controller: _staff,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Salariés'),
                onChanged: (_) => _load(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CheckboxListTile(
                value: _cascade,
                title: const Text('Option « sites en cascade »'),
                onChanged: (v) {
                  setState(() => _cascade = v ?? false);
                  _load();
                },
              ),
            ),
          ]),
          if (q != null)
            Text('${euros(q['monthlyCents'])} par mois · ${euros(q['annualCents'])} payé pour l\'année',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        ]),
      ),
    );
  }
}

class _Log extends StatelessWidget {
  final Session session;

  const _Log({required this.session});

  @override
  Widget build(BuildContext context) {
    return _Loader(
      session: session,
      path: '/admin/log',
      builder: (context, data, _) {
        final entries = data['entries'] as List;
        if (entries.isEmpty) {
          return ListView(children: const [Padding(padding: EdgeInsets.all(24), child: Text('Aucune modification.'))]);
        }
        return ListView(padding: const EdgeInsets.all(16), children: [
          for (final e in entries)
            ListTile(
              leading: Icon(e['reset'] == true ? Icons.restart_alt : Icons.edit_outlined),
              title: Text(_labels[e['key']] ?? '${e['key']}'),
              subtitle: Text('${_format(_kinds[e['key']] ?? 'count', e['old'])} → '
                  '${_format(_kinds[e['key']] ?? 'count', e['new'])}${e['reset'] == true ? ' (valeur du fichier)' : ''}\n'
                  '${DateTime.parse(e['at']).toLocal().toString().substring(0, 16)} · ${e['by'] ?? '?'}'),
              isThreeLine: true,
            ),
        ]);
      },
    );
  }
}
