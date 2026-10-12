import 'dart:convert';

import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'notifications.dart';
import 'store.dart';
import 'translator.dart';

/// Fil d'actualités : le patron et les responsables publient des annonces,
/// pour toute l'entreprise ou pour des postes, des sites, des rôles ou des
/// personnes choisies. Les salariés lisent (et traduisent) ; ils ne
/// répondent pas.
class NewsService {
  final Store store;
  final CompanyService companies;
  final NotificationService notifications;

  static const pageSize = 20;
  static const maxBody = 4000;
  static const maxTitle = 120;

  NewsService(this.store, this.companies, this.notifications);

  /// Le patron active ou coupe le fil d'actualités de l'entreprise.
  Future<void> setEnabled(User actor, String companyId, bool enabled) async {
    final (_, role) = await companies.open(actor, companyId);
    if (role != Role.owner) throw const ApiError.forbidden();
    await store.query(
        store.db, 'UPDATE companies SET messaging_enabled = @e WHERE id = @c::uuid', {'c': companyId, 'e': enabled});
    await store.audit(companyId: companyId, actorId: actor.id, action: 'news.enabled', details: {'enabled': enabled});
  }

  Future<(Company, Role, Set<String>?)> _open(User actor, String companyId) async {
    final (company, role) = await companies.open(actor, companyId);
    if (!company.messagingEnabled) {
      throw const ApiError(409, 'news_disabled', 'Le fil d\'actualités est désactivé dans cette entreprise.');
    }
    return (company, role, await companies.managedSites(companyId, actor, role));
  }

  /// Annonces que [actor] peut lire : pour tous, pour lui, ou écrites par
  /// lui ; le patron et les responsables de toute l'entreprise voient tout.
  static const _visible = '''
    a.company_id = @c::uuid AND (@all OR a.everyone OR a.author_id = @u::uuid
      OR EXISTS (SELECT 1 FROM announcement_recipients r WHERE r.announcement_id = a.id AND r.user_id = @u::uuid))''';

  Future<Map<String, Object?>> list(User actor, String companyId, {DateTime? before}) async {
    final (_, role, mine) = await _open(actor, companyId);
    final all = role.canManage && mine == null;
    final rows = await store.query(store.db, '''
      SELECT a.id::text, a.title, a.body, a.audience, a.everyone, a.created_at, a.edited_at,
        a.author_id::text, coalesce(m.display_name, u.custom_name, u.name), u.photo_url, u.avatar,
        EXISTS (SELECT 1 FROM announcement_reads x WHERE x.announcement_id = a.id AND x.user_id = @u::uuid),
        (SELECT count(*) FROM announcement_recipients r WHERE r.announcement_id = a.id),
        (SELECT count(*) FROM announcement_reads x WHERE x.announcement_id = a.id AND x.user_id IS DISTINCT FROM a.author_id
          AND (a.everyone OR EXISTS (SELECT 1 FROM announcement_recipients r WHERE r.announcement_id = a.id AND r.user_id = x.user_id)))
      FROM announcements a
      LEFT JOIN users u ON u.id = a.author_id
      LEFT JOIN memberships m ON m.company_id = a.company_id AND m.user_id = a.author_id AND m.left_at IS NULL
      WHERE $_visible AND (@before::timestamptz IS NULL OR a.created_at < @before::timestamptz)
      ORDER BY a.created_at DESC LIMIT ${pageSize + 1}''',
        {'c': companyId, 'u': actor.id, 'all': all, 'before': before});
    final items = [
      for (final r in rows.take(pageSize))
        {
          'id': r[0],
          'title': r[1],
          'body': r[2],
          'audience': r[3] is String ? jsonDecode(r[3] as String) : r[3],
          'everyone': r[4],
          'createdAt': (r[5] as DateTime).toUtc().toIso8601String(),
          'editedAt': (r[6] as DateTime?)?.toUtc().toIso8601String(),
          'author': {'id': r[7], 'name': r[8] ?? '?', 'photoUrl': r[9], 'avatar': r[10]},
          'read': r[11],
          // Pour qui écrit ou supervise : combien l'ont lue.
          if (r[7] == actor.id || all) ...{'recipients': r[12], 'reads': r[13]},
        },
    ];
    return {'items': items, 'more': rows.length > pageSize};
  }

  /// Nombre d'annonces non lues, par entreprise (pastille de l'onglet).
  Future<Map<String, int>> unreadByCompany(String userId) async {
    final rows = await store.query(store.db, '''
      SELECT a.company_id::text, count(*) FROM announcements a
      JOIN memberships m ON m.company_id = a.company_id AND m.user_id = @u::uuid AND m.left_at IS NULL
      JOIN companies c ON c.id = a.company_id AND c.messaging_enabled
      WHERE a.created_at > m.joined_at AND a.author_id IS DISTINCT FROM @u::uuid
        AND (a.everyone OR EXISTS (SELECT 1 FROM announcement_recipients r WHERE r.announcement_id = a.id AND r.user_id = @u::uuid))
        AND NOT EXISTS (SELECT 1 FROM announcement_reads x WHERE x.announcement_id = a.id AND x.user_id = @u::uuid)
      GROUP BY a.company_id''', {'u': userId});
    return {for (final r in rows) r[0] as String: r[1] as int};
  }

  /// Tout ce que [actor] voit est maintenant lu.
  Future<void> markRead(User actor, String companyId) async {
    final (_, role, mine) = await _open(actor, companyId);
    await store.query(store.db, '''
      INSERT INTO announcement_reads (announcement_id, user_id)
      SELECT a.id, @u::uuid FROM announcements a WHERE $_visible
      ON CONFLICT DO NOTHING''', {'c': companyId, 'u': actor.id, 'all': role.canManage && mine == null});
  }

  /// Publie une annonce. [audience] : `{"everyone": true}` ou des listes
  /// `positions`, `sites`, `roles` (employee, extra, manager) et `users`.
  /// Un responsable de site ne touche que les personnes de ses sites.
  Future<Map<String, Object?>> publish(User actor, String companyId,
      {String? title, required String body, required Map<String, dynamic> audience}) async {
    final (company, role, mine) = await _open(actor, companyId);
    if (!role.canManage) throw const ApiError.forbidden();
    if (company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
    final (cleanTitle, cleanBody) = _texts(title, body);
    List<String> ids(String key) {
      final v = audience[key];
      if (v == null) return const [];
      if (v is! List || v.any((e) => e is! String)) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
      return v.cast<String>();
    }

    final positions = ids('positions'), sites = ids('sites'), roles = ids('roles'), users = ids('users');
    if (roles.any((r) => !{'employee', 'extra', 'manager'}.contains(r))) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    // Pour tous : toute l'entreprise, ou tous ceux de ses sites.
    final everyone = audience['everyone'] == true;
    if (!everyone && positions.isEmpty && sites.isEmpty && roles.isEmpty && users.isEmpty) {
      throw const ApiError.badRequest('Choisissez au moins un destinataire.');
    }
    final members = await store.members(companyId);
    final expanded = sites.isEmpty ? <String>{} : await store.expandSites(companyId, sites);
    final recipients = <String>{};
    for (final m in members) {
      if (m.user.id == actor.id) continue;
      final memberSites = m.sites ?? const <String>[];
      // Responsable de site : seulement les gens de ses sites.
      if (mine != null && !memberSites.any(mine.contains)) continue;
      final roleName = m.role == Role.owner ? 'manager' : m.role.name;
      if (everyone ||
          (m.positionId != null && positions.contains(m.positionId)) ||
          memberSites.any(expanded.contains) ||
          roles.contains(roleName) ||
          users.contains(m.user.id)) {
        recipients.add(m.user.id);
      }
    }
    if (recipients.isEmpty) throw const ApiError.badRequest('Personne ne correspond à ces destinataires.');
    final forAll = everyone && mine == null;
    final noticeIds = await store.db.runTx((tx) async {
      final rows = await store.query(tx, '''
        INSERT INTO announcements (company_id, author_id, title, body, audience, everyone)
        VALUES (@c::uuid, @u::uuid, @t, @b, @a::jsonb, @e) RETURNING id::text''', {
        'c': companyId,
        'u': actor.id,
        't': cleanTitle,
        'b': cleanBody,
        'a': jsonEncode({
          if (everyone) 'everyone': true,
          'positions': positions,
          'sites': sites,
          'roles': roles,
          'users': users,
        }),
        'e': forAll,
      });
      final id = rows.first[0] as String;
      if (!forAll) {
        await store.query(tx, '''
          INSERT INTO announcement_recipients (announcement_id, user_id)
          SELECT @a::uuid, unnest(@r::uuid[])''', {'a': id, 'r': recipients.toList()});
      }
      await store.audit(
          companyId: companyId,
          actorId: actor.id,
          action: 'news.publish',
          details: {'id': id, 'recipients': recipients.length},
          tx: tx);
      final preview = (cleanTitle ?? cleanBody).replaceAll('\n', ' ');
      return (
        id,
        await notifications.add(tx, recipients,
            companyId: companyId,
            kind: 'announcement',
            data: {
              'announcementId': id,
              'byName': actor.name,
              'text': preview.length > 100 ? '${preview.substring(0, 100)}…' : preview,
            })
      );
    });
    notifications.deliver(noticeIds.$2);
    return {'id': noticeIds.$1, 'recipients': recipients.length};
  }

  (String?, String) _texts(String? title, String body) {
    final t = title?.trim();
    final b = body.trim();
    if (b.isEmpty || b.length > maxBody) throw const ApiError.badRequest('Texte entre 1 et 4000 caractères.');
    if (t != null && t.length > maxTitle) throw const ApiError.badRequest('Titre : 120 caractères au plus.');
    return (t == null || t.isEmpty ? null : t, b);
  }

  /// L'auteur ou le patron corrige une annonce (sans nouvelle notification).
  Future<void> edit(User actor, String companyId, String id, {String? title, required String body}) async {
    final (_, role, _) = await _open(actor, companyId);
    final (t, b) = _texts(title, body);
    final rows = await store.query(store.db, '''
      UPDATE announcements SET title = @t, body = @b, edited_at = now()
      WHERE id::text = @id AND company_id = @c::uuid AND (author_id = @u::uuid OR @owner)
      RETURNING id''', {'id': id, 'c': companyId, 'u': actor.id, 'owner': role == Role.owner, 't': t, 'b': b});
    if (rows.isEmpty) throw const ApiError.notFound('Annonce introuvable.');
    await store.query(store.db, 'DELETE FROM announcement_translations WHERE announcement_id = @a::uuid', {'a': id});
  }

  /// L'auteur, le patron ou un responsable de toute l'entreprise la retire.
  Future<void> delete(User actor, String companyId, String id) async {
    final (_, role, mine) = await _open(actor, companyId);
    final rows = await store.query(store.db, '''
      DELETE FROM announcements
      WHERE id::text = @id AND company_id = @c::uuid AND (author_id = @u::uuid OR @all)
      RETURNING id''', {'id': id, 'c': companyId, 'u': actor.id, 'all': role.canManage && mine == null});
    if (rows.isEmpty) throw const ApiError.notFound('Annonce introuvable.');
    await store.audit(companyId: companyId, actorId: actor.id, action: 'news.delete', details: {'id': id});
  }

  /// Annonce traduite dans [lang] (langue de l'application de la personne).
  Future<Map<String, String?>> translate(User actor, String companyId, String id, String lang, Translator translator) async {
    final (_, role, mine) = await _open(actor, companyId);
    final rows = await store.query(store.db, 'SELECT a.title, a.body FROM announcements a WHERE a.id::text = @id AND $_visible',
        {'id': id, 'c': companyId, 'u': actor.id, 'all': role.canManage && mine == null});
    if (rows.isEmpty) throw const ApiError.notFound('Annonce introuvable.');
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
        'SELECT title, body FROM announcement_translations WHERE announcement_id = @a::uuid AND lang = @l',
        {'a': id, 'l': target});
    if (cached.isNotEmpty) return {'title': cached.first[0] as String?, 'body': cached.first[1] as String};
    final String? title;
    final String body;
    try {
      title = rows.first[0] == null ? null : await translator.translate(rows.first[0] as String, target);
      body = await translator.translate(rows.first[1] as String, target);
    } catch (_) {
      throw const ApiError(409, 'translation_unavailable', 'Traduction momentanément indisponible.');
    }
    await store.query(store.db, '''
      INSERT INTO announcement_translations (announcement_id, lang, title, body) VALUES (@a::uuid, @l, @t, @b)
      ON CONFLICT DO NOTHING''', {'a': id, 'l': target, 't': title, 'b': body});
    return {'title': title, 'body': body};
  }
}
