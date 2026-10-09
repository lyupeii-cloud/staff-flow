import 'dart:async';

import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../push.dart';
import '../session.dart';
import 'chat_screen.dart';
import 'company_tab.dart';
import 'group_editor.dart';

/// Messagerie d'une entreprise (section 7) : le groupe de toute l'équipe,
/// puis les conversations privées. Hors connexion : la dernière liste
/// gardée, et les messages écrits partent au retour du réseau.
class MessagesView extends StatefulWidget {
  final Session session;
  final Membership membership;
  final CompanyData data;

  const MessagesView({super.key, required this.session, required this.membership, required this.data});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  late Future<List<Conversation>> _list;
  StreamSubscription<PushEvent>? _push;

  Session get session => widget.session;
  Company get company => widget.membership.company;

  @override
  void initState() {
    super.initState();
    _load();
    _push = session.push.events.listen((e) {
      if (e.kind == 'message' && e.data['companyId'] == company.id && mounted) setState(_load);
    });
    session.sync.addListener(_onSync);
  }

  @override
  void dispose() {
    _push?.cancel();
    session.sync.removeListener(_onSync);
    super.dispose();
  }

  late int _synced = session.sync.synced;

  void _onSync() {
    if (session.sync.synced == _synced || !mounted) return;
    _synced = session.sync.synced;
    setState(_load);
  }

  void _load() {
    _list = session.sync
        .read('convs:${company.id}', '/companies/${company.id}/conversations')
        .then((j) => [for (final c in j['conversations']) Conversation.fromJson(c)]);
  }

  Future<void> _open(Conversation c) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ChatScreen(session: session, company: company, conversation: c),
    ));
    if (mounted) setState(_load);
    unawaited(session.refresh().catchError((_) {}));
  }

  /// Nouvelle conversation privée. Un salarié écrit à un responsable ; un
  /// responsable peut écrire à tout le monde.
  Future<void> _newConversation() async {
    final t = context.l10n;
    final me = session.me!.user.id;
    final canManage = widget.membership.role.canManage;
    final people = [
      for (final m in widget.data.members)
        if (m.user.id != me && (canManage || m.role.canManage)) m,
    ];
    final picked = await showModalBottomSheet<Object>(
      context: context,
      showDragHandle: true,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(t.newConversation, style: Theme.of(context).textTheme.titleLarge),
          ),
          if (canManage)
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.group_add)),
              title: Text(t.newGroup),
              onTap: () => Navigator.pop(context, _newGroup),
            ),
          for (final m in people)
            ListTile(
              leading: _Avatar(name: m.user.name, photoUrl: m.user.photoUrl),
              title: Text(m.user.name),
              subtitle: Text(m.role.label(t)),
              onTap: () => Navigator.pop(context, m),
            ),
        ],
      ),
    );
    if (picked == null || !mounted) return;
    if (picked == _newGroup) {
      final id = await GroupEditorPage.open(context,
          session: session, company: company, members: widget.data.members);
      if (id == null || !mounted) return;
      setState(_load);
      final list = await _list;
      final created = list.where((c) => c.id == id).firstOrNull;
      if (created != null && mounted) await _open(created);
      return;
    }
    if (picked is! Member) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final j = await session.api
          .send('POST', '/companies/${company.id}/conversations', body: {'userId': picked.user.id});
      if (!mounted) return;
      await _open(Conversation.fromJson({
        'id': j['id'],
        'kind': 'private',
        'with': {'id': picked.user.id, 'name': picked.user.name, 'photoUrl': picked.user.photoUrl},
      }));
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: company.readOnly
          ? null
          : FloatingActionButton.extended(
              heroTag: 'new-conversation',
              onPressed: _newConversation,
              icon: const Icon(Icons.edit),
              label: Text(t.newConversation),
            ),
      body: RefreshIndicator(
        onRefresh: () async => setState(_load),
        child: FutureBuilder(
          future: _list,
          builder: (context, snap) {
            if (snap.hasError && !snap.hasData) {
              return ListView(children: [
                Padding(padding: const EdgeInsets.all(24), child: Text(t.offlineUnavailable)),
              ]);
            }
            if (!snap.hasData) return const Center(child: CircularProgressIndicator());
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 88),
              children: [
                for (final c in snap.data!)
                  ListTile(
                    leading: c.isGroup
                        ? const CircleAvatar(child: Icon(Icons.groups))
                        : c.isTeam
                        ? const CircleAvatar(child: Icon(Icons.workspaces))
                        : _Avatar(name: c.withName ?? '?', photoUrl: c.withPhotoUrl),
                    title: Text(c.isGroup ? t.wholeTeam : (c.isTeam ? c.name ?? '?' : c.withName ?? '?'),
                        style: c.unread > 0 ? const TextStyle(fontWeight: FontWeight.w700) : null),
                    subtitle: Text(
                      c.last == null ? t.noMessages : t.messagePreview(c.last!.authorName ?? '?', c.last!.body),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (c.last != null)
                          Text(_shortWhen(c.last!.createdAt, loc), style: Theme.of(context).textTheme.bodySmall),
                        if (c.unread > 0) ...[
                          const SizedBox(height: 4),
                          Badge(label: Text('${c.unread}')),
                        ],
                      ],
                    ),
                    onTap: () => _open(c),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Choix « nouveau groupe » dans la liste des personnes.
const _newGroup = 'new-group';

/// Heure si c'est aujourd'hui, sinon la date courte.
String _shortWhen(DateTime at, String loc) {
  final now = DateTime.now();
  return dateOnly(at) == dateOnly(now) ? timeLabel(at.hour * 60 + at.minute) : dayLabel(at, loc);
}

class _Avatar extends StatelessWidget {
  final String name;
  final String? photoUrl;

  const _Avatar({required this.name, this.photoUrl});

  @override
  Widget build(BuildContext context) => CircleAvatar(
        backgroundImage: photoUrl == null ? null : NetworkImage(photoUrl!),
        child: photoUrl == null ? Text(name.characters.first.toUpperCase()) : null,
      );
}

