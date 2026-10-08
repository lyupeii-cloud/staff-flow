import 'dart:math';

import 'models.dart';

/// Accès aux données. Les règles métier vivent dans `CompanyService` :
/// une implémentation de [Store] ne fait que lire et écrire.
abstract class Store {
  Future<User> upsertGoogleUser({
    required String sub,
    required String email,
    required String name,
    String? photoUrl,
  });

  Future<User?> findUser(String id);

  /// Crée l'entreprise et y inscrit [ownerId] comme propriétaire.
  Future<Company> createCompany({
    required String ownerId,
    required String name,
    required String timezone,
  });

  Future<Company?> findCompany(String id);

  Future<Company> updateCompany(Company company);

  /// Entreprises dont l'utilisateur est membre actif, avec son rôle.
  Future<List<Membership>> membershipsOf(String userId);

  /// Rôle actif de l'utilisateur dans l'entreprise, ou `null`.
  Future<Role?> roleOf(String companyId, String userId);

  Future<List<Member>> members(String companyId);

  /// Ajoute un membre, ou réactive celui qui était parti.
  Future<void> addMember(String companyId, String userId, Role role);

  Future<void> setRole(String companyId, String userId, Role role);

  /// Retire le membre sans effacer son historique (départ daté).
  Future<void> removeMember(String companyId, String userId);

  Future<OwnershipTransfer> createTransfer({
    required String companyId,
    required String fromUserId,
    required String toUserId,
  });

  Future<OwnershipTransfer?> findTransfer(String id);

  Future<OwnershipTransfer?> pendingTransfer(String companyId);

  Future<List<OwnershipTransfer>> pendingTransfersFor(String userId);

  /// D'un seul bloc : l'ancien propriétaire devient responsable,
  /// le nouveau devient propriétaire, le transfert est accepté.
  Future<void> completeTransfer(OwnershipTransfer transfer);

  Future<void> closeTransfer(String id, TransferStatus status);

  Future<void> audit({
    String? companyId,
    required String actorId,
    required String action,
    Map<String, Object?> details = const {},
  });
}

const _publicIdAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
final _random = Random.secure();

/// Identifiant lisible, sans caractères ambigus (0/O, 1/I) : `SF-7KQ2M9XA`.
String newPublicId() =>
    'SF-${List.generate(8, (_) => _publicIdAlphabet[_random.nextInt(_publicIdAlphabet.length)]).join()}';
