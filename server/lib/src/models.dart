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
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'publicId': publicId,
        'email': email,
        'name': name,
        'googleName': googleName,
        'photoUrl': photoUrl,
        'locale': locale,
      };
}

class Company {
  final String id;
  final String name;

  /// Fuseau IANA de l'entreprise : toutes ses heures y sont exprimées.
  final String timezone;
  final CompanyStatus status;
  final DateTime createdAt;

  /// Alertes légales choisies (minutes, jours d'affilée) ; `null` : aucune.
  final Map<String, int>? legalRules;

  /// Ce que les salariés peuvent imprimer : `own` (leur planning) ou `team`.
  final String printScope;

  const Company({
    required this.id,
    required this.name,
    required this.timezone,
    required this.status,
    required this.createdAt,
    this.legalRules,
    this.printScope = 'team',
  });

  Company copyWith({String? name, String? timezone, Map<String, int>? Function()? legalRules, String? printScope}) =>
      Company(
        id: id,
        name: name ?? this.name,
        timezone: timezone ?? this.timezone,
        status: status,
        createdAt: createdAt,
        legalRules: legalRules == null ? this.legalRules : legalRules(),
        printScope: printScope ?? this.printScope,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'timezone': timezone,
        'status': status.name,
        'legalRules': legalRules,
        'printScope': printScope,
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

  const Membership(this.company, this.role, [this.sites, this.notifySites]);

  Map<String, Object?> toJson() =>
      {'company': company.toJson(), 'role': role.name, 'sites': sites, 'notifySites': notifySites};
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

  const Member(this.user, this.role, this.joinedAt, {this.nameInCompany, this.sites, this.appointedBy});

  Map<String, Object?> toJson() => {
        'user': user.toJson(),
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
