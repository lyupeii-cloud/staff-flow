import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import '../i18n.dart';
import '../models.dart';
import '../purchases.dart';
import '../session.dart';
import 'api_keys_page.dart';
import 'billing_page.dart';
import 'tools_widgets.dart';

/// Webhooks (option « API Pro ») : Staff Flow prévient les logiciels de
/// l'entreprise quand quelque chose se passe. 5 adresses au plus.
class WebhooksPage extends StatefulWidget {
  final Session session;
  final Company company;

  const WebhooksPage({super.key, required this.session, required this.company});

  static Future<void> open(BuildContext context, Session session, Company company) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => WebhooksPage(session: session, company: company)));

  @override
  State<WebhooksPage> createState() => _WebhooksPageState();
}

class _WebhooksPageState extends State<WebhooksPage> {
  late Future<Map<String, dynamic>> _data = _load();

  String get _base => '/companies/${widget.company.id}/webhooks';

  Future<Map<String, dynamic>> _load() async => await widget.session.api.send('GET', _base) as Map<String, dynamic>;

  void _reload() => setState(() {
        _data = _load();
      });

  /// Toujours payée : abonnement payé avec l'option « API Pro ».
  bool get _pro => widget.company.apiProOption && widget.company.billingStatus == 'active';

  static String eventLabel(L10n t, String e) => switch (e) {
        'schedule.published' => t.whEvSchedulePublished,
        'request.created' => t.whEvRequestCreated,
        'request.decided' => t.whEvRequestDecided,
        'request.cancelled' => t.whEvRequestCancelled,
        'request.cancel_asked' => t.whEvRequestCancelAsked,
        'request.cancel_decided' => t.whEvRequestCancelDecided,
        'request.ended' => t.whEvRequestEnded,
        'member.joined' => t.whEvMemberJoined,
        'announcement.published' => t.whEvAnnouncementPublished,
        _ => e,
      };

  static String statusLabel(L10n t, String s) => switch (s) {
        'delivered' => t.whStDelivered,
        'pending' => t.whStPending,
        'failed' => t.whStFailed,
        _ => t.whStDropped,
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

  /// Adresse et événements ; [hook] : modification des événements.
  Future<void> _edit(List<String> all, {Map? hook}) async {
    final t = context.l10n;
    final url = TextEditingController(text: hook?['url'] as String?);
    final events = <String>{...?(hook?['events'] as List?)?.cast<String>()};
    if (hook == null) events.addAll(all);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(hook == null ? t.whNew : '${hook['url']}'),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              if (hook == null)
                TextField(
                  controller: url,
                  autofocus: true,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(labelText: t.whUrl),
                ),
              const SizedBox(height: 12),
              Text(t.whEvents, style: Theme.of(context).textTheme.labelLarge),
              for (final e in all)
                CheckboxListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: events.contains(e),
                  onChanged: (v) => setState(() => v == true ? events.add(e) : events.remove(e)),
                  title: Text(eventLabel(t, e)),
                  subtitle: Text(e, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                ),
            ]),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(hook == null ? t.create : t.save)),
          ],
        ),
      ),
    );
    if (ok != true || events.isEmpty || !mounted) return;
    if (hook != null) {
      await _run(() => widget.session.api.send('PATCH', '$_base/${hook['id']}', body: {'events': events.toList()}));
      return;
    }
    if (url.text.trim().isEmpty) return;
    await _run(() async {
      final r = await widget.session.api.send('POST', _base, body: {'url': url.text.trim(), 'events': events.toList()});
      if (!mounted) return;
      final secret = r['secret'] as String;
      // Le secret n'est montré qu'une fois.
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(t.whTitle),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(t.whCreated),
            const SizedBox(height: 12),
            SelectableText(secret, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
          ]),
          actions: [
            TextButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: secret));
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

  Future<void> _test(Map hook) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    await _run(() async {
      final r = await widget.session.api.send('POST', '$_base/${hook['id']}/test');
      messenger.showSnackBar(SnackBar(
          content: Text(r['delivered'] == true
              ? t.whTestOk('${r['httpStatus']}')
              : t.whTestFail('${r['error'] ?? r['httpStatus']}'))));
    });
  }

  Future<void> _delete(Map hook) async {
    final t = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${t.whDelete} · ${hook['url']}'),
        content: Text(t.whDeleteConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.whDelete)),
        ],
      ),
    );
    if (ok == true) await _run(() => widget.session.api.send('DELETE', '$_base/${hook['id']}'));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    final theme = Theme.of(context);
    return FutureBuilder<Map<String, dynamic>>(
      future: _data,
      builder: (context, snap) {
        final all = [for (final e in (snap.data?['events'] as List? ?? const [])) e as String];
        final hooks = (snap.data?['webhooks'] as List? ?? const []).cast<Map>();
        return Scaffold(
          appBar: AppBar(title: Text(t.whTitle)),
          floatingActionButton: _pro && snap.hasData && hooks.length < 5
              ? FloatingActionButton.extended(
                  onPressed: () => _edit(all), icon: const Icon(Icons.add_link), label: Text(t.whNew))
              : null,
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: RefreshIndicator(
                onRefresh: () async {
                  _reload();
                  await _data;
                },
                child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
                    children: [
                      Text(t.whSub),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () => openUrl(context, ApiKeysPage.docsUrl(context)),
                          icon: const Icon(Icons.menu_book_outlined),
                          label: Text(t.apiDocs),
                        ),
                      ),
                      if (!_pro)
                        Card(
                          color: theme.colorScheme.tertiaryContainer,
                          child: ListTile(
                            leading: const Icon(Icons.lock_outline),
                            title: Text(Purchases.enabled ? t.apiProNeeded : t.apiProNotActive),
                            trailing: Purchases.enabled ? const Icon(Icons.chevron_right) : null,
                            onTap: Purchases.enabled
                                ? () => BillingPage.open(context, widget.session, widget.company)
                                : null,
                          ),
                        ),
                      const SizedBox(height: 8),
                      if (snap.hasError)
                        TextButton.icon(onPressed: _reload, icon: const Icon(Icons.refresh), label: Text(t.retry))
                      else if (!snap.hasData)
                        const Center(child: CircularProgressIndicator())
                      else if (hooks.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(child: Text(t.whNone, style: theme.textTheme.bodySmall)),
                        ),
                      for (final h in hooks) _card(t, loc, theme, all, h),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _card(L10n t, String loc, ThemeData theme, List<String> all, Map h) {
    final enabled = h['enabled'] == true;
    final recent = (h['recent'] as List? ?? const []).cast<Map>();
    final last = recent.isEmpty ? null : recent.first;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(enabled ? Icons.link : Icons.link_off, color: enabled ? null : theme.colorScheme.error),
            const SizedBox(width: 12),
            Expanded(child: Text('${h['url']}', style: theme.textTheme.titleSmall)),
          ]),
          const SizedBox(height: 6),
          Text([for (final e in (h['events'] as List).cast<String>()) eventLabel(t, e)].join(' · '),
              style: theme.textTheme.bodySmall),
          if (last != null)
            Text(
                t.whLast(DateFormat.yMMMd(loc).add_Hm().format(DateTime.parse(last['at'] as String).toLocal()),
                    statusLabel(t, last['status'] as String)),
                style: theme.textTheme.bodySmall),
          if (!enabled) Text(t.whDisabled, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error)),
          Wrap(alignment: WrapAlignment.end, children: [
            if (!enabled)
              TextButton(
                  onPressed: () => _run(() => widget.session.api.send('PATCH', '$_base/${h['id']}', body: {'enabled': true})),
                  child: Text(t.whEnable)),
            if (_pro) TextButton(onPressed: () => _test(h), child: Text(t.whTest)),
            TextButton(onPressed: () => _edit(all, hook: h), child: Text(t.whEvents)),
            TextButton(onPressed: () => _delete(h), child: Text(t.whDelete)),
          ]),
        ]),
      ),
    );
  }
}
