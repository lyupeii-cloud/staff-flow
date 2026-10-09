import 'dart:async';

import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../push.dart';
import '../session.dart';
import 'company_tab.dart';

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

  void _load() => _list = session.sync
      .read('convs:${company.id}', '/companies/${company.id}/conversations')
      .then((j) => [for (final c in j['conversations']) Conversation.fromJson(c)]);

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
    final picked = await showModalBottomSheet<Member>(
      context: context,
      showDragHandle: true,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(t.newConversation, style: Theme.of(context).textTheme.titleLarge),
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
                        : _Avatar(name: c.withName ?? '?', photoUrl: c.withPhotoUrl),
                    title: Text(c.isGroup ? t.wholeTeam : (c.withName ?? '?'),
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

/// Une conversation : messages du plus ancien au plus récent, envoi en bas.
class ChatScreen extends StatefulWidget {
  final Session session;
  final Company company;
  final Conversation conversation;

  const ChatScreen({super.key, required this.session, required this.company, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _text = TextEditingController();
  final _scroll = ScrollController();
  List<ChatMessage> _messages = [];

  /// Messages en cours d'envoi : affichés tout de suite, avec l'horloge.
  final List<ChatMessage> _sending = [];
  bool _loading = true;
  bool _hasEarlier = false;
  Timer? _poll;
  StreamSubscription<PushEvent>? _push;

  Session get session => widget.session;
  String get id => widget.conversation.id;
  String get _path => '/conversations/$id/messages';

  @override
  void initState() {
    super.initState();
    _refresh();
    session.openConversation = id;
    // Temps réel : la notification prévient tout de suite ; la relecture
    // régulière rattrape ce qui aurait été manqué.
    _poll = Timer.periodic(const Duration(seconds: 10), (_) => _refresh());
    _push = session.push.events.listen((e) {
      if (e.data['conversationId'] == id) _refresh();
    });
    session.sync.addListener(_onSync);
  }

  @override
  void dispose() {
    _poll?.cancel();
    if (session.openConversation == id) session.openConversation = null;
    _push?.cancel();
    session.sync.removeListener(_onSync);
    _text.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _onSync() {
    if (mounted) _refresh();
  }

  /// Derniers messages (serveur, ou copie gardée hors connexion).
  Future<void> _refresh() async {
    try {
      final j = await session.sync.read('chat:$id', _path);
      final latest = [for (final m in j['messages']) ChatMessage.fromJson(m)];
      if (!mounted) return;
      // On garde l'historique déjà remonté plus haut.
      final older = _messages.where((m) => m.id != null && latest.isNotEmpty && m.id! < latest.first.id!);
      final wasEmpty = _messages.isEmpty;
      setState(() {
        _messages = [...older, ...latest];
        if (wasEmpty) _hasEarlier = latest.length >= 50;
        _loading = false;
      });
      _markRead();
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  int _lastRead = 0;

  Future<void> _markRead() async {
    final last = _messages.lastWhere((m) => m.id != null, orElse: () => ChatMessage(body: '', createdAt: DateTime(0))).id;
    if (last == null || last <= _lastRead) return;
    _lastRead = last;
    try {
      await session.api.send('POST', '/conversations/$id/read', body: {'lastId': last});
    } catch (_) {}
  }

  Future<void> _loadEarlier() async {
    final first = _messages.firstWhere((m) => m.id != null).id;
    try {
      final j = await session.api.send('GET', '$_path?before=$first');
      final earlier = [for (final m in j['messages']) ChatMessage.fromJson(m)];
      setState(() {
        _messages = [...earlier, ..._messages];
        _hasEarlier = earlier.length >= 50;
      });
    } on OfflineException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.offlineUnavailable)));
      }
    }
  }

  Future<void> _send() async {
    final text = _text.text.trim();
    if (text.isEmpty) return;
    _text.clear();
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final sending = ChatMessage(authorId: session.me?.user.id, body: text, createdAt: DateTime.now());
    setState(() => _sending.add(sending));
    try {
      await session.sync.submit(widget.company.id, 'message', 'POST', _path,
          body: {'body': text}, args: {'conversationId': id, 'createdAt': DateTime.now().toIso8601String()});
      await _refresh();
    } on ApiException catch (e) {
      _text.text = text;
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      _sending.remove(sending);
    }
    if (mounted) setState(() {});
  }

  /// Messages écrits hors connexion, pas encore envoyés.
  List<ChatMessage> get _pending => [
        for (final op in session.sync.queue)
          if (op.kind == 'message' && op.args['conversationId'] == id)
            ChatMessage(
              authorId: session.me?.user.id,
              body: op.body!['body'] as String,
              createdAt: op.createdAt,
            ),
      ];

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    final me = session.me?.user.id;
    final c = widget.conversation;
    final pending = _pending;
    final all = [..._messages, ...pending, ..._sending.where((s) => !pending.any((p) => p.body == s.body))];
    final canWrite = !widget.company.readOnly && (c.isGroup || c.withActive);
    return Scaffold(
      appBar: AppBar(
        title: Text(c.isGroup ? '${t.wholeTeam} · ${widget.company.name}' : (c.withName ?? '?')),
      ),
      body: Column(
        children: [
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : all.isEmpty
                    ? Center(child: Text(t.noMessages))
                    : ListView.builder(
                        controller: _scroll,
                        reverse: true,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        itemCount: all.length + (_hasEarlier ? 1 : 0),
                        itemBuilder: (context, i) {
                          if (i == all.length) {
                            return Center(
                              child: TextButton(onPressed: _loadEarlier, child: Text(t.earlierMessages)),
                            );
                          }
                          final index = all.length - 1 - i;
                          final m = all[index];
                          final previous = index > 0 ? all[index - 1] : null;
                          final newDay = previous == null || dateOnly(previous.createdAt) != dateOnly(m.createdAt);
                          return Column(
                            children: [
                              if (newDay)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(dayLabel(m.createdAt, loc),
                                      style: Theme.of(context).textTheme.labelSmall),
                                ),
                              _Bubble(
                                message: m,
                                mine: m.authorId == me,
                                showAuthor: c.isGroup && m.authorId != me && previous?.authorId != m.authorId,
                              ),
                            ],
                          );
                        },
                      ),
          ),
          if (!canWrite && !widget.company.readOnly)
            Padding(padding: const EdgeInsets.all(16), child: Text(t.personLeftCompany))
          else if (canWrite)
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _text,
                        minLines: 1,
                        maxLines: 5,
                        maxLength: 2000,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: t.messageHint,
                          counterText: '',
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton.filled(onPressed: _send, icon: const Icon(Icons.send)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final ChatMessage message;
  final bool mine;
  final bool showAuthor;

  const _Bubble({required this.message, required this.mine, required this.showAuthor});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final at = message.createdAt;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
          decoration: BoxDecoration(
            color: mine ? scheme.primaryContainer : scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(mine ? 16 : 4),
              bottomRight: Radius.circular(mine ? 4 : 16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showAuthor)
                Text(message.authorName ?? '?',
                    style: text.labelMedium?.copyWith(color: scheme.primary, fontWeight: FontWeight.w700)),
              SelectableText(message.body, style: text.bodyLarge),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(timeLabel(at.hour * 60 + at.minute), style: text.labelSmall),
                  if (message.pending) ...[
                    const SizedBox(width: 4),
                    Icon(Icons.schedule, size: 12, color: text.labelSmall?.color),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ouvre une conversation depuis une notification touchée.
Future<void> openConversationFromPush(
    BuildContext context, Session session, String companyId, String conversationId) async {
  final membership = session.me?.companies.where((m) => m.company.id == companyId).firstOrNull;
  if (membership == null) return;
  try {
    final j = await session.sync.read('convs:$companyId', '/companies/$companyId/conversations');
    final c = [for (final c in j['conversations']) Conversation.fromJson(c)]
        .where((c) => c.id == conversationId)
        .firstOrNull;
    if (c == null || !context.mounted) return;
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ChatScreen(session: session, company: membership.company, conversation: c),
    ));
  } catch (_) {
    // Hors connexion et jamais ouverte : la messagerie reste accessible depuis l'onglet.
  }
}
