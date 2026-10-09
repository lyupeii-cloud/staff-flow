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

  @override
  String get myQrCode => 'Codul meu QR';

  @override
  String get myQrCodeHint =>
      'Un responsabil scanează acest cod pentru a te adăuga în firma sa; apoi confirmi tu. Nu se schimbă niciodată.';

  @override
  String get changeMyName => 'Schimbă-mi numele';

  @override
  String get nameShownToTeam =>
      'Acest nume este afișat colegilor în locul numelui tău Google.';

  @override
  String googleName(String name) {
    return 'Nume Google: $name';
  }

  @override
  String get useGoogleName => 'Folosește numele meu Google';

  @override
  String renameMemberTitle(String name) {
    return 'Redenumește $name';
  }

  @override
  String get renameMemberHint =>
      'Acest nume este folosit doar în această firmă.';

  @override
  String get useOwnName => 'Folosește propriul nume';

  @override
  String get scanQrCode => 'Scanează un cod QR';

  @override
  String get scanQrHint =>
      'Îndreaptă camera spre codul QR afișat în aplicația persoanei (meniul contului, „Codul meu QR”).';

  @override
  String get orEnterCode => 'Sau introdu codul de 6 cifre';

  @override
  String get qrInvalid => 'Acesta nu este un cod QR Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Camera nu este disponibilă ($error).';
  }

  @override
  String get notificationsTitle => 'Notificări';

  @override
  String get notifChooseHint =>
      'Alege despre ce primești notificări. Totul rămâne vizibil la clopoțel.';

  @override
  String get notifPlanning => 'Program publicat sau modificat';

  @override
  String get notifRequests => 'Cereri: schimburi, concedii, invitații';

  @override
  String get notifMessages => 'Mesaje noi';

  @override
  String get notifOverlap => 'Ture suprapuse între firme';

  @override
  String get notifConflicts => 'Modificările tale înlocuite de alt responsabil';

  @override
  String get notifBilling => 'Mementouri despre abonament';

  @override
  String get pushEnabled => 'Notificările sunt activate pe acest dispozitiv.';

  @override
  String get pushOff => 'Notificările sunt dezactivate pe acest dispozitiv.';

  @override
  String get pushBlocked =>
      'Notificările sunt blocate: permite-le în setările telefonului sau ale browserului.';

  @override
  String get pushUnavailable =>
      'Notificările nu sunt disponibile pe acest dispozitiv.';

  @override
  String get enablePush => 'Activează';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: programul tău a fost publicat sau modificat.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company vrea să te adauge în echipa sa.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name îți propune să devii proprietarul $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name s-a alăturat $company.';
  }

  @override
  String get messagesTab => 'Mesaje';

  @override
  String get wholeTeam => 'Toată echipa';

  @override
  String get newConversation => 'Conversație nouă';

  @override
  String get noMessages => 'Încă nu există mesaje.';

  @override
  String get messageHint => 'Scrie un mesaj';

  @override
  String get earlierMessages => 'Mesaje anterioare';

  @override
  String get personLeftCompany =>
      'Această persoană nu mai face parte din firmă.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Grup nou';

  @override
  String get editGroup => 'Editează grupul';

  @override
  String get groupName => 'Numele grupului';

  @override
  String get groupMembersHint =>
      'Alege persoanele din acest grup. Doar ele vor vedea mesajele.';

  @override
  String get chooseAtLeastOne => 'Alege cel puțin o persoană.';

  @override
  String get replyAction => 'Răspunde';

  @override
  String get translateAction => 'Traduce';

  @override
  String replyingTo(String name) {
    return 'Răspuns pentru $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Ultimele mesaje de la $name';
  }

  @override
  String get deleteAllNotices => 'Șterge tot';

  @override
  String get deleteAllNoticesConfirm => 'Ștergi toate avizele?';

  @override
  String get noticeRetention => 'Șterge avizele citite după';

  @override
  String get retentionDay => '1 zi';

  @override
  String get retentionWeek => '1 săptămână';

  @override
  String get retentionMonth => '1 lună';

  @override
  String get billingOwnersOnly => 'Activ doar dacă deții o firmă.';

  @override
  String get readOnlyPastDays =>
      'Zilele mai vechi de o lună sunt doar pentru citire.';

  @override
  String get wholeCompany => 'Toată firma';

  @override
  String get sitesLabel => 'Puncte de lucru';

  @override
  String get actionSites => 'Puncte de lucru…';

  @override
  String managerOf(String name) {
    return '$name răspunde de';
  }

  @override
  String teamSitesOf(String name) {
    return 'Echipa lui $name';
  }

  @override
  String get notYourSite =>
      'Acest punct de lucru nu este în responsabilitatea ta.';

  @override
  String get chooseYourSite => 'Alege cel puțin un punct de lucru.';
}
