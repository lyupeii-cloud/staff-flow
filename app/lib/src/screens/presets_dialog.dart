import 'package:flutter/material.dart';

import '../dates.dart';
import '../i18n.dart';
import '../models.dart';

/// Préréglages d'horaires (matin, soir, nuit…) : nom, début et fin ; ajout
/// et suppression. Renvoie la nouvelle liste, ou `null` si l'on annule.
class PresetsDialog extends StatefulWidget {
  final List<ShiftPreset> initial;

  const PresetsDialog({super.key, required this.initial});

  @override
  State<PresetsDialog> createState() => _PresetsDialogState();
}

class _PresetsDialogState extends State<PresetsDialog> {
  late final List<ShiftPreset> _list = [...widget.initial];
  final _name = TextEditingController();
  var _start = 6 * 60, _end = 14 * 60;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _pick(bool start) async {
    final v = start ? _start : _end;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: v ~/ 60, minute: v % 60),
      builder: (context, child) =>
          MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
    );
    if (picked == null) return;
    setState(() {
      if (start) {
        _start = picked.hour * 60 + picked.minute;
      } else {
        _end = picked.hour * 60 + picked.minute;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return AlertDialog(
      title: Text(t.shiftPresets),
      content: SizedBox(
        width: 380,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(t.shiftPresetsHint, style: Theme.of(context).textTheme.bodySmall),
            for (final (i, p) in _list.indexed)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.schedule),
                title: Text(p.name),
                subtitle: Text('${timeLabel(p.start)} – ${timeLabel(p.end)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => setState(() => _list.removeAt(i)),
                ),
              ),
            const Divider(),
            TextField(controller: _name, maxLength: 40, decoration: InputDecoration(labelText: t.presetName)),
            Row(children: [
              Expanded(child: OutlinedButton(onPressed: () => _pick(true), child: Text('${t.start}  ${timeLabel(_start)}'))),
              const SizedBox(width: 8),
              Expanded(child: OutlinedButton(onPressed: () => _pick(false), child: Text('${t.end}  ${timeLabel(_end)}'))),
            ]),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              onPressed: _list.length >= 20
                  ? null
                  : () {
                      final name = _name.text.trim();
                      if (name.isEmpty) return;
                      setState(() {
                        _list.add(ShiftPreset(name, _start, _end));
                        _name.clear();
                      });
                    },
              icon: const Icon(Icons.add),
              label: Text(t.addPreset),
            ),
          ]),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(t.cancel)),
        FilledButton(onPressed: () => Navigator.pop(context, _list), child: Text(t.save)),
      ],
    );
  }
}
