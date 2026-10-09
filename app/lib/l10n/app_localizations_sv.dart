// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class L10nSv extends L10n {
  L10nSv([String locale = 'sv']) : super(locale);

  @override
  String get cancel => 'Avbryt';

  @override
  String get save => 'Spara';

  @override
  String get confirm => 'Bekräfta';

  @override
  String get validate => 'Bekräfta';

  @override
  String get add => 'Lägg till';

  @override
  String get rename => 'Byt namn';

  @override
  String get delete => 'Ta bort';

  @override
  String get accept => 'Acceptera';

  @override
  String get decline => 'Avböj';

  @override
  String get close => 'Stäng';

  @override
  String get retry => 'Försök igen';

  @override
  String get name => 'Namn';

  @override
  String get serverUnreachable => 'Servern går inte att nå.';

  @override
  String errorStatus(int status) {
    return 'Fel $status';
  }

  @override
  String get roleOwner => 'Ägare';

  @override
  String get roleManager => 'Ansvarig';

  @override
  String get roleEmployee => 'Anställd';

  @override
  String get roleExtra => 'Extrapersonal';

  @override
  String get taglineStart => 'Ditt teams scheman, ';

  @override
  String get taglineEnd => 'överallt.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Logga in med Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Inloggning med Google är inte tillgänglig: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Det gick inte att logga in med Google: $detail';
  }

  @override
  String get newCompany => 'Nytt företag';

  @override
  String get timezone => 'Tidszon';

  @override
  String get create => 'Skapa';

  @override
  String get noCompanyTitle => 'Du tillhör inget företag ännu.';

  @override
  String get noCompanyHint =>
      'Skapa en kod och ge den till din ansvarige för att gå med i arbetsgivarens företag.';

  @override
  String get joinCompany => 'Gå med i ett företag';

  @override
  String get createCompany => 'Skapa ett företag';

  @override
  String transferOffer(String company) {
    return 'Du har blivit erbjuden att bli ägare till ”$company”.';
  }

  @override
  String get someCompany => 'ett företag';

  @override
  String get becameOwner => 'Du är nu ägare.';

  @override
  String get myAccount => 'Mitt konto';

  @override
  String get idCopied => 'Id kopierat.';

  @override
  String myId(String id) {
    return 'Mitt id: $id';
  }

  @override
  String get signOut => 'Logga ut';

  @override
  String joinInvite(String company, String role) {
    return '”$company” bjuder in dig som $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Du har gått med i $company.';
  }

  @override
  String get viewPlanning => 'Schema';

  @override
  String get viewTeam => 'Team';

  @override
  String get viewPositions => 'Roller';

  @override
  String get readOnlyCompany => 'Företaget är skrivskyddat.';

  @override
  String get team => 'Team';

  @override
  String get leaveCompany => 'Lämna det här företaget';

  @override
  String meSuffix(String name) {
    return '$name (du)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Överlåta företaget till $name?';
  }

  @override
  String get transferConfirmBody =>
      'När personen accepterar blir hen ägare (abonnemang, fakturor, ansvariga) och du blir ansvarig.';

  @override
  String transferSent(String name) {
    return 'Erbjudande skickat till $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Ta bort $name?';
  }

  @override
  String get removeConfirmBody => 'Historiken sparas.';

  @override
  String get addPersonTitle => 'Lägg till en person';

  @override
  String get addPersonHint =>
      'Be personen öppna Staff Flow, kontomenyn, ”Gå med i ett företag”, och ange sedan koden som visas.';

  @override
  String get sixDigitCode => 'Sexsiffrig kod';

  @override
  String invitationSent(String name) {
    return 'Inbjudan skickad till $name: den måste accepteras.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Lämna $company?';
  }

  @override
  String get leaveConfirmBody => 'Du kommer inte längre att se dess schema.';

  @override
  String get renameCompany => 'Byt namn på företaget';

  @override
  String get actionMakeManager => 'Gör till ansvarig';

  @override
  String get actionMakeEmployee => 'Gör till anställd igen';

  @override
  String get actionToEmployee => 'Gör till anställd';

  @override
  String get actionToExtra => 'Gör till extrapersonal';

  @override
  String get actionTransfer => 'Överlåt ägarskapet';

  @override
  String get actionRemove => 'Ta bort från företaget';

  @override
  String get positions => 'Roller';

  @override
  String get sites => 'Platser';

  @override
  String get positionsHint => 'Vad personen gör: kassa, kök, reception…';

  @override
  String get sitesHint =>
      'Var passet äger rum, om företaget har flera platser.';

  @override
  String get archived => 'Arkiverad';

  @override
  String get archive => 'Arkivera';

  @override
  String get reactivate => 'Återaktivera';

  @override
  String weekOf(String date) {
    return 'Veckan från $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ändringar publicerade.',
      one: '1 ändring publicerad.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Pass';

  @override
  String get display => 'Visning';

  @override
  String get week => 'Vecka';

  @override
  String get month => 'Månad';

  @override
  String get today => 'Idag';

  @override
  String get onlyMine => 'Bara mina pass';

  @override
  String get replacePersonMenu => 'Ersätt en person…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count opublicerade ändringar',
      one: '1 opublicerad ändring',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'De anställda ser dem inte ännu.';

  @override
  String get publish => 'Publicera';

  @override
  String yourHours(String duration) {
    return 'Dina timmar under perioden: $duration';
  }

  @override
  String get addShiftThisDay => 'Lägg till ett pass den här dagen';

  @override
  String get noShift => 'Inga pass';

  @override
  String get unassigned => 'Ej tilldelat';

  @override
  String get formerMember => 'Tidigare medlem';

  @override
  String get statusDraft => 'Utkast';

  @override
  String get statusModified => 'Ändrat';

  @override
  String get statusDeleted => 'Borttaget';

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get editShift => 'Redigera pass';

  @override
  String get newShift => 'Nytt pass';

  @override
  String get thisShift => 'Bara det här passet';

  @override
  String get thisAndFollowing => 'Det här och följande';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dagar',
      one: 'Dag',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Annan dag';

  @override
  String get start => 'Start';

  @override
  String get end => 'Slut';

  @override
  String get endsNextDay => 'Slutar nästa dag.';

  @override
  String get person => 'Person';

  @override
  String get position => 'Roll';

  @override
  String get site => 'Plats';

  @override
  String get noteOptional => 'Anteckning (valfritt)';

  @override
  String get repetition => 'Upprepning';

  @override
  String get repeatNone => 'Ingen';

  @override
  String get repeatDaily => 'Varje dag';

  @override
  String get repeatWeekly => 'Varje vecka';

  @override
  String get repeatForPrefix => 'Under ';

  @override
  String get repeatDaysSuffix => ' dagar';

  @override
  String get repeatWeeksSuffix => ' veckor';

  @override
  String get repeatUntilPrefix => 'Till ';

  @override
  String get replacePersonTitle => 'Ersätt en person';

  @override
  String get replaceFrom => 'Ersätt';

  @override
  String get replaceBy => 'Med';

  @override
  String dateRange(String from, String to) {
    return 'Från $from till $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pass ändrade.',
      one: '1 pass ändrat.',
      zero: 'Inget pass ändrades.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Ersätt';

  @override
  String get joinHint =>
      'Ge den här koden till din ansvarige. När den har angetts i appen får du en inbjudan att acceptera.';

  @override
  String get codeExpired => 'Koden har gått ut.';

  @override
  String codeValidFor(String time) {
    return 'Giltig i $time till';
  }

  @override
  String get newCode => 'Ny kod';

  @override
  String get language => 'Språk';

  @override
  String get languageAuto => 'Automatiskt (enhetens språk)';

  @override
  String get syncUpToDate => 'Uppdaterad';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Väntande ändringar: $count';
  }

  @override
  String get syncNow => 'Synkronisera';

  @override
  String syncRejected(String reason) {
    return 'Ändringen nekades av servern: $reason';
  }

  @override
  String get pendingBadge => 'Väntar';

  @override
  String get offlineUnavailable => 'Inte tillgängligt offline.';

  @override
  String get offlineCached => 'Offline: senast sparade data.';

  @override
  String get savedOffline =>
      'Sparat på enheten, skickas när nätet är tillbaka.';

  @override
  String get notices => 'Aviseringar';

  @override
  String get noNotices => 'Inga aviseringar.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name ersatte din ändring av passet $date.';
  }

  @override
  String get history => 'Historik';

  @override
  String get recentChanges => 'Senaste ändringar';

  @override
  String get undoChange => 'Ångra den här ändringen';

  @override
  String get undoDone => 'Ändringen ångrades.';

  @override
  String get historyCreate => 'Skapad';

  @override
  String get historyUpdate => 'Ändrad';

  @override
  String get historyDelete => 'Borttagen';

  @override
  String get historyUndo => 'Ångrad';

  @override
  String get noHistory => 'Inga ändringar.';

  @override
  String get pendingNotEditable =>
      'Passet är inte synkroniserat ännu: försök igen när du är online.';

  @override
  String get myQrCode => 'Min QR-kod';

  @override
  String get myQrCodeHint =>
      'En chef skannar koden för att lägga till dig i sitt företag; sedan bekräftar du. Den ändras aldrig.';

  @override
  String get changeMyName => 'Ändra mitt namn';

  @override
  String get nameShownToTeam =>
      'Det här namnet visas för dina kollegor i stället för ditt Google-namn.';

  @override
  String googleName(String name) {
    return 'Google-namn: $name';
  }

  @override
  String get useGoogleName => 'Använd mitt Google-namn';

  @override
  String renameMemberTitle(String name) {
    return 'Byt namn på $name';
  }

  @override
  String get renameMemberHint =>
      'Det här namnet används bara i det här företaget.';

  @override
  String get useOwnName => 'Använd eget namn';

  @override
  String get scanQrCode => 'Skanna en QR-kod';

  @override
  String get scanQrHint =>
      'Rikta kameran mot QR-koden i personens app (kontomenyn, ”Min QR-kod”).';

  @override
  String get orEnterCode => 'Eller ange personens sexsiffriga kod';

  @override
  String get qrInvalid => 'Det här är inte en QR-kod från Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Kameran är inte tillgänglig ($error).';
  }

  @override
  String get notificationsTitle => 'Aviseringar';

  @override
  String get notifChooseHint =>
      'Välj vad du vill få aviseringar om. Allt syns fortfarande under klockan.';

  @override
  String get notifPlanning => 'Schema publicerat eller ändrat';

  @override
  String get notifRequests => 'Förfrågningar: byten, ledighet, inbjudningar';

  @override
  String get notifMessages => 'Nya meddelanden';

  @override
  String get notifOverlap => 'Överlappande pass mellan företag';

  @override
  String get notifConflicts => 'Dina ändringar ersatta av en annan chef';

  @override
  String get notifBilling => 'Påminnelser om abonnemang';

  @override
  String get pushEnabled => 'Aviseringar är på för den här enheten.';

  @override
  String get pushOff => 'Aviseringar är av på den här enheten.';

  @override
  String get pushBlocked =>
      'Aviseringar är blockerade: tillåt dem i telefonens eller webbläsarens inställningar.';

  @override
  String get pushUnavailable =>
      'Aviseringar är inte tillgängliga på den här enheten.';

  @override
  String get enablePush => 'Slå på';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: ditt schema har publicerats eller ändrats.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company vill lägga till dig i sitt team.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name föreslår att du blir ägare till $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name har gått med i $company.';
  }

  @override
  String get messagesTab => 'Meddelanden';

  @override
  String get wholeTeam => 'Hela teamet';

  @override
  String get newConversation => 'Ny konversation';

  @override
  String get noMessages => 'Inga meddelanden än.';

  @override
  String get messageHint => 'Skriv ett meddelande';

  @override
  String get earlierMessages => 'Tidigare meddelanden';

  @override
  String get personLeftCompany =>
      'Den här personen tillhör inte längre företaget.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Ny grupp';

  @override
  String get editGroup => 'Redigera grupp';

  @override
  String get groupName => 'Gruppnamn';

  @override
  String get groupMembersHint =>
      'Välj personerna i gruppen. Bara de ser dess meddelanden.';

  @override
  String get chooseAtLeastOne => 'Välj minst en person.';

  @override
  String get replyAction => 'Svara';

  @override
  String get translateAction => 'Översätt';

  @override
  String replyingTo(String name) {
    return 'Svar till $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Senaste meddelanden från $name';
  }

  @override
  String get deleteAllNotices => 'Radera alla';

  @override
  String get deleteAllNoticesConfirm => 'Radera alla aviseringar?';

  @override
  String get noticeRetention => 'Radera lästa aviseringar efter';

  @override
  String get retentionDay => '1 dag';

  @override
  String get retentionWeek => '1 vecka';

  @override
  String get retentionMonth => '1 månad';

  @override
  String get billingOwnersOnly => 'Bara aktivt om du äger ett företag.';

  @override
  String get readOnlyPastDays => 'Dagar äldre än en månad är skrivskyddade.';

  @override
  String get wholeCompany => 'Hela företaget';

  @override
  String get sitesLabel => 'Arbetsplatser';

  @override
  String get actionSites => 'Arbetsplatser…';

  @override
  String managerOf(String name) {
    return '$name ansvarar för';
  }

  @override
  String teamSitesOf(String name) {
    return '${name}s team';
  }

  @override
  String get notYourSite =>
      'Den här arbetsplatsen ligger inte under ditt ansvar.';

  @override
  String get chooseYourSite => 'Välj minst en arbetsplats.';

  @override
  String get viewRequests => 'Förfrågningar';

  @override
  String get newRequest => 'Ny förfrågan';

  @override
  String get requestLeave => 'Ledighet';

  @override
  String get requestUnavailability => 'Ej tillgänglig';

  @override
  String get requestSwap => 'Passbyte';

  @override
  String get swapHint =>
      'Tryck på ett av dina kommande pass i schemat för att erbjuda ett byte.';

  @override
  String get noRequests => 'Inga förfrågningar än.';

  @override
  String get requestsToHandle => 'Att hantera';

  @override
  String get myRequests => 'Mina förfrågningar';

  @override
  String get otherRequests => 'Teamets förfrågningar';

  @override
  String get statusPendingPeer => 'Väntar på kollegan';

  @override
  String get statusPendingManager => 'Väntar på ansvarig';

  @override
  String get statusApproved => 'Godkänd';

  @override
  String get statusRefused => 'Avslagen';

  @override
  String get statusCancelled => 'Avbruten';

  @override
  String get cancelRequest => 'Avbryt förfrågan';

  @override
  String get acceptSwap => 'Ta det här passet';

  @override
  String get approve => 'Godkänn';

  @override
  String periodLabel(String from, String to) {
    return 'Från $from till $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Erbjudet till $name';
  }

  @override
  String get swapToTeam => 'Hela teamet';

  @override
  String everyWeekdays(String days) {
    return 'Varje vecka: $days';
  }

  @override
  String get unavailableEveryWeek => 'Dagar då du aldrig är tillgänglig:';

  @override
  String get choosePeriod => 'Välj datum';

  @override
  String get choosePeriodOptional => 'Begränsa till en period (valfritt)';

  @override
  String get clearPeriod => 'Ingen period';

  @override
  String get sendRequest => 'Skicka förfrågan';

  @override
  String get proposeSwap => 'Erbjud ett byte';

  @override
  String get swapWith => 'Erbjud till';

  @override
  String get swapSteps =>
      'Kollegan accepterar, sedan godkänner en ansvarig. Schemat ändras först då.';

  @override
  String get absentThatDay => 'Godkänd frånvaro den dagen';

  @override
  String get requestSent => 'Förfrågan skickad.';

  @override
  String noticeSwapOffer(String name) {
    return '$name erbjuder dig ett av sina pass.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name avböjde ditt bytesförslag.';
  }

  @override
  String get noticeSwapToApprove => 'Ett passbyte väntar på ditt godkännande.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name ansöker om ledighet.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name anmäler att hen inte är tillgänglig.';
  }

  @override
  String get noticeRequestApproved => 'Din förfrågan har godkänts.';

  @override
  String get noticeRequestRefused => 'Din förfrågan har avslagits.';

  @override
  String get choosePeer => 'Vem tar över passet?';

  @override
  String get discardAll => 'Ångra allt';

  @override
  String get notifySitesHint =>
      'Välj de arbetsplatser du får aviseringar om förfrågningar för. Alla förfrågningar syns fortfarande i listan.';

  @override
  String get notifySitesTitle => 'Aviseringar per arbetsplats';

  @override
  String get pendingRequestTooltip => 'Väntande förfrågan: tryck för att öppna';

  @override
  String get requestsHistory => 'Alla förfrågningar';

  @override
  String get revertChange => 'Ångra ändringen';

  @override
  String get statusExpired => 'Inaktuell';

  @override
  String get swapWithHint => 'Tryck för att välja en viss kollega';

  @override
  String changesDiscarded(String count) {
    return 'Ångrade ändringar: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Ångra de $count opublicerade ändringarna?';
  }

  @override
  String get allSchedules => 'Alla mina scheman';

  @override
  String get busyElsewhere =>
      'Arbetar redan hos ett annat företag vid den här tiden';

  @override
  String get overlapTooltip => 'Överlappar ett pass hos ett annat företag';

  @override
  String get overlapWarning => 'Några av dina pass hos två företag överlappar.';

  @override
  String noticeOverlap(String date) {
    return 'Två av dina pass hos olika företag överlappar den $date.';
  }

  @override
  String get allMyCompanies => 'Alla mina företag';

  @override
  String get deleteGroup => 'Ta bort gruppen';

  @override
  String get openRequest => 'Visa förfrågan';

  @override
  String get thisCompany => 'Det här företaget';

  @override
  String get withExtras => 'Med extrapersonal';

  @override
  String deleteGroupConfirm(String name) {
    return 'Ta bort ”$name” och alla meddelanden för alla?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Från $company: läggs till som förstärkning och får ett meddelande.';
  }

  @override
  String get addToGoogle => 'Lägg till i Google Kalender';

  @override
  String get calendarEnabled => 'Synka mina pass';

  @override
  String get calendarHint =>
      'Lägg till dina pass från alla dina företag i Google Kalender. De uppdateras av sig själva och du kan stänga av när du vill.';

  @override
  String get changeSettings => 'Ändra';

  @override
  String get copyCalendarLink => 'Kopiera kalenderlänken';

  @override
  String get countryBelgium => 'Belgien';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Frankrike';

  @override
  String get countrySwitzerland => 'Schweiz';

  @override
  String get employeesSection => 'Anställda';

  @override
  String get emptyNoAlert => 'Tomt: ingen varning';

  @override
  String get extrasSection => 'Extrapersonal';

  @override
  String get googleCalendar => 'Google Kalender';

  @override
  String get hoursTotals => 'Timsummor';

  @override
  String get legalAlerts => 'Lagstadgade varningar';

  @override
  String get legalAlertsHint =>
      'Varningar, aldrig spärrar. Välj de regler som gäller hos dig, eller inga.';

  @override
  String get legalPreset => 'Landsmall';

  @override
  String get linkCopied => 'Länken har kopierats.';

  @override
  String get maxConsecutiveLabel => 'Högst antal arbetsdagar i följd';

  @override
  String get maxDayLabel => 'Längsta tid per dag (timmar)';

  @override
  String get maxWeekLabel => 'Längsta tid per vecka (timmar)';

  @override
  String get minRestLabel => 'Kortaste vila mellan två pass (timmar)';

  @override
  String get noLegalRules => 'Inga varningar valda.';

  @override
  String get presetNone => 'Inga';

  @override
  String get presetsCheck =>
      'Mallarna är en utgångspunkt: kontrollera dem mot ditt lands regler och ditt kollektivavtal.';

  @override
  String get printMine => 'Mitt schema';

  @override
  String get printOwn => 'Bara sitt eget schema';

  @override
  String get printPdf => 'Skriv ut / PDF';

  @override
  String get printRights => 'Vad anställda får skriva ut';

  @override
  String get printTeam => 'Hela teamets schema';

  @override
  String get printTeamOption => 'Teamets schema';

  @override
  String get totalsHint =>
      'Utkast inräknade. Excel- och CSV-exporter använder det publicerade schemat.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value dagar i följd (högst $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value under dagen (högst $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: bara $value vila (minst $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value under veckan (högst $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Lagstadgade varningar: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Pass: $count';
  }

  @override
  String get actionMakeDeputy => 'Utse till biträdande ansvarig';

  @override
  String get actionRemoveDeputy => 'Ta bort rollen som biträdande';

  @override
  String get busyHere => 'Arbetar redan i företaget vid den här tiden';

  @override
  String get calendarByLink => 'Via länk (Google Kalender på en dator)';

  @override
  String get calendarDenied =>
      'Åtkomst till kalendern nekades. Tillåt den i telefonens inställningar.';

  @override
  String get calendarLinkHint =>
      'Lägg till via Google Kalender på en dator; Google uppdaterar inom några timmar.';

  @override
  String get calendarNone => 'Ingen redigerbar kalender på den här telefonen.';

  @override
  String get calendarOnPhone => 'Lägg till mina pass i telefonens kalender';

  @override
  String get calendarOnPhoneHint =>
      'I din Google-kalender: syns direkt, i telefonen och i Google Kalender.';

  @override
  String get chooseCalendar => 'Välj kalender';

  @override
  String get otherSiteHint =>
      'Anställd från en annan arbetsplats: hens ansvariga får ett meddelande.';

  @override
  String get subManager => 'Biträdande ansvarig';

  @override
  String calendarSynced(String count) {
    return 'Pass i kalendern: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Biträdande ansvarig: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by har schemalagt $name på $site den $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company har lagt till dig som förstärkning.';
  }

  @override
  String get companyNotificationsHint =>
      'Av: inget låter på den här telefonen, men allt finns kvar i klockan.';

  @override
  String get companyNotificationsOn => 'Få aviseringar från det här företaget';

  @override
  String get companyTimezone => 'Företagets tidszon';

  @override
  String get companyTimezoneHint =>
      'Alla tider för det här företaget är i den här tidszonen (sommartid inräknad). Kalendrar räknar om dem automatiskt.';

  @override
  String get iosInstallHint =>
      'På iPhone: tryck på Dela och sedan ”Lägg till på hemskärmen” för att installera Staff Flow.';

  @override
  String get searchCity => 'Sök en stad';

  @override
  String get thisPhone => 'Den här enheten';

  @override
  String companyNotifications(String name) {
    return 'Aviseringar: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Tider enligt tiden i $zone ($company). Din enhet: $here.';
  }

  @override
  String get addPreset => 'Lägg till förinställning';

  @override
  String get addPresets => 'Skapa förinställningar';

  @override
  String get appearance => 'Utseende';

  @override
  String get chooseLogo => 'Välj en PNG-bild';

  @override
  String get conversationMuted => 'Aviseringar för konversationen avstängda.';

  @override
  String get conversationUnmuted =>
      'Aviseringar för konversationen påslagna igen.';

  @override
  String get customization => 'Anpassning';

  @override
  String get disableGroup => 'Stäng av gruppen';

  @override
  String get disableGroupConfirm =>
      'Hela företagets grupp döljs för alla. Du kan slå på den igen under Meddelanden.';

  @override
  String get editPresets => 'Förinställningar';

  @override
  String get enable => 'Slå på igen';

  @override
  String get groupDisabled => 'Gruppen avstängd (bara du ser den)';

  @override
  String get logoHint =>
      'En liten PNG-bild (din logotyp) på företagets flik, för alla medlemmar.';

  @override
  String get logoPngOnly => 'Välj en PNG-bild på högst 1 MB.';

  @override
  String get muteConversation => 'Tysta den här konversationen';

  @override
  String get myIdentifier => 'Mitt id';

  @override
  String get myProfile => 'Min profil';

  @override
  String get presetName => 'Namn (t.ex. Morgon)';

  @override
  String get removeLogo => 'Ta bort bilden';

  @override
  String get resetGroup => 'Återställ gruppen';

  @override
  String get resetGroupConfirm =>
      'Alla meddelanden i företagets grupp raderas för alla.';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get shiftPresets => 'Förinställda tider';

  @override
  String get shiftPresetsHint =>
      'Färdiga tider (morgon, kväll, natt…): ett tryck i ett pass fyller i start och slut.';

  @override
  String get themeDark => 'Mörkt';

  @override
  String get themeLight => 'Ljust';

  @override
  String get themeSystem => 'System';

  @override
  String get unmuteConversation => 'Slå på aviseringar för konversationen';
}
