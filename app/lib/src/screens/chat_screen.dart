import 'dart:async';

import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../push.dart';
import '../session.dart';
import 'group_editor.dart';
import 'requests_view.dart';

/// Une conversation : messages du plus ancien au plus récent, envoi en bas.
/// On peut répondre à un message précis, traduire un message dans sa
/// langue, et citer une personne avec « # ».
class ChatScreen extends StatefulWidget {
  final Session session;
  final Company company;
  final Conversation conversation;

  const ChatScreen({super.key, required this.session, required this.company, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

/// Nombre de personnes visibles à la fois dans la liste « # ».
const _maxSuggestions = 6;

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

  /// Message auquel on répond.
  ChatMessage? _replyTo;

  /// Personnes qui voient la conversation (pour « # »), sauf soi-même.
  List<Mention> _people = [];

  /// Personnes choisies dans la liste « # » : nom → identifiant.
  final Map<String, String> _cited = {};

  /// Recherche en cours après « # » : position du « # » et texte tapé.
  (int, String)? _query;

  /// Traductions déjà demandées, et celles affichées.
  final Map<int, String> _translations = {};
  final Set<int> _translating = {};
  final Set<int> _shown = {};

  Session get session => widget.session;
  String get id => widget.conversation.id;
  String get _path => '/conversations/$id/messages';
  String? get _me => session.me?.user.id;

  @override
  void initState() {
    super.initState();
    _refresh();
    _loadPeople();
    session.openConversation = id;
    // Temps réel : la notification prévient tout de suite ; la relecture
    // régulière (toutes les 30 s, pour ménager le serveur) rattrape ce qui
    // aurait été manqué.
    _poll = Timer.periodic(const Duration(seconds: 30), (_) => _refresh());
    _push = session.push.events.listen((e) {
      if (e.data['conversationId'] == id) _refresh();
    });
    session.sync.addListener(_onSync);
    _text.addListener(_onTextChanged);
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

  /// Membres de l'entreprise qui voient cette conversation.
  Future<void> _loadPeople() async {
    final companyId = widget.company.id;
    try {
      final j = await session.sync.read('members:$companyId', '/companies/$companyId/members');
      final c = _conversation;
      final members = [for (final m in j['members']) Member.fromJson(m)];
      if (!mounted) return;
      setState(() => _people = [
            for (final m in members)
              if (m.user.id != _me &&
                  (c.isGroup ||
                      (c.isTeam && c.memberIds.contains(m.user.id)) ||
                      (!c.isGroup && !c.isTeam && m.user.id == c.withId)))
                Mention(m.user.id, m.user.name),
          ]);
    } catch (_) {}
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

  // --- « # » : citer une personne ------------------------------------------

  /// Après un « # » en début de mot, la liste propose les personnes dont le
  /// nom contient ce qui suit.
  void _onTextChanged() {
    final selection = _text.selection;
    final cursor = selection.isValid ? selection.baseOffset : _text.text.length;
    final before = _text.text.substring(0, cursor.clamp(0, _text.text.length));
    final hash = before.lastIndexOf('#');
    (int, String)? query;
    if (hash >= 0 && (hash == 0 || before[hash - 1].trim().isEmpty)) {
      final typed = before.substring(hash + 1);
      if (!typed.contains('\n') && typed.length <= 40) query = (hash, typed);
    }
    if (query != _query) setState(() => _query = query);
  }

  List<Mention> get _suggestions {
    final q = _query;
    if (q == null) return const [];
    final typed = _fold(q.$2);
    return [for (final p in _people) if (_fold(p.name).contains(typed)) p];
  }

  void _cite(Mention person) {
    final q = _query!;
    final text = _text.text;
    final cursor = _text.selection.isValid ? _text.selection.baseOffset : text.length;
    final inserted = '#${person.name} ';
    final updated = text.replaceRange(q.$1, cursor, inserted);
    _cited[person.name] = person.id;
    _text.value = TextEditingValue(
      text: updated,
      selection: TextSelection.collapsed(offset: q.$1 + inserted.length),
    );
    setState(() => _query = null);
  }

  // --- Envoi ---------------------------------------------------------------

  Future<void> _send() async {
    final text = _text.text.trim();
    if (text.isEmpty) return;
    final mentions = {
      for (final e in _cited.entries)
        if (text.contains('#${e.key}')) e.value,
    }.toList();
    final replyTo = _replyTo;
    _text.clear();
    _cited.clear();
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final sending = ChatMessage(authorId: _me, body: text, createdAt: DateTime.now());
    setState(() {
      _sending.add(sending);
      _replyTo = null;
    });
    try {
      await session.sync.submit(widget.company.id, 'message', 'POST', _path,
          body: {
            'body': text,
            if (mentions.isNotEmpty) 'mentions': mentions,
            if (replyTo?.id != null) 'replyTo': replyTo!.id,
          },
          args: {'conversationId': id});
      await _refresh();
    } on ApiException catch (e) {
      _text.text = text;
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      _sending.remove(sending);
    }
    if (mounted) setState(() {});
  }

  // --- Traduction ----------------------------------------------------------

  /// Traduit le message dans la langue de l'application (ou masque la
  /// traduction déjà affichée).
  Future<void> _translate(ChatMessage m) async {
    final messageId = m.id!;
    if (_shown.contains(messageId)) {
      setState(() => _shown.remove(messageId));
      return;
    }
    if (_translations.containsKey(messageId)) {
      setState(() => _shown.add(messageId));
      return;
    }
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _translating.add(messageId));
    try {
      final j = await session.api
          .send('POST', '/messages/$messageId/translate', body: {'lang': session.api.language});
      setState(() {
        _translations[messageId] = j['text'] as String;
        _shown.add(messageId);
      });
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      if (mounted) setState(() => _translating.remove(messageId));
    }
  }

  // --- Personne citée : ses derniers messages ------------------------------

  Future<void> _showLastMessages(Mention person) async {
    final t = context.l10n;
    final loc = context.localeName;
    Future<List<ChatMessage>> load() async {
      try {
        final j = await session.api.send('GET', '$_path?author=${person.id}&limit=10');
        return [for (final m in j['messages']) ChatMessage.fromJson(m)];
      } on OfflineException {
        // Hors connexion : ce qui est déjà chargé ici.
        final local = _messages.where((m) => m.authorId == person.id).toList();
        return local.sublist((local.length - 10).clamp(0, local.length));
      }
    }

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.lastMessagesOf(person.name)),
        content: SizedBox(
          width: 360,
          child: FutureBuilder(
            future: load(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return const SizedBox(height: 80, child: Center(child: CircularProgressIndicator()));
              }
              final list = snap.data!;
              if (list.isEmpty) return Text(t.noMessages);
              return ListView(
                shrinkWrap: true,
                children: [
                  for (final m in list.reversed)
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(m.body),
                      subtitle: Text(
                          '${dayLabel(m.createdAt, loc)} ${timeLabel(m.createdAt.hour * 60 + m.createdAt.minute)}'),
                    ),
                ],
              );
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(t.close))],
      ),
    );
  }

  // --- Groupe ----------------------------------------------------------------

  late Conversation _conversation = widget.conversation;

  /// Groupe créé par un responsable : changer son nom ou ses membres.
  /// Responsable : supprimer le groupe et ses messages, pour tout le monde.
  Future<void> _deleteGroup() async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.deleteGroup),
        content: Text(t.deleteGroupConfirm(_conversation.name ?? '')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.deleteGroup)),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await session.api.send('DELETE', '/conversations/$id');
      session.sync.markChanged();
      navigator.pop();
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
  }

  Future<void> _editGroup() async {
    final companyId = widget.company.id;
    final messenger = ScaffoldMessenger.of(context);
    final t = context.l10n;
    try {
      final j = await session.sync.read('members:$companyId', '/companies/$companyId/members');
      if (!mounted) return;
      final saved = await GroupEditorPage.open(context,
          session: session,
          company: widget.company,
          members: [for (final m in j['members']) Member.fromJson(m)],
          existing: _conversation);
      if (saved == null) return;
      final list = await session.sync.read('convs:$companyId', '/companies/$companyId/conversations');
      final updated = [for (final c in list['conversations']) Conversation.fromJson(c)].where((c) => c.id == id);
      if (!mounted) return;
      if (updated.isEmpty) {
        // Le responsable s'est retiré du groupe.
        Navigator.pop(context);
      } else {
        setState(() => _conversation = updated.first);
        unawaited(_loadPeople());
      }
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    }
  }

  /// Messages écrits hors connexion, pas encore envoyés.
  List<ChatMessage> get _pending => [
        for (final op in session.sync.queue)
          if (op.kind == 'message' && op.args['conversationId'] == id)
            ChatMessage(authorId: _me, body: op.body!['body'] as String, createdAt: op.createdAt),
      ];

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    final c = _conversation;
    final pending = _pending;
    final all = [..._messages, ...pending, ..._sending.where((s) => !pending.any((p) => p.body == s.body))];
    final canWrite = !widget.company.readOnly && (c.isGroup || c.isTeam || c.withActive);
    final canManage =
        session.me?.companies.where((m) => m.company.id == widget.company.id).firstOrNull?.role.canManage ?? false;
    final suggestions = _suggestions;
    return Scaffold(
      appBar: AppBar(
        title: Text(c.isGroup
            ? '${t.wholeTeam} · ${widget.company.name}'
            : (c.isTeam ? c.name ?? '?' : c.withName ?? '?')),
        actions: [
          if (c.isTeam && canManage && !widget.company.readOnly)
            IconButton(tooltip: t.editGroup, icon: const Icon(Icons.group), onPressed: _editGroup),
          if (c.isTeam && canManage)
            IconButton(tooltip: t.deleteGroup, icon: const Icon(Icons.delete_outline), onPressed: _deleteGroup),
        ],
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
                          final mine = m.authorId == _me;
                          return Column(
                            children: [
                              if (newDay)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(dayLabel(m.createdAt, loc),
                                      style: Theme.of(context).textTheme.labelSmall),
                                ),
                              if (m.requestId != null)
                                _RequestCard(
                                  request: m.request,
                                  session: session,
                                  companyId: widget.company.id,
                                  mine: mine,
                                  onChanged: _refresh,
                                )
                              else
                              _Bubble(
                                message: m,
                                mine: mine,
                                showAuthor:
                                    (c.isGroup || c.isTeam) && !mine && previous?.authorId != m.authorId,
                                translation: m.id != null && _shown.contains(m.id) ? _translations[m.id] : null,
                                translating: m.id != null && _translating.contains(m.id),
                                onReply: m.id == null || !canWrite ? null : () => setState(() => _replyTo = m),
                                onTranslate: m.id == null || mine ? null : () => _translate(m),
                                onMention: _showLastMessages,
                              ),
                            ],
                          );
                        },
                      ),
          ),
          if (!canWrite && !widget.company.readOnly)
            Padding(padding: const EdgeInsets.all(16), child: Text(t.personLeftCompany))
          else if (canWrite) ...[
            if (suggestions.isNotEmpty) _suggestionList(suggestions),
            if (_replyTo != null) _replyBanner(_replyTo!),
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
        ],
      ),
    );
  }

  /// Liste « # » : 6 personnes visibles au plus, le reste en faisant défiler.
  Widget _suggestionList(List<Mention> people) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      constraints: const BoxConstraints(maxHeight: 48.0 * _maxSuggestions),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: ListView(
        shrinkWrap: true,
        itemExtent: 48,
        padding: EdgeInsets.zero,
        children: [
          for (final p in people)
            ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: CircleAvatar(radius: 14, child: Text(p.name.characters.first.toUpperCase())),
              title: Text(p.name),
              onTap: () => _cite(p),
            ),
        ],
      ),
    );
  }

  Widget _replyBanner(ChatMessage m) {
    final t = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 0),
      padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: scheme.primary, width: 4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.replyingTo(m.authorId == _me ? t.meSuffix(m.authorName ?? '?') : m.authorName ?? '?'),
                    style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w700)),
                Text(m.body, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          IconButton(
            tooltip: t.cancel,
            icon: const Icon(Icons.close),
            onPressed: () => setState(() => _replyTo = null),
          ),
        ],
      ),
    );
  }
}

/// Minuscules et sans accents, pour chercher « #eli » dans « Élise ».
String _fold(String s) {
  const from = 'àâäáãåçéèêëíìîïñóòôöõúùûüýÿ';
  const to = 'aaaaaaceeeeiiiinooooouuuuyy';
  final lower = s.toLowerCase();
  final out = StringBuffer();
  for (final ch in lower.split('')) {
    final i = from.indexOf(ch);
    out.write(i < 0 ? ch : to[i]);
  }
  return out.toString();
}

/// Demande dans la conversation, avec ses boutons.
class _RequestCard extends StatelessWidget {
  final StaffRequest? request;
  final Session session;
  final String companyId;
  final bool mine;
  final Future<void> Function() onChanged;

  const _RequestCard(
      {required this.request, required this.session, required this.companyId, required this.mine, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    final r = request;
    if (r == null) return const SizedBox.shrink();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    Future<void> act(String action, [Map<String, dynamic>? body]) async {
      try {
        await session.api.send('POST', '/requests/${r.id}/$action', body: body);
      } on OfflineException {
        messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
      } on ApiException catch (e) {
        messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
      }
      await onChanged();
    }

    // Choisir qui reprend un échange : depuis la liste des demandes.
    void open() {
      navigator.popUntil((route) => route.isFirst);
      session.openRequest.value = (companyId: companyId, requestId: r.id);
    }

    final status = switch (r.status) {
      'pending_peer' => t.statusPendingPeer,
      'pending_manager' => t.statusPendingManager,
      'approved' => t.statusApproved,
      'refused' => t.statusRefused,
      'expired' => t.statusExpired,
      _ => t.statusCancelled,
    };
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: theme.colorScheme.primary),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 8, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(requestIcon(r.kind), color: theme.colorScheme.primary, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('${r.requesterName} · ${requestKindLabel(t, r.kind)}', style: theme.textTheme.titleSmall),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  [...requestDetails(t, context.localeName, r, null), if (r.note != null) '« ${r.note} »'].join('\n'),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(status, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.tertiary)),
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 6,
                  children: [
                    TextButton(onPressed: open, child: Text(t.openRequest)),
                    if (r.canCancel) TextButton(onPressed: () => act('cancel'), child: Text(t.cancelRequest)),
                    if (r.canDecline) TextButton(onPressed: () => act('decline'), child: Text(t.decline)),
                    if (r.canAnswer)
                      FilledButton(
                        onPressed: () => r.canDecide ? act('approve', {'peerId': session.me!.user.id}) : act('accept'),
                        child: Text(t.acceptSwap),
                      ),
                    if (r.canDecide && !r.canAnswer) TextButton(onPressed: () => act('refuse'), child: Text(t.decline)),
                    if (r.canDecide && !r.canAnswer)
                      FilledButton(onPressed: r.needsPeer ? open : () => act('approve'), child: Text(t.approve)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final ChatMessage message;
  final bool mine;
  final bool showAuthor;
  final String? translation;
  final bool translating;
  final VoidCallback? onReply;
  final VoidCallback? onTranslate;
  final ValueChanged<Mention> onMention;

  const _Bubble({
    required this.message,
    required this.mine,
    required this.showAuthor,
    required this.translation,
    required this.translating,
    required this.onReply,
    required this.onTranslate,
    required this.onMention,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final at = message.createdAt;
    final reply = message.replyTo;
    final small = text.labelSmall?.color;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
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
              if (reply != null)
                Container(
                  margin: const EdgeInsets.only(top: 2, bottom: 4),
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  decoration: BoxDecoration(
                    color: scheme.surface.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(left: BorderSide(color: scheme.primary, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reply.authorName ?? '?',
                          style: text.labelSmall?.copyWith(color: scheme.primary, fontWeight: FontWeight.w700)),
                      Text(reply.body, maxLines: 2, overflow: TextOverflow.ellipsis, style: text.bodySmall),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: _body(context),
              ),
              if (translation != null)
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: scheme.outlineVariant))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.translate, size: 14, color: scheme.primary),
                      const SizedBox(width: 6),
                      Flexible(child: Text(translation!, style: text.bodyLarge?.copyWith(fontStyle: FontStyle.italic))),
                    ],
                  ),
                ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(timeLabel(at.hour * 60 + at.minute), style: text.labelSmall),
                  if (message.pending) ...[
                    const SizedBox(width: 4),
                    Icon(Icons.schedule, size: 12, color: small),
                  ],
                  if (onTranslate != null)
                    _SmallAction(
                      icon: translating ? null : Icons.translate,
                      tooltip: t.translateAction,
                      selected: translation != null,
                      onTap: translating ? null : onTranslate,
                    ),
                  if (onReply != null) _SmallAction(icon: Icons.reply, tooltip: t.replyAction, onTap: onReply),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Texte du message, les personnes citées en couleur : les toucher montre
  /// leurs derniers messages.
  Widget _body(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge;
    final body = message.body;
    if (message.mentions.isEmpty) return SelectableText(body, style: style);
    final scheme = Theme.of(context).colorScheme;
    // Les noms les plus longs d'abord (« #Bob Martin » avant « #Bob »).
    final mentions = [...message.mentions]..sort((a, b) => b.name.length.compareTo(a.name.length));
    final spans = <InlineSpan>[];
    var i = 0;
    while (i < body.length) {
      Mention? found;
      var at = body.length;
      for (final m in mentions) {
        final p = body.indexOf('#${m.name}', i);
        if (p >= 0 && p < at) {
          at = p;
          found = m;
        }
      }
      if (found == null) {
        spans.add(TextSpan(text: body.substring(i)));
        break;
      }
      if (at > i) spans.add(TextSpan(text: body.substring(i, at)));
      final person = found;
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () => onMention(person),
          child: Text('#${person.name}',
              style: style?.copyWith(color: scheme.primary, fontWeight: FontWeight.w700)),
        ),
      ));
      i = at + person.name.length + 1;
    }
    return Text.rich(TextSpan(children: spans), style: style);
  }
}

/// Petite icône sous un message (répondre, traduire).
class _SmallAction extends StatelessWidget {
  /// `null` : en cours (petit indicateur de chargement).
  final IconData? icon;
  final String tooltip;
  final bool selected;
  final VoidCallback? onTap;

  const _SmallAction({required this.icon, required this.tooltip, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: icon == null
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : Icon(icon, size: 18, color: selected ? scheme.primary : scheme.onSurfaceVariant),
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
