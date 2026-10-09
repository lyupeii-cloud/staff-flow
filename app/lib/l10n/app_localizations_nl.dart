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
}
