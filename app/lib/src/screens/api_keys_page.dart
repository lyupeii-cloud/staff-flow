import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'billing_page.dart';
import 'tools_widgets.dart';

/// Accès API (option payante) : le patron crée des clés pour ses logiciels
/// de comptabilité, de paie ou son CRM, et les révoque.
class ApiKeysPage extends StatefulWidget {
  final Session session;
  final Company company;

  const ApiKeysPage({super.key, required this.session, required this.company});

  static Future<void> open(BuildContext context, Session session, Company company) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => ApiKeysPage(session: session, company: company)));

  /// Documentation, dans la langue de l'application (français, ukrainien, sinon anglais).
  static String docsUrl(BuildContext context) => 'https://staff-flow.cloud/${switch (context.localeName) {
        'fr' => 'fr',
        'uk' || 'ru' => 'ua',
        _ => 'en',
      }}/api/';

  @override
  State<ApiKeysPage> createState() => _ApiKeysPageState();
}

class _ApiKeysPageState extends State<ApiKeysPage> {
  late Future<List> _keys = _load();

  String get _base => '/companies/${widget.company.id}/api-keys';

  Future<List> _load() async => (await widget.session.api.send('GET', _base))['keys'] as List;

  void _reload() => setState(() {
        _keys = _load();
      });

  bool get _allowed {
    final c = widget.company;
    return c.billingStatus == 'trial' || c.billingStatus == 'comped' || c.apiOption || _pro;
  }

  /// Écriture (« API Pro ») : abonnement payé avec l'option, ou entreprise offerte.
  bool get _pro {
    final c = widget.company;
    return c.billingStatus == 'comped' || (c.apiProOption && c.billingStatus == 'active');
  }

  static const _writeScopes = ['shifts', 'publish', 'members', 'catalog', 'news', 'requests'];

  String _scopeLabel(L10n t, String s) => switch (s) {
        'read' => t.scopeRead,
        'shifts' => t.scopeShifts,
        'publish' => t.scopePublish,
        'members' => t.scopeMembers,
        'catalog' => t.scopeCatalog,
        'news' => t.scopeNews,
        _ => t.scopeRequests,
      };

  Future<void> _run(Future<void> Function() action) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
    _reload();
  }

  Future<void> _create() async {
    final t = context.l10n;
    final name = TextEditingController();
    final scopes = <String>{'read'};
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
        title: Text(t.apiNewKey),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextField(
              controller: name,
              autofocus: true,
              maxLength: 60,
              decoration: InputDecoration(labelText: t.apiKeyName),
            ),
            Text(t.apiScopesTitle, style: Theme.of(context).textTheme.labelLarge),
            for (final s in ['read', ..._writeScopes])
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                value: scopes.contains(s),
                // Écriture : seulement avec l'option « API Pro ».
                onChanged: s != 'read' && !_pro ? null : (v) => setState(() => v == true ? scopes.add(s) : scopes.remove(s)),
                title: Text(_scopeLabel(t, s)),
              ),
            if (!_pro) Text(t.apiProNeeded, style: Theme.of(context).textTheme.bodySmall),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.create)),
        ],
      ),
      ),
    );
    if (ok != true || name.text.trim().isEmpty || scopes.isEmpty || !mounted) return;
    await _run(() async {
      final r = await widget.session.api
          .send('POST', _base, body: {'name': name.text.trim(), 'scopes': scopes.toList()});
      if (!mounted) return;
      final key = r['key'] as String;
      // La clé n'est montrée qu'une fois.
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(r['name'] as String),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(t.apiKeyCreated),
            const SizedBox(height: 12),
            SelectableText(key, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
          ]),
          actions: [
            TextButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: key));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.apiKeyCopied)));
              },
              icon: const Icon(Icons.copy),
              label: Text(t.apiKeyCopy),
            ),
            FilledButton(onPressed: () => Navigator.pop(context), child: Text(t.close)),
          ],
        ),
      );
    });
  }

  Future<void> _revoke(Map k) async {
    final t = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${t.apiRevoke} · ${k['name']}'),
        content: Text(t.apiRevokeConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.apiRevoke)),
        ],
      ),
    );
    if (ok == true) await _run(() => widget.session.api.send('DELETE', '$_base/${k['id']}'));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.apiTitle)),
      floatingActionButton: _allowed
          ? FloatingActionButton.extended(onPressed: _create, icon: const Icon(Icons.key), label: Text(t.apiNewKey))
          : null,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Text(t.apiSub),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => openUrl(context, ApiKeysPage.docsUrl(context)),
                icon: const Icon(Icons.menu_book_outlined),
                label: Text(t.apiDocs),
              ),
            ),
            if (!_allowed)
              Card(
                color: theme.colorScheme.tertiaryContainer,
                child: ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: Text(t.apiNeedsOption),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => BillingPage.open(context, widget.session, widget.company),
                ),
              ),
            const SizedBox(height: 8),
            FutureBuilder<List>(
              future: _keys,
              builder: (context, snap) {
                if (snap.hasError) {
                  return TextButton.icon(onPressed: _reload, icon: const Icon(Icons.refresh), label: Text(t.retry));
                }
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                return Column(children: [
                  for (final k in snap.data!)
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.key_outlined),
                        title: Text('${k['name']}'),
                        subtitle: Text('${k['prefix']}…\n'
                            '${[for (final s in (k['scopes'] as List? ?? const ['read'])) _scopeLabel(t, s as String)].join(' · ')}\n'
                            '${k['lastUsedAt'] == null ? t.apiKeyNeverUsed : t.apiKeyLastUsed(longDate(DateTime.parse(k['lastUsedAt']).toLocal(), loc))}'),
                        isThreeLine: true,
                        trailing: TextButton(onPressed: () => _revoke(k as Map), child: Text(t.apiRevoke)),
                      ),
                    ),
                ]);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
