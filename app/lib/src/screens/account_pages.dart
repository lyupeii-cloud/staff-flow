import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../brand.dart';
import 'account_tools.dart';
import 'avatar_widgets.dart';
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
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => showAvatarPicker(context, session),
                  child: UserAvatar.of(user, radius: 40),
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
                    onTap: () => showMyQrCode(context, session),
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
                    leading: const Icon(Icons.face_outlined, color: Brand.blue),
                    title: Text(t.avatarTitle),
                    subtitle: Text(t.avatarSub),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => showAvatarPicker(context, session),
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
              const SizedBox(height: 12),
              TelegramCard(session: session),
              const SizedBox(height: 12),
              Card(
                child: Column(children: [
                  ListTile(
                    leading: const Icon(Icons.switch_account_outlined, color: Brand.blue),
                    title: Text(t.changeGoogle),
                    subtitle: Text(t.changeGoogleSub),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => showChangeGoogleHelp(context, session),
                  ),
                  if (session.me!.companies.isEmpty) ...[
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.manage_history, color: Brand.blue),
                      title: Text(t.recoverAccount),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => showRecoverDialog(context, session),
                    ),
                  ],
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.download_outlined, color: Brand.blue),
                    title: Text(t.exportData),
                    subtitle: Text(t.exportDataSub),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => downloadFromServer(context, session, '/me/export/link'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.receipt_long_outlined, color: Brand.blue),
                    title: Text(t.closedInvoices),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => ClosedInvoicesPage.open(context, session),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.gavel_outlined, color: Brand.blue),
                    title: Text(t.legalTerms),
                    trailing: const Icon(Icons.open_in_new, size: 20),
                    onTap: () => openUrl(context, legalUrl(context, 'terms')),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined, color: Brand.blue),
                    title: Text(t.legalPrivacy),
                    trailing: const Icon(Icons.open_in_new, size: 20),
                    onTap: () => openUrl(context, legalUrl(context, 'privacy')),
                  ),
                ]),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: Icon(Icons.delete_outline, color: theme.colorScheme.error),
                  title: Text(t.deleteAccount, style: TextStyle(color: theme.colorScheme.error)),
                  onTap: () => showDeleteAccountDialog(context, session),
                ),
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
              const SizedBox(height: 20),
              Text(t.timeFormat, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'auto', icon: const Icon(Icons.schedule), label: Text(t.timeFormatAuto)),
                  const ButtonSegment(value: 'h12', label: Text('12 h')),
                  const ButtonSegment(value: 'h24', label: Text('24 h')),
                ],
                selected: {session.timeFormat},
                onSelectionChanged: (v) => session.setTimeFormat(v.first),
              ),
            ],
          ),
        );
      },
    );
  }
}
