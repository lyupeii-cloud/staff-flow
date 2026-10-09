// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class L10nNl extends L10n {
  L10nNl([String locale = 'nl']) : super(locale);

  @override
  String get cancel => 'Annuleren';

  @override
  String get save => 'Opslaan';

  @override
  String get confirm => 'Bevestigen';

  @override
  String get validate => 'Bevestigen';

  @override
  String get add => 'Toevoegen';

  @override
  String get rename => 'Naam wijzigen';

  @override
  String get delete => 'Verwijderen';

  @override
  String get accept => 'Accepteren';

  @override
  String get decline => 'Weigeren';

  @override
  String get close => 'Sluiten';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get name => 'Naam';

  @override
  String get serverUnreachable => 'Server niet bereikbaar.';

  @override
  String errorStatus(int status) {
    return 'Fout $status';
  }

  @override
  String get roleOwner => 'Eigenaar';

  @override
  String get roleManager => 'Leidinggevende';

  @override
  String get roleEmployee => 'Medewerker';

  @override
  String get roleExtra => 'Invalkracht';

  @override
  String get taglineStart => 'De roosters van je team, ';

  @override
  String get taglineEnd => 'overal.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Inloggen met Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Inloggen met Google niet beschikbaar: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Inloggen met Google mislukt: $detail';
  }

  @override
  String get newCompany => 'Nieuw bedrijf';

  @override
  String get timezone => 'Tijdzone';

  @override
  String get create => 'Maken';

  @override
  String get noCompanyTitle => 'Je hoort nog bij geen enkel bedrijf.';

  @override
  String get noCompanyHint =>
      'Maak een code en geef die aan je leidinggevende om bij het bedrijf van je werkgever te komen.';

  @override
  String get joinCompany => 'Lid worden van een bedrijf';

  @override
  String get createCompany => 'Bedrijf maken';

  @override
  String transferOffer(String company) {
    return 'Je wordt gevraagd eigenaar te worden van ‘$company’.';
  }

  @override
  String get someCompany => 'een bedrijf';

  @override
  String get becameOwner => 'Je bent nu eigenaar.';

  @override
  String get myAccount => 'Mijn account';

  @override
  String get idCopied => 'ID gekopieerd.';

  @override
  String myId(String id) {
    return 'Mijn ID: $id';
  }

  @override
  String get signOut => 'Uitloggen';

  @override
  String joinInvite(String company, String role) {
    return '‘$company’ nodigt je uit als $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Je bent lid van $company.';
  }

  @override
  String get viewPlanning => 'Rooster';

  @override
  String get viewTeam => 'Team';

  @override
  String get viewPositions => 'Functies';

  @override
  String get readOnlyCompany => 'Bedrijf is alleen-lezen.';

  @override
  String get team => 'Team';

  @override
  String get leaveCompany => 'Dit bedrijf verlaten';

  @override
  String meSuffix(String name) {
    return '$name (jij)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Bedrijf overdragen aan $name?';
  }

  @override
  String get transferConfirmBody =>
      'Na acceptatie wordt deze persoon eigenaar (abonnement, facturen, leidinggevenden) en word jij leidinggevende.';

  @override
  String transferSent(String name) {
    return 'Voorstel verstuurd naar $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$name verwijderen?';
  }

  @override
  String get removeConfirmBody => 'De geschiedenis blijft bewaard.';

  @override
  String get addPersonTitle => 'Persoon toevoegen';

  @override
  String get addPersonHint =>
      'Vraag om Staff Flow te openen, het accountmenu, ‘Lid worden van een bedrijf’, en voer de getoonde code in.';

  @override
  String get sixDigitCode => '6-cijferige code';

  @override
  String invitationSent(String name) {
    return 'Uitnodiging verstuurd naar $name: die moet hem accepteren.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company verlaten?';
  }

  @override
  String get leaveConfirmBody => 'Je ziet het rooster dan niet meer.';

  @override
  String get renameCompany => 'Bedrijfsnaam wijzigen';

  @override
  String get actionMakeManager => 'Leidinggevende maken';

  @override
  String get actionMakeEmployee => 'Weer medewerker maken';

  @override
  String get actionToEmployee => 'Medewerker maken';

  @override
  String get actionToExtra => 'Invalkracht maken';

  @override
  String get actionTransfer => 'Eigendom overdragen';

  @override
  String get actionRemove => 'Uit het bedrijf verwijderen';

  @override
  String get positions => 'Functies';

  @override
  String get sites => 'Locaties';

  @override
  String get positionsHint => 'Wat de persoon doet: kassa, keuken, receptie…';

  @override
  String get sitesHint =>
      'Waar de dienst plaatsvindt, als het bedrijf meerdere locaties heeft.';

  @override
  String get archived => 'Gearchiveerd';

  @override
  String get archive => 'Archiveren';

  @override
  String get reactivate => 'Heractiveren';

  @override
  String weekOf(String date) {
    return 'Week van $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wijzigingen gepubliceerd.',
      one: '1 wijziging gepubliceerd.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Dienst';

  @override
  String get display => 'Weergave';

  @override
  String get week => 'Week';

  @override
  String get month => 'Maand';

  @override
  String get today => 'Vandaag';

  @override
  String get onlyMine => 'Alleen mijn diensten';

  @override
  String get replacePersonMenu => 'Persoon vervangen…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count niet-gepubliceerde wijzigingen',
      one: '1 niet-gepubliceerde wijziging',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Medewerkers zien ze nog niet.';

  @override
  String get publish => 'Publiceren';

  @override
  String yourHours(String duration) {
    return 'Jouw uren in deze periode: $duration';
  }

  @override
  String get addShiftThisDay => 'Dienst toevoegen op deze dag';

  @override
  String get noShift => 'Geen diensten';

  @override
  String get unassigned => 'Niet toegewezen';

  @override
  String get formerMember => 'Voormalig lid';

  @override
  String get statusDraft => 'Concept';

  @override
  String get statusModified => 'Gewijzigd';

  @override
  String get statusDeleted => 'Verwijderd';

  @override
  String durationHours(int hours) {
    return '$hours u';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours u $minutes';
  }

  @override
  String get editShift => 'Dienst bewerken';

  @override
  String get newShift => 'Nieuwe dienst';

  @override
  String get thisShift => 'Alleen deze dienst';

  @override
  String get thisAndFollowing => 'Deze en volgende';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dagen',
      one: 'Dag',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Andere dag';

  @override
  String get start => 'Begin';

  @override
  String get end => 'Einde';

  @override
  String get endsNextDay => 'Eindigt de volgende dag.';

  @override
  String get person => 'Persoon';

  @override
  String get position => 'Functie';

  @override
  String get site => 'Locatie';

  @override
  String get noteOptional => 'Notitie (optioneel)';

  @override
  String get repetition => 'Herhaling';

  @override
  String get repeatNone => 'Geen';

  @override
  String get repeatDaily => 'Elke dag';

  @override
  String get repeatWeekly => 'Elke week';

  @override
  String get repeatForPrefix => 'Gedurende ';

  @override
  String get repeatDaysSuffix => ' dagen';

  @override
  String get repeatWeeksSuffix => ' weken';

  @override
  String get repeatUntilPrefix => 'Tot ';

  @override
  String get replacePersonTitle => 'Persoon vervangen';

  @override
  String get replaceFrom => 'Vervang';

  @override
  String get replaceBy => 'Door';

  @override
  String dateRange(String from, String to) {
    return 'Van $from tot $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count diensten gewijzigd.',
      one: '1 dienst gewijzigd.',
      zero: 'Geen dienst gewijzigd.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Vervangen';

  @override
  String get joinHint =>
      'Geef deze code aan je leidinggevende. Die voert hem in de app in, daarna krijg je een uitnodiging.';

  @override
  String get codeExpired => 'Code verlopen.';

  @override
  String codeValidFor(String time) {
    return 'Nog $time geldig';
  }

  @override
  String get newCode => 'Nieuwe code';

  @override
  String get language => 'Taal';

  @override
  String get languageAuto => 'Automatisch (taal van het apparaat)';

  @override
  String get syncUpToDate => 'Bijgewerkt';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Wijzigingen in wachtrij: $count';
  }

  @override
  String get syncNow => 'Nu synchroniseren';

  @override
  String syncRejected(String reason) {
    return 'Wijziging geweigerd door de server: $reason';
  }

  @override
  String get pendingBadge => 'In wachtrij';

  @override
  String get offlineUnavailable => 'Niet beschikbaar offline.';

  @override
  String get offlineCached => 'Offline: laatst opgeslagen gegevens.';

  @override
  String get savedOffline =>
      'Opgeslagen op het apparaat, wordt verstuurd zodra er netwerk is.';

  @override
  String get notices => 'Meldingen';

  @override
  String get noNotices => 'Geen meldingen.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name heeft je wijziging van de dienst van $date vervangen.';
  }

  @override
  String get history => 'Geschiedenis';

  @override
  String get recentChanges => 'Recente wijzigingen';

  @override
  String get undoChange => 'Deze wijziging ongedaan maken';

  @override
  String get undoDone => 'Wijziging ongedaan gemaakt.';

  @override
  String get historyCreate => 'Aangemaakt';

  @override
  String get historyUpdate => 'Gewijzigd';

  @override
  String get historyDelete => 'Verwijderd';

  @override
  String get historyUndo => 'Ongedaan gemaakt';

  @override
  String get noHistory => 'Geen wijzigingen.';

  @override
  String get pendingNotEditable =>
      'Deze dienst is nog niet gesynchroniseerd: probeer het online opnieuw.';

  @override
  String get myQrCode => 'Mijn QR-code';

  @override
  String get myQrCodeHint =>
      'Een leidinggevende scant deze code om je aan het bedrijf toe te voegen; daarna bevestig je. De code verandert nooit.';

  @override
  String get changeMyName => 'Mijn naam wijzigen';

  @override
  String get nameShownToTeam =>
      'Deze naam zien je collega\'s in plaats van je Google-naam.';

  @override
  String googleName(String name) {
    return 'Google-naam: $name';
  }

  @override
  String get useGoogleName => 'Mijn Google-naam gebruiken';

  @override
  String renameMemberTitle(String name) {
    return '$name hernoemen';
  }

  @override
  String get renameMemberHint =>
      'Deze naam wordt alleen in dit bedrijf gebruikt.';

  @override
  String get useOwnName => 'Eigen naam gebruiken';

  @override
  String get scanQrCode => 'QR-code scannen';

  @override
  String get scanQrHint =>
      'Richt de camera op de QR-code in hun app (accountmenu, ‘Mijn QR-code’).';

  @override
  String get orEnterCode => 'Of voer hun 6-cijferige code in';

  @override
  String get qrInvalid => 'Dit is geen Staff Flow-QR-code.';

  @override
  String cameraUnavailable(String error) {
    return 'Camera niet beschikbaar ($error).';
  }

  @override
  String get notificationsTitle => 'Meldingen';

  @override
  String get notifChooseHint =>
      'Kies waarover je meldingen krijgt. Alles blijft zichtbaar onder de bel.';

  @override
  String get notifPlanning => 'Rooster gepubliceerd of gewijzigd';

  @override
  String get notifRequests => 'Verzoeken: ruilen, verlof, uitnodigingen';

  @override
  String get notifMessages => 'Nieuwe berichten';

  @override
  String get notifOverlap => 'Overlappende diensten tussen bedrijven';

  @override
  String get notifConflicts =>
      'Je wijzigingen vervangen door een andere leidinggevende';

  @override
  String get notifBilling => 'Herinneringen over het abonnement';

  @override
  String get pushEnabled => 'Meldingen staan aan op dit apparaat.';

  @override
  String get pushOff => 'Meldingen staan uit op dit apparaat.';

  @override
  String get pushBlocked =>
      'Meldingen zijn geblokkeerd: sta ze toe in de instellingen van je telefoon of browser.';

  @override
  String get pushUnavailable =>
      'Meldingen zijn niet beschikbaar op dit apparaat.';

  @override
  String get enablePush => 'Aanzetten';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: je rooster is gepubliceerd of gewijzigd.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company wil je aan het team toevoegen.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name stelt voor dat jij eigenaar van $company wordt.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name is bij $company gekomen.';
  }

  @override
  String get messagesTab => 'Berichten';

  @override
  String get wholeTeam => 'Hele team';

  @override
  String get newConversation => 'Nieuw gesprek';

  @override
  String get noMessages => 'Nog geen berichten.';

  @override
  String get messageHint => 'Schrijf een bericht';

  @override
  String get earlierMessages => 'Eerdere berichten';

  @override
  String get personLeftCompany =>
      'Deze persoon hoort niet meer bij het bedrijf.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Nieuwe groep';

  @override
  String get editGroup => 'Groep bewerken';

  @override
  String get groupName => 'Groepsnaam';

  @override
  String get groupMembersHint =>
      'Kies de mensen van deze groep. Alleen zij zien de berichten.';

  @override
  String get chooseAtLeastOne => 'Kies minstens één persoon.';

  @override
  String get replyAction => 'Beantwoorden';

  @override
  String get translateAction => 'Vertalen';

  @override
  String replyingTo(String name) {
    return 'Antwoord aan $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Laatste berichten van $name';
  }

  @override
  String get deleteAllNotices => 'Alles verwijderen';

  @override
  String get deleteAllNoticesConfirm => 'Alle meldingen verwijderen?';

  @override
  String get noticeRetention => 'Gelezen meldingen verwijderen na';

  @override
  String get retentionDay => '1 dag';

  @override
  String get retentionWeek => '1 week';

  @override
  String get retentionMonth => '1 maand';

  @override
  String get billingOwnersOnly =>
      'Alleen actief als je eigenaar bent van een bedrijf.';

  @override
  String get readOnlyPastDays =>
      'Dagen van meer dan een maand geleden zijn alleen-lezen.';

  @override
  String get wholeCompany => 'Hele bedrijf';

  @override
  String get sitesLabel => 'Vestigingen';

  @override
  String get actionSites => 'Vestigingen…';

  @override
  String managerOf(String name) {
    return '$name is verantwoordelijk voor';
  }

  @override
  String teamSitesOf(String name) {
    return 'Team van $name';
  }

  @override
  String get notYourSite =>
      'Deze vestiging valt niet onder jouw verantwoordelijkheid.';

  @override
  String get chooseYourSite => 'Kies minstens één vestiging.';

  @override
  String get viewRequests => 'Verzoeken';

  @override
  String get newRequest => 'Nieuw verzoek';

  @override
  String get requestLeave => 'Verlof';

  @override
  String get requestUnavailability => 'Niet beschikbaar';

  @override
  String get requestSwap => 'Dienstruil';

  @override
  String get swapHint =>
      'Tik op een van je komende diensten in het rooster om een ruil aan te bieden.';

  @override
  String get noRequests => 'Nog geen verzoeken.';

  @override
  String get requestsToHandle => 'Te behandelen';

  @override
  String get myRequests => 'Mijn verzoeken';

  @override
  String get otherRequests => 'Verzoeken van het team';

  @override
  String get statusPendingPeer => 'Wacht op collega';

  @override
  String get statusPendingManager => 'Wacht op leidinggevende';

  @override
  String get statusApproved => 'Goedgekeurd';

  @override
  String get statusRefused => 'Geweigerd';

  @override
  String get statusCancelled => 'Geannuleerd';

  @override
  String get cancelRequest => 'Verzoek annuleren';

  @override
  String get acceptSwap => 'Deze dienst overnemen';

  @override
  String get approve => 'Goedkeuren';

  @override
  String periodLabel(String from, String to) {
    return 'Van $from tot $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Aangeboden aan $name';
  }

  @override
  String get swapToTeam => 'Hele team';

  @override
  String everyWeekdays(String days) {
    return 'Elke week: $days';
  }

  @override
  String get unavailableEveryWeek => 'Dagen waarop je nooit beschikbaar bent:';

  @override
  String get choosePeriod => 'Datums kiezen';

  @override
  String get choosePeriodOptional => 'Beperken tot een periode (optioneel)';

  @override
  String get clearPeriod => 'Geen periode';

  @override
  String get sendRequest => 'Verzoek versturen';

  @override
  String get proposeSwap => 'Ruil aanbieden';

  @override
  String get swapWith => 'Aanbieden aan';

  @override
  String get swapSteps =>
      'De collega accepteert, daarna keurt een leidinggevende goed. Pas dan verandert het rooster.';

  @override
  String get absentThatDay => 'Goedgekeurde afwezigheid die dag';

  @override
  String get requestSent => 'Verzoek verstuurd.';

  @override
  String noticeSwapOffer(String name) {
    return '$name biedt je een van zijn diensten aan.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name heeft je ruilvoorstel geweigerd.';
  }

  @override
  String get noticeSwapToApprove => 'Een dienstruil wacht op je goedkeuring.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name vraagt verlof aan.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name meldt niet beschikbaar te zijn.';
  }

  @override
  String get noticeRequestApproved => 'Je verzoek is goedgekeurd.';

  @override
  String get noticeRequestRefused => 'Je verzoek is geweigerd.';

  @override
  String get choosePeer => 'Wie neemt deze dienst over?';

  @override
  String get discardAll => 'Alles annuleren';

  @override
  String get notifySitesHint =>
      'Kies de locaties waarvan je meldingen over verzoeken krijgt. Alle verzoeken blijven zichtbaar in de lijst.';

  @override
  String get notifySitesTitle => 'Meldingen per locatie';

  @override
  String get pendingRequestTooltip => 'Openstaand verzoek: tik om te openen';

  @override
  String get requestsHistory => 'Alle verzoeken';

  @override
  String get revertChange => 'Deze wijziging ongedaan maken';

  @override
  String get statusExpired => 'Vervallen';

  @override
  String get swapWithHint => 'Tik om een specifieke collega te kiezen';

  @override
  String changesDiscarded(String count) {
    return 'Geannuleerde wijzigingen: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'De $count niet-gepubliceerde wijzigingen annuleren?';
  }

  @override
  String get allSchedules => 'Al mijn roosters';

  @override
  String get busyElsewhere => 'Werkt op dit tijdstip al bij een ander bedrijf';

  @override
  String get overlapTooltip => 'Overlapt met een dienst bij een ander bedrijf';

  @override
  String get overlapWarning =>
      'Sommige van je diensten bij twee bedrijven overlappen.';

  @override
  String noticeOverlap(String date) {
    return 'Twee van je diensten bij verschillende bedrijven overlappen op $date.';
  }

  @override
  String get allMyCompanies => 'Al mijn bedrijven';

  @override
  String get deleteGroup => 'Groep verwijderen';

  @override
  String get openRequest => 'Verzoek bekijken';

  @override
  String get thisCompany => 'Dit bedrijf';

  @override
  String get withExtras => 'Met invalkrachten';

  @override
  String deleteGroupConfirm(String name) {
    return '„$name” en alle berichten voor iedereen verwijderen?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Van $company: wordt als versterking toegevoegd en op de hoogte gebracht.';
  }

  @override
  String get addToGoogle => 'Toevoegen aan Google Agenda';

  @override
  String get calendarEnabled => 'Mijn diensten synchroniseren';

  @override
  String get calendarHint =>
      'Zet je diensten van al je bedrijven in Google Agenda. Ze worden vanzelf bijgewerkt en je kunt dit altijd uitzetten.';

  @override
  String get changeSettings => 'Wijzigen';

  @override
  String get copyCalendarLink => 'Agendalink kopiëren';

  @override
  String get countryBelgium => 'België';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryFrance => 'Frankrijk';

  @override
  String get countrySwitzerland => 'Zwitserland';

  @override
  String get employeesSection => 'Werknemers';

  @override
  String get emptyNoAlert => 'Leeg: geen waarschuwing';

  @override
  String get extrasSection => 'Invalkrachten';

  @override
  String get googleCalendar => 'Google Agenda';

  @override
  String get hoursTotals => 'Urentotalen';

  @override
  String get legalAlerts => 'Wettelijke waarschuwingen';

  @override
  String get legalAlertsHint =>
      'Waarschuwingen, nooit blokkades. Kies de regels die voor jou gelden, of geen.';

  @override
  String get legalPreset => 'Landsjabloon';

  @override
  String get linkCopied => 'Link gekopieerd.';

  @override
  String get maxConsecutiveLabel => 'Maximaal aantal opeenvolgende werkdagen';

  @override
  String get maxDayLabel => 'Maximale duur per dag (uren)';

  @override
  String get maxWeekLabel => 'Maximale duur per week (uren)';

  @override
  String get minRestLabel => 'Minimale rust tussen twee diensten (uren)';

  @override
  String get noLegalRules => 'Geen waarschuwing gekozen.';

  @override
  String get presetNone => 'Geen';

  @override
  String get presetsCheck =>
      'Sjablonen zijn een vertrekpunt: controleer ze volgens je land en je cao.';

  @override
  String get printMine => 'Mijn rooster';

  @override
  String get printOwn => 'Alleen hun eigen rooster';

  @override
  String get printPdf => 'Afdrukken / pdf';

  @override
  String get printRights => 'Wat werknemers mogen afdrukken';

  @override
  String get printTeam => 'Het rooster van het hele team';

  @override
  String get printTeamOption => 'Het rooster van het team';

  @override
  String get totalsHint =>
      'Concepten inbegrepen. Excel- en CSV-exports gebruiken het gepubliceerde rooster.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value dagen achter elkaar (maximaal $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value op de dag (maximaal $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: slechts $value rust (minimaal $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value in de week (maximaal $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Wettelijke waarschuwingen: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Diensten: $count';
  }

  @override
  String get actionMakeDeputy => 'Benoemen tot plaatsvervangend leidinggevende';

  @override
  String get actionRemoveDeputy => 'Rol als plaatsvervanger intrekken';

  @override
  String get busyHere => 'Werkt op dit tijdstip al in dit bedrijf';

  @override
  String get calendarByLink => 'Via link (Google Agenda op een computer)';

  @override
  String get calendarDenied =>
      'Toegang tot de agenda geweigerd. Sta het toe in de telefooninstellingen.';

  @override
  String get calendarLinkHint =>
      'Toevoegen via Google Agenda op een computer; Google werkt het binnen enkele uren bij.';

  @override
  String get calendarNone => 'Geen bewerkbare agenda op deze telefoon.';

  @override
  String get calendarOnPhone => 'Mijn diensten in de telefoonagenda zetten';

  @override
  String get calendarOnPhoneHint =>
      'In je Google-agenda: meteen zichtbaar, op de telefoon en in Google Agenda.';

  @override
  String get chooseCalendar => 'Agenda kiezen';

  @override
  String get otherSiteHint =>
      'Werknemer van een andere locatie: de leidinggevenden worden ingelicht.';

  @override
  String get subManager => 'Plaatsvervangend leidinggevende';

  @override
  String calendarSynced(String count) {
    return 'Diensten in de agenda: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Plaatsvervangend leidinggevende: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by heeft $name op $date ingepland op locatie $site.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company heeft je toegevoegd als versterking.';
  }

  @override
  String get companyNotificationsHint =>
      'Uit: op deze telefoon gaat niets af, maar alles blijft in de bel.';

  @override
  String get companyNotificationsOn => 'Meldingen van dit bedrijf ontvangen';

  @override
  String get companyTimezone => 'Tijdzone van het bedrijf';

  @override
  String get companyTimezoneHint =>
      'Alle tijden van dit bedrijf zijn in deze tijdzone (zomertijd inbegrepen). Agenda\'s rekenen ze automatisch om.';

  @override
  String get iosInstallHint =>
      'Op iPhone: tik op Deel en daarna op ‘Zet op beginscherm’ om Staff Flow te installeren.';

  @override
  String get searchCity => 'Zoek een stad';

  @override
  String get thisPhone => 'Dit apparaat';

  @override
  String companyNotifications(String name) {
    return 'Meldingen: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Tijden in de tijd van $zone ($company). Je apparaat: $here.';
  }

  @override
  String get addPreset => 'Voorinstelling toevoegen';

  @override
  String get addPresets => 'Voorinstellingen maken';

  @override
  String get appearance => 'Weergave';

  @override
  String get chooseLogo => 'Kies een PNG-afbeelding';

  @override
  String get conversationMuted => 'Meldingen voor dit gesprek gedempt.';

  @override
  String get conversationUnmuted => 'Meldingen voor dit gesprek weer aan.';

  @override
  String get customization => 'Aanpassen';

  @override
  String get disableGroup => 'Groep uitschakelen';

  @override
  String get disableGroupConfirm =>
      'De groep van het hele bedrijf wordt voor iedereen verborgen. Je kunt hem weer inschakelen bij Berichten.';

  @override
  String get editPresets => 'Voorinstellingen';

  @override
  String get enable => 'Weer inschakelen';

  @override
  String get groupDisabled => 'Groep uitgeschakeld (alleen jij ziet hem)';

  @override
  String get logoHint =>
      'Een kleine PNG-afbeelding (je logo) op het tabblad van het bedrijf, voor alle leden.';

  @override
  String get logoPngOnly => 'Kies een PNG-afbeelding van maximaal 1 MB.';

  @override
  String get muteConversation => 'Dit gesprek dempen';

  @override
  String get myIdentifier => 'Mijn ID';

  @override
  String get myProfile => 'Mijn profiel';

  @override
  String get presetName => 'Naam (bijv. Ochtend)';

  @override
  String get removeLogo => 'Afbeelding verwijderen';

  @override
  String get resetGroup => 'Groep leegmaken';

  @override
  String get resetGroupConfirm =>
      'Alle berichten van de bedrijfsgroep worden voor iedereen verwijderd.';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get shiftPresets => 'Voorinstellingen voor diensten';

  @override
  String get shiftPresetsHint =>
      'Kant-en-klare tijden (ochtend, avond, nacht…): één tik in een dienst vult begin en einde in.';

  @override
  String get themeDark => 'Donker';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeSystem => 'Systeem';

  @override
  String get unmuteConversation => 'Meldingen van dit gesprek weer aanzetten';
}
