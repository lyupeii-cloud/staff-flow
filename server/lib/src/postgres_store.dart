import 'dart:convert';

import 'package:postgres/postgres.dart';

import 'migrations.dart';
import 'models.dart';
import 'store.dart';

class PostgresStore implements Store {
  final Pool _db;

  PostgresStore(this._db);

  /// Ouvre un pool depuis une URL `postgresql://user:pass@host:5432/base`.
  factory PostgresStore.connect(String url) => PostgresStore(Pool.withUrl(url));

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

  Future<Result> _q(Session s, String sql, [Map<String, Object?> params = const {}]) =>
      s.execute(Sql.named(sql), parameters: params);

  static User _user(Map<String, dynamic> r) => User(
        id: r['id'] as String,
        publicId: r['public_id'] as String,
        googleSub: r['google_sub'] as String,
        email: r['email'] as String,
        name: r['name'] as String,
        photoUrl: r['photo_url'] as String?,
        createdAt: r['created_at'] as DateTime,
      );

  static Company _company(Map<String, dynamic> r) => Company(
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

  @override
  Future<User> upsertGoogleUser({
    required String sub,
    required String email,
    required String name,
    String? photoUrl,
  }) async {
    final rows = await _q(_db, '''
      INSERT INTO users (public_id, google_sub, email, name, photo_url)
      VALUES (@publicId, @sub, @email, @name, @photo)
      ON CONFLICT (google_sub) DO UPDATE
        SET email = EXCLUDED.email, name = EXCLUDED.name, photo_url = EXCLUDED.photo_url
      RETURNING *''', {
      'publicId': newPublicId(),
      'sub': sub,
      'email': email,
      'name': name,
      'photo': photoUrl,
    });
    return _user(rows.first.toColumnMap());
  }

  @override
  Future<User?> findUser(String id) async {
    final rows = await _q(_db, 'SELECT * FROM users WHERE id = @id::uuid', {'id': id});
    return rows.isEmpty ? null : _user(rows.first.toColumnMap());
  }

  @override
  Future<Company> createCompany({
    required String ownerId,
    required String name,
    required String timezone,
  }) =>
      _db.runTx((tx) async {
        final rows = await _q(tx,
            'INSERT INTO companies (name, timezone) VALUES (@name, @tz) RETURNING *',
            {'name': name, 'tz': timezone});
        final company = _company(rows.first.toColumnMap());
        await _q(tx,
            "INSERT INTO memberships (company_id, user_id, role) VALUES (@c::uuid, @u::uuid, 'owner')",
            {'c': company.id, 'u': ownerId});
        return company;
      });

  @override
  Future<Company?> findCompany(String id) async {
    final rows = await _q(_db, 'SELECT * FROM companies WHERE id = @id::uuid', {'id': id});
    return rows.isEmpty ? null : _company(rows.first.toColumnMap());
  }

  @override
  Future<Company> updateCompany(Company company) async {
    final rows = await _q(_db,
        'UPDATE companies SET name = @name, timezone = @tz WHERE id = @id::uuid RETURNING *',
        {'id': company.id, 'name': company.name, 'tz': company.timezone});
    return _company(rows.first.toColumnMap());
  }

  @override
  Future<List<Membership>> membershipsOf(String userId) async {
    final rows = await _q(_db, '''
      SELECT c.*, m.role FROM memberships m JOIN companies c ON c.id = m.company_id
      WHERE m.user_id = @u::uuid AND m.left_at IS NULL
      ORDER BY c.created_at''', {'u': userId});
    return [
      for (final r in rows)
        Membership(_company(r.toColumnMap()), Role.parse(r.toColumnMap()['role'] as String)),
    ];
  }

  @override
  Future<Role?> roleOf(String companyId, String userId) async {
    final rows = await _q(_db, '''
      SELECT role FROM memberships
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
        {'c': companyId, 'u': userId});
    return rows.isEmpty ? null : Role.parse(rows.first[0] as String);
  }

  @override
  Future<List<Member>> members(String companyId) async {
    final rows = await _q(_db, '''
      SELECT u.*, m.role, m.joined_at FROM memberships m JOIN users u ON u.id = m.user_id
      WHERE m.company_id = @c::uuid AND m.left_at IS NULL
      ORDER BY m.joined_at''', {'c': companyId});
    return [
      for (final r in rows.map((r) => r.toColumnMap()))
        Member(_user(r), Role.parse(r['role'] as String), r['joined_at'] as DateTime),
    ];
  }

  @override
  Future<void> addMember(String companyId, String userId, Role role) async {
    await _q(_db, '''
      INSERT INTO memberships (company_id, user_id, role) VALUES (@c::uuid, @u::uuid, @r)
      ON CONFLICT (company_id, user_id) WHERE left_at IS NULL DO NOTHING''',
        {'c': companyId, 'u': userId, 'r': role.name});
  }

  @override
  Future<void> setRole(String companyId, String userId, Role role) async {
    await _q(_db, '''
      UPDATE memberships SET role = @r
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
        {'c': companyId, 'u': userId, 'r': role.name});
  }

  @override
  Future<void> removeMember(String companyId, String userId) async {
    await _q(_db, '''
      UPDATE memberships SET left_at = now()
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
        {'c': companyId, 'u': userId});
  }

  @override
  Future<OwnershipTransfer> createTransfer({
    required String companyId,
    required String fromUserId,
    required String toUserId,
  }) async {
    final rows = await _q(_db, '''
      INSERT INTO ownership_transfers (company_id, from_user_id, to_user_id)
      VALUES (@c::uuid, @f::uuid, @t::uuid) RETURNING *''',
        {'c': companyId, 'f': fromUserId, 't': toUserId});
    return _transfer(rows.first.toColumnMap());
  }

  @override
  Future<OwnershipTransfer?> findTransfer(String id) async {
    final rows =
        await _q(_db, 'SELECT * FROM ownership_transfers WHERE id = @id::uuid', {'id': id});
    return rows.isEmpty ? null : _transfer(rows.first.toColumnMap());
  }

  @override
  Future<OwnershipTransfer?> pendingTransfer(String companyId) async {
    final rows = await _q(_db,
        "SELECT * FROM ownership_transfers WHERE company_id = @c::uuid AND status = 'pending'",
        {'c': companyId});
    return rows.isEmpty ? null : _transfer(rows.first.toColumnMap());
  }

  @override
  Future<List<OwnershipTransfer>> pendingTransfersFor(String userId) async {
    final rows = await _q(_db,
        "SELECT * FROM ownership_transfers WHERE to_user_id = @u::uuid AND status = 'pending'",
        {'u': userId});
    return [for (final r in rows) _transfer(r.toColumnMap())];
  }

  @override
  Future<void> completeTransfer(OwnershipTransfer t) => _db.runTx((tx) async {
        final p = {'c': t.companyId, 'f': t.fromUserId, 't': t.toUserId, 'id': t.id};
        // L'ancien propriétaire d'abord, à cause de l'index « un seul propriétaire ».
        await _q(tx, '''
          UPDATE memberships SET role = 'manager'
          WHERE company_id = @c::uuid AND user_id = @f::uuid AND left_at IS NULL''', p);
        await _q(tx, '''
          UPDATE memberships SET role = 'owner'
          WHERE company_id = @c::uuid AND user_id = @t::uuid AND left_at IS NULL''', p);
        await _q(tx, '''
          UPDATE ownership_transfers SET status = 'accepted', resolved_at = now()
          WHERE id = @id::uuid''', p);
      });

  @override
  Future<void> closeTransfer(String id, TransferStatus status) async {
    await _q(_db,
        'UPDATE ownership_transfers SET status = @s, resolved_at = now() WHERE id = @id::uuid',
        {'id': id, 's': status.name});
  }

  @override
  Future<void> audit({
    String? companyId,
    required String actorId,
    required String action,
    Map<String, Object?> details = const {},
  }) async {
    await _q(_db, '''
      INSERT INTO audit_log (company_id, actor_id, action, details)
      VALUES (@c::uuid, @a::uuid, @action, @d::jsonb)''',
        {'c': companyId, 'a': actorId, 'action': action, 'd': jsonEncode(details)});
  }
}
