import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'notifications.dart';
import 'store.dart';

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
             AND m.id > coalesce(r.last_read_id, 0) AND m.created_at > me.joined_at) AS unread
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
      WHERE c.company_id = @c::uuid AND (c.kind = 'group' OR @u::uuid IN (c.user_a, c.user_b))
      ORDER BY c.kind = 'group' DESC, last.created_at DESC NULLS LAST''',
        {'c': companyId, 'u': actor.id});
    return [
      for (final r in rows.map((r) => r.toColumnMap()))
        {
          'id': r['id'],
          'kind': r['kind'],
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
  Future<({String companyId, String kind, String? otherId, Company company})> _open(
      User actor, String conversationId) async {
    final rows = await store.query(store.db, '''
      SELECT company_id::text, kind, user_a::text, user_b::text FROM conversations
      WHERE id = @id::uuid''', {'id': conversationId});
    if (rows.isEmpty) throw const ApiError.notFound('Conversation introuvable.');
    final [companyId as String, kind as String, a as String?, b as String?] = rows.first;
    if (kind == 'private' && actor.id != a && actor.id != b) {
      throw const ApiError.notFound('Conversation introuvable.');
    }
    final (company, _) = await companies.open(actor, companyId);
    return (companyId: companyId, kind: kind, otherId: actor.id == a ? b : a, company: company);
  }

  /// Messages du plus ancien au plus récent ; [before] : pour remonter
  /// l'historique, 50 à la fois.
  Future<List<Map<String, Object?>>> messages(User actor, String conversationId,
      {int? before, int limit = 50}) async {
    final conv = await _open(actor, conversationId);
    final rows = await store.query(store.db, '''
      SELECT m.id, m.author_id::text, $_name AS author_name, m.body, m.created_at
      FROM messages m
      LEFT JOIN users u ON u.id = m.author_id
      LEFT JOIN memberships ms ON ms.user_id = u.id AND ms.company_id = @c::uuid AND ms.left_at IS NULL
      WHERE m.conversation_id = @id::uuid AND (@before::bigint IS NULL OR m.id < @before::bigint)
      ORDER BY m.id DESC LIMIT @limit''',
        {'id': conversationId, 'c': conv.companyId, 'before': before, 'limit': limit.clamp(1, 100)});
    return [for (final r in rows.reversed) _message(r.toColumnMap())];
  }

  static Map<String, Object?> _message(Map<String, dynamic> r) => {
        'id': r['id'],
        'authorId': r['author_id'],
        'authorName': r['author_name'],
        'body': r['body'],
        'createdAt': (r['created_at'] as DateTime).toUtc().toIso8601String(),
      };

  Future<Map<String, Object?>> send(User actor, String conversationId, String body) async {
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
    final rows = await store.query(store.db, '''
      INSERT INTO messages (conversation_id, author_id, body) VALUES (@id::uuid, @u::uuid, @b)
      RETURNING id, author_id::text, body, created_at''', {'id': conversationId, 'u': actor.id, 'b': text});
    final row = rows.first.toColumnMap();
    // L'auteur a forcément lu son propre message.
    await markRead(actor, conversationId, row['id'] as int, checked: true);
    final authorName = await _nameIn(conv.companyId, actor);
    final message = _message({...row, 'author_name': authorName});

    final recipients = conv.kind == 'group'
        ? [for (final m in await store.members(conv.companyId)) if (m.user.id != actor.id) m.user.id]
        : [conv.otherId!];
    notifications.pushDirect(
      recipients,
      category: NotifyCategory.messages,
      title: conv.kind == 'group' ? '${conv.company.name} · $authorName' : '$authorName · ${conv.company.name}',
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
      WHERE (c.kind = 'group' OR @u::uuid IN (c.user_a, c.user_b))
        AND m.author_id IS DISTINCT FROM @u::uuid
        AND m.id > coalesce(r.last_read_id, 0) AND m.created_at > me.joined_at
      GROUP BY c.company_id''', {'u': userId});
    return {for (final r in rows) r[0] as String: r[1] as int};
  }
}
