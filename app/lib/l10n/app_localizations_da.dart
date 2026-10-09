// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class L10nDa extends L10n {
  L10nDa([String locale = 'da']) : super(locale);

  @override
  String get cancel => 'Annuller';

  @override
  String get save => 'Gem';

  @override
  String get confirm => 'Bekræft';

  @override
  String get validate => 'Bekræft';

  @override
  String get add => 'Tilføj';

  @override
  String get rename => 'Omdøb';

  @override
  String get delete => 'Slet';

  @override
  String get accept => 'Accepter';

  @override
  String get decline => 'Afvis';

  @override
  String get close => 'Luk';

  @override
  String get retry => 'Prøv igen';

  @override
  String get name => 'Navn';

  @override
  String get serverUnreachable => 'Serveren kan ikke nås.';

  @override
  String errorStatus(int status) {
    return 'Fejl $status';
  }

  @override
  String get roleOwner => 'Ejer';

  @override
  String get roleManager => 'Ansvarlig';

  @override
  String get roleEmployee => 'Medarbejder';

  @override
  String get roleExtra => 'Afløser';

  @override
  String get taglineStart => 'Dit teams vagtplaner, ';

  @override
  String get taglineEnd => 'overalt.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Log ind med Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Login med Google er ikke tilgængeligt: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Login med Google mislykkedes: $detail';
  }

  @override
  String get newCompany => 'Ny virksomhed';

  @override
  String get timezone => 'Tidszone';

  @override
  String get create => 'Opret';

  @override
  String get noCompanyTitle => 'Du er endnu ikke med i nogen virksomhed.';

  @override
  String get noCompanyHint =>
      'Opret en kode, og giv den til din ansvarlige for at blive en del af din arbejdsgivers virksomhed.';

  @override
  String get joinCompany => 'Bliv en del af en virksomhed';

  @override
  String get createCompany => 'Opret en virksomhed';

  @override
  String transferOffer(String company) {
    return 'Du er blevet tilbudt at blive ejer af “$company”.';
  }

  @override
  String get someCompany => 'en virksomhed';

  @override
  String get becameOwner => 'Du er nu ejer.';

  @override
  String get myAccount => 'Min konto';

  @override
  String get idCopied => 'Id kopieret.';

  @override
  String myId(String id) {
    return 'Mit id: $id';
  }

  @override
  String get signOut => 'Log ud';

  @override
  String joinInvite(String company, String role) {
    return '“$company” inviterer dig som $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Du er nu med i $company.';
  }

  @override
  String get viewPlanning => 'Vagtplan';

  @override
  String get viewTeam => 'Team';

  @override
  String get viewPositions => 'Funktioner';

  @override
  String get readOnlyCompany => 'Virksomheden er skrivebeskyttet.';

  @override
  String get team => 'Team';

  @override
  String get leaveCompany => 'Forlad denne virksomhed';

  @override
  String meSuffix(String name) {
    return '$name (dig)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Overdrage virksomheden til $name?';
  }

  @override
  String get transferConfirmBody =>
      'Når personen accepterer, bliver vedkommende ejer (abonnement, fakturaer, ansvarlige), og du bliver ansvarlig.';

  @override
  String transferSent(String name) {
    return 'Tilbud sendt til $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Fjern $name?';
  }

  @override
  String get removeConfirmBody => 'Historikken bevares.';

  @override
  String get addPersonTitle => 'Tilføj en person';

  @override
  String get addPersonHint =>
      'Bed personen åbne Staff Flow, kontomenuen, “Bliv en del af en virksomhed”, og indtast koden, der vises.';

  @override
  String get sixDigitCode => '6-cifret kode';

  @override
  String invitationSent(String name) {
    return 'Invitation sendt til $name: den skal accepteres.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Forlad $company?';
  }

  @override
  String get leaveConfirmBody => 'Du vil ikke længere kunne se dens vagtplan.';

  @override
  String get renameCompany => 'Omdøb virksomheden';

  @override
  String get actionMakeManager => 'Gør til ansvarlig';

  @override
  String get actionMakeEmployee => 'Gør til medarbejder igen';

  @override
  String get actionToEmployee => 'Gør til medarbejder';

  @override
  String get actionToExtra => 'Gør til afløser';

  @override
  String get actionTransfer => 'Overdrag ejerskab';

  @override
  String get actionRemove => 'Fjern fra virksomheden';

  @override
  String get positions => 'Funktioner';

  @override
  String get sites => 'Lokationer';

  @override
  String get positionsHint => 'Hvad personen laver: kasse, køkken, reception…';

  @override
  String get sitesHint =>
      'Hvor vagten foregår, hvis virksomheden har flere lokationer.';

  @override
  String get archived => 'Arkiveret';

  @override
  String get archive => 'Arkivér';

  @override
  String get reactivate => 'Genaktivér';

  @override
  String weekOf(String date) {
    return 'Ugen fra $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ændringer offentliggjort.',
      one: '1 ændring offentliggjort.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Vagt';

  @override
  String get display => 'Visning';

  @override
  String get week => 'Uge';

  @override
  String get month => 'Måned';

  @override
  String get today => 'I dag';

  @override
  String get onlyMine => 'Kun mine vagter';

  @override
  String get replacePersonMenu => 'Erstat en person…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ikke-offentliggjorte ændringer',
      one: '1 ikke-offentliggjort ændring',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Medarbejderne kan ikke se dem endnu.';

  @override
  String get publish => 'Offentliggør';

  @override
  String yourHours(String duration) {
    return 'Dine timer i perioden: $duration';
  }

  @override
  String get addShiftThisDay => 'Tilføj en vagt denne dag';

  @override
  String get noShift => 'Ingen vagter';

  @override
  String get unassigned => 'Ikke tildelt';

  @override
  String get formerMember => 'Tidligere medlem';

  @override
  String get statusDraft => 'Kladde';

  @override
  String get statusModified => 'Ændret';

  @override
  String get statusDeleted => 'Slettet';

  @override
  String durationHours(int hours) {
    return '$hours t';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours t $minutes min';
  }

  @override
  String get editShift => 'Redigér vagt';

  @override
  String get newShift => 'Ny vagt';

  @override
  String get thisShift => 'Kun denne vagt';

  @override
  String get thisAndFollowing => 'Denne og de følgende';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dage',
      one: 'Dag',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Anden dag';

  @override
  String get start => 'Start';

  @override
  String get end => 'Slut';

  @override
  String get endsNextDay => 'Slutter næste dag.';

  @override
  String get person => 'Person';

  @override
  String get position => 'Funktion';

  @override
  String get site => 'Lokation';

  @override
  String get noteOptional => 'Note (valgfri)';

  @override
  String get repetition => 'Gentagelse';

  @override
  String get repeatNone => 'Ingen';

  @override
  String get repeatDaily => 'Hver dag';

  @override
  String get repeatWeekly => 'Hver uge';

  @override
  String get repeatForPrefix => 'I ';

  @override
  String get repeatDaysSuffix => ' dage';

  @override
  String get repeatWeeksSuffix => ' uger';

  @override
  String get repeatUntilPrefix => 'Indtil ';

  @override
  String get replacePersonTitle => 'Erstat en person';

  @override
  String get replaceFrom => 'Erstat';

  @override
  String get replaceBy => 'Med';

  @override
  String dateRange(String from, String to) {
    return 'Fra $from til $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vagter ændret.',
      one: '1 vagt ændret.',
      zero: 'Ingen vagter ændret.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Erstat';

  @override
  String get joinHint =>
      'Giv denne kode til din ansvarlige. Når den er indtastet i appen, får du en invitation.';

  @override
  String get codeExpired => 'Koden er udløbet.';

  @override
  String codeValidFor(String time) {
    return 'Gyldig i $time endnu';
  }

  @override
  String get newCode => 'Ny kode';

  @override
  String get language => 'Sprog';

  @override
  String get languageAuto => 'Automatisk (enhedens sprog)';

  @override
  String get syncUpToDate => 'Opdateret';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Ventende ændringer: $count';
  }

  @override
  String get syncNow => 'Synkronisér nu';

  @override
  String syncRejected(String reason) {
    return 'Ændringen blev afvist af serveren: $reason';
  }

  @override
  String get pendingBadge => 'Venter';

  @override
  String get offlineUnavailable => 'Ikke tilgængelig offline.';

  @override
  String get offlineCached => 'Offline: senest gemte data.';

  @override
  String get savedOffline =>
      'Gemt på enheden, sendes når netværket er tilbage.';

  @override
  String get notices => 'Meddelelser';

  @override
  String get noNotices => 'Ingen meddelelser.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name har erstattet din ændring af vagten den $date.';
  }

  @override
  String get history => 'Historik';

  @override
  String get recentChanges => 'Seneste ændringer';

  @override
  String get undoChange => 'Fortryd denne ændring';

  @override
  String get undoDone => 'Ændringen er fortrudt.';

  @override
  String get historyCreate => 'Oprettet';

  @override
  String get historyUpdate => 'Ændret';

  @override
  String get historyDelete => 'Slettet';

  @override
  String get historyUndo => 'Fortrudt';

  @override
  String get noHistory => 'Ingen ændringer.';

  @override
  String get pendingNotEditable =>
      'Vagten er ikke synkroniseret endnu: prøv igen, når du er online.';

  @override
  String get myQrCode => 'Min QR-kode';

  @override
  String get myQrCodeHint =>
      'En leder scanner koden for at tilføje dig til sin virksomhed; derefter bekræfter du. Den ændres aldrig.';

  @override
  String get changeMyName => 'Skift mit navn';

  @override
  String get nameShownToTeam =>
      'Dette navn vises for dine kolleger i stedet for dit Google-navn.';

  @override
  String googleName(String name) {
    return 'Google-navn: $name';
  }

  @override
  String get useGoogleName => 'Brug mit Google-navn';

  @override
  String renameMemberTitle(String name) {
    return 'Omdøb $name';
  }

  @override
  String get renameMemberHint => 'Dette navn bruges kun i denne virksomhed.';

  @override
  String get useOwnName => 'Brug eget navn';

  @override
  String get scanQrCode => 'Scan en QR-kode';

  @override
  String get scanQrHint =>
      'Ret kameraet mod QR-koden i personens app (kontomenuen, »Min QR-kode«).';

  @override
  String get orEnterCode => 'Eller indtast personens 6-cifrede kode';

  @override
  String get qrInvalid => 'Dette er ikke en Staff Flow-QR-kode.';

  @override
  String cameraUnavailable(String error) {
    return 'Kameraet er ikke tilgængeligt ($error).';
  }

  @override
  String get notificationsTitle => 'Notifikationer';

  @override
  String get notifChooseHint =>
      'Vælg, hvad du vil have besked om. Alt er stadig synligt under klokken.';

  @override
  String get notifPlanning => 'Vagtplan offentliggjort eller ændret';

  @override
  String get notifRequests => 'Anmodninger: bytte, ferie, invitationer';

  @override
  String get notifMessages => 'Nye beskeder';

  @override
  String get notifOverlap => 'Overlappende vagter mellem virksomheder';

  @override
  String get notifConflicts => 'Dine ændringer erstattet af en anden leder';

  @override
  String get notifBilling => 'Påmindelser om abonnement';

  @override
  String get pushEnabled => 'Notifikationer er slået til på denne enhed.';

  @override
  String get pushOff => 'Notifikationer er slået fra på denne enhed.';

  @override
  String get pushBlocked =>
      'Notifikationer er blokeret: tillad dem i telefonens eller browserens indstillinger.';

  @override
  String get pushUnavailable =>
      'Notifikationer er ikke tilgængelige på denne enhed.';

  @override
  String get enablePush => 'Slå til';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: din vagtplan er offentliggjort eller ændret.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company vil tilføje dig til sit team.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name foreslår, at du bliver ejer af $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name er blevet en del af $company.';
  }

  @override
  String get messagesTab => 'Beskeder';

  @override
  String get wholeTeam => 'Hele teamet';

  @override
  String get newConversation => 'Ny samtale';

  @override
  String get noMessages => 'Ingen beskeder endnu.';

  @override
  String get messageHint => 'Skriv en besked';

  @override
  String get earlierMessages => 'Tidligere beskeder';

  @override
  String get personLeftCompany =>
      'Denne person er ikke længere en del af virksomheden.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Ny gruppe';

  @override
  String get editGroup => 'Rediger gruppe';

  @override
  String get groupName => 'Gruppenavn';

  @override
  String get groupMembersHint =>
      'Vælg personerne i gruppen. Kun de kan se dens beskeder.';

  @override
  String get chooseAtLeastOne => 'Vælg mindst én person.';

  @override
  String get replyAction => 'Svar';

  @override
  String get translateAction => 'Oversæt';

  @override
  String replyingTo(String name) {
    return 'Svar til $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Seneste beskeder fra $name';
  }

  @override
  String get deleteAllNotices => 'Slet alle';

  @override
  String get deleteAllNoticesConfirm => 'Slet alle notifikationer?';

  @override
  String get noticeRetention => 'Slet læste notifikationer efter';

  @override
  String get retentionDay => '1 dag';

  @override
  String get retentionWeek => '1 uge';

  @override
  String get retentionMonth => '1 måned';

  @override
  String get billingOwnersOnly => 'Kun aktiv, hvis du ejer en virksomhed.';

  @override
  String get readOnlyPastDays =>
      'Dage, der er mere end en måned gamle, er skrivebeskyttede.';

  @override
  String get wholeCompany => 'Hele virksomheden';

  @override
  String get sitesLabel => 'Steder';

  @override
  String get actionSites => 'Steder…';

  @override
  String managerOf(String name) {
    return '$name har ansvaret for';
  }

  @override
  String teamSitesOf(String name) {
    return '${name}s team';
  }

  @override
  String get notYourSite => 'Dette sted er ikke dit ansvar.';

  @override
  String get chooseYourSite => 'Vælg mindst ét sted.';

  @override
  String get viewRequests => 'Anmodninger';

  @override
  String get newRequest => 'Ny anmodning';

  @override
  String get requestLeave => 'Ferie';

  @override
  String get requestUnavailability => 'Utilgængelighed';

  @override
  String get requestSwap => 'Vagtbytte';

  @override
  String get swapHint =>
      'Tryk på en af dine kommende vagter i vagtplanen for at tilbyde et bytte.';

  @override
  String get noRequests => 'Ingen anmodninger endnu.';

  @override
  String get requestsToHandle => 'Til behandling';

  @override
  String get myRequests => 'Mine anmodninger';

  @override
  String get otherRequests => 'Teamets anmodninger';

  @override
  String get statusPendingPeer => 'Venter på kollegaen';

  @override
  String get statusPendingManager => 'Venter på en leder';

  @override
  String get statusApproved => 'Godkendt';

  @override
  String get statusRefused => 'Afvist';

  @override
  String get statusCancelled => 'Annulleret';

  @override
  String get cancelRequest => 'Annullér anmodning';

  @override
  String get acceptSwap => 'Tag denne vagt';

  @override
  String get approve => 'Godkend';

  @override
  String periodLabel(String from, String to) {
    return 'Fra $from til $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Tilbudt til $name';
  }

  @override
  String get swapToTeam => 'Hele teamet';

  @override
  String everyWeekdays(String days) {
    return 'Hver uge: $days';
  }

  @override
  String get unavailableEveryWeek => 'Dage hvor du aldrig er tilgængelig:';

  @override
  String get choosePeriod => 'Vælg datoer';

  @override
  String get choosePeriodOptional => 'Begræns til en periode (valgfrit)';

  @override
  String get clearPeriod => 'Ingen periode';

  @override
  String get sendRequest => 'Send anmodning';

  @override
  String get proposeSwap => 'Tilbyd et bytte';

  @override
  String get swapWith => 'Tilbyd til';

  @override
  String get swapSteps =>
      'Kollegaen accepterer, derefter godkender en leder. Vagtplanen ændres først da.';

  @override
  String get absentThatDay => 'Godkendt fravær den dag';

  @override
  String get requestSent => 'Anmodning sendt.';

  @override
  String noticeSwapOffer(String name) {
    return '$name tilbyder dig en af sine vagter.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name afslog dit bytteforslag.';
  }

  @override
  String get noticeSwapToApprove => 'Et vagtbytte venter på din godkendelse.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name beder om fri.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name melder sig utilgængelig.';
  }

  @override
  String get noticeRequestApproved => 'Din anmodning er godkendt.';

  @override
  String get noticeRequestRefused => 'Din anmodning er afvist.';

  @override
  String get choosePeer => 'Hvem overtager vagten?';

  @override
  String get discardAll => 'Fortryd alt';

  @override
  String get notifySitesHint =>
      'Vælg de steder, du får notifikationer om anmodninger fra. Alle anmodninger er stadig synlige på listen.';

  @override
  String get notifySitesTitle => 'Notifikationer pr. sted';

  @override
  String get pendingRequestTooltip => 'Ventende anmodning: tryk for at åbne';

  @override
  String get requestsHistory => 'Alle anmodninger';

  @override
  String get revertChange => 'Fortryd denne ændring';

  @override
  String get statusExpired => 'Ikke længere aktuel';

  @override
  String get swapWithHint => 'Tryk for at vælge en bestemt kollega';

  @override
  String changesDiscarded(String count) {
    return 'Fortrudte ændringer: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Fortryd de $count ikke-offentliggjorte ændringer?';
  }

  @override
  String get allSchedules => 'Alle mine vagtplaner';

  @override
  String get busyElsewhere =>
      'Arbejder allerede i en anden virksomhed på dette tidspunkt';

  @override
  String get overlapTooltip => 'Overlapper en vagt i en anden virksomhed';

  @override
  String get overlapWarning =>
      'Nogle af dine vagter i to virksomheder overlapper.';

  @override
  String noticeOverlap(String date) {
    return 'To af dine vagter i forskellige virksomheder overlapper den $date.';
  }

  @override
  String get allMyCompanies => 'Alle mine virksomheder';

  @override
  String get deleteGroup => 'Slet gruppen';

  @override
  String get openRequest => 'Se anmodningen';

  @override
  String get thisCompany => 'Denne virksomhed';

  @override
  String get withExtras => 'Med afløsere';

  @override
  String deleteGroupConfirm(String name) {
    return 'Slet “$name” og alle beskeder for alle?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Fra $company: tilføjes som forstærkning og får besked.';
  }

  @override
  String get addToGoogle => 'Føj til Google Kalender';

  @override
  String get calendarEnabled => 'Synkroniser mine vagter';

  @override
  String get calendarHint =>
      'Føj dine vagter fra alle dine virksomheder til Google Kalender. De opdaterer sig selv, og du kan slå det fra når som helst.';

  @override
  String get changeSettings => 'Rediger';

  @override
  String get copyCalendarLink => 'Kopiér kalenderlink';

  @override
  String get countryBelgium => 'Belgien';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryFrance => 'Frankrig';

  @override
  String get countrySwitzerland => 'Schweiz';

  @override
  String get employeesSection => 'Medarbejdere';

  @override
  String get emptyNoAlert => 'Tomt: ingen advarsel';

  @override
  String get extrasSection => 'Afløsere';

  @override
  String get googleCalendar => 'Google Kalender';

  @override
  String get hoursTotals => 'Timetotaler';

  @override
  String get legalAlerts => 'Lovpligtige advarsler';

  @override
  String get legalAlertsHint =>
      'Advarsler, aldrig blokeringer. Vælg de regler, der gælder for dig, eller ingen.';

  @override
  String get legalPreset => 'Landeskabelon';

  @override
  String get linkCopied => 'Link kopieret.';

  @override
  String get maxConsecutiveLabel => 'Højst antal arbejdsdage i træk';

  @override
  String get maxDayLabel => 'Længste varighed pr. dag (timer)';

  @override
  String get maxWeekLabel => 'Længste varighed pr. uge (timer)';

  @override
  String get minRestLabel => 'Mindste hvile mellem to vagter (timer)';

  @override
  String get noLegalRules => 'Ingen advarsler valgt.';

  @override
  String get presetNone => 'Ingen';

  @override
  String get presetsCheck =>
      'Skabelonerne er et udgangspunkt: tjek dem efter dit lands regler og din overenskomst.';

  @override
  String get printMine => 'Min vagtplan';

  @override
  String get printOwn => 'Kun deres egen vagtplan';

  @override
  String get printPdf => 'Udskriv / PDF';

  @override
  String get printRights => 'Hvad medarbejdere må udskrive';

  @override
  String get printTeam => 'Hele holdets vagtplan';

  @override
  String get printTeamOption => 'Holdets vagtplan';

  @override
  String get totalsHint =>
      'Kladder medregnet. Excel- og CSV-eksport bruger den offentliggjorte vagtplan.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value dage i træk (højst $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value på dagen (højst $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: kun $value hvile (mindst $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value på ugen (højst $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Lovpligtige advarsler: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Vagter: $count';
  }

  @override
  String get actionMakeDeputy => 'Udnævn til stedfortrædende leder';

  @override
  String get actionRemoveDeputy => 'Fjern rollen som stedfortræder';

  @override
  String get busyHere => 'Arbejder allerede i virksomheden på dette tidspunkt';

  @override
  String get calendarByLink => 'Via link (Google Kalender på en computer)';

  @override
  String get calendarDenied =>
      'Adgang til kalenderen afvist. Tillad den i telefonens indstillinger.';

  @override
  String get calendarLinkHint =>
      'Tilføj via Google Kalender på en computer; Google opdaterer inden for nogle timer.';

  @override
  String get calendarNone => 'Ingen redigerbar kalender på denne telefon.';

  @override
  String get calendarOnPhone => 'Tilføj mine vagter til telefonens kalender';

  @override
  String get calendarOnPhoneHint =>
      'I din Google-kalender: synlig med det samme, på telefonen og i Google Kalender.';

  @override
  String get chooseCalendar => 'Vælg kalender';

  @override
  String get otherSiteHint =>
      'Medarbejder fra et andet sted: vedkommendes ledere får besked.';

  @override
  String get subManager => 'Stedfortrædende leder';

  @override
  String calendarSynced(String count) {
    return 'Vagter i kalenderen: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Stedfortrædende leder: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by har sat $name på $site den $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company har tilføjet dig som forstærkning.';
  }
}
