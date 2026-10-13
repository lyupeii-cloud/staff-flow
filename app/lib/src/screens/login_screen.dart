import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'totp_pages.dart';

import '../brand.dart';
import '../config.dart';
import '../platform/standalone.dart';
import '../google/button.dart';
import '../i18n.dart';
import '../session.dart';
import 'account_tools.dart';
import 'language_picker.dart';
import 'tools_widgets.dart';

class LoginScreen extends StatefulWidget {
  final Session session;

  const LoginScreen({super.key, required this.session});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final theme = Brand.theme(Brightness.dark);
    final t = context.l10n;
    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: Brand.navy,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: TextButton.icon(
            onPressed: () => showLanguagePicker(context, session),
            icon: const Icon(Icons.language, color: Colors.white70),
            label: Text(
              appLanguages.firstWhere((l) => l.code == t.localeName, orElse: () => appLanguages.first).nativeName,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.4),
              radius: 1.1,
              colors: [Brand.navyLight, Brand.navy],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(36),
                        child: Image.asset('assets/brand/icon-rounded.png', width: 168, height: 168),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: t.taglineStart),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: Brand.flow.createShader,
                              child: Text(t.taglineEnd, style: Brand.display(18)),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: Brand.display(18).copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 32),
                    if (session.googleSwitchToken != null) ...[
                      Card(
                        color: Colors.white.withValues(alpha: 0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(children: [
                            const Icon(Icons.switch_account, color: Colors.white),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Text(session.linkingGoogle ? t.linkGoogleBanner : t.switchBanner,
                                    style: const TextStyle(color: Colors.white))),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (Config.googleWebClientId.isEmpty)
                      Text(
                    t.googleNotConfigured,
                        textAlign: TextAlign.center,
                      )
                    else if (!session.googleReady)
                      const Center(child: CircularProgressIndicator())
                    else if (kIsWeb)
                      Center(child: googleWebButton())
                    else
                      FilledButton.icon(
                        onPressed: session.signInWithGoogle,
                        icon: const Icon(Icons.login),
                        label: Text(t.signInWithGoogle),
                      ),
                    // Sans Google : un seul bouton (connexion, activation ou création de compte).
                    if (session.googleSwitchToken == null) ...[
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54)),
                        onPressed: () => TotpLoginPage.open(context, session, initial: session.inviteCode),
                        icon: const Icon(Icons.shield_outlined),
                        label: Text(t.totpContinueButton),
                      ),
                    ],
                    // iPhone (pas d'application iOS pour l'instant) : l'installer depuis Safari.
                    if (kIsWeb && defaultTargetPlatform == TargetPlatform.iOS && !isStandalone) ...[
                      const SizedBox(height: 28),
                      Card(
                        color: Colors.white.withValues(alpha: 0.08),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(children: [
                            const Icon(Icons.ios_share, color: Colors.white),
                            const SizedBox(width: 12),
                            Expanded(child: Text(t.iosInstallHint, style: const TextStyle(color: Colors.white))),
                          ]),
                        ),
                      ),
                    ],
                    if (Config.devLogin) ...[
                      const SizedBox(height: 32),
                      const Divider(),
                      Text(t.devSection, style: theme.textTheme.labelMedium),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _email,
                        decoration: InputDecoration(labelText: t.emailLabel),
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (v) => session.signInDev(v.trim()),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => session.signInDev(_email.text.trim()),
                        child: Text(t.devSignIn),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Wrap(alignment: WrapAlignment.center, children: [
                      TextButton(
                        onPressed: () => openUrl(context, legalUrl(context, 'terms')),
                        child: Text(t.legalTerms, style: const TextStyle(fontSize: 12)),
                      ),
                      TextButton(
                        onPressed: () => openUrl(context, legalUrl(context, 'privacy')),
                        child: Text(t.legalPrivacy, style: const TextStyle(fontSize: 12)),
                      ),
                    ]),
                    if (session.error != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        session.error!(t),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}
