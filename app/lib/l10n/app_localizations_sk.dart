// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class L10nSk extends L10n {
  L10nSk([String locale = 'sk']) : super(locale);

  @override
  String get cancel => 'Zrušiť';

  @override
  String get save => 'Uložiť';

  @override
  String get confirm => 'Potvrdiť';

  @override
  String get validate => 'Potvrdiť';

  @override
  String get add => 'Pridať';

  @override
  String get rename => 'Premenovať';

  @override
  String get delete => 'Odstrániť';

  @override
  String get accept => 'Prijať';

  @override
  String get decline => 'Odmietnuť';

  @override
  String get close => 'Zavrieť';

  @override
  String get retry => 'Skúsiť znova';

  @override
  String get name => 'Názov';

  @override
  String get serverUnreachable => 'Server nie je dostupný.';

  @override
  String errorStatus(int status) {
    return 'Chyba $status';
  }

  @override
  String get roleOwner => 'Vlastník';

  @override
  String get roleManager => 'Vedúci';

  @override
  String get roleEmployee => 'Zamestnanec';

  @override
  String get roleExtra => 'Brigádnik';

  @override
  String get taglineStart => 'Rozpisy zmien vášho tímu, ';

  @override
  String get taglineEnd => 'kdekoľvek.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Prihlásiť sa cez Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Prihlásenie cez Google nie je dostupné: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Prihlásenie cez Google zlyhalo: $detail';
  }

  @override
  String get newCompany => 'Nová firma';

  @override
  String get timezone => 'Časové pásmo';

  @override
  String get create => 'Vytvoriť';

  @override
  String get noCompanyTitle => 'Zatiaľ nepatríte do žiadnej firmy.';

  @override
  String get noCompanyHint =>
      'Ak sa chcete pripojiť k firme zamestnávateľa, vygenerujte kód a dajte ho svojmu vedúcemu.';

  @override
  String get joinCompany => 'Pripojiť sa k firme';

  @override
  String get createCompany => 'Vytvoriť firmu';

  @override
  String transferOffer(String company) {
    return 'Bolo vám ponúknuté stať sa vlastníkom firmy „$company“.';
  }

  @override
  String get someCompany => 'firma';

  @override
  String get becameOwner => 'Teraz ste vlastník.';

  @override
  String get myAccount => 'Môj účet';

  @override
  String get idCopied => 'Identifikátor skopírovaný.';

  @override
  String myId(String id) {
    return 'Môj identifikátor: $id';
  }

  @override
  String get signOut => 'Odhlásiť sa';

  @override
  String joinInvite(String company, String role) {
    return '„$company“ vás pozýva ako: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Pripojili ste sa k firme $company.';
  }

  @override
  String get viewPlanning => 'Rozpis';

  @override
  String get viewTeam => 'Tím';

  @override
  String get viewPositions => 'Pozície';

  @override
  String get readOnlyCompany => 'Firma je len na čítanie.';

  @override
  String get team => 'Tím';

  @override
  String get leaveCompany => 'Opustiť túto firmu';

  @override
  String meSuffix(String name) {
    return '$name (vy)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Previesť firmu na: $name?';
  }

  @override
  String get transferConfirmBody =>
      'Po prijatí sa táto osoba stane vlastníkom (predplatné, faktúry, vedúci) a vy sa stanete vedúcim.';

  @override
  String transferSent(String name) {
    return 'Ponuka odoslaná: $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Odobrať: $name?';
  }

  @override
  String get removeConfirmBody => 'História zostane zachovaná.';

  @override
  String get addPersonTitle => 'Pridať osobu';

  @override
  String get addPersonHint =>
      'Požiadajte ju, aby otvorila Staff Flow, ponuku účtu, „Pripojiť sa k firme“, a zadajte zobrazený kód.';

  @override
  String get sixDigitCode => 'Šesťmiestny kód';

  @override
  String invitationSent(String name) {
    return 'Pozvánka odoslaná: $name. Musí ju prijať.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Opustiť $company?';
  }

  @override
  String get leaveConfirmBody => 'Jej rozpis už neuvidíte.';

  @override
  String get renameCompany => 'Premenovať firmu';

  @override
  String get actionMakeManager => 'Vymenovať za vedúceho';

  @override
  String get actionMakeEmployee => 'Vrátiť na zamestnanca';

  @override
  String get actionToEmployee => 'Zmeniť na zamestnanca';

  @override
  String get actionToExtra => 'Zmeniť na brigádnika';

  @override
  String get actionTransfer => 'Previesť vlastníctvo';

  @override
  String get actionRemove => 'Odobrať z firmy';

  @override
  String get positions => 'Pozície';

  @override
  String get sites => 'Prevádzky';

  @override
  String get positionsHint => 'Čo osoba robí: pokladňa, kuchyňa, recepcia…';

  @override
  String get sitesHint => 'Kde sa zmena koná, ak má firma viac prevádzok.';

  @override
  String get archived => 'Archivované';

  @override
  String get archive => 'Archivovať';

  @override
  String get reactivate => 'Obnoviť';

  @override
  String weekOf(String date) {
    return 'Týždeň od $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zverejnených $count zmien.',
      many: 'Zverejnených $count zmeny.',
      few: 'Zverejnené $count zmeny.',
      one: 'Zverejnená $count zmena.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Zmena';

  @override
  String get display => 'Zobrazenie';

  @override
  String get week => 'Týždeň';

  @override
  String get month => 'Mesiac';

  @override
  String get today => 'Dnes';

  @override
  String get onlyMine => 'Len moje zmeny';

  @override
  String get replacePersonMenu => 'Nahradiť osobu…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nezverejnených zmien',
      many: '$count nezverejnenej zmeny',
      few: '$count nezverejnené zmeny',
      one: '$count nezverejnená zmena',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Zamestnanci ich zatiaľ nevidia.';

  @override
  String get publish => 'Zverejniť';

  @override
  String yourHours(String duration) {
    return 'Vaše hodiny za obdobie: $duration';
  }

  @override
  String get addShiftThisDay => 'Pridať zmenu na tento deň';

  @override
  String get noShift => 'Žiadne zmeny';

  @override
  String get unassigned => 'Nepriradené';

  @override
  String get formerMember => 'Bývalý člen';

  @override
  String get statusDraft => 'Koncept';

  @override
  String get statusModified => 'Zmenené';

  @override
  String get statusDeleted => 'Odstránené';

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get editShift => 'Upraviť zmenu';

  @override
  String get newShift => 'Nová zmena';

  @override
  String get thisShift => 'Len táto zmena';

  @override
  String get thisAndFollowing => 'Táto a nasledujúce';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dni',
      one: 'Deň',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Iný deň';

  @override
  String get start => 'Začiatok';

  @override
  String get end => 'Koniec';

  @override
  String get endsNextDay => 'Končí nasledujúci deň.';

  @override
  String get person => 'Osoba';

  @override
  String get position => 'Pozícia';

  @override
  String get site => 'Prevádzka';

  @override
  String get noteOptional => 'Poznámka (nepovinné)';

  @override
  String get repetition => 'Opakovanie';

  @override
  String get repeatNone => 'Žiadne';

  @override
  String get repeatDaily => 'Každý deň';

  @override
  String get repeatWeekly => 'Každý týždeň';

  @override
  String get repeatForPrefix => 'Počas ';

  @override
  String get repeatDaysSuffix => ' dní';

  @override
  String get repeatWeeksSuffix => ' týždňov';

  @override
  String get repeatUntilPrefix => 'Do ';

  @override
  String get replacePersonTitle => 'Nahradiť osobu';

  @override
  String get replaceFrom => 'Nahradiť';

  @override
  String get replaceBy => 'Kým';

  @override
  String dateRange(String from, String to) {
    return 'Od $from do $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Upravených $count zmien.',
      many: 'Upravených $count zmeny.',
      few: 'Upravené $count zmeny.',
      one: 'Upravená $count zmena.',
      zero: 'Žiadna zmena nebola upravená.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Nahradiť';

  @override
  String get joinHint =>
      'Dajte tento kód svojmu vedúcemu. Po zadaní v jeho aplikácii dostanete pozvánku.';

  @override
  String get codeExpired => 'Platnosť kódu vypršala.';

  @override
  String codeValidFor(String time) {
    return 'Platí ešte $time';
  }

  @override
  String get newCode => 'Nový kód';

  @override
  String get language => 'Jazyk';

  @override
  String get languageAuto => 'Automaticky (jazyk zariadenia)';

  @override
  String get syncUpToDate => 'Aktuálne';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Čakajúce zmeny: $count';
  }

  @override
  String get syncNow => 'Synchronizovať';

  @override
  String syncRejected(String reason) {
    return 'Server zmenu odmietol: $reason';
  }

  @override
  String get pendingBadge => 'Čaká';

  @override
  String get offlineUnavailable => 'Offline nedostupné.';

  @override
  String get offlineCached => 'Offline: posledné uložené údaje.';

  @override
  String get savedOffline =>
      'Uložené v zariadení, odošle sa po obnovení siete.';

  @override
  String get notices => 'Oznámenia';

  @override
  String get noNotices => 'Žiadne oznámenia.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name nahradil(a) vašu úpravu zmeny z $date.';
  }

  @override
  String get history => 'História';

  @override
  String get recentChanges => 'Posledné zmeny';

  @override
  String get undoChange => 'Vrátiť túto zmenu';

  @override
  String get undoDone => 'Zmena vrátená.';

  @override
  String get historyCreate => 'Vytvorenie';

  @override
  String get historyUpdate => 'Úprava';

  @override
  String get historyDelete => 'Odstránenie';

  @override
  String get historyUndo => 'Vrátenie';

  @override
  String get noHistory => 'Žiadne zmeny.';

  @override
  String get pendingNotEditable =>
      'Táto zmena ešte nie je synchronizovaná: skúste to znova online.';

  @override
  String get myQrCode => 'Môj QR kód';

  @override
  String get myQrCodeHint =>
      'Vedúci naskenuje tento kód, aby vás pridal do svojej firmy; potom to potvrdíte. Kód sa nikdy nemení.';

  @override
  String get changeMyName => 'Zmeniť moje meno';

  @override
  String get nameShownToTeam =>
      'Toto meno uvidia kolegovia namiesto vášho mena z Googlu.';

  @override
  String googleName(String name) {
    return 'Meno z Googlu: $name';
  }

  @override
  String get useGoogleName => 'Použiť meno z Googlu';

  @override
  String renameMemberTitle(String name) {
    return 'Premenovať: $name';
  }

  @override
  String get renameMemberHint => 'Toto meno sa používa len v tejto firme.';

  @override
  String get useOwnName => 'Použiť vlastné meno';

  @override
  String get scanQrCode => 'Naskenovať QR kód';

  @override
  String get scanQrHint =>
      'Namierte fotoaparát na QR kód v jeho aplikácii (ponuka účtu, „Môj QR kód“).';

  @override
  String get orEnterCode => 'Alebo zadajte jeho 6-miestny kód';

  @override
  String get qrInvalid => 'Toto nie je QR kód Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Fotoaparát nie je dostupný ($error).';
  }

  @override
  String get notificationsTitle => 'Upozornenia';

  @override
  String get notifChooseHint =>
      'Vyberte, o čom chcete dostávať upozornenia. Všetko zostáva viditeľné pod zvončekom.';

  @override
  String get notifPlanning => 'Rozpis zverejnený alebo zmenený';

  @override
  String get notifRequests => 'Žiadosti: výmeny, dovolenka, pozvánky';

  @override
  String get notifMessages => 'Nové správy';

  @override
  String get notifOverlap => 'Prekrývajúce sa zmeny medzi firmami';

  @override
  String get notifConflicts => 'Vaše zmeny nahradené iným vedúcim';

  @override
  String get notifBilling => 'Pripomienky predplatného';

  @override
  String get pushEnabled => 'Upozornenia sú na tomto zariadení zapnuté.';

  @override
  String get pushOff => 'Upozornenia sú na tomto zariadení vypnuté.';

  @override
  String get pushBlocked =>
      'Upozornenia sú zablokované: povoľte ich v nastaveniach telefónu alebo prehliadača.';

  @override
  String get pushUnavailable =>
      'Upozornenia nie sú na tomto zariadení dostupné.';

  @override
  String get enablePush => 'Zapnúť';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: váš rozpis bol zverejnený alebo zmenený.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company vás chce pridať do svojho tímu.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name vám ponúka, aby ste sa stali vlastníkom $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name sa pripojil k $company.';
  }
}
