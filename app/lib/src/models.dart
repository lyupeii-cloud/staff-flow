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

  Membership.fromJson(Map<String, dynamic> j)
      : company = Company.fromJson(j['company']),
        role = Role.values.byName(j['role']);
}

class Member {
  final User user;
  final Role role;

  /// Nom donné par un responsable, pour cette entreprise seulement.
  final String? nameInCompany;

  Member.fromJson(Map<String, dynamic> j)
      : user = User.fromJson(j['user']),
        role = Role.values.byName(j['role']),
        nameInCompany = j['nameInCompany'];
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

  const ChatMessage({this.id, this.authorId, this.authorName, required this.body, required this.createdAt});

  bool get pending => id == null;

  ChatMessage.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        authorId = j['authorId'],
        authorName = j['authorName'],
        body = j['body'],
        createdAt = DateTime.parse(j['createdAt']).toLocal();
}
