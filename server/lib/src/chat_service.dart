import 'dart:convert';

import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'notifications.dart';
import 'store.dart';
import 'translator.dart';

/// Messagerie interne (section 7) : un groupe par entreprise avec tous ses
/// membres, et des conversations privées entre un salarié et un responsable
/// (ou entre responsables). Les messages restent dans l'entreprise : un
/// membre qui part n'y a plus accès, le nouveau propriétaire les garde.
class ChatService {
  final Store store;
  final CompanyService companies;
  final NotificationService notifications;

  static const maxLength = 2000;

  ChatService(this.store, this.companies, this.notifications);

  /// Nom affiché d'une personne dans l'entreprise `c` (alias `ms`, `u`).
  static const _name = 'coalesce(ms.display_name, u.custom_name, u.name)';

  /// La conversation `c` est-elle visible par `@u` (membre actuel de l'entreprise) ?
  static const _visible = '''(c.kind = 'group'
    OR (c.kind = 'private' AND @u::uuid IN (c.user_a, c.user_b))
    OR (c.kind = 'team' AND EXISTS (SELECT 1 FROM conversation_members cm
          WHERE cm.conversation_id = c.id AND cm.user_id = @u::uuid)))''';

  /// Les messages comptent comme non lus à partir de l'arrivée de `@u`
  /// dans l'entreprise (`me`) ou dans le groupe.
  static const _since = '''greatest(me.joined_at, coalesce((SELECT cm.added_at FROM conversation_members cm
      WHERE cm.conversation_id = c.id AND cm.user_id = @u::uuid), me.joined_at))''';

  /// Conversations visibles par [actor] dans l'entreprise, groupe en premier.
  Future<List<Map<String, Object?>>> conversations(User actor, String companyId) async {
    final (_, _) = await companies.open(actor, companyId);
    await store.query(store.db, '''
      INSERT INTO conversations (company_id, kind) VALUES (@c::uuid, 'group')
      ON CONFLICT (company_id) WHERE kind = 'group' DO NOTHING''', {'c': companyId});
    final rows = await store.query(store.db, '''
      SELECT c.id::text, c.kind,
        other.id::text AS other_id, other.name AS other_name, other.photo_url AS other_photo,
        other.role AS other_role, other.active AS other_active,
        last.body AS last_body, last.author_name AS last_author, last.created_at AS last_at,
        (SELECT count(*) FROM messages m
           WHERE m.conversation_id = c.id AND m.author_id IS DISTINCT FROM @u::uuid
             AND m.id > coalesce(r.last_read_id, 0) AND m.created_at > $_since) AS unread,
        c.name AS team_name,
        (SELECT array_agg(cm.user_id::text) FROM conversation_members cm WHERE cm.conversation_id = c.id) AS member_ids
      FROM conversations c
      JOIN memberships me ON me.company_id = c.company_id AND me.user_id = @u::uuid AND me.left_at IS NULL
      LEFT JOIN conversation_reads r ON r.conversation_id = c.id AND r.user_id = @u::uuid
      LEFT JOIN LATERAL (
        SELECT u.id, $_name AS name, u.photo_url, ms.role, ms.user_id IS NOT NULL AS active
        FROM users u
        LEFT JOIN memberships ms ON ms.user_id = u.id AND ms.company_id = c.company_id AND ms.left_at IS NULL
        WHERE c.kind = 'private' AND u.id = CASE WHEN c.user_a = @u::uuid THEN c.user_b ELSE c.user_a END
      ) other ON true
      LEFT JOIN LATERAL (
        SELECT m.body, m.created_at, $_name AS author_name
        FROM messages m
        LEFT JOIN users u ON u.id = m.author_id
        LEFT JOIN memberships ms ON ms.user_id = u.id AND ms.company_id = c.company_id AND ms.left_at IS NULL
        WHERE m.conversation_id = c.id ORDER BY m.id DESC LIMIT 1
      ) last ON true
      WHERE c.company_id = @c::uuid AND $_visible
      ORDER BY c.kind = 'group' DESC, last.created_at DESC NULLS LAST''',
        {'c': companyId, 'u': actor.id});
    return [
      for (final r in rows.map((r) => r.toColumnMap()))
        {
          'id': r['id'],
          'kind': r['kind'],
          if (r['kind'] == 'team') ...{'name': r['team_name'], 'memberIds': r['member_ids'] ?? const []},
          if (r['kind'] == 'private')
            'with': {
              'id': r['other_id'],
              'name': r['other_name'],
              'photoUrl': r['other_photo'],
              'role': r['other_role'],
              'active': r['other_active'],
            },
          'lastMessage': r['last_at'] == null
              ? null
              : {
                  'body': r['last_body'],
                  'authorName': r['last_author'],
                  'createdAt': (r['last_at'] as DateTime).toUtc().toIso8601String(),
                },
          'unread': r['unread'],
        },
    ];
  }

  /// Conversation privée avec [userId] (créée au besoin). Un salarié ne
  /// peut écrire en privé qu'à un responsable.
  Future<String> openPrivate(User actor, String companyId, String userId) async {
    final (_, role) = await companies.open(actor, companyId);
    final other = await store.roleOf(companyId, userId);
    if (other == null || userId == actor.id) throw const ApiError.notFound('Membre introuvable.');
    if (!role.canManage && !other.canManage) throw const ApiError.forbidden();
    final (a, b) = actor.id.compareTo(userId) < 0 ? (actor.id, userId) : (userId, actor.id);
    await store.query(store.db, '''
      INSERT INTO conversations (company_id, kind, user_a, user_b)
      VALUES (@c::uuid, 'private', @a::uuid, @b::uuid)
      ON CONFLICT (company_id, user_a, user_b) WHERE kind = 'private' DO NOTHING''',
        {'c': companyId, 'a': a, 'b': b});
    final rows = await store.query(store.db, '''
      SELECT id::text FROM conversations
      WHERE company_id = @c::uuid AND kind = 'private' AND user_a = @a::uuid AND user_b = @b::uuid''',
        {'c': companyId, 'a': a, 'b': b});
    return rows.first[0] as String;
  }

  /// Ouvre la conversation pour [actor] ; 404 si elle ne le concerne pas.
  Future<({String companyId, String kind, String? otherId, String? name, Company company, Role role})> _open(
      User actor, String conversationId) async {
    final rows = await store.query(store.db, '''
      SELECT c.company_id::text, c.kind, c.user_a::text, c.user_b::text, c.name,
        EXISTS (SELECT 1 FROM conversation_members cm WHERE cm.conversation_id = c.id AND cm.user_id = @u::uuid)
      FROM conversations c WHERE c.id = @id::uuid''', {'id': conversationId, 'u': actor.id});
    if (rows.isEmpty) throw const ApiError.notFound('Conversation introuvable.');
    final [companyId as String, kind as String, a as String?, b as String?, name as String?, inTeam as bool] =
        rows.first;
    if ((kind == 'private' && actor.id != a && actor.id != b) || (kind == 'team' && !inTeam)) {
      throw const ApiError.notFound('Conversation introuvable.');
    }
    final (company, role) = await companies.open(actor, companyId);
    return (
      companyId: companyId,
      kind: kind,
      otherId: actor.id == a ? b : a,
      name: name,
      company: company,
      role: role,
    );
  }

  /// Groupe de discussion créé par un responsable avec les personnes
  /// choisies (le responsable en fait partie). Renvoie son identifiant.
  Future<String> createTeam(User actor, String companyId, String name, List<String> userIds) async {
    final (company, role) = await companies.open(actor, companyId);
    if (!role.canManage) throw const ApiError.forbidden();
    if (company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
    final clean = CompanyService.personName(name);
    if (clean == null) throw const ApiError.badRequest('Le nom doit faire entre 1 et 120 caractères.');
    final members = await _checkMembers(companyId, {...userIds, actor.id});
    return store.db.runTx((tx) async {
      final rows = await store.query(tx, '''
        INSERT INTO conversations (company_id, kind, name, created_by)
        VALUES (@c::uuid, 'team', @n, @u::uuid) RETURNING id::text''',
          {'c': companyId, 'n': clean, 'u': actor.id});
      final id = rows.first[0] as String;
      for (final m in members) {
        await store.query(tx, 'INSERT INTO conversation_members (conversation_id, user_id) VALUES (@id::uuid, @u::uuid)',
            {'id': id, 'u': m});
      }
      return id;
    });
  }

  /// Renommer le groupe ou changer ses membres (un responsable de l'entreprise).
  Future<void> updateTeam(User actor, String conversationId, {String? name, List<String>? userIds}) async {
    final rows = await store.query(store.db,
        "SELECT company_id::text FROM conversations WHERE id = @id::uuid AND kind = 'team'", {'id': conversationId});
    if (rows.isEmpty) throw const ApiError.notFound('Conversation introuvable.');
    final companyId = rows.first[0] as String;
    final (company, role) = await companies.open(actor, companyId);
    if (!role.canManage) throw const ApiError.forbidden();
    if (company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
    final clean = name == null ? null : CompanyService.personName(name);
    if (name != null && clean == null) throw const ApiError.badRequest('Le nom doit faire entre 1 et 120 caractères.');
    final members = userIds == null ? null : await _checkMembers(companyId, userIds.toSet());
    await store.db.runTx((tx) async {
      if (clean != null) {
        await store.query(tx, 'UPDATE conversations SET name = @n WHERE id = @id::uuid', {'id': conversationId, 'n': clean});
      }
      if (members != null) {
        await store.query(tx,
            'DELETE FROM conversation_members WHERE conversation_id = @id::uuid AND NOT (user_id::text = ANY(@m))',
            {'id': conversationId, 'm': members.toList()});
        for (final m in members) {
          await store.query(tx, '''
            INSERT INTO conversation_members (conversation_id, user_id) VALUES (@id::uuid, @u::uuid)
            ON CONFLICT DO NOTHING''', {'id': conversationId, 'u': m});
        }
      }
    });
  }

  /// Les personnes doivent toutes être membres actuels de l'entreprise.
  Future<Set<String>> _checkMembers(String companyId, Set<String> userIds) async {
    for (final u in userIds) {
      if (await store.roleOf(companyId, u) == null) throw const ApiError.notFound('Membre introuvable.');
    }
    return userIds;
  }

  /// Messages du plus ancien au plus récent ; [before] : pour remonter
  /// l'historique, 50 à la fois.
  /// [author] : seulement les messages de cette personne (bulle d'une
  /// personne citée : ses derniers messages).
  Future<List<Map<String, Object?>>> messages(User actor, String conversationId,
      {int? before, String? author, int limit = 50}) async {
    final conv = await _open(actor, conversationId);
    final rows = await store.query(store.db, '''
      SELECT m.id, m.author_id::text, $_name AS author_name, m.body, m.created_at, m.mentions,
        m.reply_to, rm.author_id::text AS reply_author_id, rm.body AS reply_body,
        coalesce(rms.display_name, ru.custom_name, ru.name) AS reply_author
      FROM messages m
      LEFT JOIN users u ON u.id = m.author_id
      LEFT JOIN memberships ms ON ms.user_id = u.id AND ms.company_id = @c::uuid AND ms.left_at IS NULL
      LEFT JOIN messages rm ON rm.id = m.reply_to
      LEFT JOIN users ru ON ru.id = rm.author_id
      LEFT JOIN memberships rms ON rms.user_id = ru.id AND rms.company_id = @c::uuid AND rms.left_at IS NULL
      WHERE m.conversation_id = @id::uuid AND (@before::bigint IS NULL OR m.id < @before::bigint)
        AND (@author::uuid IS NULL OR m.author_id = @author::uuid)
      ORDER BY m.id DESC LIMIT @limit''', {
      'id': conversationId,
      'c': conv.companyId,
      'before': before,
      'author': author,
      'limit': limit.clamp(1, 100),
    });
    return [for (final r in rows.reversed) _message(r.toColumnMap())];
  }

  static Map<String, Object?> _message(Map<String, dynamic> r) => {
        'id': r['id'],
        'authorId': r['author_id'],
        'authorName': r['author_name'],
        'body': r['body'],
        'createdAt': (r['created_at'] as DateTime).toUtc().toIso8601String(),
        'mentions': r['mentions'] ?? const [],
        'replyTo': r['reply_to'] == null
            ? null
            : {
                'id': r['reply_to'],
                'authorId': r['reply_author_id'],
                'authorName': r['reply_author'],
                'body': _excerpt(r['reply_body'] as String? ?? ''),
              },
      };

  static String _excerpt(String text) => text.length > 140 ? '${text.substring(0, 139)}…' : text;

  /// Personnes qui voient la conversation (membres actuels de l'entreprise).
  Future<Set<String>> _participants(
      ({String companyId, String kind, String? otherId, String? name, Company company, Role role}) conv,
      String conversationId,
      User actor) async {
    final active = {for (final m in await store.members(conv.companyId)) m.user.id};
    return switch (conv.kind) {
      'private' => {actor.id, conv.otherId!}.intersection(active),
      'team' => {
          for (final r in await store.query(store.db,
              'SELECT user_id::text FROM conversation_members WHERE conversation_id = @id::uuid', {'id': conversationId}))
            if (active.contains(r[0])) r[0] as String,
        },
      _ => active,
    };
  }

  /// Message traduit dans [lang] (langue de l'application de la personne).
  Future<String> translate(User actor, int messageId, String lang, Translator translator) async {
    final rows = await store.query(store.db,
        'SELECT conversation_id::text, body FROM messages WHERE id = @id', {'id': messageId});
    if (rows.isEmpty) throw const ApiError.notFound('Message introuvable.');
    await _open(actor, rows.first[0] as String);
    final body = rows.first[1] as String;
    final Set<String> available;
    try {
      available = await translator.languages();
    } catch (_) {
      throw const ApiError(409, 'translation_unavailable', 'Traduction momentanément indisponible.');
    }
    final target = translatorLanguage(lang, available);
    if (target == null) {
      throw const ApiError(422, 'unsupported_language', 'Traduction indisponible pour cette langue.');
    }
    final cached = await store.query(store.db,
        'SELECT body FROM message_translations WHERE message_id = @id AND lang = @l', {'id': messageId, 'l': target});
    if (cached.isNotEmpty) return cached.first[0] as String;
    final String text;
    try {
      text = await translator.translate(body, target);
    } catch (_) {
      throw const ApiError(409, 'translation_unavailable', 'Traduction momentanément indisponible.');
    }
    await store.query(store.db, '''
      INSERT INTO message_translations (message_id, lang, body) VALUES (@id, @l, @b)
      ON CONFLICT DO NOTHING''', {'id': messageId, 'l': target, 'b': text});
    return text;
  }

  /// [replyTo] : message de la même conversation auquel on répond.
  /// [mentions] : personnes citées avec « # » (elles doivent voir la conversation).
  Future<Map<String, Object?>> send(User actor, String conversationId, String body,
      {int? replyTo, List<String> mentions = const []}) async {
    final conv = await _open(actor, conversationId);
    if (conv.company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
    final text = body.trim();
    if (text.isEmpty || text.length > maxLength) {
      throw const ApiError.badRequest('Message vide ou trop long (2000 caractères au plus).');
    }
    if (conv.kind == 'private' && await store.roleOf(conv.companyId, conv.otherId!) == null) {
      throw const ApiError.conflict('Cette personne ne fait plus partie de l\'entreprise.');
    }
    if (replyTo != null) {
      final found = await store.query(store.db,
          'SELECT 1 FROM messages WHERE id = @r AND conversation_id = @id::uuid', {'r': replyTo, 'id': conversationId});
      if (found.isEmpty) throw const ApiError.notFound('Message introuvable.');
    }
    final participants = await _participants(conv, conversationId, actor);
    final cited = <Map<String, String>>[];
    for (final id in mentions.toSet()) {
      if (!participants.contains(id)) throw const ApiError.notFound('Membre introuvable.');
      final user = (await store.findUser(id))!;
      cited.add({'id': id, 'name': await _nameIn(conv.companyId, user)});
    }
    final rows = await store.query(store.db, '''
      INSERT INTO messages (conversation_id, author_id, body, reply_to, mentions)
      VALUES (@id::uuid, @u::uuid, @b, @r, @m::jsonb)
      RETURNING id''', {'id': conversationId, 'u': actor.id, 'b': text, 'r': replyTo, 'm': jsonEncode(cited)});
    final id = rows.first[0] as int;
    // L'auteur a forcément lu son propre message.
    await markRead(actor, conversationId, id, checked: true);
    final message = (await messages(actor, conversationId, before: id + 1, limit: 1)).single;
    final authorName = message['authorName'] as String;

    notifications.pushDirect(
      participants.where((u) => u != actor.id),
      category: NotifyCategory.messages,
      title: switch (conv.kind) {
        'private' => '$authorName · ${conv.company.name}',
        'team' => '${conv.name} · $authorName',
        _ => '${conv.company.name} · $authorName',
      },
      body: text.length > 200 ? '${text.substring(0, 199)}…' : text,
      data: {'kind': 'message', 'companyId': conv.companyId, 'conversationId': conversationId, 'tag': 'conv-$conversationId'},
    );
    return message;
  }

  Future<String> _nameIn(String companyId, User user) async {
    final rows = await store.query(store.db, '''
      SELECT display_name FROM memberships
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''', {'c': companyId, 'u': user.id});
    return (rows.isEmpty ? null : rows.first[0] as String?) ?? user.name;
  }

  /// Tout est lu jusqu'au message [lastId] compris.
  Future<void> markRead(User actor, String conversationId, int lastId, {bool checked = false}) async {
    if (!checked) await _open(actor, conversationId);
    await store.query(store.db, '''
      INSERT INTO conversation_reads (conversation_id, user_id, last_read_id) VALUES (@id::uuid, @u::uuid, @l)
      ON CONFLICT (conversation_id, user_id)
        DO UPDATE SET last_read_id = greatest(conversation_reads.last_read_id, EXCLUDED.last_read_id)''',
        {'id': conversationId, 'u': actor.id, 'l': lastId});
  }

  /// Messages non lus par entreprise, pour les pastilles.
  Future<Map<String, int>> unreadByCompany(String userId) async {
    final rows = await store.query(store.db, '''
      SELECT c.company_id::text, count(*) FROM messages m
      JOIN conversations c ON c.id = m.conversation_id
      JOIN memberships me ON me.company_id = c.company_id AND me.user_id = @u::uuid AND me.left_at IS NULL
      LEFT JOIN conversation_reads r ON r.conversation_id = c.id AND r.user_id = @u::uuid
      WHERE $_visible
        AND m.author_id IS DISTINCT FROM @u::uuid
        AND m.id > coalesce(r.last_read_id, 0) AND m.created_at > $_since
      GROUP BY c.company_id''', {'u': userId});
    return {for (final r in rows) r[0] as String: r[1] as int};
  }
}
