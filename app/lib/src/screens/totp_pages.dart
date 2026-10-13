import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api.dart';
import '../i18n.dart';
import '../session.dart';
import 'invite_widgets.dart';
import 'people_widgets.dart';

/// « Rester connecté sur cet appareil » : la connexion est gardée (comme
/// avec Google) ; sinon il faudra se reconnecter à la prochaine ouverture.
class RememberSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RememberSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      value: value,
      onChanged: onChanged,
      title: Text(t.rememberMe),
      subtitle: Text(t.rememberMeHint),
    );
  }
}

/// Champ du code à 6 chiffres (ou d'un code de secours à 8 caractères).
Widget otpField(TextEditingController c, {required String label, VoidCallback? onDone, int max = 6}) => TextField(
      controller: c,
      keyboardType: max == 6 ? TextInputType.number : TextInputType.text,
      textCapitalization: TextCapitalization.characters,
      maxLength: max,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 26, letterSpacing: 8, fontWeight: FontWeight.w600),
      decoration: InputDecoration(labelText: label, counterText: ''),
      onSubmitted: (_) => onDone?.call(),
    );

/// Connexion par application 2FA : identifiant SF (ou matricule et code de
/// l'entreprise) et code à 6 chiffres.
class TotpLoginPage extends StatefulWidget {
  final Session session;

  const TotpLoginPage({super.key, required this.session});

  static Future<void> open(BuildContext context, Session session) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => TotpLoginPage(session: session)));

  @override
  State<TotpLoginPage> createState() => _TotpLoginPageState();
}

class _TotpLoginPageState extends State<TotpLoginPage> {
  final _login = TextEditingController();
  final _company = TextEditingController();
  final _otp = TextEditingController();
  bool _remember = true, _busy = false, _backup = false;
  String? _error;

  bool get _byNumber => _login.text.trim().isNotEmpty && !_login.text.trim().toUpperCase().startsWith('SF-');

  Future<void> _submit() async {
    final t = context.l10n;
    setState(() => (_busy = true, _error = null));
    try {
      final j = await widget.session.api.send('POST', '/auth/totp', body: {
        'login': _login.text.trim(),
        if (_byNumber) 'company': _company.text.trim(),
        'otp': _otp.text.trim(),
      });
      await widget.session.signInWithToken(j['token'] as String, remember: _remember);
      if (mounted) Navigator.of(context).popUntil((r) => r.isFirst);
    } on OfflineException {
      setState(() => _error = t.offlineUnavailable);
    } on ApiException catch (e) {
      setState(() => _error = e.describe(t));
      _otp.clear();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.totpLoginTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: ListView(padding: const EdgeInsets.all(20), children: [
            Icon(Icons.shield_outlined, size: 48, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(t.totpLoginHint, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextField(
              controller: _login,
              onChanged: (_) => setState(() {}),
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: t.totpLoginField, hintText: 'SF-A7K3P9QX'),
            ),
            if (_byNumber)
              TextField(
                controller: _company,
                textCapitalization: TextCapitalization.characters,
                maxLength: 6,
                decoration: InputDecoration(labelText: t.totpCompanyCode, helperText: t.totpCompanyCodeHint, counterText: ''),
              ),
            const SizedBox(height: 12),
            otpField(_otp, label: _backup ? t.totpBackupCode : t.totpCode, onDone: _submit, max: _backup ? 8 : 6),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => setState(() {
                  _backup = !_backup;
                  _otp.clear();
                }),
                child: Text(_backup ? t.totpUseApp : t.totpUseBackup),
              ),
            ),
            RememberSwitch(value: _remember, onChanged: (v) => setState(() => _remember = v)),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
              ),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              onPressed: _busy ? null : _submit,
              child: Text(t.totpSignIn),
            ),
            const SizedBox(height: 12),
            Text(t.totpLostPhone, style: theme.textTheme.bodySmall, textAlign: TextAlign.center),
          ]),
        ),
      ),
    );
  }
}

/// Activation d'un compte sans Google : code de l'employeur (QR code ou
/// saisi), puis application 2FA reliée et confirmée par un premier code.
class ActivatePage extends StatefulWidget {
  final Session session;
  final String? initialCode;

  const ActivatePage({super.key, required this.session, this.initialCode});

  static Future<void> open(BuildContext context, Session session, {String? code}) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => ActivatePage(session: session, initialCode: code)));

  @override
  State<ActivatePage> createState() => _ActivatePageState();
}

class _ActivatePageState extends State<ActivatePage> {
  late final _code = TextEditingController(text: widget.initialCode == null ? null : formatInviteCode(widget.initialCode!));
  final _otp = TextEditingController();
  Map<String, dynamic>? _start;
  bool _remember = true, _busy = false;
  String? _error;

  L10n get t => context.l10n;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => (_busy = true, _error = null));
    try {
      await action();
    } on OfflineException {
      setState(() => _error = t.offlineUnavailable);
    } on ApiException catch (e) {
      setState(() => _error = e.describe(t));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _scan() async {
    final qr = await scanQrCode(context, accept: inviteQr);
    final found = qr == null ? null : inviteQr.firstMatch(qr.toUpperCase())?[1];
    if (found == null) return;
    _code.text = formatInviteCode(found);
    await _check();
  }

  Future<void> _check() => _run(() async {
        final r = await widget.session.api.send('POST', '/auth/activate', body: {'code': _code.text});
        setState(() => _start = (r as Map).cast<String, dynamic>());
      });

  Future<void> _confirm() => _run(() async {
        final r = await widget.session.api
            .send('POST', '/auth/activate/confirm', body: {'pending': _start!['pending'], 'otp': _otp.text.trim()});
        if (!mounted) return;
        await _showBackup((r['backupCodes'] as List).cast<String>(), r['user']['publicId'] as String);
        await widget.session.signInWithToken(r['token'] as String, remember: _remember);
        if (mounted) Navigator.of(context).popUntil((r) => r.isFirst);
      });

  /// Identifiant SF et codes de secours : à noter, ils ne seront plus montrés.
  Future<void> _showBackup(List<String> codes, String publicId) => showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialog) => AlertDialog(
          title: Text(t.totpReadyTitle),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text(t.totpYourId),
              SelectableText(publicId, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: 1)),
              const SizedBox(height: 16),
              Text(t.totpBackupHint),
              const SizedBox(height: 8),
              Wrap(spacing: 12, runSpacing: 6, children: [
                for (final c in codes)
                  Text('${c.substring(0, 4)}-${c.substring(4)}',
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 16, fontWeight: FontWeight.w600)),
              ]),
            ]),
          ),
          actions: [
            TextButton.icon(
              onPressed: () => Clipboard.setData(ClipboardData(text: '$publicId\n${codes.join('\n')}')),
              icon: const Icon(Icons.copy),
              label: Text(t.apiKeyCopy),
            ),
            FilledButton(onPressed: () => Navigator.pop(dialog), child: Text(t.totpBackupSaved)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final start = _start;
    return Scaffold(
      appBar: AppBar(title: Text(t.activateTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: ListView(padding: const EdgeInsets.all(20), children: [
            if (start == null) ...[
              Text(t.activateStep1, style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(t.activateStep1Hint),
              const SizedBox(height: 16),
              FilledButton.tonalIcon(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                onPressed: _busy ? null : _scan,
                icon: const Icon(Icons.qr_code_scanner),
                label: Text(t.activateScan),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _code,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(fontSize: 22, letterSpacing: 3),
                decoration: InputDecoration(labelText: t.activateCodeField, hintText: 'ABCD-2345'),
                onSubmitted: (_) => _check(),
              ),
              const SizedBox(height: 16),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: _busy ? null : _check,
                child: Text(t.activateContinue),
              ),
            ] else ...[
              Text(t.activateHello(start['name'] as String, start['companyName'] as String), style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(t.activateStep2),
              const SizedBox(height: 12),
              // Sur le même téléphone, on ne peut pas scanner son propre écran : bouton direct.
              FilledButton.tonalIcon(
                onPressed: () => launchUrl(Uri.parse(start['otpauth'] as String), mode: LaunchMode.externalApplication),
                icon: const Icon(Icons.add_moderator_outlined),
                label: Text(t.activateOpenApp),
              ),
              const SizedBox(height: 12),
              Text(t.activateOrScan, textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                      width: 180, height: 180, child: QrImageView(data: start['otpauth'] as String, backgroundColor: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              Text(t.activateManualKey, textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
              SelectableText(start['secret'] as String,
                  textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
              const SizedBox(height: 16),
              otpField(_otp, label: t.activateFirstCode, onDone: _confirm),
              RememberSwitch(value: _remember, onChanged: (v) => setState(() => _remember = v)),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: _busy ? null : _confirm,
                child: Text(t.activateDone),
              ),
            ],
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
              ),
          ]),
        ),
      ),
    );
  }
}

/// Compte sans Google qui veut créer une entreprise : relier d'abord Google.
Future<void> askLinkGoogle(BuildContext context, Session session) async {
  final t = context.l10n;
  final ok = await showDialog<bool>(
    context: context,
    builder: (dialog) => AlertDialog(
      icon: const Icon(Icons.verified_user_outlined),
      title: Text(t.linkGoogleTitle),
      content: Text(t.linkGoogleHint),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialog, false), child: Text(t.cancel)),
        FilledButton.icon(
          onPressed: () => Navigator.pop(dialog, true),
          icon: const Icon(Icons.login),
          label: Text(t.linkGoogleButton),
        ),
      ],
    ),
  );
  if (ok != true || !context.mounted) return;
  try {
    final r = await session.api.send('POST', '/me/link-google');
    await session.startGoogleLink(r['switchToken'] as String);
  } on ApiException catch (e) {
    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.describe(t))));
  }
}
