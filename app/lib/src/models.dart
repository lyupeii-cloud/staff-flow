enum Role {
  owner('Propriétaire'),
  manager('Responsable'),
  employee('Salarié'),
  extra('Extra');

  final String label;
  const Role(this.label);

  bool get canManage => this == owner || this == manager;
}

class User {
  final String id;
  final String publicId;
  final String email;
  final String name;
  final String? photoUrl;

  User.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        publicId = j['publicId'],
        email = j['email'],
        name = j['name'],
        photoUrl = j['photoUrl'];
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

  Member.fromJson(Map<String, dynamic> j)
      : user = User.fromJson(j['user']),
        role = Role.values.byName(j['role']);
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

  Me.fromJson(Map<String, dynamic> j)
      : user = User.fromJson(j['user']),
        companies = [for (final c in j['companies']) Membership.fromJson(c)],
        pendingTransfers = [for (final t in j['pendingTransfers']) Transfer.fromJson(t)];
}
