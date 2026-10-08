// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class L10nHu extends L10n {
  L10nHu([String locale = 'hu']) : super(locale);

  @override
  String get cancel => 'Mégse';

  @override
  String get save => 'Mentés';

  @override
  String get confirm => 'Megerősítés';

  @override
  String get validate => 'Megerősítés';

  @override
  String get add => 'Hozzáadás';

  @override
  String get rename => 'Átnevezés';

  @override
  String get delete => 'Törlés';

  @override
  String get accept => 'Elfogadás';

  @override
  String get decline => 'Elutasítás';

  @override
  String get close => 'Bezárás';

  @override
  String get retry => 'Újra';

  @override
  String get name => 'Név';

  @override
  String get serverUnreachable => 'A szerver nem érhető el.';

  @override
  String errorStatus(int status) {
    return 'Hiba: $status';
  }

  @override
  String get roleOwner => 'Tulajdonos';

  @override
  String get roleManager => 'Vezető';

  @override
  String get roleEmployee => 'Munkavállaló';

  @override
  String get roleExtra => 'Kisegítő';

  @override
  String get taglineStart => 'A csapatod beosztása, ';

  @override
  String get taglineEnd => 'bárhol.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Bejelentkezés Google-fiókkal';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'A Google-bejelentkezés nem érhető el: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Nem sikerült Google-fiókkal bejelentkezni: $detail';
  }

  @override
  String get newCompany => 'Új cég';

  @override
  String get timezone => 'Időzóna';

  @override
  String get create => 'Létrehozás';

  @override
  String get noCompanyTitle => 'Még egyetlen céghez sem tartozol.';

  @override
  String get noCompanyHint =>
      'A munkáltatód cégéhez való csatlakozáshoz hozz létre egy kódot, és add oda a vezetődnek.';

  @override
  String get joinCompany => 'Csatlakozás céghez';

  @override
  String get createCompany => 'Cég létrehozása';

  @override
  String transferOffer(String company) {
    return 'Felajánlották, hogy legyél a(z) „$company” tulajdonosa.';
  }

  @override
  String get someCompany => 'egy cég';

  @override
  String get becameOwner => 'Mostantól te vagy a tulajdonos.';

  @override
  String get myAccount => 'Fiókom';

  @override
  String get idCopied => 'Azonosító másolva.';

  @override
  String myId(String id) {
    return 'Azonosítóm: $id';
  }

  @override
  String get signOut => 'Kijelentkezés';

  @override
  String joinInvite(String company, String role) {
    return 'A(z) „$company” meghív téged ebben a szerepkörben: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Csatlakoztál: $company.';
  }

  @override
  String get viewPlanning => 'Beosztás';

  @override
  String get viewTeam => 'Csapat';

  @override
  String get viewPositions => 'Munkakörök';

  @override
  String get readOnlyCompany => 'A cég csak olvasható.';

  @override
  String get team => 'Csapat';

  @override
  String get leaveCompany => 'Kilépés a cégből';

  @override
  String meSuffix(String name) {
    return '$name (te)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Átadod a céget neki: $name?';
  }

  @override
  String get transferConfirmBody =>
      'Elfogadás után ő lesz a tulajdonos (előfizetés, számlák, vezetők), te pedig vezető leszel.';

  @override
  String transferSent(String name) {
    return 'Ajánlat elküldve: $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Eltávolítod: $name?';
  }

  @override
  String get removeConfirmBody => 'Az előzmények megmaradnak.';

  @override
  String get addPersonTitle => 'Személy hozzáadása';

  @override
  String get addPersonHint =>
      'Kérd meg, hogy nyissa meg a Staff Flow-t, a fiókmenüben válassza a „Csatlakozás céghez” lehetőséget, majd írd be a megjelenő kódot.';

  @override
  String get sixDigitCode => '6 jegyű kód';

  @override
  String invitationSent(String name) {
    return 'Meghívó elküldve: $name. El kell fogadnia.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Kilépsz innen: $company?';
  }

  @override
  String get leaveConfirmBody => 'Többé nem látod a beosztását.';

  @override
  String get renameCompany => 'Cég átnevezése';

  @override
  String get actionMakeManager => 'Vezetővé tesz';

  @override
  String get actionMakeEmployee => 'Vissza munkavállalóvá';

  @override
  String get actionToEmployee => 'Munkavállalóvá tesz';

  @override
  String get actionToExtra => 'Kisegítővé tesz';

  @override
  String get actionTransfer => 'Tulajdonjog átadása';

  @override
  String get actionRemove => 'Eltávolítás a cégből';

  @override
  String get positions => 'Munkakörök';

  @override
  String get sites => 'Telephelyek';

  @override
  String get positionsHint =>
      'Mit csinál a személy: pénztár, konyha, recepció…';

  @override
  String get sitesHint => 'Hol van a műszak, ha a cégnek több telephelye van.';

  @override
  String get archived => 'Archivált';

  @override
  String get archive => 'Archiválás';

  @override
  String get reactivate => 'Újraaktiválás';

  @override
  String weekOf(String date) {
    return '$date hete';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count módosítás közzétéve.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Műszak';

  @override
  String get display => 'Nézet';

  @override
  String get week => 'Hét';

  @override
  String get month => 'Hónap';

  @override
  String get today => 'Ma';

  @override
  String get onlyMine => 'Csak a saját műszakjaim';

  @override
  String get replacePersonMenu => 'Személy cseréje…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count közzé nem tett módosítás',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'A munkavállalók még nem látják.';

  @override
  String get publish => 'Közzététel';

  @override
  String yourHours(String duration) {
    return 'Óráid az időszakban: $duration';
  }

  @override
  String get addShiftThisDay => 'Műszak hozzáadása erre a napra';

  @override
  String get noShift => 'Nincs műszak';

  @override
  String get unassigned => 'Nincs kiosztva';

  @override
  String get formerMember => 'Korábbi tag';

  @override
  String get statusDraft => 'Piszkozat';

  @override
  String get statusModified => 'Módosítva';

  @override
  String get statusDeleted => 'Törölve';

  @override
  String durationHours(int hours) {
    return '$hours ó';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ó $minutes p';
  }

  @override
  String get editShift => 'Műszak szerkesztése';

  @override
  String get newShift => 'Új műszak';

  @override
  String get thisShift => 'Csak ez a műszak';

  @override
  String get thisAndFollowing => 'Ez és a következők';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nap',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Másik nap';

  @override
  String get start => 'Kezdés';

  @override
  String get end => 'Befejezés';

  @override
  String get endsNextDay => 'Másnap ér véget.';

  @override
  String get person => 'Személy';

  @override
  String get position => 'Munkakör';

  @override
  String get site => 'Telephely';

  @override
  String get noteOptional => 'Megjegyzés (nem kötelező)';

  @override
  String get repetition => 'Ismétlés';

  @override
  String get repeatNone => 'Nincs';

  @override
  String get repeatDaily => 'Minden nap';

  @override
  String get repeatWeekly => 'Minden héten';

  @override
  String get repeatForPrefix => 'Időtartam: ';

  @override
  String get repeatDaysSuffix => ' nap';

  @override
  String get repeatWeeksSuffix => ' hét';

  @override
  String get repeatUntilPrefix => 'Eddig: ';

  @override
  String get replacePersonTitle => 'Személy cseréje';

  @override
  String get replaceFrom => 'Csere';

  @override
  String get replaceBy => 'Erre';

  @override
  String dateRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count műszak módosítva.',
      zero: 'Egy műszak sem változott.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Csere';

  @override
  String get joinHint =>
      'Add oda ezt a kódot a vezetődnek. Miután beírja az alkalmazásba, kapsz egy meghívót.';

  @override
  String get codeExpired => 'A kód lejárt.';

  @override
  String codeValidFor(String time) {
    return 'Még $time érvényes';
  }

  @override
  String get newCode => 'Új kód';

  @override
  String get language => 'Nyelv';

  @override
  String get languageAuto => 'Automatikus (eszköz nyelve)';
}
