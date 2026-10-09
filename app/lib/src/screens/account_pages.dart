import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../brand.dart';
import '../i18n.dart';
import '../session.dart';
import 'home_screen.dart';
import 'join_code_dialog.dart';
import 'language_picker.dart';
import 'notification_settings.dart';
import 'people_widgets.dart';
import 'tools_widgets.dart';

/// « Mon profil » : son QR code, son identifiant, son nom.
class ProfilePage extends StatelessWidget {
  final Session session;

  const ProfilePage({super.key, required this.session});

  static Future<void> open(BuildContext context, Session session) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfilePage(session: session)));

  Future<void> _changeName(BuildContext context) async {
    final t = context.l10n;
    final user = session.me!.user;
    final name = await askName(
      context,
      title: t.changeMyName,
      current: user.name,
      hint: '${t.nameShownToTeam}\n${t.googleName(user.googleName)}',
      resetLabel: t.useGoogleName,
      canReset: user.name != user.googleName,
    );
    if (name == null || !context.mounted) return;
    await runAction(context, session, () => session.api.setMyName(name.isEmpty ? null : name));
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) {
        final user = session.me!.user;
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(title: Text(t.myProfile)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: user.photoUrl == null ? null : NetworkImage(user.photoUrl!),
                  child: user.photoUrl == null
                      ? Text(user.name.characters.first.toUpperCase(), style: theme.textTheme.headlineMedium)
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              Text(user.name, textAlign: TextAlign.center, style: theme.textTheme.titleLarge),
              Text(user.email, textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
              const SizedBox(height: 16),
              Card(
                child: Column(children: [
                  ListTile(
                    leading: const Icon(Icons.qr_code_2, color: Brand.blue),
                    title: Text(t.myQrCode),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => showMyQrCode(context, user),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.badge_outlined, color: Brand.blue),
                    title: Text(t.myIdentifier),
                    subtitle: Text(user.publicId),
                    trailing: const Icon(Icons.copy, size: 20),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: user.publicId));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.idCopied)));
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.edit_outlined, color: Brand.blue),
                    title: Text(t.changeMyName),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _changeName(context),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// « Réglages » : langue, notifications, rejoindre une entreprise, Google
/// Agenda, apparence.
class SettingsPage extends StatelessWidget {
  final Session session;

  const SettingsPage({super.key, required this.session});

  static Future<void> open(BuildContext context, Session session) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsPage(session: session)));

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) {
        final theme = Theme.of(context);
        final language =
            appLanguages.firstWhere((l) => l.code == t.localeName, orElse: () => appLanguages.first).nativeName;
        Widget tile(IconData icon, String title, VoidCallback onTap, {String? subtitle}) => ListTile(
              leading: Icon(icon, color: Brand.blue),
              title: Text(title),
              subtitle: subtitle == null ? null : Text(subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: onTap,
            );
        return Scaffold(
          appBar: AppBar(title: Text(t.settingsTitle)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Column(children: [
                  tile(Icons.language, t.language, () => showLanguagePicker(context, session), subtitle: language),
                  const Divider(height: 1),
                  tile(Icons.notifications_outlined, t.notificationsTitle,
                      () => NotificationSettingsPage.open(context, session)),
                  const Divider(height: 1),
                  tile(Icons.event, t.googleCalendar, () => showCalendarDialog(context, session)),
                  const Divider(height: 1),
                  tile(Icons.pin_outlined, t.joinCompany, () => showJoinCodeDialog(context, session)),
                ]),
              ),
              const SizedBox(height: 16),
              Text(t.appearance, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(value: ThemeMode.system, icon: const Icon(Icons.brightness_auto), label: Text(t.themeSystem)),
                  ButtonSegment(value: ThemeMode.light, icon: const Icon(Icons.light_mode), label: Text(t.themeLight)),
                  ButtonSegment(value: ThemeMode.dark, icon: const Icon(Icons.dark_mode), label: Text(t.themeDark)),
                ],
                selected: {session.themeMode},
                onSelectionChanged: (v) => session.setThemeMode(v.first),
              ),
            ],
          ),
        );
      },
    );
  }
}
