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

/// Connexion par application 2FA, en deux temps. 1 : un seul champ, où l'on
/// tape son identifiant SF, son matricule ou le code de l'employeur ; le
/// serveur dit ce qu'il appelle (code 2FA, activation, création de compte).
/// 2 : le code à 6 chiffres (et, pour un matricule, le code de l'entreprise).
class TotpLoginPage extends StatefulWidget {
  final Session session;

  /// Code d'invitation déjà connu (lien ou QR code de la fiche d'invitation).
  final String? initial;

  const TotpLoginPage({super.key, required this.session, this.initial});

  static Future<void> open(BuildContext context, Session session, {String? initial}) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => TotpLoginPage(session: session, initial: initial)));

  @override
  State<TotpLoginPage> createState() => _TotpLoginPageState();
}

class _TotpLoginPageState extends State<TotpLoginPage> {
  late final _login = TextEditingController(text: widget.initial);
  final _company = TextEditingController();
  final _otp = TextEditingController();
  bool _remember = true, _busy = false, _backup = false;
  String? _error;

  /// Réponse du serveur : `code`, `number`, `unknown`, `google` ; null = étape 1.
  String? _next;

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) WidgetsBinding.instance.addPostFrameCallback((_) => _identify());
  }

  Future<void> _run(Future<void> Function() action) async {
    final t = context.l10n;
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

  Future<void> _identify() => _run(() async {
        final login = _login.text.trim();
        if (login.isEmpty) return;
        final j = await widget.session.api.send('POST', '/auth/identify', body: {'login': login});
        final next = j['next'] as String;
        if (!mounted) return;
        if (next == 'activation') {
          // Code de l'employeur : l'activation prend la suite.
          await Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => ActivatePage(session: widget.session, initialCode: login)));
          return;
        }
        setState(() => _next = next);
      });

  Future<void> _submit() => _run(() async {
        try {
          final j = await widget.session.api.send('POST', '/auth/totp', body: {
            'login': _login.text.trim(),
            if (_next == 'number') 'company': _company.text.trim(),
            'otp': _otp.text.trim(),
          });
          await widget.session.signInWithToken(j['token'] as String, remember: _remember);
          if (mounted) Navigator.of(context).popUntil((r) => r.isFirst);
        } on ApiException {
          _otp.clear();
          rethrow;
        }
      });

  void _signup() => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => ActivatePage(session: widget.session, signup: true)));

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    final asking = _next == 'code' || _next == 'number';
    return Scaffold(
      appBar: AppBar(title: Text(t.totpLoginTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: ListView(padding: const EdgeInsets.all(20), children: [
            Icon(Icons.shield_outlined, size: 48, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            if (_next == null) Text(t.totpIdentHint, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextField(
              controller: _login,
              enabled: _next == null,
              autofocus: widget.initial == null,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: t.totpIdentField, hintText: 'SF-A7K3P9QX'),
              onSubmitted: (_) => _identify(),
            ),
            if (_next != null)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => setState(() {
                    _next = null;
                    _error = null;
                    _otp.clear();
                  }),
                  child: Text(t.totpChange),
                ),
              ),
            // Identifiant inconnu : proposer de créer un compte.
            if (_next == 'unknown') ...[
              Text(t.totpUnknown, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: _signup,
                child: Text(t.signupButton),
              ),
            ],
            if (_next == 'google') Text(t.totpGoogleAccount, textAlign: TextAlign.center),
            if (asking) ...[
              if (_next == 'number')
                TextField(
                  controller: _company,
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 6,
                  decoration:
                      InputDecoration(labelText: t.totpCompanyCode, helperText: t.totpCompanyCodeHint, counterText: ''),
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
            ],
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
              ),
            if (_next == null || asking)
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: _busy ? null : (asking ? _submit : _identify),
                child: Text(asking ? t.totpSignIn : t.totpContinue),
              ),
            const SizedBox(height: 12),
            if (_next == null) TextButton(onPressed: _signup, child: Text(t.totpNoAccount)),
            if (asking) Text(t.totpLostPhone, style: theme.textTheme.bodySmall, textAlign: TextAlign.center),
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

  /// Création libre d'un compte (sans code de l'employeur ni entreprise).
  final bool signup;

  const ActivatePage({super.key, required this.session, this.initialCode, this.signup = false});

  static Future<void> open(BuildContext context, Session session, {String? code}) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => ActivatePage(session: session, initialCode: code)));

  static Future<void> openSignup(BuildContext context, Session session) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => ActivatePage(session: session, signup: true)));

  @override
  State<ActivatePage> createState() => _ActivatePageState();
}

class _ActivatePageState extends State<ActivatePage> {
  late final _code = TextEditingController(text: widget.initialCode == null ? null : formatInviteCode(widget.initialCode!));
  final _otp = TextEditingController();
  final _name = TextEditingController();
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
        final r = widget.signup
            ? await widget.session.api.send('POST', '/auth/signup', body: {'name': _name.text.trim()})
            : await widget.session.api.send('POST', '/auth/activate', body: {'code': _code.text});
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
      appBar: AppBar(title: Text(widget.signup ? t.signupTitle : t.activateTitle)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: ListView(padding: const EdgeInsets.all(20), children: [
            if (start == null && widget.signup) ...[
              Text(t.signupStep1, style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(t.signupStep1Hint),
              const SizedBox(height: 16),
              TextField(
                controller: _name,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: t.signupName),
                onSubmitted: (_) => _check(),
              ),
              const SizedBox(height: 16),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: _busy ? null : _check,
                child: Text(t.activateContinue),
              ),
            ] else if (start == null) ...[
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
              Text(
                  start['companyName'] == null
                      ? t.signupHello(start['name'] as String)
                      : t.activateHello(start['name'] as String, start['companyName'] as String),
                  style: theme.textTheme.titleMedium),
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

/// Mon profil : connexion par application 2FA. Un compte Google peut la
/// préparer pour s'en servir à la place de Google ; un compte sans Google
/// l'a toujours.
class TotpCard extends StatelessWidget {
  final Session session;

  const TotpCard({super.key, required this.session});

  Future<void> _enable(BuildContext context) async {
    final t = context.l10n;
    try {
      final start = (await session.api.send('POST', '/me/totp') as Map).cast<String, dynamic>();
      if (!context.mounted) return;
      final otp = TextEditingController();
      String? error;
      final codes = await showDialog<List<String>>(
        context: context,
        builder: (dialog) => StatefulBuilder(
          builder: (dialog, setState) => AlertDialog(
            title: Text(t.totpEnableTitle),
            content: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(t.activateStep2),
                const SizedBox(height: 8),
                FilledButton.tonalIcon(
                  onPressed: () => launchUrl(Uri.parse(start['otpauth'] as String), mode: LaunchMode.externalApplication),
                  icon: const Icon(Icons.add_moderator_outlined),
                  label: Text(t.activateOpenApp),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(6),
                    child: SizedBox(
                        width: 150, height: 150, child: QrImageView(data: start['otpauth'] as String, backgroundColor: Colors.white)),
                  ),
                ),
                SelectableText(start['secret'] as String,
                    textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                const SizedBox(height: 8),
                otpField(otp, label: t.activateFirstCode),
                if (error != null) Text(error!, style: TextStyle(color: Theme.of(dialog).colorScheme.error)),
              ]),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(dialog), child: Text(t.cancel)),
              FilledButton(
                onPressed: () async {
                  try {
                    final r = await session.api
                        .send('POST', '/me/totp/confirm', body: {'pending': start['pending'], 'otp': otp.text.trim()});
                    if (dialog.mounted) Navigator.pop(dialog, (r['backupCodes'] as List).cast<String>());
                  } on ApiException catch (e) {
                    setState(() => error = e.describe(t));
                  }
                },
                child: Text(t.activateDone),
              ),
            ],
          ),
        ),
      );
      if (codes == null || !context.mounted) return;
      await session.refresh();
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialog) => AlertDialog(
          title: Text(t.totpEnabledTitle),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(t.totpYourId),
            SelectableText(session.me!.user.publicId, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Text(t.totpBackupHint),
            const SizedBox(height: 8),
            Wrap(spacing: 12, runSpacing: 6, children: [
              for (final c in codes)
                Text('${c.substring(0, 4)}-${c.substring(4)}',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 15, fontWeight: FontWeight.w600)),
            ]),
          ]),
          actions: [
            TextButton.icon(
              onPressed: () => Clipboard.setData(ClipboardData(text: codes.join('\n'))),
              icon: const Icon(Icons.copy),
              label: Text(t.apiKeyCopy),
            ),
            FilledButton(onPressed: () => Navigator.pop(dialog), child: Text(t.totpBackupSaved)),
          ],
        ),
      );
    } on ApiException catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.describe(t))));
    } on OfflineException {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    }
  }

  Future<void> _disable(BuildContext context) async {
    final t = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialog) => AlertDialog(
        content: Text(t.totpDisableConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialog, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(dialog, true), child: Text(t.validate)),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await session.api.send('DELETE', '/me/totp');
      await session.refresh();
    } on ApiException catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final me = session.me!;
    final on = me.totp;
    return Card(
      child: ListTile(
        leading: Icon(on ? Icons.verified_user : Icons.shield_outlined, color: on ? Colors.green.shade700 : null),
        title: Text(t.totpCardTitle),
        subtitle: Text(me.user.local ? t.totpCardLocal(me.user.publicId) : (on ? t.totpCardOn(me.user.publicId) : t.totpCardOff)),
        isThreeLine: true,
        trailing: me.user.local
            ? null
            : on
                ? TextButton(onPressed: () => _disable(context), child: Text(t.totpDisable))
                : FilledButton.tonal(onPressed: () => _enable(context), child: Text(t.totpEnable)),
      ),
    );
  }
}
