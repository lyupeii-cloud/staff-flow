// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class L10nRo extends L10n {
  L10nRo([String locale = 'ro']) : super(locale);

  @override
  String get cancel => 'Anulează';

  @override
  String get save => 'Salvează';

  @override
  String get confirm => 'Confirmă';

  @override
  String get validate => 'Confirmă';

  @override
  String get add => 'Adaugă';

  @override
  String get rename => 'Redenumește';

  @override
  String get delete => 'Șterge';

  @override
  String get accept => 'Acceptă';

  @override
  String get decline => 'Refuză';

  @override
  String get close => 'Închide';

  @override
  String get retry => 'Încearcă din nou';

  @override
  String get name => 'Nume';

  @override
  String get serverUnreachable => 'Serverul nu poate fi accesat.';

  @override
  String errorStatus(int status) {
    return 'Eroare $status';
  }

  @override
  String get roleOwner => 'Proprietar';

  @override
  String get roleManager => 'Responsabil';

  @override
  String get roleEmployee => 'Angajat';

  @override
  String get roleExtra => 'Temporar';

  @override
  String get taglineStart => 'Programul echipei tale, ';

  @override
  String get taglineEnd => 'oriunde.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Conectează-te cu Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Conectarea cu Google nu este disponibilă: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Conectarea cu Google a eșuat: $detail';
  }

  @override
  String get newCompany => 'Firmă nouă';

  @override
  String get timezone => 'Fus orar';

  @override
  String get create => 'Creează';

  @override
  String get noCompanyTitle => 'Încă nu faci parte din nicio firmă.';

  @override
  String get noCompanyHint =>
      'Pentru a te alătura firmei angajatorului, generează un cod și dă-l responsabilului tău.';

  @override
  String get joinCompany => 'Alătură-te unei firme';

  @override
  String get createCompany => 'Creează o firmă';

  @override
  String transferOffer(String company) {
    return 'Ți se propune să devii proprietarul „$company”.';
  }

  @override
  String get someCompany => 'o firmă';

  @override
  String get becameOwner => 'Acum ești proprietarul.';

  @override
  String get myAccount => 'Contul meu';

  @override
  String get idCopied => 'Identificator copiat.';

  @override
  String myId(String id) {
    return 'Identificatorul meu: $id';
  }

  @override
  String get signOut => 'Deconectează-te';

  @override
  String joinInvite(String company, String role) {
    return '„$company” te invită ca $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Te-ai alăturat firmei $company.';
  }

  @override
  String get viewPlanning => 'Program';

  @override
  String get viewTeam => 'Echipă';

  @override
  String get viewPositions => 'Posturi';

  @override
  String get readOnlyCompany => 'Firmă doar pentru citire.';

  @override
  String get team => 'Echipă';

  @override
  String get leaveCompany => 'Părăsește această firmă';

  @override
  String meSuffix(String name) {
    return '$name (tu)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Transferi firma către $name?';
  }

  @override
  String get transferConfirmBody =>
      'După acceptare, persoana va deveni proprietar (abonament, facturi, responsabili), iar tu vei deveni responsabil.';

  @override
  String transferSent(String name) {
    return 'Propunere trimisă către $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Elimini persoana $name?';
  }

  @override
  String get removeConfirmBody => 'Istoricul este păstrat.';

  @override
  String get addPersonTitle => 'Adaugă o persoană';

  @override
  String get addPersonHint =>
      'Roag-o să deschidă Staff Flow, meniul contului, „Alătură-te unei firme”, apoi introdu codul afișat.';

  @override
  String get sixDigitCode => 'Cod din 6 cifre';

  @override
  String invitationSent(String name) {
    return 'Invitație trimisă către $name: trebuie să o accepte.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Părăsești $company?';
  }

  @override
  String get leaveConfirmBody => 'Nu vei mai vedea programul acestei firme.';

  @override
  String get renameCompany => 'Redenumește firma';

  @override
  String get actionMakeManager => 'Numește responsabil';

  @override
  String get actionMakeEmployee => 'Din nou angajat';

  @override
  String get actionToEmployee => 'Treci la angajat';

  @override
  String get actionToExtra => 'Treci la temporar';

  @override
  String get actionTransfer => 'Transferă proprietatea';

  @override
  String get actionRemove => 'Elimină din firmă';

  @override
  String get positions => 'Posturi';

  @override
  String get sites => 'Locații';

  @override
  String get positionsHint => 'Ce face persoana: casă, bucătărie, recepție…';

  @override
  String get sitesHint =>
      'Unde are loc tura, dacă firma are mai multe locații.';

  @override
  String get archived => 'Arhivat';

  @override
  String get archive => 'Arhivează';

  @override
  String get reactivate => 'Reactivează';

  @override
  String weekOf(String date) {
    return 'Săptămâna din $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de modificări publicate.',
      few: '$count modificări publicate.',
      one: '$count modificare publicată.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Tură';

  @override
  String get display => 'Afișare';

  @override
  String get week => 'Săptămână';

  @override
  String get month => 'Lună';

  @override
  String get today => 'Azi';

  @override
  String get onlyMine => 'Doar turele mele';

  @override
  String get replacePersonMenu => 'Înlocuiește o persoană…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de modificări nepublicate',
      few: '$count modificări nepublicate',
      one: '$count modificare nepublicată',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Angajații nu le văd încă.';

  @override
  String get publish => 'Publică';

  @override
  String yourHours(String duration) {
    return 'Orele tale în perioadă: $duration';
  }

  @override
  String get addShiftThisDay => 'Adaugă o tură în această zi';

  @override
  String get noShift => 'Nicio tură';

  @override
  String get unassigned => 'Nealocat';

  @override
  String get formerMember => 'Fost membru';

  @override
  String get statusDraft => 'Ciornă';

  @override
  String get statusModified => 'Modificat';

  @override
  String get statusDeleted => 'Șters';

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours h $minutes';
  }

  @override
  String get editShift => 'Editează tura';

  @override
  String get newShift => 'Tură nouă';

  @override
  String get thisShift => 'Doar această tură';

  @override
  String get thisAndFollowing => 'Aceasta și următoarele';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zile',
      one: 'Zi',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Altă zi';

  @override
  String get start => 'Început';

  @override
  String get end => 'Sfârșit';

  @override
  String get endsNextDay => 'Se termină a doua zi.';

  @override
  String get person => 'Persoană';

  @override
  String get position => 'Post';

  @override
  String get site => 'Locație';

  @override
  String get noteOptional => 'Notă (opțional)';

  @override
  String get repetition => 'Repetare';

  @override
  String get repeatNone => 'Niciuna';

  @override
  String get repeatDaily => 'Zilnic';

  @override
  String get repeatWeekly => 'Săptămânal';

  @override
  String get repeatForPrefix => 'Timp de ';

  @override
  String get repeatDaysSuffix => ' zile';

  @override
  String get repeatWeeksSuffix => ' săptămâni';

  @override
  String get repeatUntilPrefix => 'Până pe ';

  @override
  String get replacePersonTitle => 'Înlocuiește o persoană';

  @override
  String get replaceFrom => 'Înlocuiește';

  @override
  String get replaceBy => 'Cu';

  @override
  String dateRange(String from, String to) {
    return 'De la $from la $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count de ture modificate.',
      few: '$count ture modificate.',
      one: '$count tură modificată.',
      zero: 'Nicio tură modificată.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Înlocuiește';

  @override
  String get joinHint =>
      'Dă acest cod responsabilului tău. După ce îl introduce în aplicație, vei primi o invitație de acceptat.';

  @override
  String get codeExpired => 'Cod expirat.';

  @override
  String codeValidFor(String time) {
    return 'Valabil încă $time';
  }

  @override
  String get newCode => 'Cod nou';

  @override
  String get language => 'Limbă';

  @override
  String get languageAuto => 'Automat (limba dispozitivului)';

  @override
  String get syncUpToDate => 'Actualizat';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Modificări în așteptare: $count';
  }

  @override
  String get syncNow => 'Sincronizează';

  @override
  String syncRejected(String reason) {
    return 'Modificare refuzată de server: $reason';
  }

  @override
  String get pendingBadge => 'În așteptare';

  @override
  String get offlineUnavailable => 'Indisponibil offline.';

  @override
  String get offlineCached => 'Offline: ultimele date salvate.';

  @override
  String get savedOffline =>
      'Salvat pe dispozitiv, va fi trimis când revine rețeaua.';

  @override
  String get notices => 'Notificări';

  @override
  String get noNotices => 'Nicio notificare.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name a înlocuit modificarea ta la tura din $date.';
  }

  @override
  String get history => 'Istoric';

  @override
  String get recentChanges => 'Modificări recente';

  @override
  String get undoChange => 'Anulează această modificare';

  @override
  String get undoDone => 'Modificare anulată.';

  @override
  String get historyCreate => 'Creare';

  @override
  String get historyUpdate => 'Modificare';

  @override
  String get historyDelete => 'Ștergere';

  @override
  String get historyUndo => 'Anulare';

  @override
  String get noHistory => 'Nicio modificare.';

  @override
  String get pendingNotEditable =>
      'Această tură nu este încă sincronizată: încearcă din nou când ești online.';
}
