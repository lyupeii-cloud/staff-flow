import 'package:flutter/material.dart';

import '../i18n.dart';
import '../session.dart';

/// Menu « Langue » : automatique, ou une des langues proposées (chacune écrite
/// dans sa propre langue). Le changement est immédiat et mémorisé sur l'appareil.
Future<void> showLanguagePicker(BuildContext context, Session session) async {
  final t = context.l10n;
  final chosen = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(t.language),
      children: [
        _option(context, value: '', label: t.languageAuto, selected: session.language == null),
        const Divider(),
        for (final l in appLanguages)
          _option(context, value: l.code, label: l.nativeName, selected: session.language == l.code),
      ],
    ),
  );
  if (chosen == null) return;
  await session.setLanguage(chosen.isEmpty ? null : chosen);
}

Widget _option(BuildContext context, {required String value, required String label, required bool selected}) =>
    SimpleDialogOption(
      onPressed: () => Navigator.pop(context, value),
      child: Row(
        children: [
          SizedBox(width: 28, child: selected ? const Icon(Icons.check, size: 20) : null),
          Expanded(child: Text(label)),
        ],
      ),
    );
