import 'errors.dart';
import 'store.dart';

/// Avis destinés à un utilisateur (par exemple : « un autre responsable a
/// remplacé votre modification »). Le texte est composé par l'application,
/// dans sa langue, à partir de [Notice.kind] et [Notice.data].
class Notice {
  final String id;
  final String? companyId;

  /// Nom de l'entreprise (utile avant d'en être membre, pour une invitation).
  final String? companyName;
  final String kind;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final bool read;

  const Notice(this.id, this.companyId, this.companyName, this.kind, this.data, this.createdAt, this.read);

  Map<String, Object?> toJson() => {
        'id': id,
        'companyId': companyId,
        'companyName': companyName,
        'kind': kind,
        'data': data,
        'createdAt': createdAt.toUtc().toIso8601String(),
        'read': read,
      };
}

class NoticeService {
  final Store store;

  /// Horloge (UTC), remplaçable dans les tests.
  final DateTime Function() now;

  NoticeService(this.store, {DateTime Function()? now}) : now = now ?? (() => DateTime.now().toUtc());

  /// Durée de conservation d'un avis une fois lu, au choix de chacun.
  static const retentions = {'day': Duration(days: 1), 'week': Duration(days: 7), 'month': Duration(days: 30)};

  /// Avis non lus, puis les plus récents déjà lus (50 au plus). Les avis lus
  /// depuis plus longtemps que la durée choisie sont d'abord supprimés.
  Future<List<Notice>> list(String userId) async {
    await purge(userId);
    final rows = await store.query(store.db, '''
      SELECT n.id::text, n.company_id::text, c.name, n.kind, n.data, n.created_at, n.read_at IS NOT NULL
      FROM notices n LEFT JOIN companies c ON c.id = n.company_id
      WHERE n.user_id = @u::uuid
      ORDER BY n.read_at IS NOT NULL, n.created_at DESC LIMIT 50''', {'u': userId});
    return [
      for (final r in rows)
        Notice(r[0] as String, r[1] as String?, r[2] as String?, r[3] as String,
            r[4] as Map<String, dynamic>, r[5] as DateTime, r[6] as bool),
    ];
  }

  Future<void> purge(String userId) async {
    final rows = await store.query(
        store.db, 'SELECT notice_retention FROM users WHERE id = @u::uuid', {'u': userId});
    final keep = retentions[rows.first[0]] ?? retentions['week']!;
    await store.query(store.db, '''
      DELETE FROM notices WHERE user_id = @u::uuid AND read_at IS NOT NULL AND read_at < @limit''',
        {'u': userId, 'limit': now().subtract(keep)});
  }

  Future<int> unreadCount(String userId) async {
    final rows = await store.query(store.db,
        'SELECT count(*) FROM notices WHERE user_id = @u::uuid AND read_at IS NULL', {'u': userId});
    return rows.first[0] as int;
  }

  Future<void> markAllRead(String userId) async {
    await store.query(store.db,
        'UPDATE notices SET read_at = @now WHERE user_id = @u::uuid AND read_at IS NULL', {'u': userId, 'now': now()});
  }

  /// Bouton « Tout supprimer » de la cloche.
  Future<void> deleteAll(String userId) async {
    await store.query(store.db, 'DELETE FROM notices WHERE user_id = @u::uuid', {'u': userId});
  }

  Future<String> retention(String userId) async {
    final rows = await store.query(
        store.db, 'SELECT notice_retention FROM users WHERE id = @u::uuid', {'u': userId});
    return rows.first[0] as String;
  }

  Future<void> setRetention(String userId, String value) async {
    if (!retentions.containsKey(value)) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    await store.query(store.db, 'UPDATE users SET notice_retention = @v WHERE id = @u::uuid', {'u': userId, 'v': value});
  }
}
