import 'package:flutter/material.dart';

import '../api.dart';
import '../i18n.dart';
import '../models.dart';
import '../push.dart';
import '../session.dart';

/// Choix des notifications (section 7) : chaque famille peut être coupée.
/// Les avis restent toujours visibles dans la cloche.
class NotificationSettingsPage extends StatefulWidget {
  final Session session;

  const NotificationSettingsPage({super.key, required this.session});

  static Future<void> open(BuildContext context, Session session) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => NotificationSettingsPage(session: session)));

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  late Map<String, bool> _prefs = {...widget.session.me!.notificationPrefs};
  bool _busy = false;

  static const _families = ['planning', 'requests', 'messages', 'overlap', 'conflicts', 'billing'];

  String _label(L10n t, String family) => switch (family) {
        'planning' => t.notifPlanning,
        'requests' => t.notifRequests,
        'messages' => t.notifMessages,
        'overlap' => t.notifOverlap,
        'conflicts' => t.notifConflicts,
        _ => t.notifBilling,
      };

  /// Propriétaire d'au moins une entreprise active : seul concerné par les
  /// rappels d'abonnement.
  bool get _ownsActiveCompany =>
      widget.session.me!.companies.any((m) => m.role == Role.owner && !m.company.readOnly);

  late String _retention = widget.session.me!.noticeRetention;

  Future<void> _setRetention(String value) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final previous = _retention;
    setState(() => _retention = value);
    try {
      await widget.session.api.send('PUT', '/me/notice-retention', body: {'value': value});
      await widget.session.refresh();
    } catch (e) {
      setState(() => _retention = previous);
      messenger.showSnackBar(SnackBar(content: Text(e is OfflineException ? t.offlineUnavailable : t.serverUnreachable)));
    }
  }

  Future<void> _toggle(String family, bool value) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _prefs[family] = value);
    try {
      final saved = await widget.session.api.send('PATCH', '/me/notifications', body: {family: value});
      setState(() => _prefs = {for (final e in (saved as Map).entries) e.key as String: e.value == true});
      await widget.session.refresh();
    } on OfflineException {
      setState(() => _prefs[family] = !value);
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } catch (_) {
      setState(() => _prefs[family] = !value);
      messenger.showSnackBar(SnackBar(content: Text(t.serverUnreachable)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final push = widget.session.push;
    return Scaffold(
      appBar: AppBar(title: Text(t.notificationsTitle)),
      body: ListenableBuilder(
        listenable: push,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            _deviceStatus(t, push),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(t.notifChooseHint, style: Theme.of(context).textTheme.bodySmall),
            ),
            for (final f in _families)
              if (f == 'billing' && !_ownsActiveCompany)
                // Les rappels d'abonnement ne concernent que les propriétaires.
                SwitchListTile(
                  title: Row(
                    children: [
                      Flexible(child: Text(_label(t, f))),
                      const SizedBox(width: 6),
                      Tooltip(
                        message: t.billingOwnersOnly,
                        triggerMode: TooltipTriggerMode.tap,
                        child: Icon(Icons.info_outline, size: 18, color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                  subtitle: Text(t.billingOwnersOnly),
                  value: false,
                  onChanged: null,
                )
              else
                SwitchListTile(
                  title: Text(_label(t, f)),
                  value: _prefs[f] ?? true,
                  onChanged: (v) => _toggle(f, v),
                ),
            const Divider(),
            ListTile(
              title: Text(t.noticeRetention),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SegmentedButton<String>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(value: 'day', label: Text(t.retentionDay)),
                    ButtonSegment(value: 'week', label: Text(t.retentionWeek)),
                    ButtonSegment(value: 'month', label: Text(t.retentionMonth)),
                  ],
                  selected: {_retention},
                  onSelectionChanged: (s) => _setRetention(s.first),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deviceStatus(L10n t, Push push) {
    final (icon, text) = switch (push.state) {
      PushState.on => (Icons.notifications_active, t.pushEnabled),
      PushState.off => (Icons.notifications_off_outlined, t.pushOff),
      PushState.blocked => (Icons.block, t.pushBlocked),
      PushState.unavailable => (Icons.notifications_off_outlined, t.pushUnavailable),
    };
    return ListTile(
      leading: Icon(icon, color: push.state == PushState.on ? Theme.of(context).colorScheme.primary : null),
      title: Text(text),
      trailing: push.state == PushState.off
          ? FilledButton(
              onPressed: _busy
                  ? null
                  : () async {
                      setState(() => _busy = true);
                      await push.enable();
                      if (mounted) setState(() => _busy = false);
                    },
              child: Text(t.enablePush),
            )
          : null,
    );
  }
}
