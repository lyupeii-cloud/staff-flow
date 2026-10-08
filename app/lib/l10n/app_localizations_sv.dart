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
}
