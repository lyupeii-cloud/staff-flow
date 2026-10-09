import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'notifications.dart';
import 'overlap_service.dart';
import 'planning_service.dart';
import 'store.dart';

/// Demandes des salariés (sections 5 et 7) :
/// - échange de service en 3 étapes : A propose un de ses services publiés
///   à un collègue B (ou à tous les collègues de l'équipe du site), B accepte,
///   un responsable valide ; le planning publié change et chacun est prévenu ;
/// - congé et indisponibilité : validés ou refusés par un responsable.
/// Rien n'est bloquant : une absence validée est signalée au planning.
class RequestService {
  final Store store;
  final CompanyService companies;
  final PlanningService planning;
  final NotificationService notifications;

  /// Prévenue après un échange validé (chevauchement avec une autre entreprise).
  final OverlapService? overlaps;

  RequestService(this.store, this.companies, this.planning, this.notifications, {this.overlaps});

  static const kinds = {'swap', 'leave', 'unavailability'};

  // --- Création ---------------------------------------------------------------

  Future<Map<String, Object?>> create(User actor, String companyId, Map<String, dynamic> body) async {
    final (company, _) = await companies.open(actor, companyId);
    if (company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
    final kind = body['kind'];
    final note = _note(body['note']);
    final String id;
    switch (kind) {
      case 'swap':
        id = await _createSwap(actor, companyId, body, note);
      case 'leave':
        final start = _day(body['startDay']), end = _day(body['endDay']);
        if (start == null || end == null || end.isBefore(start) || end.difference(start).inDays > 366) {
          throw const ApiError.badRequest('Dates invalides.');
        }
        id = await _insert(companyId, actor, 'leave', 'pending_manager', startDay: start, endDay: end, note: note);
      case 'unavailability':
        final weekdays = body['weekdays'];
        final days = weekdays is List ? [for (final d in weekdays) if (d is int && d >= 1 && d <= 7) d] : <int>[];
        final start = _day(body['startDay']), end = _day(body['endDay']);
        if (days.isEmpty && (start == null || end == null)) {
          throw const ApiError.badRequest('Choisissez des jours ou une période.');
        }
        if (start != null && end != null && end.isBefore(start)) throw const ApiError.badRequest('Dates invalides.');
        id = await _insert(companyId, actor, 'unavailability', 'pending_manager',
            startDay: start, endDay: end, weekdays: days.isEmpty ? null : (days.toSet().toList()..sort()), note: note);
      default:
        throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    final request = await _load(id);
    if (request.status == 'pending_manager') {
      await _notifyDeciders(request, actor);
    } else {
      await notifications.notify(await _candidates(request),
          companyId: companyId, kind: 'swap_offer', data: _noticeData(request, actor.name));
    }
    return _json(request, actor, await _viewer(actor, companyId));
  }

  Future<String> _createSwap(User actor, String companyId, Map<String, dynamic> body, String? note) async {
    final shiftId = body['shiftId'];
    if (shiftId is! String) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final rows = await store.query(store.db, '''
      SELECT version, day, published->>'userId' FROM shifts
      WHERE id = @id::uuid AND company_id = @c::uuid AND NOT deleted AND published IS NOT NULL''',
        {'id': shiftId, 'c': companyId});
    if (rows.isEmpty || rows.first[2] != actor.id) {
      throw const ApiError.badRequest('Seul votre propre service publié peut être proposé.');
    }
    final day = rows.first[1] as DateTime;
    if (day.isBefore(_today())) throw const ApiError.badRequest('Seul votre propre service publié peut être proposé.');
    final busy = await store.query(store.db, '''
      SELECT 1 FROM requests WHERE shift_id = @s::uuid AND status IN ('pending_peer', 'pending_manager')''',
        {'s': shiftId});
    if (busy.isNotEmpty) throw const ApiError.conflict('Une demande est déjà en cours pour ce service.');
    final peer = body['peerId'];
    if (peer != null) {
      final role = peer is String ? await store.roleOf(companyId, peer) : null;
      if (role == null || peer == actor.id) {
        throw const ApiError.notFound('Membre introuvable.');
      }
    }
    return _insert(companyId, actor, 'swap', 'pending_peer',
        peerId: peer as String?, openOffer: peer == null, shiftId: shiftId, shiftVersion: rows.first[0] as int, note: note);
  }

  Future<String> _insert(String companyId, User actor, String kind, String status,
      {String? peerId,
      bool openOffer = false,
      String? shiftId,
      int? shiftVersion,
      DateTime? startDay,
      DateTime? endDay,
      List<int>? weekdays,
      String? note}) async {
    final rows = await store.query(store.db, '''
      INSERT INTO requests (company_id, kind, status, requester_id, peer_id, open_offer, shift_id, shift_version,
        start_day, end_day, weekdays, note)
      VALUES (@c::uuid, @k, @st, @r::uuid, @p::uuid, @o, @s::uuid, @v, @sd::date, @ed::date, @w::int[], @n)
      RETURNING id::text''', {
      'c': companyId,
      'k': kind,
      'st': status,
      'r': actor.id,
      'p': peerId,
      'o': openOffer,
      's': shiftId,
      'v': shiftVersion,
      'sd': startDay == null ? null : formatDay(startDay),
      'ed': endDay == null ? null : formatDay(endDay),
      'w': weekdays,
      'n': note,
    });
    final id = rows.first[0] as String;
    await store.audit(companyId: companyId, actorId: actor.id, action: 'request.create', details: {'id': id, 'kind': kind});
    return id;
  }

  // --- Étapes -----------------------------------------------------------------

  /// Étape 2 de l'échange : le collègue (ou un des collègues d'une offre
  /// ouverte) accepte ; la demande passe aux responsables.
  Future<Map<String, Object?>> accept(User actor, String requestId) async {
    var r = await _load(requestId);
    await companies.open(actor, r.companyId);
    await expire(r.companyId);
    r = await _load(requestId);
    if (r.status != 'pending_peer') throw const ApiError.conflict('Cette demande n\'est plus en attente.');
    if (!await _canTake(r, actor, await _viewer(actor, r.companyId))) throw const ApiError.forbidden();
    final changed = await store.query(store.db, '''
      UPDATE requests SET status = 'pending_manager', peer_id = @p::uuid, updated_at = now()
      WHERE id = @id::uuid AND status = 'pending_peer' RETURNING id''', {'id': requestId, 'p': actor.id});
    if (changed.isEmpty) throw const ApiError.conflict('Cette demande n\'est plus en attente.');
    final updated = await _load(requestId);
    await _notifyDeciders(updated, actor);
    return _json(updated, actor, await _viewer(actor, r.companyId));
  }

  /// Le collègue refuse une proposition qui lui était adressée.
  Future<void> decline(User actor, String requestId) async {
    final r = await _load(requestId);
    if (r.status != 'pending_peer' || r.peerId != actor.id) throw const ApiError.forbidden();
    await _setStatus(r, 'refused', actor);
    await notifications.notify([r.requesterId],
        companyId: r.companyId, kind: 'swap_declined', data: _noticeData(r, actor.name));
  }

  /// Étape 3 : un responsable valide ou refuse. Il peut aussi trancher sans
  /// attendre le collègue : pour un échange, [peerId] choisit (ou change) la
  /// personne qui reprend le service.
  Future<Map<String, Object?>> decide(User actor, String requestId, {required bool approve, String? peerId}) async {
    var r = await _load(requestId);
    final viewer = await _viewer(actor, r.companyId);
    await expire(r.companyId);
    r = await _load(requestId);
    if (!r.pending) throw const ApiError.conflict('Cette demande n\'est plus en attente.');
    if (!await _canDecide(r, actor, viewer)) throw const ApiError.forbidden();
    var peer = r.peerId;
    if (approve && r.kind == 'swap') {
      final to = peerId ?? r.peerId;
      if (to == null) throw const ApiError.badRequest('Choisissez la personne qui reprend le service.');
      if (to == r.requesterId || await store.roleOf(r.companyId, to) == null) {
        throw const ApiError.notFound('Membre introuvable.');
      }
      peer = to;
      await store.db.runTx((tx) async {
        await planning.applySwap(tx, actor, r.companyId, r.shiftId ?? '', r.requesterId, to);
        await store.query(tx, '''
          UPDATE requests SET status = 'approved', peer_id = @p::uuid, decided_by = @a::uuid, updated_at = now()
          WHERE id = @id::uuid''', {'id': r.id, 'a': actor.id, 'p': to});
      });
      await overlaps?.notifyNew(r.companyId, [to]);
    } else {
      await _setStatus(r, approve ? 'approved' : 'refused', actor);
    }
    final people = [r.requesterId, if (r.kind == 'swap' && peer != null) peer];
    await notifications.notify(people.where((u) => u != actor.id),
        companyId: r.companyId, kind: approve ? 'request_approved' : 'request_refused', data: _noticeData(r, actor.name));
    return _json(await _load(requestId), actor, viewer);
  }

  Future<void> cancel(User actor, String requestId) async {
    final r = await _load(requestId);
    if (r.requesterId != actor.id) throw const ApiError.notFound('Demande introuvable.');
    if (!r.status.startsWith('pending')) throw const ApiError.conflict('Cette demande n\'est plus en attente.');
    await _setStatus(r, 'cancelled', actor);
  }

  Future<void> _setStatus(_Request r, String status, User actor) async {
    final changed = await store.query(store.db, '''
      UPDATE requests SET status = @s, decided_by = @a::uuid, updated_at = now()
      WHERE id = @id::uuid AND status = @from RETURNING id''', {'id': r.id, 's': status, 'a': actor.id, 'from': r.status});
    if (changed.isEmpty) throw const ApiError.conflict('Cette demande n\'est plus en attente.');
    await store.audit(companyId: r.companyId, actorId: actor.id, action: 'request.$status', details: {'id': r.id});
  }

  // --- Lecture ------------------------------------------------------------------

  /// Demandes visibles : les siennes, celles qui attendent sa réponse, et pour
  /// un responsable celles de son périmètre (ses sites). Les plus récentes
  /// d'abord, [limit] à la fois ; [before] : date de création de la dernière
  /// demande déjà affichée (page suivante).
  Future<List<Map<String, Object?>>> list(User actor, String companyId, {String? before, int limit = 10}) async {
    final viewer = await _viewer(actor, companyId);
    await expire(companyId);
    final wanted = limit.clamp(1, 50);
    final out = <Map<String, Object?>>[];
    var cursor = before;
    while (out.length < wanted) {
      final rows = await store.query(store.db, '''
        SELECT id::text, created_at FROM requests WHERE company_id = @c::uuid
          AND (@before::timestamptz IS NULL OR created_at < @before::timestamptz)
        ORDER BY created_at DESC LIMIT 50''', {'c': companyId, 'before': cursor});
      if (rows.isEmpty) break;
      for (final row in rows) {
        final json = await _visible(row[0] as String, actor, viewer);
        if (json != null && out.length < wanted) out.add(json);
      }
      cursor = (rows.last[1] as DateTime).toUtc().toIso8601String();
      if (rows.length < 50) break;
    }
    return out;
  }

  /// Toutes les demandes en attente visibles (pour le planning et « À traiter »).
  Future<List<Map<String, Object?>>> pending(User actor, String companyId) async {
    final viewer = await _viewer(actor, companyId);
    await expire(companyId);
    final rows = await store.query(store.db, '''
      SELECT id::text FROM requests WHERE company_id = @c::uuid AND status IN ('pending_peer', 'pending_manager')
      ORDER BY created_at DESC LIMIT 500''', {'c': companyId});
    final out = <Map<String, Object?>>[];
    for (final row in rows) {
      final json = await _visible(row[0] as String, actor, viewer);
      if (json != null) out.add(json);
    }
    return out;
  }

  /// Une demande (ouverte depuis une notification ou le planning).
  Future<Map<String, Object?>> one(User actor, String requestId) async {
    final r = await _load(requestId);
    final viewer = await _viewer(actor, r.companyId);
    await expire(r.companyId);
    final json = await _visible(requestId, actor, viewer);
    if (json == null) throw const ApiError.notFound('Demande introuvable.');
    return json;
  }

  Future<Map<String, Object?>?> _visible(String id, User actor, ({Role role, Set<String>? sites}) viewer) async {
    final r = await _load(id);
    final mine = r.requesterId == actor.id || r.peerId == actor.id;
    final offered = r.status == 'pending_peer' && await _canTake(r, actor, viewer);
    if (mine || offered || await _inScope(r, viewer)) return _json(r, actor, viewer, candidate: offered);
    return null;
  }

  /// Demandes devenues sans objet : service supprimé, donné à quelqu'un
  /// d'autre ou passé ; congé ou indisponibilité dont la période est finie.
  Future<void> expire(String companyId) async {
    await store.query(store.db, '''
      UPDATE requests r SET status = 'expired', updated_at = now()
      WHERE r.company_id = @c::uuid AND r.status IN ('pending_peer', 'pending_manager') AND (
        (r.kind = 'swap' AND NOT EXISTS (
          SELECT 1 FROM shifts s WHERE s.id = r.shift_id AND NOT s.deleted AND s.user_id = r.requester_id
            AND s.published->>'userId' = r.requester_id::text AND s.day >= @today::date))
        OR (r.kind <> 'swap' AND r.end_day IS NOT NULL AND r.end_day < @today::date))''',
        {'c': companyId, 'today': formatDay(_today())});
  }

  /// Congés et indisponibilités validés qui touchent la période : tous pour
  /// un responsable, les siens pour un salarié.
  Future<List<Map<String, Object?>>> absences(User actor, String companyId, String from, String to) async {
    final (_, role) = await companies.open(actor, companyId);
    final rows = await store.query(store.db, '''
      SELECT id::text FROM requests WHERE company_id = @c::uuid AND status = 'approved'
        AND kind IN ('leave', 'unavailability')
        AND (start_day IS NULL OR start_day <= @to::date) AND (end_day IS NULL OR end_day >= @from::date)
        AND (@all OR requester_id = @u::uuid)''',
        {'c': companyId, 'from': from, 'to': to, 'all': role.canManage, 'u': actor.id});
    final viewer = await _viewer(actor, companyId);
    return [for (final row in rows) _json(await _load(row[0] as String), actor, viewer)];
  }

  // --- Outils -------------------------------------------------------------------

  Future<_Request> _load(String id) async {
    final rows = await store.query(store.db, '''
      SELECT r.id::text, r.company_id::text, r.kind, r.status, r.requester_id::text, r.peer_id::text, r.open_offer,
        r.shift_id::text, r.shift_version, r.start_day, r.end_day, r.weekdays, r.note, r.created_at,
        s.day, s.start_min, s.end_min, s.site_id::text, s.position_id::text,
        coalesce(rm.display_name, ru.custom_name, ru.name), coalesce(pm.display_name, pu.custom_name, pu.name)
      FROM requests r
      LEFT JOIN shifts s ON s.id = r.shift_id
      JOIN users ru ON ru.id = r.requester_id
      LEFT JOIN memberships rm ON rm.user_id = ru.id AND rm.company_id = r.company_id AND rm.left_at IS NULL
      LEFT JOIN users pu ON pu.id = r.peer_id
      LEFT JOIN memberships pm ON pm.user_id = pu.id AND pm.company_id = r.company_id AND pm.left_at IS NULL
      WHERE r.id::text = @id''', {'id': id});
    if (rows.isEmpty) throw const ApiError.notFound('Demande introuvable.');
    final v = rows.first;
    return _Request(
      id: v[0] as String,
      companyId: v[1] as String,
      kind: v[2] as String,
      status: v[3] as String,
      requesterId: v[4] as String,
      peerId: v[5] as String?,
      openOffer: v[6] as bool,
      shiftId: v[7] as String?,
      shiftVersion: v[8] as int?,
      startDay: v[9] as DateTime?,
      endDay: v[10] as DateTime?,
      weekdays: (v[11] as List?)?.cast<int>(),
      note: v[12] as String?,
      createdAt: v[13] as DateTime,
      shiftDay: v[14] as DateTime?,
      shiftStart: v[15] as int?,
      shiftEnd: v[16] as int?,
      siteId: v[17] as String?,
      positionId: v[18] as String?,
      requesterName: v[19] as String,
      peerName: v[20] as String?,
    );
  }

  /// Rôle et sites de la personne qui regarde.
  Future<({Role role, Set<String>? sites})> _viewer(User actor, String companyId) async {
    final (_, role) = await companies.open(actor, companyId);
    return (role: role, sites: await companies.managedSites(companyId, actor, role));
  }

  /// Dans le périmètre d'un responsable : échange d'un service de ses sites,
  /// absence d'une personne de ses équipes.
  Future<bool> _inScope(_Request r, ({Role role, Set<String>? sites}) viewer) async {
    if (!viewer.role.canManage) return false;
    final mine = viewer.sites;
    if (mine == null) return true;
    if (r.kind == 'swap') return r.siteId != null && mine.contains(r.siteId);
    return companies.inSites(r.companyId, r.requesterId, mine);
  }

  /// On ne valide pas sa propre demande (sauf le propriétaire).
  Future<bool> _canDecide(_Request r, User actor, ({Role role, Set<String>? sites}) viewer) async =>
      r.pending && (r.requesterId != actor.id || viewer.role == Role.owner) && await _inScope(r, viewer);

  /// Peut reprendre le service : la personne choisie ; pour une offre à
  /// toute l'équipe, les collègues prévenus, et aussi les responsables et le
  /// patron (qui travaillent eux aussi).
  Future<bool> _canTake(_Request r, User actor, ({Role role, Set<String>? sites}) viewer) async {
    if (actor.id == r.requesterId) return false;
    if (!r.openOffer) return r.peerId == actor.id;
    return viewer.role.canManage || (await _candidates(r)).contains(actor.id);
  }

  /// Collègues à qui l'échange est proposé : la personne choisie, ou pour une
  /// offre ouverte les salariés et extras de l'équipe du site du service ; à
  /// défaut tous les salariés et extras ; à défaut tous les autres membres.
  Future<List<String>> _candidates(_Request r) async {
    if (!r.openOffer) return [if (r.peerId != null) r.peerId!];
    final others = [for (final m in await store.members(r.companyId)) if (m.user.id != r.requesterId) m];
    final staff = [for (final m in others) if (m.role == Role.employee || m.role == Role.extra) m];
    final team = [for (final m in staff) if (r.siteId != null && (m.sites ?? const []).contains(r.siteId)) m];
    final chosen = team.isNotEmpty ? team : (staff.isNotEmpty ? staff : others);
    return [for (final m in chosen) m.user.id];
  }

  /// Responsables qui peuvent valider : ceux du site du service (échange) ou
  /// de l'équipe de la personne (absence), et ceux de toute l'entreprise.
  Future<void> _notifyDeciders(_Request r, User actor) async {
    final deciders = <String>[];
    final concerned = r.kind == 'swap'
        ? {?r.siteId}
        : (await store.sitesOf(r.companyId, r.requesterId) ?? const []).toSet();
    for (final m in await store.members(r.companyId)) {
      if (!m.role.canManage || m.user.id == actor.id) continue;
      if (m.user.id == r.requesterId && m.role != Role.owner) continue;
      final sites = m.role == Role.owner ? null : m.sites?.toSet();
      if (!await _inScope(r, (role: m.role, sites: sites))) continue;
      // Sites dont ce responsable a choisi de recevoir les notifications.
      final wanted = await store.notifySitesOf(r.companyId, m.user.id);
      if (wanted != null && concerned.isNotEmpty && !concerned.any(wanted.contains)) continue;
      deciders.add(m.user.id);
    }
    final kind = switch (r.kind) {
      'swap' => 'swap_to_approve',
      'leave' => 'leave_to_approve',
      _ => 'unavailability_to_approve',
    };
    await notifications.notify(deciders, companyId: r.companyId, kind: kind, data: _noticeData(r, actor.name));
  }

  Map<String, Object?> _noticeData(_Request r, String byName) => {
        'requestId': r.id,
        'requestKind': r.kind,
        'byName': byName,
        'requesterName': r.requesterName,
        'peerName': r.peerName,
        'day': r.shiftDay == null ? null : formatDay(r.shiftDay!),
        'startDay': r.startDay == null ? null : formatDay(r.startDay!),
        'endDay': r.endDay == null ? null : formatDay(r.endDay!),
      };

  Map<String, Object?> _json(_Request r, User actor, ({Role role, Set<String>? sites}) viewer, {bool candidate = false}) {
    final pendingPeer = r.status == 'pending_peer';
    return {
      'id': r.id,
      'kind': r.kind,
      'status': r.status,
      'requester': {'id': r.requesterId, 'name': r.requesterName},
      'peer': r.peerId == null ? null : {'id': r.peerId, 'name': r.peerName},
      'openOffer': r.openOffer,
      'shift': r.shiftDay == null
          ? null
          : {
              'id': r.shiftId,
              'day': formatDay(r.shiftDay!),
              'start': r.shiftStart,
              'end': r.shiftEnd,
              'siteId': r.siteId,
              'positionId': r.positionId,
            },
      'startDay': r.startDay == null ? null : formatDay(r.startDay!),
      'endDay': r.endDay == null ? null : formatDay(r.endDay!),
      'weekdays': r.weekdays,
      'note': r.note,
      'createdAt': r.createdAt.toUtc().toIso8601String(),
      // Ce que la personne qui regarde peut faire.
      'canAnswer': pendingPeer && r.requesterId != actor.id && (r.peerId == actor.id || candidate),
      'canDecline': pendingPeer && r.peerId == actor.id,
      'canDecide': r.pending &&
          viewer.role.canManage &&
          (r.requesterId != actor.id || viewer.role == Role.owner) &&
          _scopeSync(r, viewer),
      'canCancel': r.requesterId == actor.id && r.status.startsWith('pending'),
      // Échange sans collègue encore désigné : le responsable choisit qui le reprend.
      'needsPeer': r.kind == 'swap' && r.peerId == null,
    };
  }

  /// Version immédiate de [_inScope] pour l'affichage (l'équipe d'une
  /// personne n'est pas relue : le serveur revérifie à la validation).
  static bool _scopeSync(_Request r, ({Role role, Set<String>? sites}) viewer) {
    final mine = viewer.sites;
    if (mine == null) return true;
    return r.kind != 'swap' || (r.siteId != null && mine.contains(r.siteId));
  }

  static DateTime? _day(Object? value) {
    if (value is! String) return null;
    try {
      return parseDay(value);
    } on FormatException {
      return null;
    }
  }

  static String? _note(Object? value) {
    if (value is! String || value.trim().isEmpty) return null;
    final t = value.trim();
    return t.length > 500 ? t.substring(0, 500) : t;
  }

  DateTime _today() {
    final n = planning.now();
    return DateTime.utc(n.year, n.month, n.day);
  }
}

class _Request {
  final String id, companyId, kind, status, requesterId, requesterName;
  final String? peerId, peerName, shiftId, siteId, positionId, note;
  final bool openOffer;
  final int? shiftVersion, shiftStart, shiftEnd;
  final DateTime? startDay, endDay, shiftDay;
  final List<int>? weekdays;
  final DateTime createdAt;

  _Request({
    required this.id,
    required this.companyId,
    required this.kind,
    required this.status,
    required this.requesterId,
    required this.requesterName,
    this.peerId,
    this.peerName,
    required this.openOffer,
    this.shiftId,
    this.shiftVersion,
    this.startDay,
    this.endDay,
    this.weekdays,
    this.note,
    required this.createdAt,
    this.shiftDay,
    this.shiftStart,
    this.shiftEnd,
    this.siteId,
    this.positionId,
  });

  bool get pending => status == 'pending_peer' || status == 'pending_manager';
}
