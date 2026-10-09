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
}
