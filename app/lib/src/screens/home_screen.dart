import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import '../api.dart';
import '../brand.dart';
import '../i18n.dart';
import '../models.dart';
import '../push.dart';
import '../session.dart';
import 'all_schedules_view.dart';
import 'company_tab.dart';
import 'join_code_dialog.dart';
import 'language_picker.dart';
import 'chat_screen.dart';
import 'notification_settings.dart';
import 'people_widgets.dart';
import 'sync_widgets.dart';
import 'tools_widgets.dart';

/// Un onglet par entreprise dont l'utilisateur est membre (section 3).
class HomeScreen extends StatefulWidget {
  final Session session;

  const HomeScreen({super.key, required this.session});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Session get session => widget.session;

  StreamSubscription<PushEvent>? _push;

  /// Onglets des entreprises (pour aller à celle d'une demande).
  TabController? _tabs;

  /// « Tous mes plannings » : utile dès deux entreprises.
  bool get _showAll => (session.me?.companies.length ?? 0) >= 2;

  @override
  void initState() {
    super.initState();
    session.sync.addListener(_onSync);
    session.openRequest.addListener(_onOpenRequest);
    _push = session.push.events.listen(_onPush);
  }

  @override
  void dispose() {
    session.sync.removeListener(_onSync);
    session.openRequest.removeListener(_onOpenRequest);
    _push?.cancel();
    super.dispose();
  }

  /// Une demande est à montrer : on passe à l'onglet de son entreprise
  /// (qui affiche alors la vue « Demandes »).
  void _onOpenRequest() {
    final wanted = session.openRequest.value;
    if (wanted == null) return;
    final index = session.me?.companies.indexWhere((m) => m.company.id == wanted.companyId) ?? -1;
    // L'onglet « Tous mes plannings » vient en premier s'il est affiché.
    if (index >= 0) _tabs?.animateTo(index + (_showAll ? 1 : 0));
  }

  /// Notification reçue pendant que l'application est à l'écran : Android
  /// ne l'affiche pas lui-même, on la montre ici.
  void _onPush(PushEvent e) {
    if (!mounted) return;
    final conversation = e.data['conversationId'] as String?;
    if (e.opened) {
      // Notification de message touchée : on ouvre la conversation.
      if (e.kind == 'message' && conversation != null) {
        openConversationFromPush(context, session, e.data['companyId'] as String, conversation);
      }
      // Notification d'une demande touchée : on ouvre la demande.
      final request = e.data['requestId'] as String?;
      final company = e.data['companyId'] as String?;
      if (request != null && company != null) {
        Navigator.of(context).popUntil((r) => r.isFirst);
        session.openRequest.value = (companyId: company, requestId: request);
      }
      return;
    }
    // Message de la conversation déjà à l'écran : rien à signaler.
    if (e.body == null || (conversation != null && conversation == session.openConversation)) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.title == null ? e.body! : '${e.title} · ${e.body}')));
  }

  /// Une modification en attente a été refusée par le serveur : on le dit.
  void _onSync() {
    final rejection = session.sync.rejection;
    if (rejection == null || !mounted) return;
    session.sync.clearRejection();
    final t = context.l10n;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.syncRejected(rejection(t)))));
  }

  @override
  Widget build(BuildContext context) {
    final me = session.me!;
    final companies = me.companies;
    return DefaultTabController(
      key: ValueKey(companies.map((m) => m.company.id).join(',')),
      length: companies.length + (_showAll ? 1 : 0),
      child: Builder(builder: (context) {
        _tabs = companies.isEmpty ? null : DefaultTabController.of(context);
        return Scaffold(
        appBar: AppBar(
          // Sur un très petit écran, le titre rétrécit au lieu de cacher les boutons.
          title: const FittedBox(fit: BoxFit.scaleDown, child: BrandTitle(size: 22)),
          actions: [
            SyncIndicator(session: session),
            NoticesButton(session: session),
            // Son QR code toujours à portée de main (pour se faire ajouter).
            IconButton(
              tooltip: context.l10n.myQrCode,
              icon: const Icon(Icons.qr_code_2),
              onPressed: () => showMyQrCode(context, session.me!.user),
            ),
            _ProfileMenu(session: session),
          ],
          bottom: companies.isEmpty
              ? null
              : PreferredSize(
                  preferredSize: const Size.fromHeight(kTextTabBarHeight),
                  child: Row(children: [
                    Flexible(
                      child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    if (_showAll)
                      Tab(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.calendar_view_week, size: 18),
                          const SizedBox(width: 6),
                          Text(context.l10n.allSchedules),
                        ]),
                      ),
                    for (final (i, m) in companies.indexed)
                      _showAll
                          ? Tab(
                              child: Row(mainAxisSize: MainAxisSize.min, children: [
                                CircleAvatar(radius: 5, backgroundColor: companyColor(i)),
                                const SizedBox(width: 6),
                                Text(m.company.name),
                              ]),
                            )
                          : Tab(text: m.company.name),
                  ],
                      ),
                    ),
                    // Nouvelle entreprise : un onglet de plus.
                    IconButton(
                      tooltip: context.l10n.newCompany,
                      color: Colors.white,
                      onPressed: () => createCompany(context, session),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ]),
                ),
        ),
        body: Column(
          children: [
            for (final r in me.pendingJoinRequests) _JoinBanner(session: session, request: r),
            for (final t in me.pendingTransfers) _TransferBanner(session: session, transfer: t),
            Expanded(
              child: companies.isEmpty
                  ? _NoCompany(session: session)
                  : TabBarView(
                      children: [
                        if (_showAll) AllSchedulesView(session: session),
                        for (final m in companies)
                          CompanyTab(key: ValueKey(m.company.id), session: session, membership: m),
                      ],
                    ),
            ),
          ],
        ),
      );
      }),
    );
  }
}

Future<void> createCompany(BuildContext context, Session session) async {
  final t = context.l10n;
  final name = TextEditingController();
  // Fuseau de l'appareil (réglage du téléphone ou de l'ordinateur) ; à
  // défaut, celui du pays de la langue. Modifiable dans la liste.
  var suggested = defaultTimezone(WidgetsBinding.instance.platformDispatcher.locale);
  try {
    suggested = (await FlutterTimezone.getLocalTimezone()).identifier;
  } catch (_) {}
  final zones = [if (!timezones.contains(suggested) && suggested.contains('/')) suggested, ...timezones];
  var timezone = zones.contains(suggested) ? suggested : zones.first;
  if (!context.mounted) return;
  final created = await showDialog<bool>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(t.newCompany),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              autofocus: true,
              decoration: InputDecoration(labelText: t.name),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: timezone,
              decoration: InputDecoration(labelText: t.timezone),
              items: [for (final z in zones) DropdownMenuItem(value: z, child: Text(z))],
              onChanged: (z) => setState(() => timezone = z!),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.create)),
        ],
      ),
    ),
  );
  if (created != true || !context.mounted) return;
  await runAction(context, session, () => session.api.createCompany(name.text, timezone));
}

/// Lance une action de l'API, affiche l'erreur éventuelle, puis recharge `/me`.
Future<void> runAction(BuildContext context, Session session, Future<void> Function() action,
    {String? success}) async {
  final messenger = ScaffoldMessenger.of(context);
  final t = context.l10n;
  try {
    await action();
    if (success != null) messenger.showSnackBar(SnackBar(content: Text(success)));
  } on ApiException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
  } on OfflineException {
    messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
  } catch (_) {
    messenger.showSnackBar(SnackBar(content: Text(t.serverUnreachable)));
  }
  await session.refresh().catchError((_) {});
}

class _NoCompany extends StatelessWidget {
  final Session session;

  const _NoCompany({required this.session});

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.storefront, size: 48),
            const SizedBox(height: 12),
            Text(t.noCompanyTitle, textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(t.noCompanyHint, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => showJoinCodeDialog(context, session),
              icon: const Icon(Icons.pin),
              label: Text(t.joinCompany),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => createCompany(context, session),
              icon: const Icon(Icons.add_business),
              label: Text(t.createCompany),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransferBanner extends StatelessWidget {
  final Session session;
  final Transfer transfer;

  const _TransferBanner({required this.session, required this.transfer});

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final company = session.me!.companies
        .where((m) => m.company.id == transfer.companyId)
        .firstOrNull
        ?.company
        .name;
    return MaterialBanner(
      content: Text(t.transferOffer(company ?? t.someCompany)),
      actions: [
        TextButton(
          onPressed: () => runAction(context, session,
              () => session.api.answerTransfer(transfer.id, accept: false)),
          child: Text(t.decline),
        ),
        FilledButton(
          onPressed: () => runAction(
              context, session, () => session.api.answerTransfer(transfer.id, accept: true),
              success: t.becameOwner),
          child: Text(t.accept),
        ),
      ],
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  final Session session;

  const _ProfileMenu({required this.session});

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final user = session.me!.user;
    return PopupMenuButton<String>(
      tooltip: t.myAccount,
      icon: CircleAvatar(
        radius: 16,
        backgroundImage: user.photoUrl == null ? null : NetworkImage(user.photoUrl!),
        child: user.photoUrl == null ? Text(user.name.characters.first.toUpperCase()) : null,
      ),
      onSelected: (v) {
        if (v == 'qr') {
          showMyQrCode(context, user);
        } else if (v == 'name') {
          _changeName(context);
        } else if (v == 'notifications') {
          NotificationSettingsPage.open(context, session);
        } else if (v == 'join') {
          showJoinCodeDialog(context, session);
        } else if (v == 'create') {
          createCompany(context, session);
        } else if (v == 'calendar') {
          showCalendarDialog(context, session);
        } else if (v == 'language') {
          showLanguagePicker(context, session);
        } else if (v == 'copy') {
          Clipboard.setData(ClipboardData(text: user.publicId));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.idCopied)));
        } else if (v == 'logout') {
          session.signOut();
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(enabled: false, child: Text('${user.name}\n${user.email}')),
        _item('qr', Icons.qr_code_2, t.myQrCode),
        _item('name', Icons.badge_outlined, t.changeMyName),
        _item('notifications', Icons.notifications_outlined, t.notificationsTitle),
        _item('calendar', Icons.event, t.googleCalendar),
        _item('join', Icons.pin_outlined, t.joinCompany),
        _item('copy', Icons.copy, t.myId(user.publicId)),
        _item('language', Icons.language, t.language),
        _item('logout', Icons.logout, t.signOut),
      ],
    );
  }

  static PopupMenuItem<String> _item(String value, IconData icon, String label) => PopupMenuItem(
        value: value,
        child: Row(children: [Icon(icon, size: 20, color: Brand.blue), const SizedBox(width: 12), Flexible(child: Text(label))]),
      );

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
}

class _JoinBanner extends StatelessWidget {
  final Session session;
  final JoinRequest request;

  const _JoinBanner({required this.session, required this.request});

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    return MaterialBanner(
      content: Text(t.joinInvite(request.company.name, request.role.label(t).toLowerCase())),
      actions: [
        TextButton(
          onPressed: () =>
              runAction(context, session, () => session.api.answerJoin(request.id, accept: false)),
          child: Text(t.decline),
        ),
        FilledButton(
          onPressed: () => runAction(
              context, session, () => session.api.answerJoin(request.id, accept: true),
              success: t.joinedCompany(request.company.name)),
          child: Text(t.accept),
        ),
      ],
    );
  }
}
