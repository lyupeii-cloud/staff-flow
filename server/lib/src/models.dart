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
  final String name;
  final String? photoUrl;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.publicId,
    required this.googleSub,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.createdAt,
  });

  Map<String, Object?> toJson() => {
        'id': id,
        'publicId': publicId,
        'email': email,
        'name': name,
        'photoUrl': photoUrl,
      };
}

class Company {
  final String id;
  final String name;

  /// Fuseau IANA de l'entreprise : toutes ses heures y sont exprimées.
  final String timezone;
  final CompanyStatus status;
  final DateTime createdAt;

  const Company({
    required this.id,
    required this.name,
    required this.timezone,
    required this.status,
    required this.createdAt,
  });

  Company copyWith({String? name, String? timezone}) => Company(
        id: id,
        name: name ?? this.name,
        timezone: timezone ?? this.timezone,
        status: status,
        createdAt: createdAt,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'timezone': timezone,
        'status': status.name,
      };
}

class Membership {
  final Company company;
  final Role role;

  const Membership(this.company, this.role);

  Map<String, Object?> toJson() => {'company': company.toJson(), 'role': role.name};
}

class Member {
  final User user;
  final Role role;
  final DateTime joinedAt;

  const Member(this.user, this.role, this.joinedAt);

  Map<String, Object?> toJson() => {
        'user': user.toJson(),
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
