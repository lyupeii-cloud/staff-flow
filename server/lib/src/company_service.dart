import 'errors.dart';
import 'models.dart';
import 'store.dart';

/// Règles des sections 2 et 3 du cahier des charges : rôles par entreprise,
/// gestion des membres et transfert de propriété.
class CompanyService {
  final Store store;

  CompanyService(this.store);

  Future<Company> create(User actor, {required String name, required String timezone}) async {
    final company = await store.createCompany(
      ownerId: actor.id,
      name: _validName(name),
      timezone: validTimezone(timezone),
    );
    await store.audit(companyId: company.id, actorId: actor.id, action: 'company.create');
    return company;
  }

  /// Entreprise vue par un membre actif ; 404 pour les autres, pour ne pas
  /// révéler qu'elle existe.
  Future<(Company, Role)> open(User actor, String companyId) async {
    final role = await store.roleOf(companyId, actor.id);
    final company = role == null ? null : await store.findCompany(companyId);
    if (role == null || company == null) throw const ApiError.notFound('Entreprise introuvable.');
    return (company, role);
  }

  /// Sites gérés par [actor] : `null` pour le propriétaire et un responsable
  /// de toute l'entreprise ; sinon ceux d'un responsable de site.
  Future<Set<String>?> managedSites(String companyId, User actor, Role role) async {
    if (role != Role.manager) return null;
    return (await store.sitesOf(companyId, actor.id))?.toSet();
  }

  /// Un responsable de site gère les salariés et extras rattachés à au
  /// moins un de ses sites.
  Future<bool> inSites(String companyId, String userId, Set<String>? mine) async {
    if (mine == null) return true;
    return (await store.sitesOf(companyId, userId) ?? const []).any(mine.contains);
  }

  /// Sites existants et non archivés de l'entreprise (sans doublon).
  Future<List<String>> validSites(String companyId, Iterable<String> sites) async {
    final wanted = sites.toSet().toList();
    if (wanted.isEmpty) return wanted;
    final rows = await store.query(store.db, '''
      SELECT count(*) FROM sites
      WHERE company_id = @c::uuid AND archived_at IS NULL AND id::text = ANY(@s)''',
        {'c': companyId, 's': wanted});
    if (rows.first[0] != wanted.length) throw const ApiError.badRequest('Site inconnu ou archivé.');
    return wanted;
  }

  /// Sites d'une personne. Le propriétaire choisit ceux d'un responsable
  /// (`null` : toute l'entreprise). Pour un salarié ou un extra : un
  /// responsable de toute l'entreprise choisit librement ; un responsable de
  /// site n'ajoute ou ne retire que ses propres sites.
  Future<void> setSites(User actor, String companyId, String userId, List<String>? sites) async {
    final (company, actorRole) = await open(actor, companyId);
    _requireWritable(company);
    final target = await store.roleOf(companyId, userId);
    if (target == null) throw const ApiError.notFound('Membre introuvable.');
    final requested = sites == null ? null : await validSites(companyId, sites);
    List<String>? result;
    switch (target) {
      case Role.owner:
        throw const ApiError.forbidden();
      case Role.manager:
        if (actorRole != Role.owner) throw const ApiError.forbidden();
        result = requested == null || requested.isEmpty ? null : requested;
      case Role.employee || Role.extra:
        if (!actorRole.canManage) throw const ApiError.forbidden();
        final mine = await managedSites(companyId, actor, actorRole);
        if (mine == null) {
          result = requested == null || requested.isEmpty ? null : requested;
        } else {
          if (!(requested ?? const []).every(mine.contains)) throw const ApiError.forbidden();
          final current = await store.sitesOf(companyId, userId) ?? const [];
          final merged = {...current.where((s) => !mine.contains(s)), ...?requested}.toList();
          result = merged.isEmpty ? null : merged;
        }
    }
    await store.setSites(companyId, userId, result);
    await store.audit(
        companyId: companyId, actorId: actor.id, action: 'member.sites', details: {'userId': userId, 'sites': result});
  }

  Future<Company> update(User actor, String companyId, {String? name, String? timezone}) async {
    final (company, role) = await open(actor, companyId);
    _requireWritable(company);
    if (!role.canManage) throw const ApiError.forbidden();
    // Nom et fuseau de l'entreprise : pas pour un responsable de site.
    if (await managedSites(companyId, actor, role) != null) throw const ApiError.forbidden();
    final updated = await store.updateCompany(company.copyWith(
      name: name == null ? null : _validName(name),
      timezone: timezone == null ? null : validTimezone(timezone),
    ));
    await store.audit(
      companyId: companyId,
      actorId: actor.id,
      action: 'company.update',
      details: {'name': name, 'timezone': timezone}..removeWhere((_, v) => v == null),
    );
    return updated;
  }

  Future<List<Member>> members(User actor, String companyId) async {
    await open(actor, companyId);
    return store.members(companyId);
  }

  /// Le propriétaire nomme ou retire les responsables ; un responsable peut
  /// seulement faire passer quelqu'un de salarié à extra et inversement.
  /// Le rôle de propriétaire ne change que par transfert.
  /// [sites] : pour un nouveau responsable, ses sites (`null` : toute l'entreprise).
  Future<void> setRole(User actor, String companyId, String userId, Role newRole, {List<String>? sites}) async {
    final (company, actorRole) = await open(actor, companyId);
    _requireWritable(company);
    final current = await store.roleOf(companyId, userId);
    if (current == null) throw const ApiError.notFound('Membre introuvable.');
    if (current == newRole) return;
    if (current == Role.owner || newRole == Role.owner) {
      throw const ApiError.conflict('La propriété se change par un transfert.');
    }
    final touchesManager = current == Role.manager || newRole == Role.manager;
    final allowed = actorRole == Role.owner ||
        (actorRole == Role.manager &&
            !touchesManager &&
            await inSites(companyId, userId, await managedSites(companyId, actor, actorRole)));
    if (!allowed) throw const ApiError.forbidden();
    await store.setRole(companyId, userId, newRole);
    if (newRole == Role.manager) {
      final chosen = sites == null ? null : await validSites(companyId, sites);
      await store.setSites(companyId, userId, chosen == null || chosen.isEmpty ? null : chosen);
    }
    await store.audit(
      companyId: companyId,
      actorId: actor.id,
      action: 'member.role',
      details: {'userId': userId, 'from': current.name, 'to': newRole.name},
    );
  }

  /// Retire un membre, ou permet à un membre de quitter l'entreprise.
  /// Le propriétaire ne peut pas partir sans avoir transféré la propriété.
  Future<void> removeMember(User actor, String companyId, String userId) async {
    final (company, actorRole) = await open(actor, companyId);
    final target = await store.roleOf(companyId, userId);
    if (target == null) throw const ApiError.notFound('Membre introuvable.');
    if (target == Role.owner) {
      throw const ApiError.conflict(
          'Le propriétaire doit transférer l\'entreprise avant de la quitter.');
    }
    final leaving = userId == actor.id;
    if (!leaving) {
      _requireWritable(company);
      final allowed = actorRole == Role.owner ||
          (actorRole == Role.manager &&
              (target == Role.employee || target == Role.extra) &&
              await inSites(companyId, userId, await managedSites(companyId, actor, actorRole)));
      if (!allowed) throw const ApiError.forbidden();
    }
    await store.removeMember(companyId, userId);
    await store.audit(
      companyId: companyId,
      actorId: actor.id,
      action: leaving ? 'member.leave' : 'member.remove',
      details: {'userId': userId},
    );
  }

  Future<OwnershipTransfer> proposeTransfer(User actor, String companyId, String toUserId) async {
    final (company, role) = await open(actor, companyId);
    _requireWritable(company);
    if (role != Role.owner) throw const ApiError.forbidden('Seul le propriétaire peut transférer.');
    if (await store.roleOf(companyId, toUserId) != Role.manager) {
      throw const ApiError.badRequest('Le nouveau propriétaire doit être responsable de l\'entreprise.');
    }
    if (await store.pendingTransfer(companyId) != null) {
      throw const ApiError.conflict('Un transfert est déjà en attente.');
    }
    final transfer = await store.createTransfer(
        companyId: companyId, fromUserId: actor.id, toUserId: toUserId);
    await store.audit(
      companyId: companyId,
      actorId: actor.id,
      action: 'transfer.propose',
      details: {'transferId': transfer.id, 'toUserId': toUserId},
    );
    return transfer;
  }

  Future<void> cancelTransfer(User actor, String companyId) async {
    final (_, role) = await open(actor, companyId);
    if (role != Role.owner) throw const ApiError.forbidden();
    final pending = await store.pendingTransfer(companyId);
    if (pending == null) throw const ApiError.notFound('Aucun transfert en attente.');
    await store.closeTransfer(pending.id, TransferStatus.cancelled);
    await store.audit(
        companyId: companyId,
        actorId: actor.id,
        action: 'transfer.cancel',
        details: {'transferId': pending.id});
  }

  /// Le destinataire accepte ou refuse. Si l'un des deux a quitté
  /// l'entreprise ou changé de rôle entre-temps, le transfert est annulé.
  Future<void> answerTransfer(User actor, String transferId, {required bool accept}) async {
    final t = await store.findTransfer(transferId);
    if (t == null || t.toUserId != actor.id || t.status != TransferStatus.pending) {
      throw const ApiError.notFound('Transfert introuvable.');
    }
    final stillValid = await store.roleOf(t.companyId, t.fromUserId) == Role.owner &&
        await store.roleOf(t.companyId, t.toUserId) == Role.manager;
    if (!stillValid) {
      await store.closeTransfer(t.id, TransferStatus.cancelled);
      throw const ApiError.conflict('Ce transfert n\'est plus valable.');
    }
    if (accept) {
      await store.completeTransfer(t);
      // Le nouveau propriétaire couvre toute l'entreprise.
      await store.setSites(t.companyId, t.toUserId, null);
    } else {
      await store.closeTransfer(t.id, TransferStatus.declined);
    }
    await store.audit(
      companyId: t.companyId,
      actorId: actor.id,
      action: accept ? 'transfer.accept' : 'transfer.decline',
      details: {'transferId': t.id},
    );
  }

  void _requireWritable(Company company) {
    if (company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
  }

  /// Nom d'une personne dans l'entreprise, donné par un responsable : le
  /// propriétaire renomme tout le monde, un responsable les salariés, les
  /// extras et lui-même. Vide : on revient au nom choisi par la personne.
  Future<void> renameMember(User actor, String companyId, String userId, String? name) async {
    final (company, actorRole) = await open(actor, companyId);
    _requireWritable(company);
    final target = await store.roleOf(companyId, userId);
    if (target == null) throw const ApiError.notFound('Membre introuvable.');
    final allowed = actorRole == Role.owner ||
        (actorRole == Role.manager &&
            (userId == actor.id ||
                ((target == Role.employee || target == Role.extra) &&
                    await inSites(companyId, userId, await managedSites(companyId, actor, actorRole)))));
    if (!allowed) throw const ApiError.forbidden();
    final clean = personName(name);
    await store.setMemberName(companyId, userId, clean);
    await store.audit(
      companyId: companyId,
      actorId: actor.id,
      action: 'member.name',
      details: {'userId': userId, 'name': clean},
    );
  }

  /// `null` ou vide : pas de nom personnalisé.
  static String? personName(String? name) =>
      name == null || name.trim().isEmpty ? null : _validName(name);

  static String _validName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed.length > 120) {
      throw const ApiError.badRequest('Le nom doit faire entre 1 et 120 caractères.');
    }
    return trimmed;
  }
}

final _ianaZone = RegExp(r'^(UTC|[A-Z][A-Za-z_]+(/[A-Za-z0-9_+\-]+){1,2})$');

/// Vérifie la forme d'un fuseau IANA (`Europe/Paris`, `America/Argentina/Buenos_Aires`).
String validTimezone(String value) {
  if (!_ianaZone.hasMatch(value)) {
    throw ApiError.badRequest('Fuseau horaire invalide : {value}', {'value': value});
  }
  return value;
}
