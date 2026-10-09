/// Rôle dans une entreprise ; son libellé traduit est dans i18n.dart.
enum Role {
  owner,
  manager,
  employee,
  extra;

  bool get canManage => this == owner || this == manager;
}

class User {
  final String id;
  final String publicId;
  final String email;

  /// Nom affiché (choisi par la personne, ou par un responsable dans une
  /// entreprise) ; à défaut, celui de Google.
  final String name;

  /// Nom du compte Google.
  final String googleName;
  final String? photoUrl;

  /// Langue du compte Google (« uk », « fr »…), si Google l'a fournie.
  final String? locale;

  User.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        publicId = j['publicId'],
        email = j['email'],
        name = j['name'],
        googleName = j['googleName'] ?? j['name'],
        photoUrl = j['photoUrl'],
        locale = j['locale'];
}

class Company {
  final String id;
  final String name;
  final String timezone;
  final bool readOnly;

  Company.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        name = j['name'],
        timezone = j['timezone'],
        readOnly = j['status'] == 'readOnly';
}

class Membership {
  final Company company;
  final Role role;

  /// Responsable : ses sites (`null` : toute l'entreprise). Salarié ou
  /// extra : les sites de son équipe.
  final List<String>? sites;

  /// Responsable : sites dont il reçoit les notifications (`null` : tous).
  final List<String>? notifySites;

  Membership.fromJson(Map<String, dynamic> j)
      : company = Company.fromJson(j['company']),
        role = Role.values.byName(j['role']),
        sites = _sites(j['sites']),
        notifySites = _sites(j['notifySites']);

  /// Sites que cette personne gère : `null` pour toute l'entreprise
  /// (propriétaire, responsable général), vide si elle ne gère rien.
  Set<String>? get managedSites =>
      role == Role.owner ? null : (role == Role.manager ? sites?.toSet() : const {});

  /// Gère-t-elle toute l'entreprise (sites, postes, nom) ?
  bool get managesAll => role.canManage && managedSites == null;

  /// Peut-elle modifier un service de ce site ?
  bool canEditSite(String? siteId) {
    if (!role.canManage) return false;
    final mine = managedSites;
    return mine == null || (siteId != null && mine.contains(siteId));
  }
}

List<String>? _sites(Object? v) => v == null ? null : [for (final s in v as List) s as String];

class Member {
  final User user;
  final Role role;

  /// Nom donné par un responsable, pour cette entreprise seulement.
  final String? nameInCompany;

  /// Voir [Membership.sites].
  final List<String>? sites;

  Member.fromJson(Map<String, dynamic> j)
      : user = User.fromJson(j['user']),
        role = Role.values.byName(j['role']),
        nameInCompany = j['nameInCompany'],
        sites = _sites(j['sites']);
}

class Transfer {
  final String id;
  final String companyId;

  Transfer.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        companyId = j['companyId'];
}

/// Réponse de `GET /me`.
class Me {
  final User user;
  final List<Membership> companies;
  final List<Transfer> pendingTransfers;
  final List<JoinRequest> pendingJoinRequests;

  /// Avis non lus (par exemple : une modification remplacée par un autre responsable).
  final int unreadNotices;

  /// Avis lus supprimés après : « day », « week » ou « month ».
  final String noticeRetention;

  /// Messages non lus, par entreprise.
  final Map<String, int> unreadMessages;

  /// Familles de notifications activées (planning, requests, messages…).
  final Map<String, bool> notificationPrefs;

  Me.fromJson(Map<String, dynamic> j)
      : user = User.fromJson(j['user']),
        companies = [for (final c in j['companies']) Membership.fromJson(c)],
        pendingTransfers = [for (final t in j['pendingTransfers']) Transfer.fromJson(t)],
        pendingJoinRequests = [
          for (final r in j['pendingJoinRequests'] ?? const []) JoinRequest.fromJson(r),
        ],
        unreadNotices = j['unreadNotices'] ?? 0,
        noticeRetention = j['noticeRetention'] ?? 'week',
        unreadMessages = {
          for (final e in ((j['unreadMessages'] ?? const {}) as Map).entries) e.key as String: e.value as int,
        },
        notificationPrefs = {
          for (final e in ((j['notificationPrefs'] ?? const {}) as Map).entries) e.key as String: e.value == true,
        };
}

class JoinRequest {
  final String id;
  final Company company;
  final Role role;

  JoinRequest.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        company = Company.fromJson(j['company']),
        role = Role.values.byName(j['role']);
}

/// Site ou poste.
class CatalogItem {
  final String id;
  final String name;
  final bool archived;

  CatalogItem.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        name = j['name'],
        archived = j['archived'];
}

enum ShiftStatus { draft, published, modified, deleted }

/// Service. Heures en minutes depuis minuit (heure de l'entreprise) ;
/// `end` peut dépasser 1440 pour un service qui finit le lendemain.
class Shift {
  final String id;
  final String? seriesId;
  final DateTime day;
  final int start;
  final int end;
  final String? userId;
  final String? siteId;
  final String? positionId;
  final String? note;
  final ShiftStatus status;

  /// Augmente à chaque modification sur le serveur (détection des conflits).
  final int version;

  /// Occurrence modifiée à part de sa série.
  final bool detached;

  /// Modification faite sur l'appareil, pas encore envoyée au serveur.
  final bool pending;

  const Shift({
    required this.id,
    this.seriesId,
    required this.day,
    required this.start,
    required this.end,
    this.userId,
    this.siteId,
    this.positionId,
    this.note,
    required this.status,
    this.version = 1,
    this.detached = false,
    this.pending = false,
  });

  Shift.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        seriesId = j['seriesId'],
        day = parseDay(j['day']),
        start = j['start'],
        end = j['end'],
        userId = j['userId'],
        siteId = j['siteId'],
        positionId = j['positionId'],
        note = j['note'],
        status = ShiftStatus.values.byName(j['status']),
        version = j['version'] ?? 1,
        detached = j['detached'] ?? false,
        pending = j['pending'] ?? false;

  Map<String, Object?> toJson() => {
        'id': id,
        'seriesId': seriesId,
        'day': formatDay(day),
        'start': start,
        'end': end,
        'userId': userId,
        'siteId': siteId,
        'positionId': positionId,
        'note': note,
        'status': status.name,
        'version': version,
        'detached': detached,
        if (pending) 'pending': true,
      };

  /// Créé hors connexion : il n'a pas encore d'identifiant sur le serveur.
  bool get isLocal => id.startsWith('local:');

  int get minutes => end - start;
}

DateTime parseDay(String s) => DateTime.parse(s);

String formatDay(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// Conversation de la messagerie : le groupe de l'entreprise, ou une
/// conversation privée avec [withName].
class Conversation {
  final String id;
  final bool isGroup;

  /// Groupe créé par un responsable avec des personnes choisies.
  final bool isTeam;

  /// Nom du groupe (pour [isTeam]).
  final String? name;
  final List<String> memberIds;
  final String? withId;
  final String? withName;
  final String? withPhotoUrl;

  /// L'autre personne fait-elle encore partie de l'entreprise ?
  final bool withActive;
  final ChatMessage? last;
  final int unread;

  Conversation.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        isGroup = j['kind'] == 'group',
        isTeam = j['kind'] == 'team',
        name = j['name'],
        memberIds = [for (final m in j['memberIds'] ?? const []) m as String],
        withId = j['with']?['id'],
        withName = j['with']?['name'],
        withPhotoUrl = j['with']?['photoUrl'],
        withActive = j['with']?['active'] ?? true,
        last = j['lastMessage'] == null ? null : ChatMessage.fromJson(j['lastMessage']),
        unread = j['unread'] ?? 0;
}

class ChatMessage {
  /// `null` : message pas encore envoyé (file d'attente hors connexion).
  final int? id;
  final String? authorId;
  final String? authorName;
  final String body;
  final DateTime createdAt;

  /// Message auquel celui-ci répond.
  final ChatReply? replyTo;

  /// Personnes citées avec « # ».
  final List<Mention> mentions;

  const ChatMessage(
      {this.id,
      this.authorId,
      this.authorName,
      required this.body,
      required this.createdAt,
      this.replyTo,
      this.mentions = const []});

  bool get pending => id == null;

  ChatMessage.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        authorId = j['authorId'],
        authorName = j['authorName'],
        body = j['body'],
        createdAt = DateTime.parse(j['createdAt']).toLocal(),
        replyTo = j['replyTo'] == null ? null : ChatReply.fromJson(j['replyTo']),
        mentions = [for (final m in j['mentions'] ?? const []) Mention(m['id'], m['name'])];
}

/// Extrait du message auquel on répond.
class ChatReply {
  final int id;
  final String? authorId;
  final String? authorName;
  final String body;

  ChatReply.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        authorId = j['authorId'],
        authorName = j['authorName'],
        body = j['body'];
}

/// Personne citée dans un message (« #Bob »).
class Mention {
  final String id;
  final String name;

  const Mention(this.id, this.name);
}

enum RequestKind { swap, leave, unavailability }

/// Demande d'un salarié : échange de service, congé ou indisponibilité.
/// Les champs `can…` disent ce que la personne connectée peut en faire.
class StaffRequest {
  final String id;
  final RequestKind kind;

  /// pending_peer, pending_manager, approved, refused, cancelled ou expired
  /// (sans objet : service changé, période passée).
  final String status;
  final String requesterId, requesterName;
  final String? peerId, peerName;

  /// Échange proposé à toute l'équipe plutôt qu'à une personne.
  final bool openOffer;
  final DateTime? shiftDay;
  final int? shiftStart, shiftEnd;
  final String? siteId;
  final DateTime? startDay, endDay;

  /// Indisponibilité chaque semaine : 1 = lundi … 7 = dimanche.
  final List<int>? weekdays;
  final String? note;
  final DateTime createdAt;
  final bool canAnswer, canDecline, canDecide, canCancel;

  /// Échange sans collègue désigné : le responsable choisit qui le reprend.
  final bool needsPeer;

  StaffRequest.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        kind = RequestKind.values.byName(j['kind']),
        status = j['status'],
        requesterId = j['requester']['id'],
        requesterName = j['requester']['name'],
        peerId = j['peer']?['id'],
        peerName = j['peer']?['name'],
        openOffer = j['openOffer'] == true,
        shiftDay = j['shift'] == null ? null : parseDay(j['shift']['day']),
        shiftStart = j['shift']?['start'],
        shiftEnd = j['shift']?['end'],
        siteId = j['shift']?['siteId'],
        startDay = j['startDay'] == null ? null : parseDay(j['startDay']),
        endDay = j['endDay'] == null ? null : parseDay(j['endDay']),
        weekdays = (j['weekdays'] as List?)?.cast<int>(),
        note = j['note'],
        createdAt = DateTime.parse(j['createdAt']),
        canAnswer = j['canAnswer'] == true,
        canDecline = j['canDecline'] == true,
        canDecide = j['canDecide'] == true,
        canCancel = j['canCancel'] == true,
        needsPeer = j['needsPeer'] == true,
        shiftId = j['shift']?['id'];

  /// Échange : le service proposé.
  final String? shiftId;

  bool get pending => status.startsWith('pending');

  /// Absence validée qui touche ce jour.
  bool covers(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    if (startDay != null && d.isBefore(startDay!)) return false;
    if (endDay != null && d.isAfter(endDay!)) return false;
    return weekdays == null || weekdays!.contains(d.weekday);
  }
}
