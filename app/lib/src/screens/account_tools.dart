import 'package:flutter/material.dart';

import '../api.dart';
import '../brand.dart';
import '../dates.dart';
import '../i18n.dart';
import '../session.dart';
import 'billing_page.dart';
import 'home_screen.dart';
import 'tools_widgets.dart';

/// Conditions d'utilisation (`terms`) ou confidentialité (`privacy`) sur
/// le site, dans la langue de l'application (français, ukrainien, sinon anglais).
String legalUrl(BuildContext context, String page) {
  final lang = switch (context.localeName) {
    'fr' => 'fr',
    'uk' || 'ru' => 'ua',
    _ => 'en',
  };
  return 'https://staff-flow.cloud/$lang/$page/';
}

/// Demande un lien temporaire au serveur ([linkPath]) et ouvre le fichier.
Future<void> downloadFromServer(BuildContext context, Session session, String linkPath) async {
  final t = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  final sep = linkPath.contains('?') ? '&' : '?';
  try {
    final r = await session.api.send('GET', '$linkPath${sep}lang=${context.localeName}');
    if (!context.mounted) return;
    await openUrl(context, serverUrl(r['path'] as String));
  } on OfflineException {
    messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
  } on ApiException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
  }
}

/// Telegram vérifié : relier (le bot confirme), délier, et l'afficher ou
/// non dans chacune de ses entreprises.
class TelegramCard extends StatelessWidget {
  final Session session;

  const TelegramCard({super.key, required this.session});

  Future<void> _link(BuildContext context) async {
    final t = context.l10n;
    await runAction(context, session, () async {
      final r = await session.api.send('POST', '/me/telegram/link');
      if (!context.mounted) return;
      await openUrl(context, r['url'] as String);
      if (!context.mounted) return;
      // Le temps de toucher « Démarrer » dans Telegram, puis on revient.
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(t.telegramTitle),
          content: Text(t.telegramLinkHint),
          actions: [FilledButton(onPressed: () => Navigator.pop(context), child: Text(t.close))],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final me = session.me!;
    final telegram = me.telegramUsername;
    final linked = me.telegramLinked;
    return Card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ListTile(
          leading: const Icon(Icons.send_outlined, color: Brand.blue),
          title: Text(t.telegramTitle),
          subtitle: Text(!linked
              ? (me.telegramBot == null ? t.telegramUnavailable : t.telegramNotLinked)
              : t.telegramLinked(telegram == null ? t.telegramNoUsername : '@$telegram')),
          trailing: linked
              ? TextButton(
                  onPressed: () => runAction(context, session, () => session.api.send('DELETE', '/me/telegram')),
                  child: Text(t.telegramUnlink),
                )
              : null,
        ),
        if (!linked && me.telegramBot != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: FilledButton.icon(
              onPressed: () => _link(context),
              icon: const Icon(Icons.link),
              label: Text(t.telegramLink),
            ),
          ),
        if (linked && telegram != null && me.companies.isNotEmpty) ...[
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(t.telegramShowIn, style: Theme.of(context).textTheme.titleSmall),
          ),
          for (final m in me.companies)
            SwitchListTile(
              title: Text(m.company.name),
              value: m.showTelegram,
              onChanged: (v) => runAction(context, session,
                  () => session.api.send('PUT', '/companies/${m.company.id}/telegram', body: {'show': v})),
            ),
        ],
      ]),
    );
  }
}

/// Nouveau QR code (et nouvel identifiant), après confirmation ; `true` s'il a changé.
Future<bool> confirmNewQrCode(BuildContext context, Session session) async {
  final t = context.l10n;
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.newQrCode),
      content: Text(t.newQrCodeConfirm),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
        FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.newQrCode)),
      ],
    ),
  );
  if (ok != true || !context.mounted) return false;
  final before = session.me!.user.publicId;
  await runAction(context, session, () => session.api.send('POST', '/me/qr'), success: t.newQrCodeDone);
  return session.me!.user.publicId != before;
}

/// Comment changer de compte Google sans perdre son compte.
Future<void> showChangeGoogleHelp(BuildContext context, Session session) {
  final t = context.l10n;
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.changeGoogle),
      content: SingleChildScrollView(
        child: Text('${t.changeGoogleBot('@${session.me!.telegramBot ?? 'Staff_Flow_Bot'}')}\n\n'
            '${t.changeGoogleSteps(session.me!.user.publicId)}\n\n${t.changeGoogleNoTelegram}'),
      ),
      actions: [FilledButton(onPressed: () => Navigator.pop(context), child: Text(t.close))],
    ),
  );
}

/// Depuis un compte Google tout neuf : reprendre son ancien compte avec un
/// code reçu sur son Telegram.
Future<void> showRecoverDialog(BuildContext context, Session session) async {
  final t = context.l10n;
  final id = TextEditingController();
  final code = TextEditingController();
  var sent = false;
  var busy = false;
  String? error;
  final token = await showDialog<String>(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      Future<void> run(Future<void> Function() action) async {
        setState(() {
          busy = true;
          error = null;
        });
        try {
          await action();
        } on ApiException catch (e) {
          error = e.describe(t);
        } on OfflineException {
          error = t.offlineUnavailable;
        } catch (_) {
          error = t.serverUnreachable;
        }
        if (context.mounted) setState(() => busy = false);
      }

      return AlertDialog(
        title: Text(t.recoverAccount),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(t.recoverHint),
            TextField(
              controller: id,
              enabled: !sent,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: t.recoverIdLabel),
            ),
            if (sent) ...[
              const SizedBox(height: 12),
              Text(t.recoverCodeSent),
              TextField(
                controller: code,
                keyboardType: TextInputType.number,
                maxLength: 6,
                autofocus: true,
                style: const TextStyle(fontSize: 22, letterSpacing: 6),
                decoration: InputDecoration(labelText: t.recoverCodeLabel, counterText: ''),
              ),
            ],
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
          if (!sent)
            FilledButton(
              onPressed: busy
                  ? null
                  : () => run(() async {
                        await session.api.send('POST', '/me/recover', body: {'publicId': id.text});
                        sent = true;
                      }),
              child: Text(t.recoverSend),
            )
          else
            FilledButton(
              onPressed: busy
                  ? null
                  : () => run(() async {
                        final r = await session.api.send('POST', '/me/recover/confirm', body: {'code': code.text});
                        if (context.mounted) Navigator.pop(context, r['token'] as String);
                      }),
              child: Text(t.recoverConfirm),
            ),
        ],
      );
    }),
  );
  if (token == null || !context.mounted) return;
  final messenger = ScaffoldMessenger.of(context);
  await session.switchToken(token);
  messenger.showSnackBar(SnackBar(content: Text(t.recoverDone)));
}

/// Suppression du compte : fantôme (on revient avec le même compte Google)
/// ou effacement définitif. Un « Ghost » anonyme reste toujours dans
/// l'historique des entreprises.
Future<void> showDeleteAccountDialog(BuildContext context, Session session) async {
  final t = context.l10n;
  final theme = Theme.of(context);
  final erase = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.deleteAccount),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(t.deleteGhostNote, style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          Text(t.deleteOwnerNote, style: theme.textTheme.bodySmall),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_off_outlined),
              title: Text(t.deleteGhost),
              subtitle: Text(t.deleteGhostHint),
              onTap: () => Navigator.pop(context, false),
            ),
          ),
          Card(
            color: theme.colorScheme.errorContainer,
            child: ListTile(
              leading: const Icon(Icons.delete_forever_outlined),
              title: Text(t.deleteErase),
              subtitle: Text(t.deleteEraseHint),
              onTap: () => Navigator.pop(context, true),
            ),
          ),
        ]),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel))],
    ),
  );
  if (erase == null || !context.mounted) return;
  // Dernière confirmation.
  final sure = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(erase ? t.deleteErase : t.deleteGhost),
      content: Text(erase ? t.deleteEraseHint : t.deleteGhostHint),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: theme.colorScheme.error),
          onPressed: () => Navigator.pop(context, true),
          child: Text(t.deleteConfirmButton),
        ),
      ],
    ),
  );
  if (sure != true || !context.mounted) return;
  final messenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context);
  try {
    await session.api.send('POST', '/me/delete', body: {'erase': erase});
  } on ApiException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    return;
  } on OfflineException {
    messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    return;
  }
  navigator.popUntil((r) => r.isFirst);
  await session.signOut();
}

/// Factures des entreprises fermées dont on était le dernier propriétaire.
class ClosedInvoicesPage extends StatefulWidget {
  final Session session;

  const ClosedInvoicesPage({super.key, required this.session});

  static Future<void> open(BuildContext context, Session session) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => ClosedInvoicesPage(session: session)));

  @override
  State<ClosedInvoicesPage> createState() => _ClosedInvoicesPageState();
}

class _ClosedInvoicesPageState extends State<ClosedInvoicesPage> {
  late Future<List> _invoices = _load();

  Future<List> _load() async => (await widget.session.api.send('GET', '/me/invoices'))['invoices'] as List;

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    return Scaffold(
      appBar: AppBar(title: Text(t.closedInvoices)),
      body: FutureBuilder<List>(
        future: _invoices,
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(
              child: TextButton.icon(
                onPressed: () => setState(() {
                  _invoices = _load();
                }),
                icon: const Icon(Icons.refresh),
                label: Text(t.retry),
              ),
            );
          }
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final list = snap.data!;
          if (list.isEmpty) return Center(child: Text(t.billingNoInvoices));
          return ListView(padding: const EdgeInsets.all(16), children: [
            FilledButton.icon(
              onPressed: () => downloadFromServer(context, widget.session, '/me/invoices-zip/link'),
              icon: const Icon(Icons.folder_zip_outlined),
              label: Text(t.downloadAllInvoices),
            ),
            const SizedBox(height: 8),
            for (final i in list)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.receipt_long_outlined),
                title: Text('${i['number']}'),
                subtitle: Text('${i['companyName']} · ${longDate(DateTime.parse(i['issuedAt']).toLocal(), loc)}'
                    ' · ${euroAmount(context, i['amountCents'] as int)}'),
                trailing: const Icon(Icons.download_outlined),
                onTap: () => downloadFromServer(context, widget.session, '/me/invoices/${i['id']}/link'),
              ),
          ]);
        },
      ),
    );
  }
}
