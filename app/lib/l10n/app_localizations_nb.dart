// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class L10nNb extends L10n {
  L10nNb([String locale = 'nb']) : super(locale);

  @override
  String get cancel => 'Avbryt';

  @override
  String get save => 'Lagre';

  @override
  String get confirm => 'Bekreft';

  @override
  String get validate => 'Bekreft';

  @override
  String get add => 'Legg til';

  @override
  String get rename => 'Gi nytt navn';

  @override
  String get delete => 'Slett';

  @override
  String get accept => 'Godta';

  @override
  String get decline => 'Avslå';

  @override
  String get close => 'Lukk';

  @override
  String get retry => 'Prøv igjen';

  @override
  String get name => 'Navn';

  @override
  String get serverUnreachable => 'Får ikke kontakt med serveren.';

  @override
  String errorStatus(int status) {
    return 'Feil $status';
  }

  @override
  String get roleOwner => 'Eier';

  @override
  String get roleManager => 'Ansvarlig';

  @override
  String get roleEmployee => 'Ansatt';

  @override
  String get roleExtra => 'Ekstrahjelp';

  @override
  String get taglineStart => 'Teamets vaktplaner, ';

  @override
  String get taglineEnd => 'overalt.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Logg på med Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Pålogging med Google er ikke tilgjengelig: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Pålogging med Google mislyktes: $detail';
  }

  @override
  String get newCompany => 'Ny bedrift';

  @override
  String get timezone => 'Tidssone';

  @override
  String get create => 'Opprett';

  @override
  String get noCompanyTitle => 'Du er ikke med i noen bedrift ennå.';

  @override
  String get noCompanyHint =>
      'For å bli med i arbeidsgiverens bedrift, lag en kode og gi den til den ansvarlige.';

  @override
  String get joinCompany => 'Bli med i en bedrift';

  @override
  String get createCompany => 'Opprett en bedrift';

  @override
  String transferOffer(String company) {
    return 'Du er blitt tilbudt å bli eier av «$company».';
  }

  @override
  String get someCompany => 'en bedrift';

  @override
  String get becameOwner => 'Du er nå eier.';

  @override
  String get myAccount => 'Min konto';

  @override
  String get idCopied => 'ID kopiert.';

  @override
  String myId(String id) {
    return 'Min ID: $id';
  }

  @override
  String get signOut => 'Logg av';

  @override
  String joinInvite(String company, String role) {
    return '«$company» inviterer deg som $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Du er nå med i $company.';
  }

  @override
  String get viewPlanning => 'Vaktplan';

  @override
  String get viewTeam => 'Ledelse';

  @override
  String get viewPositions => 'Stillinger';

  @override
  String get readOnlyCompany => 'Bedriften er skrivebeskyttet.';

  @override
  String get team => 'Team';

  @override
  String get leaveCompany => 'Forlat denne bedriften';

  @override
  String meSuffix(String name) {
    return '$name (deg)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Overføre bedriften til $name?';
  }

  @override
  String get transferConfirmBody =>
      'Når personen godtar, blir vedkommende eier (abonnement, fakturaer, ansvarlige), og du blir ansvarlig.';

  @override
  String transferSent(String name) {
    return 'Tilbud sendt til $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Fjerne $name?';
  }

  @override
  String get removeConfirmBody => 'Historikken beholdes.';

  @override
  String get addPersonTitle => 'Legg til en person';

  @override
  String get addPersonHint =>
      'Be personen åpne Staff Flow, kontomenyen, «Bli med i en bedrift», og skriv inn koden som vises.';

  @override
  String get sixDigitCode => 'Sekssifret kode';

  @override
  String invitationSent(String name) {
    return 'Invitasjon sendt til $name: den må godtas.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Forlate $company?';
  }

  @override
  String get leaveConfirmBody => 'Du vil ikke lenger se vaktplanen.';

  @override
  String get renameCompany => 'Gi bedriften nytt navn';

  @override
  String get actionMakeManager => 'Gjør til ansvarlig';

  @override
  String get actionMakeEmployee => 'Gjør til ansatt igjen';

  @override
  String get actionToEmployee => 'Gjør til ansatt';

  @override
  String get actionToExtra => 'Gjør til ekstrahjelp';

  @override
  String get actionTransfer => 'Overfør eierskap';

  @override
  String get actionRemove => 'Fjern fra bedriften';

  @override
  String get positions => 'Stillinger';

  @override
  String get sites => 'Steder';

  @override
  String get positionsHint => 'Hva personen gjør: kasse, kjøkken, resepsjon…';

  @override
  String get sitesHint =>
      'Hvor vakten foregår, hvis bedriften har flere steder.';

  @override
  String get archived => 'Arkivert';

  @override
  String get archive => 'Arkiver';

  @override
  String get reactivate => 'Aktiver igjen';

  @override
  String weekOf(String date) {
    return 'Uken fra $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count endringer publisert.',
      one: '1 endring publisert.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Vakt';

  @override
  String get display => 'Visning';

  @override
  String get week => 'Uke';

  @override
  String get month => 'Måned';

  @override
  String get today => 'I dag';

  @override
  String get onlyMine => 'Bare mine vakter';

  @override
  String get replacePersonMenu => 'Erstatt en person…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count upubliserte endringer',
      one: '1 upublisert endring',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'De ansatte ser dem ikke ennå.';

  @override
  String get publish => 'Publiser';

  @override
  String yourHours(String duration) {
    return 'Timene dine i perioden: $duration';
  }

  @override
  String get addShiftThisDay => 'Legg til en vakt denne dagen';

  @override
  String get noShift => 'Ingen vakter';

  @override
  String get unassigned => 'Ikke tildelt';

  @override
  String get formerMember => 'Tidligere medlem';

  @override
  String get statusDraft => 'Utkast';

  @override
  String get statusModified => 'Endret';

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
  String get editShift => 'Rediger vakt';

  @override
  String get newShift => 'Ny vakt';

  @override
  String get thisShift => 'Bare denne vakten';

  @override
  String get thisAndFollowing => 'Denne og de neste';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dager',
      one: 'Dag',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Annen dag';

  @override
  String get start => 'Start';

  @override
  String get end => 'Slutt';

  @override
  String get endsNextDay => 'Slutter neste dag.';

  @override
  String get person => 'Person';

  @override
  String get position => 'Stilling';

  @override
  String get site => 'Sted';

  @override
  String get noteOptional => 'Notat (valgfritt)';

  @override
  String get repetition => 'Gjentakelse';

  @override
  String get repeatNone => 'Ingen';

  @override
  String get repeatDaily => 'Hver dag';

  @override
  String get repeatWeekly => 'Hver uke';

  @override
  String get repeatForPrefix => 'I ';

  @override
  String get repeatDaysSuffix => ' dager';

  @override
  String get repeatWeeksSuffix => ' uker';

  @override
  String get repeatUntilPrefix => 'Til ';

  @override
  String get replacePersonTitle => 'Erstatt en person';

  @override
  String get replaceFrom => 'Erstatt';

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
      other: '$count vakter endret.',
      one: '1 vakt endret.',
      zero: 'Ingen vakter endret.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Erstatt';

  @override
  String get joinHint =>
      'Gi denne koden til den ansvarlige. Når den er skrevet inn i appen, får du en invitasjon.';

  @override
  String get codeExpired => 'Koden er utløpt.';

  @override
  String codeValidFor(String time) {
    return 'Gyldig i $time til';
  }

  @override
  String get newCode => 'Ny kode';

  @override
  String get language => 'Språk';

  @override
  String get languageAuto => 'Automatisk (enhetens språk)';

  @override
  String get syncUpToDate => 'Oppdatert';

  @override
  String get syncOffline => 'Frakoblet';

  @override
  String syncPending(int count) {
    return 'Ventende endringer: $count';
  }

  @override
  String get syncNow => 'Synkroniser nå';

  @override
  String syncRejected(String reason) {
    return 'Endringen ble avvist av serveren: $reason';
  }

  @override
  String get pendingBadge => 'Venter';

  @override
  String get offlineUnavailable => 'Ikke tilgjengelig frakoblet.';

  @override
  String get offlineCached => 'Frakoblet: sist lagrede data.';

  @override
  String get savedOffline => 'Lagret på enheten, sendes når nettet er tilbake.';

  @override
  String get notices => 'Varsler';

  @override
  String get noNotices => 'Ingen varsler.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name erstattet endringen din av vakten $date.';
  }

  @override
  String get history => 'Historikk';

  @override
  String get recentChanges => 'Siste endringer';

  @override
  String get undoChange => 'Angre denne endringen';

  @override
  String get undoDone => 'Endringen er angret.';

  @override
  String get historyCreate => 'Opprettet';

  @override
  String get historyUpdate => 'Endret';

  @override
  String get historyDelete => 'Slettet';

  @override
  String get historyUndo => 'Angret';

  @override
  String get noHistory => 'Ingen endringer.';

  @override
  String get pendingNotEditable =>
      'Vakten er ikke synkronisert ennå: prøv igjen når du er tilkoblet.';

  @override
  String get myQrCode => 'Min QR-kode';

  @override
  String get myQrCodeHint =>
      'En leder skanner koden for å legge deg til i bedriften sin; deretter bekrefter du. Den endres aldri.';

  @override
  String get changeMyName => 'Endre navnet mitt';

  @override
  String get nameShownToTeam =>
      'Dette navnet vises for kollegene dine i stedet for Google-navnet ditt.';

  @override
  String googleName(String name) {
    return 'Google-navn: $name';
  }

  @override
  String get useGoogleName => 'Bruk Google-navnet mitt';

  @override
  String renameMemberTitle(String name) {
    return 'Gi nytt navn til $name';
  }

  @override
  String get renameMemberHint => 'Dette navnet brukes bare i denne bedriften.';

  @override
  String get useOwnName => 'Bruk eget navn';

  @override
  String get scanQrCode => 'Skann en QR-kode';

  @override
  String get scanQrHint =>
      'Rett kameraet mot QR-koden i personens app (kontomenyen, «Min QR-kode»).';

  @override
  String get orEnterCode => 'Eller skriv inn personens 6-sifrede kode';

  @override
  String get qrInvalid => 'Dette er ikke en QR-kode fra Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Kameraet er ikke tilgjengelig ($error).';
  }

  @override
  String get notificationsTitle => 'Varsler';

  @override
  String get notifChooseHint =>
      'Velg hva du vil få varsler om. Alt er fortsatt synlig under bjella.';

  @override
  String get notifPlanning => 'Vaktplan publisert eller endret';

  @override
  String get notifRequests => 'Forespørsler: bytte, fravær, invitasjoner';

  @override
  String get notifMessages => 'Nye meldinger';

  @override
  String get notifOverlap => 'Overlappende vakter mellom bedrifter';

  @override
  String get notifConflicts => 'Endringene dine erstattet av en annen leder';

  @override
  String get notifBilling => 'Påminnelser om abonnement';

  @override
  String get pushEnabled => 'Varsler er på for denne enheten.';

  @override
  String get pushOff => 'Varsler er av på denne enheten.';

  @override
  String get pushBlocked =>
      'Varsler er blokkert: tillat dem i innstillingene på telefonen eller i nettleseren.';

  @override
  String get pushUnavailable =>
      'Varsler er ikke tilgjengelige på denne enheten.';

  @override
  String get enablePush => 'Slå på';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: vaktplanen din er publisert eller endret.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company vil legge deg til i teamet sitt.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name foreslår at du blir eier av $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name har blitt med i $company.';
  }

  @override
  String get messagesTab => 'Meldinger';

  @override
  String get wholeTeam => 'Hele teamet';

  @override
  String get newConversation => 'Ny samtale';

  @override
  String get noMessages => 'Ingen meldinger ennå.';

  @override
  String get messageHint => 'Skriv en melding';

  @override
  String get earlierMessages => 'Tidligere meldinger';

  @override
  String get personLeftCompany =>
      'Denne personen er ikke lenger en del av bedriften.';

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
      'Velg personene i gruppen. Bare de ser meldingene.';

  @override
  String get chooseAtLeastOne => 'Velg minst én person.';

  @override
  String get replyAction => 'Svar';

  @override
  String get translateAction => 'Oversett';

  @override
  String replyingTo(String name) {
    return 'Svar til $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Siste meldinger fra $name';
  }

  @override
  String get deleteAllNotices => 'Slett alle';

  @override
  String get deleteAllNoticesConfirm => 'Slette alle varsler?';

  @override
  String get noticeRetention => 'Slett leste varsler etter';

  @override
  String get retentionDay => '1 dag';

  @override
  String get retentionWeek => '1 uke';

  @override
  String get retentionMonth => '1 måned';

  @override
  String get billingOwnersOnly => 'Bare aktiv hvis du eier en bedrift.';

  @override
  String get readOnlyPastDays =>
      'Dager som er mer enn en måned gamle, er skrivebeskyttet.';

  @override
  String get wholeCompany => 'Hele bedriften';

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
    return 'Teamet til $name';
  }

  @override
  String get notYourSite => 'Dette stedet er ikke ditt ansvar.';

  @override
  String get chooseYourSite => 'Velg minst ett sted.';

  @override
  String get viewRequests => 'Forespørsler';

  @override
  String get newRequest => 'Ny forespørsel';

  @override
  String get requestLeave => 'Fri';

  @override
  String get requestUnavailability => 'Utilgjengelighet';

  @override
  String get requestSwap => 'Vaktbytte';

  @override
  String get swapHint =>
      'Trykk på en av dine kommende vakter i vaktplanen for å tilby et bytte.';

  @override
  String get noRequests => 'Ingen forespørsler ennå.';

  @override
  String get requestsToHandle => 'Til behandling';

  @override
  String get myRequests => 'Mine forespørsler';

  @override
  String get otherRequests => 'Teamets forespørsler';

  @override
  String get statusPendingPeer => 'Venter på kollegaen';

  @override
  String get statusPendingManager => 'Venter på en leder';

  @override
  String get statusApproved => 'Godkjent';

  @override
  String get statusRefused => 'Avslått';

  @override
  String get statusCancelled => 'Avbrutt';

  @override
  String get cancelRequest => 'Avbryt forespørselen';

  @override
  String get acceptSwap => 'Ta denne vakten';

  @override
  String get approve => 'Godkjenn';

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
    return 'Hver uke: $days';
  }

  @override
  String get unavailableEveryWeek => 'Dager du aldri er tilgjengelig:';

  @override
  String get choosePeriod => 'Velg datoer';

  @override
  String get choosePeriodOptional => 'Begrens til en periode (valgfritt)';

  @override
  String get clearPeriod => 'Ingen periode';

  @override
  String get sendRequest => 'Send forespørselen';

  @override
  String get proposeSwap => 'Tilby et bytte';

  @override
  String get swapWith => 'Tilby til';

  @override
  String get swapSteps =>
      'Kollegaen godtar, deretter godkjenner en leder. Vaktplanen endres først da.';

  @override
  String get absentThatDay => 'Godkjent fravær den dagen';

  @override
  String get requestSent => 'Forespørselen er sendt.';

  @override
  String noticeSwapOffer(String name) {
    return '$name tilbyr deg en av sine vakter.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name avslo byttetilbudet ditt.';
  }

  @override
  String get noticeSwapToApprove => 'Et vaktbytte venter på godkjenningen din.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name ber om fri.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name melder at hen ikke er tilgjengelig.';
  }

  @override
  String get noticeRequestApproved => 'Forespørselen din er godkjent.';

  @override
  String get noticeRequestRefused => 'Forespørselen din er avslått.';

  @override
  String get choosePeer => 'Hvem tar over vakten?';

  @override
  String get discardAll => 'Angre alt';

  @override
  String get notifySitesHint =>
      'Velg stedene du får varsler om forespørsler fra. Alle forespørsler er fortsatt synlige i listen.';

  @override
  String get notifySitesTitle => 'Varsler per sted';

  @override
  String get pendingRequestTooltip => 'Ventende forespørsel: trykk for å åpne';

  @override
  String get requestsHistory => 'Alle forespørsler';

  @override
  String get revertChange => 'Angre denne endringen';

  @override
  String get statusExpired => 'Ikke lenger aktuell';

  @override
  String get swapWithHint => 'Trykk for å velge en bestemt kollega';

  @override
  String changesDiscarded(String count) {
    return 'Angrede endringer: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Angre de $count upubliserte endringene?';
  }

  @override
  String get allSchedules => 'Alle vaktplanene mine';

  @override
  String get busyElsewhere =>
      'Jobber allerede i en annen bedrift på dette tidspunktet';

  @override
  String get overlapTooltip => 'Overlapper en vakt i en annen bedrift';

  @override
  String get overlapWarning =>
      'Noen av vaktene dine i to bedrifter overlapper.';

  @override
  String noticeOverlap(String date) {
    return 'To av vaktene dine i ulike bedrifter overlapper $date.';
  }

  @override
  String get allMyCompanies => 'Alle bedriftene mine';

  @override
  String get deleteGroup => 'Slett gruppen';

  @override
  String get openRequest => 'Se forespørselen';

  @override
  String get thisCompany => 'Denne bedriften';

  @override
  String get withExtras => 'Med ekstrahjelp';

  @override
  String deleteGroupConfirm(String name) {
    return 'Slette «$name» og alle meldingene for alle?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Fra $company: legges til som forsterkning og varsles.';
  }

  @override
  String get addToGoogle => 'Legg til i Google Kalender';

  @override
  String get calendarEnabled => 'Synkroniser vaktene mine';

  @override
  String get calendarHint =>
      'Legg til vaktene dine fra alle bedriftene i Google Kalender. De oppdateres av seg selv, og du kan slå det av når du vil.';

  @override
  String get changeSettings => 'Endre';

  @override
  String get copyCalendarLink => 'Kopier kalenderlenken';

  @override
  String get countryBelgium => 'Belgia';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryFrance => 'Frankrike';

  @override
  String get countrySwitzerland => 'Sveits';

  @override
  String get employeesSection => 'Ansatte';

  @override
  String get emptyNoAlert => 'Tomt: ingen varsel';

  @override
  String get extrasSection => 'Ekstrahjelp';

  @override
  String get googleCalendar => 'Google Kalender';

  @override
  String get hoursTotals => 'Timesummer';

  @override
  String get legalAlerts => 'Lovpålagte varsler';

  @override
  String get legalAlertsHint =>
      'Varsler, aldri sperrer. Velg reglene som gjelder hos deg, eller ingen.';

  @override
  String get legalPreset => 'Landsmal';

  @override
  String get linkCopied => 'Lenken er kopiert.';

  @override
  String get maxConsecutiveLabel => 'Høyeste antall arbeidsdager på rad';

  @override
  String get maxDayLabel => 'Lengste varighet per dag (timer)';

  @override
  String get maxWeekLabel => 'Lengste varighet per uke (timer)';

  @override
  String get minRestLabel => 'Korteste hvile mellom to vakter (timer)';

  @override
  String get noLegalRules => 'Ingen varsler valgt.';

  @override
  String get presetNone => 'Ingen';

  @override
  String get presetsCheck =>
      'Malene er et utgangspunkt: sjekk dem mot reglene i landet ditt og tariffavtalen.';

  @override
  String get printMine => 'Min vaktplan';

  @override
  String get printOwn => 'Bare sin egen vaktplan';

  @override
  String get printPdf => 'Skriv ut / PDF';

  @override
  String get printRights => 'Hva ansatte kan skrive ut';

  @override
  String get printTeam => 'Hele teamets vaktplan';

  @override
  String get printTeamOption => 'Teamets vaktplan';

  @override
  String get totalsHint =>
      'Utkast medregnet. Excel- og CSV-eksport bruker den publiserte vaktplanen.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value dager på rad (høyst $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value på dagen (høyst $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: bare $value hvile (minst $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value i uken (høyst $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Lovpålagte varsler: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Vakter: $count';
  }

  @override
  String get actionMakeDeputy => 'Utnevn til stedfortredende leder';

  @override
  String get actionRemoveDeputy => 'Fjern rollen som stedfortreder';

  @override
  String get busyHere => 'Jobber allerede i bedriften på dette tidspunktet';

  @override
  String get calendarByLink => 'Via lenke (Google Kalender på en datamaskin)';

  @override
  String get calendarDenied =>
      'Tilgang til kalenderen avslått. Tillat den i telefoninnstillingene.';

  @override
  String get calendarLinkHint =>
      'Legg til fra Google Kalender på en datamaskin; Google oppdaterer innen noen timer.';

  @override
  String get calendarNone => 'Ingen redigerbar kalender på denne telefonen.';

  @override
  String get calendarOnPhone => 'Legg til vaktene mine i telefonkalenderen';

  @override
  String get calendarOnPhoneHint =>
      'I Google-kalenderen din: synlig med en gang, på telefonen og i Google Kalender.';

  @override
  String get chooseCalendar => 'Velg kalender';

  @override
  String get otherSiteHint =>
      'Ansatt fra et annet sted: lederne der blir varslet.';

  @override
  String get subManager => 'Stedfortredende leder';

  @override
  String calendarSynced(String count) {
    return 'Vakter i kalenderen: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Stedfortredende leder: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by har satt opp $name på $site $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company har lagt deg til som forsterkning.';
  }

  @override
  String get companyNotificationsHint =>
      'Av: ingenting ringer på denne telefonen, men alt blir liggende i klokken.';

  @override
  String get companyNotificationsOn => 'Få varsler fra denne bedriften';

  @override
  String get companyTimezone => 'Bedriftens tidssone';

  @override
  String get companyTimezoneHint =>
      'Alle tidene for denne bedriften er i denne tidssonen (sommertid medregnet). Kalendere regner dem om automatisk.';

  @override
  String get iosInstallHint =>
      'På iPhone: trykk på Del og deretter «Legg til på Hjem-skjerm» for å installere Staff Flow.';

  @override
  String get searchCity => 'Søk etter en by';

  @override
  String get thisPhone => 'Denne enheten';

  @override
  String companyNotifications(String name) {
    return 'Varsler: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Tider etter tiden i $zone ($company). Enheten din: $here.';
  }

  @override
  String get addPreset => 'Legg til forhåndsinnstilling';

  @override
  String get addPresets => 'Lag forhåndsinnstillinger';

  @override
  String get appearance => 'Utseende';

  @override
  String get chooseLogo => 'Velg et PNG-bilde';

  @override
  String get conversationMuted => 'Varsler for denne samtalen er dempet.';

  @override
  String get conversationUnmuted => 'Varsler for denne samtalen er på igjen.';

  @override
  String get customization => 'Tilpasning';

  @override
  String get disableGroup => 'Slå av gruppen';

  @override
  String get disableGroupConfirm =>
      'Hele bedriftens gruppe skjules for alle. Du kan slå den på igjen under Meldinger.';

  @override
  String get editPresets => 'Forhåndsinnstillinger';

  @override
  String get enable => 'Slå på igjen';

  @override
  String get groupDisabled => 'Gruppen er slått av (bare du ser den)';

  @override
  String get logoHint =>
      'Et lite PNG-bilde (logoen din) på bedriftens fane, for alle medlemmer.';

  @override
  String get logoPngOnly => 'Velg et PNG-bilde på maks. 1 MB.';

  @override
  String get muteConversation => 'Demp denne samtalen';

  @override
  String get myIdentifier => 'Min ID';

  @override
  String get myProfile => 'Min profil';

  @override
  String get presetName => 'Navn (f.eks. Morgen)';

  @override
  String get removeLogo => 'Fjern bildet';

  @override
  String get resetGroup => 'Tilbakestill gruppen';

  @override
  String get resetGroupConfirm =>
      'Alle meldinger i bedriftens gruppe slettes for alle.';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get shiftPresets => 'Forhåndsinnstilte tider';

  @override
  String get shiftPresetsHint =>
      'Ferdige tider (morgen, kveld, natt…): ett trykk i en vakt fyller ut start og slutt.';

  @override
  String get themeDark => 'Mørkt';

  @override
  String get themeLight => 'Lyst';

  @override
  String get themeSystem => 'System';

  @override
  String get unmuteConversation => 'Slå på varsler for denne samtalen';

  @override
  String get awaitingApproval => 'Til godkjenning';

  @override
  String get placementNeedsApproval =>
      '! Denne personen hører ikke til dine steder: vakten venter på godkjenning fra din overordnede eller eieren før den kan publiseres. Ellers velg en annen.';

  @override
  String get placementAwaiting =>
      'Venter på godkjenning fra en overordnet eller eieren.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by vil sette opp $name fra et annet sted $date: må godkjennes.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by godkjente oppsettet av $name $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by avslo oppsettet av $name $date.';
  }

  @override
  String get addSubSite => 'Legg til et understed';

  @override
  String get moveSite => 'Flytt';

  @override
  String get topLevel => 'Øverste nivå';

  @override
  String moveSiteTitle(String name) {
    return 'Flytt «$name» under…';
  }

  @override
  String subSiteOf(String name) {
    return 'Understed av $name';
  }

  @override
  String get siteTreeHint =>
      'Opptil 3 nivåer, f.eks. Region › By › Butikk. En leder for et sted leder også alt under det.';

  @override
  String get subSitesOnlyHint =>
      'Her legger du til understeder under dine egne steder.';

  @override
  String get messagingSetting => 'Bedriftens meldinger';

  @override
  String get messagingSettingHint =>
      'På: teamet har en Meldinger-fane. Av: ingen ser den eller kan skrive (gamle meldinger beholdes).';
}
