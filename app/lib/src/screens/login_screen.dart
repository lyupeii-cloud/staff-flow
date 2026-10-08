import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.calendar_month, size: 56, color: theme.colorScheme.primary),
                const SizedBox(height: 12),
                Text('Staff Flow',
                    textAlign: TextAlign.center, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 4),
                Text('Les plannings de votre équipe, partout.',
                    textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 32),
                if (Config.googleWebClientId.isEmpty)
                  const Text('Connexion Google non configurée (GOOGLE_WEB_CLIENT_ID).',
                      textAlign: TextAlign.center)
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
                  Text(session.error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: theme.colorScheme.error)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
