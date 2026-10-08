import 'package:uuid/uuid.dart';

import 'models.dart';
import 'store.dart';

class _MemberRow {
  final String companyId;
  final String userId;
  Role role;
  DateTime joinedAt;
  DateTime? leftAt;

  _MemberRow(this.companyId, this.userId, this.role, this.joinedAt);
}

class AuditEntry {
  final String? companyId;
  final String actorId;
  final String action;
  final Map<String, Object?> details;

  AuditEntry(this.companyId, this.actorId, this.action, this.details);
}

/// Stockage en mémoire, pour les tests et le développement sans base.
class MemoryStore implements Store {
  final _uuid = const Uuid();
  final _users = <String, User>{};
  final _companies = <String, Company>{};
  final _members = <_MemberRow>[];
  final _transfers = <String, OwnershipTransfer>{};
  final auditLog = <AuditEntry>[];

  _MemberRow? _activeRow(String companyId, String userId) {
    for (final m in _members) {
      if (m.companyId == companyId && m.userId == userId && m.leftAt == null) return m;
    }
    return null;
  }

  @override
  Future<User> upsertGoogleUser({
    required String sub,
    required String email,
    required String name,
    String? photoUrl,
  }) async {
    final existing = _users.values.where((u) => u.googleSub == sub).firstOrNull;
    final user = User(
      id: existing?.id ?? _uuid.v4(),
      publicId: existing?.publicId ?? newPublicId(),
      googleSub: sub,
      email: email,
      name: name,
      photoUrl: photoUrl,
      createdAt: existing?.createdAt ?? DateTime.now().toUtc(),
    );
    _users[user.id] = user;
    return user;
  }

  @override
  Future<User?> findUser(String id) async => _users[id];

  @override
  Future<Company> createCompany({
    required String ownerId,
    required String name,
    required String timezone,
  }) async {
    final company = Company(
      id: _uuid.v4(),
      name: name,
      timezone: timezone,
      status: CompanyStatus.active,
      createdAt: DateTime.now().toUtc(),
    );
    _companies[company.id] = company;
    _members.add(_MemberRow(company.id, ownerId, Role.owner, company.createdAt));
    return company;
  }

  @override
  Future<Company?> findCompany(String id) async => _companies[id];

  @override
  Future<Company> updateCompany(Company company) async => _companies[company.id] = company;

  @override
  Future<List<Membership>> membershipsOf(String userId) async => [
        for (final m in _members)
          if (m.userId == userId && m.leftAt == null) Membership(_companies[m.companyId]!, m.role),
      ]..sort((a, b) => a.company.createdAt.compareTo(b.company.createdAt));

  @override
  Future<Role?> roleOf(String companyId, String userId) async =>
      _activeRow(companyId, userId)?.role;

  @override
  Future<List<Member>> members(String companyId) async => [
        for (final m in _members)
          if (m.companyId == companyId && m.leftAt == null)
            Member(_users[m.userId]!, m.role, m.joinedAt),
      ];

  @override
  Future<void> addMember(String companyId, String userId, Role role) async {
    if (_activeRow(companyId, userId) != null) return;
    _members.add(_MemberRow(companyId, userId, role, DateTime.now().toUtc()));
  }

  @override
  Future<void> setRole(String companyId, String userId, Role role) async {
    _activeRow(companyId, userId)?.role = role;
  }

  @override
  Future<void> removeMember(String companyId, String userId) async {
    _activeRow(companyId, userId)?.leftAt = DateTime.now().toUtc();
  }

  @override
  Future<OwnershipTransfer> createTransfer({
    required String companyId,
    required String fromUserId,
    required String toUserId,
  }) async {
    final t = OwnershipTransfer(
      id: _uuid.v4(),
      companyId: companyId,
      fromUserId: fromUserId,
      toUserId: toUserId,
      status: TransferStatus.pending,
      createdAt: DateTime.now().toUtc(),
    );
    return _transfers[t.id] = t;
  }

  @override
  Future<OwnershipTransfer?> findTransfer(String id) async => _transfers[id];

  @override
  Future<OwnershipTransfer?> pendingTransfer(String companyId) async => _transfers.values
      .where((t) => t.companyId == companyId && t.status == TransferStatus.pending)
      .firstOrNull;

  @override
  Future<List<OwnershipTransfer>> pendingTransfersFor(String userId) async => _transfers.values
      .where((t) => t.toUserId == userId && t.status == TransferStatus.pending)
      .toList();

  @override
  Future<void> completeTransfer(OwnershipTransfer transfer) async {
    await setRole(transfer.companyId, transfer.fromUserId, Role.manager);
    await setRole(transfer.companyId, transfer.toUserId, Role.owner);
    await closeTransfer(transfer.id, TransferStatus.accepted);
  }

  @override
  Future<void> closeTransfer(String id, TransferStatus status) async {
    final t = _transfers[id]!;
    _transfers[id] = OwnershipTransfer(
      id: t.id,
      companyId: t.companyId,
      fromUserId: t.fromUserId,
      toUserId: t.toUserId,
      status: status,
      createdAt: t.createdAt,
    );
  }

  @override
  Future<void> audit({
    String? companyId,
    required String actorId,
    required String action,
    Map<String, Object?> details = const {},
  }) async {
    auditLog.add(AuditEntry(companyId, actorId, action, details));
  }
}
