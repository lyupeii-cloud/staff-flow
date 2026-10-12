/// Rôle d'une personne dans une entreprise (section 2 du cahier des charges).
enum Role {
  owner,
  manager,
  employee,
  extra;

  static Role parse(String value) => Role.values.firstWhere(
        (r) => r.name == value,
        orElse: () => throw FormatException('Rôle inconnu : $value'),
      );

  /// Propriétaire et responsables gèrent l'entreprise.
  bool get canManage => this == Role.owner || this == Role.manager;
}

enum CompanyStatus { active, readOnly }

enum TransferStatus { pending, accepted, declined, cancelled }

class User {
  final String id;

  /// Identifiant unique visible, valable dans toutes les entreprises.
  final String publicId;
  final String googleSub;
  final String email;

  /// Nom affiché : celui choisi par la personne, sinon celui de Google.
  final String name;

  /// Nom du compte Google, mis à jour à chaque connexion.
  final String googleName;
  final String? photoUrl;

  /// Langue du compte Google, pour afficher le site dans cette langue.
  final String? locale;
  final DateTime createdAt;

  /// Avatar choisi ({icon, color}) ; `null` : photo Google (ou initiale).
  final Map<String, Object?>? avatar;

  /// Version des sessions : les jetons d'une version plus ancienne ne valent plus.
  final int sessionVersion;

  const User({
    required this.id,
    required this.publicId,
    required this.googleSub,
    required this.email,
    required this.name,
    String? googleName,
    this.photoUrl,
    this.locale,
    required this.createdAt,
    this.avatar,
    this.sessionVersion = 0,
  }) : googleName = googleName ?? name;

  User withName(String name) => User(
        id: id,
        publicId: publicId,
        googleSub: googleSub,
        email: email,
        name: name,
        googleName: googleName,
        photoUrl: photoUrl,
        locale: locale,
        createdAt: createdAt,
        avatar: avatar,
        sessionVersion: sessionVersion,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'publicId': publicId,
        'email': email,
        'name': name,
        'googleName': googleName,
        'photoUrl': photoUrl,
        'locale': locale,
        'avatar': avatar,
      };
}

class Company {
  final String id;
  final String name;

  /// Identifiant public (6 caractères), sur les factures de l'entreprise.
  final String publicId;

  /// Fuseau IANA de l'entreprise : toutes ses heures y sont exprimées.
  final String timezone;
  final CompanyStatus status;
  final DateTime createdAt;

  /// Alertes légales choisies (minutes, jours d'affilée) ; `null` : aucune.
  final Map<String, int>? legalRules;

  /// Ce que les salariés peuvent imprimer : `own` (leur planning) ou `team`.
  final String printScope;

  /// Préréglages d'horaires : [{name, start, end}] en minutes.
  final List<Map<String, Object?>> shiftPresets;

  /// Image de l'entreprise : 0 = aucune ; augmente à chaque changement.
  final int logoVersion;

  /// Messagerie de l'entreprise : le patron l'active (désactivée au départ).
  final bool messagingEnabled;

  /// Abonnement : `trial`, `active`, `grace` (lecture seule avant
  /// suppression) ou `comped` (offerte).
  final String billingStatus;
  final DateTime? trialEndsAt;
  final DateTime? paidUntil;
  final DateTime? graceEndsAt;
  final String? billingPeriod;
  final bool cascadeOption;

  /// Option « accès API » payée.
  final bool apiOption;

  /// Le patron masque les photos Google dans son entreprise (avatars à la place).
  final bool hidePhotos;

  const Company({
    required this.id,
    required this.name,
    this.publicId = '',
    required this.timezone,
    required this.status,
    required this.createdAt,
    this.legalRules,
    this.printScope = 'team',
    this.shiftPresets = const [],
    this.logoVersion = 0,
    this.messagingEnabled = false,
    this.billingStatus = 'trial',
    this.trialEndsAt,
    this.paidUntil,
    this.graceEndsAt,
    this.billingPeriod,
    this.cascadeOption = false,
    this.apiOption = false,
    this.hidePhotos = false,
  });

  Map<String, Object?> billingJson() => {
        'status': billingStatus,
        'trialEndsAt': trialEndsAt?.toIso8601String(),
        'paidUntil': paidUntil?.toIso8601String(),
        'graceEndsAt': graceEndsAt?.toIso8601String(),
        'period': billingPeriod,
        'cascadeOption': cascadeOption,
        'apiOption': apiOption,
      };

  Company copyWith({String? name, String? timezone, Map<String, int>? Function()? legalRules, String? printScope}) =>
      Company(
        id: id,
        name: name ?? this.name,
        timezone: timezone ?? this.timezone,
        status: status,
        createdAt: createdAt,
        legalRules: legalRules == null ? this.legalRules : legalRules(),
        printScope: printScope ?? this.printScope,
        shiftPresets: shiftPresets,
        logoVersion: logoVersion,
        messagingEnabled: messagingEnabled,
        billingStatus: billingStatus,
        trialEndsAt: trialEndsAt,
        paidUntil: paidUntil,
        graceEndsAt: graceEndsAt,
        billingPeriod: billingPeriod,
        cascadeOption: cascadeOption,
        apiOption: apiOption,
        hidePhotos: hidePhotos,
        publicId: publicId,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'publicId': publicId,
        'timezone': timezone,
        'status': status.name,
        'legalRules': legalRules,
        'printScope': printScope,
        'shiftPresets': shiftPresets,
        'logoVersion': logoVersion,
        'messagingEnabled': messagingEnabled,
        'hidePhotos': hidePhotos,
        'billing': billingJson(),
      };
}

class Membership {
  final Company company;
  final Role role;

  /// Responsable : sites dont il s'occupe (`null` : toute l'entreprise).
  /// Salarié ou extra : sites de son équipe (`null` : aucun en particulier).
  final List<String>? sites;

  /// Responsable : sites dont il reçoit les notifications (`null` : tous).
  final List<String>? notifySites;

  /// Notifications de cette entreprise sur le téléphone.
  final bool notificationsOn;

  /// Décalage actuel de l'heure de l'entreprise avec UTC, en minutes
  /// (heure d'été comprise).
  final int? utcOffset;

  /// Son Telegram est affiché aux autres membres de cette entreprise.
  final bool showTelegram;

  Membership(this.company, this.role,
      [this.sites, this.notifySites, this.notificationsOn = true, this.utcOffset, this.showTelegram = false]);

  /// Le patron lui a confié l'abonnement et les factures.
  bool billingAccess = false;

  Map<String, Object?> toJson() => {
        'company': company.toJson(),
        'role': role.name,
        'billingAccess': billingAccess || role == Role.owner,
        'sites': sites,
        'notifySites': notifySites,
        'notificationsOn': notificationsOn,
        'utcOffset': utcOffset,
        'showTelegram': showTelegram,
      };
}

class Member {
  /// `user.name` est déjà le nom utilisé dans cette entreprise.
  final User user;
  final Role role;
  final DateTime joinedAt;

  /// Voir [Membership.sites].
  final List<String>? sites;

  /// Nom donné par un responsable pour cette entreprise seulement.
  final String? nameInCompany;

  /// Sous-responsable : le responsable qui l'a nommé.
  final String? appointedBy;

  /// Nom Telegram (sans « @ »), si la personne l'affiche dans cette entreprise.
  final String? telegram;

  /// Telegram vérifié (sinon, le changement de compte Google passe par un lien du responsable).
  final bool telegramLinked;

  /// Matricule donné par l'employeur (l'identifiant SF reste dans `user.publicId`).
  final String? employeeNumber;

  /// Peut gérer l'abonnement et les factures (confié par le patron).
  bool billingAccess = false;

  /// Poste habituel dans l'entreprise.
  final String? positionId;

  Member(this.user, this.role, this.joinedAt,
      {this.nameInCompany,
      this.sites,
      this.appointedBy,
      this.telegram,
      this.telegramLinked = false,
      this.employeeNumber,
      this.positionId});

  Map<String, Object?> toJson() => {
        'user': user.toJson(),
        'employeeNumber': employeeNumber,
        'positionId': positionId,
        'billingAccess': billingAccess,
        'telegram': telegram,
        'telegramLinked': telegramLinked,
        'nameInCompany': nameInCompany,
        'sites': sites,
        'appointedBy': appointedBy,
        'role': role.name,
        'joinedAt': joinedAt.toUtc().toIso8601String(),
      };
}

/// Invitation créée quand un responsable saisit le code d'un salarié ;
/// le salarié l'accepte ou la refuse.
class JoinRequest {
  final String id;
  final Company company;
  final Role role;

  const JoinRequest({required this.id, required this.company, required this.role});

  Map<String, Object?> toJson() => {'id': id, 'company': company.toJson(), 'role': role.name};
}

class OwnershipTransfer {
  final String id;
  final String companyId;
  final String fromUserId;
  final String toUserId;
  final TransferStatus status;
  final DateTime createdAt;

  const OwnershipTransfer({
    required this.id,
    required this.companyId,
    required this.fromUserId,
    required this.toUserId,
    required this.status,
    required this.createdAt,
  });

  Map<String, Object?> toJson() => {
        'id': id,
        'companyId': companyId,
        'fromUserId': fromUserId,
        'toUserId': toUserId,
        'status': status.name,
        'createdAt': createdAt.toUtc().toIso8601String(),
      };
}
