import 'store.dart';

/// Avis destinés à un utilisateur (par exemple : « un autre responsable a
/// remplacé votre modification »). Le texte est composé par l'application,
/// dans sa langue, à partir de [Notice.kind] et [Notice.data].
class Notice {
  final String id;
  final String? companyId;
  final String kind;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final bool read;

  const Notice(this.id, this.companyId, this.kind, this.data, this.createdAt, this.read);

  Map<String, Object?> toJson() => {
        'id': id,
        'companyId': companyId,
        'kind': kind,
        'data': data,
        'createdAt': createdAt.toUtc().toIso8601String(),
        'read': read,
      };
}

class NoticeService {
  final Store store;

  NoticeService(this.store);

  /// Avis non lus, puis les plus récents déjà lus (50 au plus).
  Future<List<Notice>> list(String userId) async {
    final rows = await store.query(store.db, '''
      SELECT id::text, company_id::text, kind, data, created_at, read_at IS NOT NULL
      FROM notices WHERE user_id = @u::uuid
      ORDER BY read_at IS NOT NULL, created_at DESC LIMIT 50''', {'u': userId});
    return [
      for (final r in rows)
        Notice(r[0] as String, r[1] as String?, r[2] as String, r[3] as Map<String, dynamic>,
            r[4] as DateTime, r[5] as bool),
    ];
  }

  Future<int> unreadCount(String userId) async {
    final rows = await store.query(store.db,
        'SELECT count(*) FROM notices WHERE user_id = @u::uuid AND read_at IS NULL', {'u': userId});
    return rows.first[0] as int;
  }

  Future<void> markAllRead(String userId) async {
    await store.query(store.db,
        'UPDATE notices SET read_at = now() WHERE user_id = @u::uuid AND read_at IS NULL', {'u': userId});
  }
}
