import 'dart:convert';
import 'dart:math';

import 'package:postgres/postgres.dart';

import 'migrations.dart';
import 'models.dart';

/// Accès aux données (PostgreSQL). Les règles métier vivent dans les services.
class Store {
  final Pool _db;

  Store(this._db);

  /// Ouvre un pool depuis une URL `postgresql://user:pass@host:5432/base`,
  /// avec 10 connexions par défaut (le paquet n'en ouvre qu'une sinon).
  factory Store.connect(String url) {
    final uri = Uri.parse(url);
    if (uri.queryParameters.containsKey('max_connection_count')) return Store(Pool.withUrl(url));
    final query = {...uri.queryParameters, 'max_connection_count': '10'};
    return Store(Pool.withUrl(uri.replace(queryParameters: query).toString()));
  }

  /// Connexions, pour les services qui écrivent leurs propres requêtes.
  Pool get db => _db;

  Future<void> close() => _db.close();

  /// Applique les migrations manquantes, sous verrou pour qu'un seul
  /// serveur à la fois le fasse.
  Future<void> migrate() => _db.runTx((tx) async {
        await tx.execute('SELECT pg_advisory_xact_lock(4242)');
        await tx.execute(
            'CREATE TABLE IF NOT EXISTS schema_migrations (version int PRIMARY KEY, applied_at timestamptz NOT NULL DEFAULT now())');
        final done = (await tx.execute('SELECT version FROM schema_migrations'))
            .map((r) => r[0] as int)
            .toSet();
        for (var i = 0; i < migrations.length; i++) {
          final version = i + 1;
          if (done.contains(version)) continue;
          await tx.execute(migrations[i], queryMode: QueryMode.simple);
          await tx.execute(Sql.named('INSERT INTO schema_migrations (version) VALUES (@v)'),
              parameters: {'v': version});
        }
      });

  /// Requête SQL à paramètres nommés (`@nom`) sur une session ou une transaction.
  /// Seuls les paramètres cités dans la requête sont transmis : le pilote
  /// refuse les autres, ce qui permet de partager une table de paramètres
  /// entre plusieurs variantes d'une requête.
  Future<Result> query(Session s, String sql, [Map<String, Object?> params = const {}]) {
    final used = {for (final m in _paramName.allMatches(sql)) m[1]!};
    return s.execute(Sql.named(sql),
        parameters: {for (final e in params.entries) if (used.contains(e.key)) e.key: e.value});
  }

  static final _paramName = RegExp(r'@(\w+)');

  static User _user(Map<String, dynamic> r) => User(
        id: r['id'] as String,
        publicId: r['public_id'] as String,
        googleSub: r['google_sub'] as String,
        email: r['email'] as String,
        name: (r['custom_name'] as String?) ?? r['name'] as String,
        googleName: r['name'] as String,
        photoUrl: r['photo_url'] as String?,
        locale: r['locale'] as String?,
        createdAt: r['created_at'] as DateTime,
      );

  static Company companyFromRow(Map<String, dynamic> r) => Company(
        id: r['id'] as String,
        name: r['name'] as String,
        timezone: r['timezone'] as String,
        status: CompanyStatus.values.byName(r['status'] as String),
        createdAt: r['created_at'] as DateTime,
      );

  static OwnershipTransfer _transfer(Map<String, dynamic> r) => OwnershipTransfer(
        id: r['id'] as String,
        companyId: r['company_id'] as String,
        fromUserId: r['from_user_id'] as String,
        toUserId: r['to_user_id'] as String,
        status: TransferStatus.values.byName(r['status'] as String),
        createdAt: r['created_at'] as DateTime,
      );

  Future<User> upsertGoogleUser({
    required String sub,
    required String email,
    required String name,
    String? photoUrl,
    String? locale,
  }) async {
    final rows = await query(_db, '''
      INSERT INTO users (public_id, google_sub, email, name, photo_url, locale)
      VALUES (@publicId, @sub, @email, @name, @photo, @locale)
      ON CONFLICT (google_sub) DO UPDATE
        SET email = EXCLUDED.email, name = EXCLUDED.name, photo_url = EXCLUDED.photo_url,
            locale = coalesce(EXCLUDED.locale, users.locale)
      RETURNING *''', {
      'publicId': newPublicId(),
      'sub': sub,
      'email': email,
      'name': name,
      'photo': photoUrl,
      'locale': locale,
    });
    return _user(rows.first.toColumnMap());
  }

  Future<User?> findUser(String id) async {
    final rows = await query(_db, 'SELECT * FROM users WHERE id = @id::uuid', {'id': id});
    return rows.isEmpty ? null : _user(rows.first.toColumnMap());
  }

  Future<Company> createCompany({
    required String ownerId,
    required String name,
    required String timezone,
  }) =>
      _db.runTx((tx) async {
        final rows = await query(tx,
            'INSERT INTO companies (name, timezone) VALUES (@name, @tz) RETURNING *',
            {'name': name, 'tz': timezone});
        final company = companyFromRow(rows.first.toColumnMap());
        await query(tx,
            "INSERT INTO memberships (company_id, user_id, role) VALUES (@c::uuid, @u::uuid, 'owner')",
            {'c': company.id, 'u': ownerId});
        return company;
      });

  Future<Company?> findCompany(String id) async {
    final rows = await query(_db, 'SELECT * FROM companies WHERE id = @id::uuid', {'id': id});
    return rows.isEmpty ? null : companyFromRow(rows.first.toColumnMap());
  }

  Future<Company> updateCompany(Company company) async {
    final rows = await query(_db,
        'UPDATE companies SET name = @name, timezone = @tz WHERE id = @id::uuid RETURNING *',
        {'id': company.id, 'name': company.name, 'tz': company.timezone});
    return companyFromRow(rows.first.toColumnMap());
  }

  Future<List<Membership>> membershipsOf(String userId) async {
    final rows = await query(_db, '''
      SELECT c.*, m.role, m.sites::text[] AS member_sites, m.notify_sites::text[] AS notify_sites FROM memberships m JOIN companies c ON c.id = m.company_id
      WHERE m.user_id = @u::uuid AND m.left_at IS NULL
      ORDER BY c.created_at''', {'u': userId});
    return [
      for (final r in rows)
        Membership(companyFromRow(r.toColumnMap()), Role.parse(r.toColumnMap()['role'] as String),
            _sites(r.toColumnMap()['member_sites']), _sites(r.toColumnMap()['notify_sites'])),
    ];
  }

  Future<Role?> roleOf(String companyId, String userId) async {
    final rows = await query(_db, '''
      SELECT role FROM memberships
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
        {'c': companyId, 'u': userId});
    return rows.isEmpty ? null : Role.parse(rows.first[0] as String);
  }

  Future<List<Member>> members(String companyId) async {
    final rows = await query(_db, '''
      SELECT u.*, m.role, m.joined_at, m.display_name, m.sites::text[] AS member_sites
      FROM memberships m JOIN users u ON u.id = m.user_id
      WHERE m.company_id = @c::uuid AND m.left_at IS NULL
      ORDER BY m.joined_at''', {'c': companyId});
    return [
      for (final r in rows.map((r) => r.toColumnMap()))
        if (_user(r) case final u)
          Member(
            r['display_name'] == null ? u : u.withName(r['display_name'] as String),
            Role.parse(r['role'] as String),
            r['joined_at'] as DateTime,
            nameInCompany: r['display_name'] as String?,
            sites: _sites(r['member_sites']),
          ),
    ];
  }

  Future<User?> findUserByPublicId(String publicId) async {
    final rows = await query(_db, 'SELECT * FROM users WHERE public_id = @p', {'p': publicId});
    return rows.isEmpty ? null : _user(rows.first.toColumnMap());
  }

  /// Nom choisi par la personne (`null` : reprendre celui de Google).
  Future<User> setCustomName(String userId, String? name) async {
    final rows = await query(_db, 'UPDATE users SET custom_name = @n WHERE id = @id::uuid RETURNING *',
        {'id': userId, 'n': name});
    return _user(rows.first.toColumnMap());
  }

  /// Nom donné par un responsable dans une entreprise (`null` : nom de la personne).
  Future<void> setMemberName(String companyId, String userId, String? name) async {
    await query(_db, '''
      UPDATE memberships SET display_name = @n
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
        {'c': companyId, 'u': userId, 'n': name});
  }

  Future<void> addMember(String companyId, String userId, Role role, {List<String>? sites}) async {
    await query(_db, '''
      INSERT INTO memberships (company_id, user_id, role, sites) VALUES (@c::uuid, @u::uuid, @r, @s::uuid[])
      ON CONFLICT (company_id, user_id) WHERE left_at IS NULL DO NOTHING''',
        {'c': companyId, 'u': userId, 'r': role.name, 's': sites});
  }

  /// Voir [Membership.sites].
  Future<List<String>?> sitesOf(String companyId, String userId) async {
    final rows = await query(_db, '''
      SELECT sites::text[] FROM memberships
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''', {'c': companyId, 'u': userId});
    return rows.isEmpty ? null : _sites(rows.first[0]);
  }

  Future<void> setSites(String companyId, String userId, List<String>? sites) async {
    await query(_db, '''
      UPDATE memberships SET sites = @s::uuid[]
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
        {'c': companyId, 'u': userId, 's': sites});
  }

  /// Sites dont un responsable reçoit les notifications (`null` : tous).
  Future<List<String>?> notifySitesOf(String companyId, String userId) async {
    final rows = await query(_db, '''
      SELECT notify_sites::text[] FROM memberships
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''', {'c': companyId, 'u': userId});
    return rows.isEmpty ? null : _sites(rows.first[0]);
  }

  Future<void> setNotifySites(String companyId, String userId, List<String>? sites) async {
    await query(_db, '''
      UPDATE memberships SET notify_sites = @s::uuid[]
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
        {'c': companyId, 'u': userId, 's': sites});
  }

  static List<String>? _sites(Object? value) => value == null ? null : [for (final s in value as List) s as String];

  Future<void> setRole(String companyId, String userId, Role role) async {
    await query(_db, '''
      UPDATE memberships SET role = @r
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
        {'c': companyId, 'u': userId, 'r': role.name});
  }

  Future<void> removeMember(String companyId, String userId) async {
    await query(_db, '''
      UPDATE memberships SET left_at = now()
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
        {'c': companyId, 'u': userId});
  }

  Future<OwnershipTransfer> createTransfer({
    required String companyId,
    required String fromUserId,
    required String toUserId,
  }) async {
    final rows = await query(_db, '''
      INSERT INTO ownership_transfers (company_id, from_user_id, to_user_id)
      VALUES (@c::uuid, @f::uuid, @t::uuid) RETURNING *''',
        {'c': companyId, 'f': fromUserId, 't': toUserId});
    return _transfer(rows.first.toColumnMap());
  }

  Future<OwnershipTransfer?> findTransfer(String id) async {
    final rows =
        await query(_db, 'SELECT * FROM ownership_transfers WHERE id = @id::uuid', {'id': id});
    return rows.isEmpty ? null : _transfer(rows.first.toColumnMap());
  }

  Future<OwnershipTransfer?> pendingTransfer(String companyId) async {
    final rows = await query(_db,
        "SELECT * FROM ownership_transfers WHERE company_id = @c::uuid AND status = 'pending'",
        {'c': companyId});
    return rows.isEmpty ? null : _transfer(rows.first.toColumnMap());
  }

  Future<List<OwnershipTransfer>> pendingTransfersFor(String userId) async {
    final rows = await query(_db,
        "SELECT * FROM ownership_transfers WHERE to_user_id = @u::uuid AND status = 'pending'",
        {'u': userId});
    return [for (final r in rows) _transfer(r.toColumnMap())];
  }

  Future<void> completeTransfer(OwnershipTransfer t) => _db.runTx((tx) async {
        // L'ancien propriétaire d'abord, à cause de l'index « un seul propriétaire ».
        await query(tx, '''
          UPDATE memberships SET role = 'manager'
          WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
            {'c': t.companyId, 'u': t.fromUserId});
        await query(tx, '''
          UPDATE memberships SET role = 'owner'
          WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
            {'c': t.companyId, 'u': t.toUserId});
        await query(tx, '''
          UPDATE ownership_transfers SET status = 'accepted', resolved_at = now()
          WHERE id = @id::uuid''', {'id': t.id});
      });

  Future<void> closeTransfer(String id, TransferStatus status) async {
    await query(_db,
        'UPDATE ownership_transfers SET status = @s, resolved_at = now() WHERE id = @id::uuid',
        {'id': id, 's': status.name});
  }

  Future<void> audit({
    String? companyId,
    required String actorId,
    required String action,
    Map<String, Object?> details = const {},
    Session? tx,
  }) async {
    await query(tx ?? _db, '''
      INSERT INTO audit_log (company_id, actor_id, action, details)
      VALUES (@c::uuid, @a::uuid, @action, @d::jsonb)''',
        {'c': companyId, 'a': actorId, 'action': action, 'd': jsonEncode(details)});
  }
}

const _publicIdAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
final _random = Random.secure();

/// Identifiant lisible, sans caractères ambigus (0/O, 1/I) : `SF-7KQ2M9XA`.
String newPublicId() =>
    'SF-${List.generate(8, (_) => _publicIdAlphabet[_random.nextInt(_publicIdAlphabet.length)]).join()}';
