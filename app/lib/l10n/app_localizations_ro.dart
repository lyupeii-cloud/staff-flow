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

  @override
  String get viewRequests => 'Cereri';

  @override
  String get newRequest => 'Cerere nouă';

  @override
  String get requestLeave => 'Concediu';

  @override
  String get requestUnavailability => 'Indisponibilitate';

  @override
  String get requestSwap => 'Schimb de tură';

  @override
  String get swapHint =>
      'Pentru a propune un schimb, atinge una dintre turele tale viitoare din planificare.';

  @override
  String get noRequests => 'Încă nu există cereri.';

  @override
  String get requestsToHandle => 'De rezolvat';

  @override
  String get myRequests => 'Cererile mele';

  @override
  String get otherRequests => 'Cererile echipei';

  @override
  String get statusPendingPeer => 'Așteaptă colegul';

  @override
  String get statusPendingManager => 'Așteaptă responsabilul';

  @override
  String get statusApproved => 'Acceptată';

  @override
  String get statusRefused => 'Refuzată';

  @override
  String get statusCancelled => 'Anulată';

  @override
  String get cancelRequest => 'Anulează cererea';

  @override
  String get acceptSwap => 'Preia această tură';

  @override
  String get approve => 'Validează';

  @override
  String periodLabel(String from, String to) {
    return 'De la $from până la $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Propus lui $name';
  }

  @override
  String get swapToTeam => 'Toată echipa';

  @override
  String everyWeekdays(String days) {
    return 'În fiecare săptămână: $days';
  }

  @override
  String get unavailableEveryWeek =>
      'Zile în care nu ești niciodată disponibil:';

  @override
  String get choosePeriod => 'Alege datele';

  @override
  String get choosePeriodOptional => 'Limitează la o perioadă (opțional)';

  @override
  String get clearPeriod => 'Fără perioadă';

  @override
  String get sendRequest => 'Trimite cererea';

  @override
  String get proposeSwap => 'Propune un schimb';

  @override
  String get swapWith => 'Propune lui';

  @override
  String get swapSteps =>
      'Colegul acceptă, apoi un responsabil validează. Planificarea se schimbă doar după aceea.';

  @override
  String get absentThatDay => 'Absență validată în acea zi';

  @override
  String get requestSent => 'Cerere trimisă.';

  @override
  String noticeSwapOffer(String name) {
    return '$name îți propune una dintre turele sale.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name a refuzat propunerea ta de schimb.';
  }

  @override
  String get noticeSwapToApprove => 'Un schimb de tură așteaptă validarea ta.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name cere concediu.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name anunță că nu este disponibil.';
  }

  @override
  String get noticeRequestApproved => 'Cererea ta a fost acceptată.';

  @override
  String get noticeRequestRefused => 'Cererea ta a fost refuzată.';

  @override
  String get choosePeer => 'Cine preia această tură?';

  @override
  String get discardAll => 'Anulează tot';

  @override
  String get notifySitesHint =>
      'Alege locațiile pentru care primești notificări despre cereri. Toate cererile rămân vizibile în listă.';

  @override
  String get notifySitesTitle => 'Notificări pe locație';

  @override
  String get pendingRequestTooltip =>
      'Cerere în așteptare: atinge pentru a o deschide';

  @override
  String get requestsHistory => 'Toate cererile';

  @override
  String get revertChange => 'Anulează această modificare';

  @override
  String get statusExpired => 'Fără obiect';

  @override
  String get swapWithHint => 'Atinge pentru a alege un anumit coleg';

  @override
  String changesDiscarded(String count) {
    return 'Modificări anulate: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Anulezi cele $count modificări nepublicate?';
  }

  @override
  String get allSchedules => 'Toate planificările mele';

  @override
  String get busyElsewhere => 'Lucrează deja la altă firmă în acest interval';

  @override
  String get overlapTooltip => 'Se suprapune cu o tură de la altă firmă';

  @override
  String get overlapWarning =>
      'Unele dintre turele tale de la două firme se suprapun.';

  @override
  String noticeOverlap(String date) {
    return 'Două dintre turele tale de la firme diferite se suprapun pe $date.';
  }

  @override
  String get allMyCompanies => 'Toate firmele mele';

  @override
  String get deleteGroup => 'Șterge grupul';

  @override
  String get openRequest => 'Vezi cererea';

  @override
  String get thisCompany => 'Această firmă';

  @override
  String get withExtras => 'Cu colaboratorii';

  @override
  String deleteGroupConfirm(String name) {
    return 'Ștergi „$name” și toate mesajele pentru toți?';
  }

  @override
  String reinforcementHint(String company) {
    return 'De la $company: va fi adăugat ca întăritură și anunțat.';
  }

  @override
  String get addToGoogle => 'Adaugă în Google Calendar';

  @override
  String get calendarEnabled => 'Sincronizează turele mele';

  @override
  String get calendarHint =>
      'Adaugă turele din toate firmele tale în Google Calendar. Se actualizează singure și poți dezactiva oricând.';

  @override
  String get changeSettings => 'Modifică';

  @override
  String get copyCalendarLink => 'Copiază linkul calendarului';

  @override
  String get countryBelgium => 'Belgia';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryFrance => 'Franța';

  @override
  String get countrySwitzerland => 'Elveția';

  @override
  String get employeesSection => 'Angajați';

  @override
  String get emptyNoAlert => 'Gol: fără alertă';

  @override
  String get extrasSection => 'Colaboratori';

  @override
  String get googleCalendar => 'Google Calendar';

  @override
  String get hoursTotals => 'Totaluri de ore';

  @override
  String get legalAlerts => 'Alerte legale';

  @override
  String get legalAlertsHint =>
      'Avertismente, niciodată blocări. Alege regulile care se aplică la tine, sau niciuna.';

  @override
  String get legalPreset => 'Model pe țară';

  @override
  String get linkCopied => 'Link copiat.';

  @override
  String get maxConsecutiveLabel => 'Maximum de zile lucrate la rând';

  @override
  String get maxDayLabel => 'Durată maximă pe zi (ore)';

  @override
  String get maxWeekLabel => 'Durată maximă pe săptămână (ore)';

  @override
  String get minRestLabel => 'Repaus minim între două ture (ore)';

  @override
  String get noLegalRules => 'Nicio alertă aleasă.';

  @override
  String get presetNone => 'Niciuna';

  @override
  String get presetsCheck =>
      'Modelele sunt un punct de plecare: verifică-le după legislația țării tale și contractul colectiv.';

  @override
  String get printMine => 'Planificarea mea';

  @override
  String get printOwn => 'Doar propria planificare';

  @override
  String get printPdf => 'Tipărire / PDF';

  @override
  String get printRights => 'Ce pot tipări angajații';

  @override
  String get printTeam => 'Planificarea întregii echipe';

  @override
  String get printTeamOption => 'Planificarea echipei';

  @override
  String get totalsHint =>
      'Inclusiv ciornele. Exporturile Excel și CSV folosesc planificarea publicată.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value zile la rând (maximum $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value într-o zi (maximum $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: doar $value de repaus (minimum $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value într-o săptămână (maximum $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Alerte legale: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Ture: $count';
  }

  @override
  String get actionMakeDeputy => 'Numește adjunct al responsabilului';

  @override
  String get actionRemoveDeputy => 'Retrage rolul de adjunct';

  @override
  String get busyHere => 'Lucrează deja în firmă în acest interval';

  @override
  String get calendarByLink => 'Prin link (Google Calendar pe calculator)';

  @override
  String get calendarDenied =>
      'Accesul la calendar a fost refuzat. Permite-l din setările telefonului.';

  @override
  String get calendarLinkHint =>
      'Adaugă-l din Google Calendar pe un calculator; Google îl actualizează în câteva ore.';

  @override
  String get calendarNone => 'Niciun calendar editabil pe acest telefon.';

  @override
  String get calendarOnPhone => 'Adaugă turele mele în calendarul telefonului';

  @override
  String get calendarOnPhoneHint =>
      'În calendarul tău Google: vizibil imediat, pe telefon și în Google Calendar.';

  @override
  String get chooseCalendar => 'Alege calendarul';

  @override
  String get otherSiteHint =>
      'Angajat de la altă locație: responsabilii lui vor fi anunțați.';

  @override
  String get subManager => 'Adjunct al responsabilului';

  @override
  String calendarSynced(String count) {
    return 'Ture în calendar: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Adjunct al responsabilului: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by l-a programat pe $name la locația $site pe $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company te-a adăugat ca întăritură.';
  }

  @override
  String get companyNotificationsHint =>
      'Oprite: nu sună nimic pe acest telefon, dar totul rămâne în clopoțel.';

  @override
  String get companyNotificationsOn => 'Primește notificările acestei firme';

  @override
  String get companyTimezone => 'Fusul orar al firmei';

  @override
  String get companyTimezoneHint =>
      'Toate orele acestei firme sunt în acest fus (inclusiv ora de vară). Calendarele le convertesc automat.';

  @override
  String get iosInstallHint =>
      'Pe iPhone: atinge Partajează, apoi „Adaugă pe ecranul principal” pentru a instala Staff Flow.';

  @override
  String get searchCity => 'Caută un oraș';

  @override
  String get thisPhone => 'Acest dispozitiv';

  @override
  String companyNotifications(String name) {
    return 'Notificări: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Ore după ora din $zone ($company). Dispozitivul tău: $here.';
  }

  @override
  String get addPreset => 'Adaugă presetarea';

  @override
  String get addPresets => 'Creează presetări';

  @override
  String get appearance => 'Aspect';

  @override
  String get chooseLogo => 'Alege o imagine PNG';

  @override
  String get conversationMuted =>
      'Notificări oprite pentru această conversație.';

  @override
  String get conversationUnmuted =>
      'Notificări repornite pentru această conversație.';

  @override
  String get customization => 'Personalizare';

  @override
  String get disableGroup => 'Dezactivează grupul';

  @override
  String get disableGroupConfirm =>
      'Grupul întregii firme va fi ascuns pentru toți. Îl poți reactiva din Mesaje.';

  @override
  String get editPresets => 'Presetări';

  @override
  String get enable => 'Reactivează';

  @override
  String get groupDisabled => 'Grup dezactivat (doar tu îl vezi)';

  @override
  String get logoHint =>
      'O imagine PNG mică (logoul tău) afișată pe fila firmei, pentru toți membrii.';

  @override
  String get logoPngOnly => 'Alege o imagine PNG de cel mult 1 MB.';

  @override
  String get muteConversation => 'Oprește notificările acestei conversații';

  @override
  String get myIdentifier => 'Identificatorul meu';

  @override
  String get myProfile => 'Profilul meu';

  @override
  String get presetName => 'Nume (ex. Dimineață)';

  @override
  String get removeLogo => 'Elimină imaginea';

  @override
  String get resetGroup => 'Resetează grupul';

  @override
  String get resetGroupConfirm =>
      'Toate mesajele din grupul firmei vor fi șterse pentru toți.';

  @override
  String get settingsTitle => 'Setări';

  @override
  String get shiftPresets => 'Presetări de ore';

  @override
  String get shiftPresetsHint =>
      'Ore gata făcute (dimineață, seară, noapte…): o atingere într-o tură completează începutul și sfârșitul.';

  @override
  String get themeDark => 'Întunecat';

  @override
  String get themeLight => 'Luminos';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get unmuteConversation =>
      'Repornește notificările acestei conversații';

  @override
  String get awaitingApproval => 'De aprobat';

  @override
  String get placementNeedsApproval =>
      '! Această persoană nu este din punctele dvs. de lucru: tura va aștepta aprobarea superiorului sau a proprietarului înainte de a putea fi publicată. Altfel, alegeți pe altcineva.';

  @override
  String get placementAwaiting =>
      'Așteaptă aprobarea unui superior sau a proprietarului.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by vrea să programeze pe $name, de la alt punct de lucru, pe $date: necesită aprobare.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by a aprobat programarea lui $name pe $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by a refuzat programarea lui $name pe $date.';
  }

  @override
  String get addSubSite => 'Adaugă un sub-punct de lucru';

  @override
  String get moveSite => 'Mută';

  @override
  String get topLevel => 'Primul nivel';

  @override
  String moveSiteTitle(String name) {
    return 'Mută „$name” sub…';
  }

  @override
  String subSiteOf(String name) {
    return 'Sub-punct al $name';
  }

  @override
  String get siteTreeHint =>
      'Până la 3 niveluri, de ex. Regiune › Oraș › Magazin. Responsabilul unui punct de lucru gestionează și tot ce e sub el.';

  @override
  String get subSitesOnlyHint =>
      'Aici adăugați sub-puncte de lucru sub propriile puncte.';
}
