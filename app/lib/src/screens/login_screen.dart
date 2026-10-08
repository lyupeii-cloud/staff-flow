import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../brand.dart';
import '../config.dart';
import '../google/button.dart';
import '../session.dart';

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
    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: Brand.navy,
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.4),
              radius: 1.1,
              colors: [Brand.navyLight, Brand.navy],
            ),
          ),
          child: Center(
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
                          const TextSpan(text: 'Les plannings de votre équipe, '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: Brand.flow.createShader,
                              child: Text('partout.', style: Brand.display(18)),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: Brand.display(18).copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 32),
                    if (Config.googleWebClientId.isEmpty)
                      const Text(
                        'Connexion Google non configurée (GOOGLE_WEB_CLIENT_ID).',
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
                        label: const Text('Se connecter avec Google'),
                      ),
                    if (Config.devLogin) ...[
                      const SizedBox(height: 32),
                      const Divider(),
                      Text('Développement', style: theme.textTheme.labelMedium),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _email,
                        decoration: const InputDecoration(labelText: 'Adresse e-mail'),
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (v) => session.signInDev(v.trim()),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => session.signInDev(_email.text.trim()),
                        child: const Text('Connexion de test'),
                      ),
                    ],
                    if (session.error != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        session.error!,
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
    );
  }
}
