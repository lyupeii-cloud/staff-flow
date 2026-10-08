import 'dart:async';

import 'package:flutter/material.dart';

import '../api.dart';
import '../session.dart';

/// Affiche un code à 6 chiffres valable 2 minutes, à donner au responsable.
Future<void> showJoinCodeDialog(BuildContext context, Session session) => showDialog(
      context: context,
      builder: (_) => _JoinCodeDialog(session: session),
    );

class _JoinCodeDialog extends StatefulWidget {
  final Session session;

  const _JoinCodeDialog({required this.session});

  @override
  State<_JoinCodeDialog> createState() => _JoinCodeDialogState();
}

class _JoinCodeDialogState extends State<_JoinCodeDialog> {
  String? _code;
  DateTime? _expires;
  String? _error;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _generate();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _generate() async {
    setState(() => (_code = null, _error = null));
    try {
      final (code, expires) = await widget.session.api.createJoinCode();
      // Le compte à rebours suit l'horloge du téléphone : on garde la durée
      // annoncée par le serveur plutôt que son heure absolue.
      final lifetime = expires.difference(DateTime.now().toUtc());
      setState(() => (
            _code = code,
            _expires = DateTime.now().add(lifetime.isNegative || lifetime > const Duration(minutes: 2)
                ? const Duration(minutes: 2)
                : lifetime)
          ));
    } on ApiException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = 'Serveur injoignable.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final left = _expires?.difference(DateTime.now());
    final expired = left != null && left.isNegative;
    return AlertDialog(
      title: const Text('Rejoindre une entreprise'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Donnez ce code à votre responsable. Il le saisit dans son application, '
              'puis vous recevez une invitation à accepter.'),
          const SizedBox(height: 20),
          if (_error != null)
            Text(_error!, style: TextStyle(color: theme.colorScheme.error))
          else if (_code == null)
            const CircularProgressIndicator()
          else ...[
            SelectableText(
              '${_code!.substring(0, 3)} ${_code!.substring(3)}',
              style: theme.textTheme.displaySmall?.copyWith(
                letterSpacing: 6,
                color: expired ? theme.disabledColor : null,
                decoration: expired ? TextDecoration.lineThrough : null,
              ),
            ),
            const SizedBox(height: 8),
            Text(expired
                ? 'Code expiré.'
                : 'Valable encore ${left!.inMinutes}:${(left.inSeconds % 60).toString().padLeft(2, '0')}'),
          ],
        ],
      ),
      actions: [
        TextButton(onPressed: _generate, child: const Text('Nouveau code')),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            widget.session.refresh().catchError((_) {});
          },
          child: const Text('Fermer'),
        ),
      ],
    );
  }
}
