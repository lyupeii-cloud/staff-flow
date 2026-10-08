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
  final String name;
  final String? photoUrl;

  /// Langue du compte Google (« uk », « fr »…), si Google l'a fournie.
  final String? locale;

  User.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        publicId = j['publicId'],
        email = j['email'],
        name = j['name'],
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
  final List<JoinRequest> pendingJoinRequests;

  Me.fromJson(Map<String, dynamic> j)
      : user = User.fromJson(j['user']),
        companies = [for (final c in j['companies']) Membership.fromJson(c)],
        pendingTransfers = [for (final t in j['pendingTransfers']) Transfer.fromJson(t)],
        pendingJoinRequests = [
          for (final r in j['pendingJoinRequests'] ?? const []) JoinRequest.fromJson(r),
        ];
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
        status = ShiftStatus.values.byName(j['status']);

  int get minutes => end - start;
}

DateTime parseDay(String s) => DateTime.parse(s);

String formatDay(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
