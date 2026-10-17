import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../api.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';
import 'home_screen.dart';
import 'people_widgets.dart';
import 'pick_list.dart';
import 'tools_widgets.dart';

/// Code d'invitation dans un QR code : https://…/invite/ABCD2345.
final inviteQr = RegExp(r'/INVITE/([A-Z2-9]{8})');

/// « ABCD2345 » → « ABCD-2345 ».
String formatInviteCode(String code) => code.length == 8 ? '${code.substring(0, 4)}-${code.substring(4)}' : code;

/// La personne saisit (ou scanne) le code reçu de son employeur.
Future<void> showInviteCodeDialog(BuildContext context, Session session, {String? initial}) async {
  final t = context.l10n;
  final code = TextEditingController(text: initial == null ? null : formatInviteCode(initial));
  final ok = await showDialog<bool>(
    context: context,
    builder: (dialog) => AlertDialog(
      title: Text(t.inviteCodeTitle),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(t.inviteCodeHint),
        const SizedBox(height: 12),
        TextField(
          controller: code,
          autofocus: initial == null,
          textCapitalization: TextCapitalization.characters,
          style: const TextStyle(fontSize: 22, letterSpacing: 3),
          decoration: const InputDecoration(hintText: 'ABCD-2345'),
          onSubmitted: (_) => Navigator.pop(dialog, true),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () async {
            final qr = await scanQrCode(dialog, accept: inviteQr);
            final found = qr == null ? null : inviteQr.firstMatch(qr.toUpperCase())?[1];
            if (found != null && dialog.mounted) {
              code.text = formatInviteCode(found);
              Navigator.pop(dialog, true);
            }
          },
          icon: const Icon(Icons.qr_code_scanner),
          label: Text(t.scanQrCode),
        ),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialog, false), child: Text(t.cancel)),
        FilledButton(onPressed: () => Navigator.pop(dialog, true), child: Text(t.validate)),
      ],
    ),
  );
  if (ok != true || !context.mounted) return;
  String? company;
  await runAction(context, session, () async {
    final r = await session.api.send('POST', '/invites/redeem', body: {'code': code.text});
    company = r['companyName'] as String?;
    await session.refresh();
  });
  if (company != null && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.inviteJoined(company!))));
  }
}

/// Importation des salariés : modèle à remplir, fichier, aperçu, invitations.
class ImportPage extends StatefulWidget {
  final Session session;
  final Company company;
  final CompanyData data;

  const ImportPage({super.key, required this.session, required this.company, required this.data});

  static Future<void> open(BuildContext context, Session session, Company company, CompanyData data) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ImportPage(session: session, company: company, data: data)));

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  String? _fileName;
  String? _file;
  Map<String, dynamic>? _preview;
  bool _busy = false;

  L10n get t => context.l10n;

  Future<void> _pick() async {
    final file = await FilePicker.pickFile(type: FileType.custom, allowedExtensions: ['xlsx', 'csv']);
    final bytes = file == null ? null : await file.readAsBytes();
    if (file == null || bytes == null || !mounted) return;
    setState(() {
      _fileName = file.name;
      _file = base64Encode(bytes);
      _preview = null;
    });
    await _send(dryRun: true);
  }

  Future<void> _send({required bool dryRun}) async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final r = await widget.session.api.send('POST', '/companies/${widget.company.id}/imports',
          body: {'file': _file, 'fileName': _fileName, 'dryRun': dryRun});
      if (!mounted) return;
      if (dryRun) {
        setState(() => _preview = (r as Map).cast<String, dynamic>());
      } else {
        messenger.showSnackBar(SnackBar(content: Text(t.importDone('${r['created']}'))));
        widget.session.sync.markChanged();
        setState(() => (_preview = null, _file = null, _fileName = null));
        await InvitesPage.open(context, widget.session, widget.company, widget.data);
      }
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final preview = _preview;
    final summary = (preview?['summary'] as Map?)?.cast<String, dynamic>();
    final rows = [for (final r in (preview?['rows'] as List? ?? const [])) (r as Map).cast<String, dynamic>()];
    final toImport = (summary?['new'] ?? 0) + (summary?['update'] ?? 0);
    return Scaffold(
      appBar: AppBar(title: Text(t.importTitle), actions: [
        IconButton(
          tooltip: t.invitesTitle,
          onPressed: () => InvitesPage.open(context, widget.session, widget.company, widget.data),
          icon: const Icon(Icons.qr_code_2),
        ),
      ]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(t.importIntro),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.table_view_outlined),
            title: Text(t.importTemplate),
            subtitle: Text(t.importTemplateHint),
            trailing: const Icon(Icons.download),
            onTap: () => openUrl(context, serverUrl('/api/v1/import-template?lang=${context.localeName}')),
          ),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          onPressed: _busy ? null : _pick,
          icon: const Icon(Icons.upload_file),
          label: Text(_fileName ?? t.importChooseFile),
        ),
        if (_busy) const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator())),
        if (summary != null) ...[
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 4, children: [
            _chip(Icons.person_add_alt, t.importNew('${summary['new']}'), theme.colorScheme.primary),
            if (summary['update'] > 0) _chip(Icons.edit_outlined, t.importUpdate('${summary['update']}'), Colors.teal),
            if (summary['skip'] > 0) _chip(Icons.redo, t.importSkip('${summary['skip']}'), theme.colorScheme.outline),
            if (summary['error'] > 0) _chip(Icons.error_outline, t.importErrors('${summary['error']}'), theme.colorScheme.error),
          ]),
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxHeight: 520),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: rows.length,
              itemBuilder: (context, i) => _row(rows[i], theme),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            onPressed: _busy || toImport == 0 ? null : () => _send(dryRun: false),
            icon: const Icon(Icons.check_rounded),
            label: Text(t.importConfirm('$toImport')),
          ),
          if (summary['error'] > 0)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(t.importErrorsIgnored, style: theme.textTheme.bodySmall),
            ),
        ],
      ]),
    );
  }

  Widget _chip(IconData icon, String label, Color color) =>
      Chip(avatar: Icon(icon, size: 18, color: color), label: Text(label));

  Widget _row(Map<String, dynamic> r, ThemeData theme) {
    final status = r['status'] as String;
    final (icon, color) = switch (status) {
      'new' => (Icons.person_add_alt, theme.colorScheme.primary),
      'update' => (Icons.edit_outlined, Colors.teal),
      'skip' => (Icons.redo, theme.colorScheme.outline),
      _ => (Icons.error_outline, theme.colorScheme.error),
    };
    final details = [
      ?r['number'],
      if (r['position'] != null) '${r['position']}${r['newPosition'] == true ? ' (${t.importCreated})' : ''}',
      if (r['site'] != null) '${r['site']}${r['newSite'] == true ? ' (${t.importCreated})' : ''}',
      ?r['email'],
    ].join(' · ');
    return ListTile(
      dense: true,
      leading: Icon(icon, color: color),
      title: Text('${r['line']}. ${(r['name'] as String).isEmpty ? '—' : r['name']}'),
      subtitle: Text([
        if (details.isNotEmpty) details,
        ?r['message'],
      ].join('\n')),
    );
  }
}

/// Invitations en attente : code et QR code de chacun, feuille à imprimer.
class InvitesPage extends StatefulWidget {
  final Session session;
  final Company company;
  final CompanyData data;

  const InvitesPage({super.key, required this.session, required this.company, required this.data});

  static Future<void> open(BuildContext context, Session session, Company company, CompanyData data) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => InvitesPage(session: session, company: company, data: data)));

  @override
  State<InvitesPage> createState() => _InvitesPageState();
}

class _InvitesPageState extends State<InvitesPage> {
  late Future<List<Map<String, dynamic>>> _invites = _load();
  final _search = TextEditingController();

  L10n get t => context.l10n;

  Future<List<Map<String, dynamic>>> _load() async {
    final r = await widget.session.api.send('GET', '/companies/${widget.company.id}/invites');
    return [for (final i in r['invites']) (i as Map).cast<String, dynamic>()];
  }

  Future<void> _print() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final r = await widget.session.api.send('POST', '/companies/${widget.company.id}/invites/sheet-link');
      if (mounted) await openUrl(context, serverUrl(r['path'] as String));
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
  }

  Future<void> _show(Map<String, dynamic> i) async {
    final link = i['link'] as String;
    final delete = await showDialog<bool>(
      context: context,
      builder: (dialog) => AlertDialog(
        title: Text(i['name'] as String),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: SizedBox(width: 200, height: 200, child: QrImageView(data: link, backgroundColor: Colors.white)),
          ),
          const SizedBox(height: 12),
          SelectableText(formatInviteCode(i['code'] as String),
              style: const TextStyle(fontSize: 26, letterSpacing: 3, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(t.inviteShowHint, textAlign: TextAlign.center, style: Theme.of(dialog).textTheme.bodySmall),
        ]),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(dialog, true),
            icon: const Icon(Icons.delete_outline),
            label: Text(t.delete),
            style: TextButton.styleFrom(foregroundColor: Theme.of(dialog).colorScheme.error),
          ),
          TextButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: link));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.googleLinkCopied)));
            },
            icon: const Icon(Icons.copy),
            label: Text(t.apiKeyCopy),
          ),
          FilledButton(onPressed: () => Navigator.pop(dialog, false), child: Text(t.close)),
        ],
      ),
    );
    if (delete != true || !mounted) return;
    await runAction(context, widget.session,
        () => widget.session.api.send('DELETE', '/companies/${widget.company.id}/invites/${i['id']}'));
    if (mounted) setState(() => _invites = _load());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.invitesTitle), actions: [
        IconButton(tooltip: t.invitesPrint, onPressed: _print, icon: const Icon(Icons.print_outlined)),
      ]),
      body: FutureBuilder(
        future: _invites,
        builder: (context, snap) {
          if (snap.hasError) {
            final e = snap.error;
            return Center(child: Text(e is ApiException ? e.describe(t) : t.serverUnreachable));
          }
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final all = snap.data!;
          final items = searchItems([
            for (final i in all)
              PickItem(i['id'] as String, i['name'] as String,
                  number: i['employeeNumber'] as String?,
                  sfId: i['code'] as String,
                  detail: [?widget.data.positionName(i['positionId'] as String?), ?i['email']].join(' · ')),
          ], _search.text);
          final byId = {for (final i in all) i['id']: i};
          return RefreshIndicator(
            onRefresh: () async {
              setState(() => _invites = _load());
              await _invites;
            },
            child: ListView(physics: const AlwaysScrollableScrollPhysics(), padding: const EdgeInsets.all(16), children: [
            Text(t.invitesHint(all.length.toString())),
            const SizedBox(height: 12),
            TextField(
              controller: _search,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                prefixIcon: const Icon(Icons.search, size: 20),
                hintText: t.pickSearchPeople,
              ),
            ),
            const SizedBox(height: 8),
            for (final item in items.take(200))
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.qr_code_2),
                title: Text(item.name),
                subtitle: Text([
                  formatInviteCode(item.sfId!),
                  ?item.number,
                  if (item.detail!.isNotEmpty) item.detail!,
                  if (byId[item.id]!['requested'] == true) t.inviteSeenByEmail,
                ].join(' · ')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _show(byId[item.id]!),
              ),
            if (all.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Center(child: Text(t.invitesNone, style: theme.textTheme.bodySmall)),
              ),
          ]),
          );
        },
      ),
    );
  }
}
