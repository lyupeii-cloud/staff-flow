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

  @override
  String get messagesTab => 'Správy';

  @override
  String get wholeTeam => 'Celý tím';

  @override
  String get newConversation => 'Nová konverzácia';

  @override
  String get noMessages => 'Zatiaľ žiadne správy.';

  @override
  String get messageHint => 'Napíšte správu';

  @override
  String get earlierMessages => 'Staršie správy';

  @override
  String get personLeftCompany => 'Táto osoba už vo firme nie je.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Nová skupina';

  @override
  String get editGroup => 'Upraviť skupinu';

  @override
  String get groupName => 'Názov skupiny';

  @override
  String get groupMembersHint =>
      'Vyberte ľudí do tejto skupiny. Len oni uvidia jej správy.';

  @override
  String get chooseAtLeastOne => 'Vyberte aspoň jednu osobu.';

  @override
  String get replyAction => 'Odpovedať';

  @override
  String get translateAction => 'Preložiť';

  @override
  String replyingTo(String name) {
    return 'Odpoveď pre: $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Posledné správy od: $name';
  }

  @override
  String get deleteAllNotices => 'Vymazať všetko';

  @override
  String get deleteAllNoticesConfirm => 'Vymazať všetky upozornenia?';

  @override
  String get noticeRetention => 'Mazať prečítané upozornenia po';

  @override
  String get retentionDay => '1 dni';

  @override
  String get retentionWeek => '1 týždni';

  @override
  String get retentionMonth => '1 mesiaci';

  @override
  String get billingOwnersOnly => 'Aktívne, len ak vlastníte firmu.';

  @override
  String get readOnlyPastDays => 'Dni staršie ako mesiac sú iba na čítanie.';

  @override
  String get wholeCompany => 'Celá firma';

  @override
  String get sitesLabel => 'Pracoviská';

  @override
  String get actionSites => 'Pracoviská…';

  @override
  String managerOf(String name) {
    return '$name má na starosti';
  }

  @override
  String teamSitesOf(String name) {
    return 'Tím: $name';
  }

  @override
  String get notYourSite => 'Toto pracovisko nemáte na starosti.';

  @override
  String get chooseYourSite => 'Vyberte aspoň jedno pracovisko.';

  @override
  String get viewRequests => 'Žiadosti';

  @override
  String get newRequest => 'Nová žiadosť';

  @override
  String get requestLeave => 'Dovolenka';

  @override
  String get requestUnavailability => 'Nedostupnosť';

  @override
  String get requestSwap => 'Výmena zmeny';

  @override
  String get swapHint =>
      'Ak chcete ponúknuť výmenu, ťuknite v pláne na jednu zo svojich nadchádzajúcich zmien.';

  @override
  String get noRequests => 'Zatiaľ žiadne žiadosti.';

  @override
  String get requestsToHandle => 'Na vybavenie';

  @override
  String get myRequests => 'Moje žiadosti';

  @override
  String get otherRequests => 'Žiadosti tímu';

  @override
  String get statusPendingPeer => 'Čaká na kolegu';

  @override
  String get statusPendingManager => 'Čaká na vedúceho';

  @override
  String get statusApproved => 'Schválená';

  @override
  String get statusRefused => 'Zamietnutá';

  @override
  String get statusCancelled => 'Zrušená';

  @override
  String get cancelRequest => 'Zrušiť žiadosť';

  @override
  String get acceptSwap => 'Prevziať túto zmenu';

  @override
  String get approve => 'Schváliť';

  @override
  String periodLabel(String from, String to) {
    return 'Od $from do $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Ponúknuté: $name';
  }

  @override
  String get swapToTeam => 'Celý tím';

  @override
  String everyWeekdays(String days) {
    return 'Každý týždeň: $days';
  }

  @override
  String get unavailableEveryWeek => 'Dni, keď nikdy nie ste k dispozícii:';

  @override
  String get choosePeriod => 'Vybrať dátumy';

  @override
  String get choosePeriodOptional => 'Obmedziť na obdobie (voliteľné)';

  @override
  String get clearPeriod => 'Bez obdobia';

  @override
  String get sendRequest => 'Odoslať žiadosť';

  @override
  String get proposeSwap => 'Ponúknuť výmenu';

  @override
  String get swapWith => 'Ponúknuť';

  @override
  String get swapSteps =>
      'Kolega prijme, potom vedúci schváli. Plán sa zmení až potom.';

  @override
  String get absentThatDay => 'Schválená neprítomnosť v tento deň';

  @override
  String get requestSent => 'Žiadosť odoslaná.';

  @override
  String noticeSwapOffer(String name) {
    return '$name vám ponúka jednu zo svojich zmien.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name odmietol vašu ponuku výmeny.';
  }

  @override
  String get noticeSwapToApprove => 'Výmena zmeny čaká na vaše schválenie.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name žiada o dovolenku.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name hlási nedostupnosť.';
  }

  @override
  String get noticeRequestApproved => 'Vaša žiadosť bola schválená.';

  @override
  String get noticeRequestRefused => 'Vaša žiadosť bola zamietnutá.';

  @override
  String get choosePeer => 'Kto prevezme túto zmenu?';

  @override
  String get discardAll => 'Zrušiť všetko';

  @override
  String get notifySitesHint =>
      'Vyberte pobočky, z ktorých dostávate oznámenia o žiadostiach. Všetky žiadosti zostávajú viditeľné v zozname.';

  @override
  String get notifySitesTitle => 'Oznámenia podľa pobočky';

  @override
  String get pendingRequestTooltip => 'Čakajúca žiadosť: ťuknutím otvoríte';

  @override
  String get requestsHistory => 'Všetky žiadosti';

  @override
  String get revertChange => 'Vrátiť túto zmenu';

  @override
  String get statusExpired => 'Neaktuálna';

  @override
  String get swapWithHint => 'Ťuknutím vyberte konkrétneho kolegu';

  @override
  String changesDiscarded(String count) {
    return 'Zrušené zmeny: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Zrušiť $count nezverejnených zmien?';
  }

  @override
  String get allSchedules => 'Všetky moje plány';

  @override
  String get busyElsewhere => 'V tomto čase už pracuje v inej firme';

  @override
  String get overlapTooltip => 'Prekrýva sa so zmenou v inej firme';

  @override
  String get overlapWarning =>
      'Niektoré vaše zmeny v dvoch firmách sa prekrývajú.';

  @override
  String noticeOverlap(String date) {
    return 'Dve vaše zmeny v rôznych firmách sa prekrývajú $date.';
  }

  @override
  String get allMyCompanies => 'Všetky moje firmy';

  @override
  String get deleteGroup => 'Odstrániť skupinu';

  @override
  String get openRequest => 'Zobraziť žiadosť';

  @override
  String get thisCompany => 'Táto firma';

  @override
  String get withExtras => 'Vrátane brigádnikov';

  @override
  String deleteGroupConfirm(String name) {
    return 'Odstrániť „$name“ a všetky správy pre všetkých?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Z firmy $company: bude pridaný ako posila a upozornený.';
  }

  @override
  String get addToGoogle => 'Pridať do Kalendára Google';

  @override
  String get calendarEnabled => 'Synchronizovať moje zmeny';

  @override
  String get calendarHint =>
      'Pridajte svoje zmeny zo všetkých firiem do Kalendára Google. Aktualizujú sa samy a vypnúť to môžete kedykoľvek.';

  @override
  String get changeSettings => 'Upraviť';

  @override
  String get copyCalendarLink => 'Kopírovať odkaz na kalendár';

  @override
  String get countryBelgium => 'Belgicko';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Francúzsko';

  @override
  String get countrySwitzerland => 'Švajčiarsko';

  @override
  String get employeesSection => 'Zamestnanci';

  @override
  String get emptyNoAlert => 'Prázdne: bez upozornenia';

  @override
  String get extrasSection => 'Brigádnici';

  @override
  String get googleCalendar => 'Kalendár Google';

  @override
  String get hoursTotals => 'Súčty hodín';

  @override
  String get legalAlerts => 'Zákonné upozornenia';

  @override
  String get legalAlertsHint =>
      'Len upozornenia, nikdy blokovanie. Vyberte pravidlá, ktoré u vás platia, alebo žiadne.';

  @override
  String get legalPreset => 'Šablóna krajiny';

  @override
  String get linkCopied => 'Odkaz skopírovaný.';

  @override
  String get maxConsecutiveLabel => 'Najviac pracovných dní za sebou';

  @override
  String get maxDayLabel => 'Najdlhší čas za deň (hodiny)';

  @override
  String get maxWeekLabel => 'Najdlhší čas za týždeň (hodiny)';

  @override
  String get minRestLabel => 'Najkratší odpočinok medzi zmenami (hodiny)';

  @override
  String get noLegalRules => 'Nie sú vybrané žiadne upozornenia.';

  @override
  String get presetNone => 'Žiadne';

  @override
  String get presetsCheck =>
      'Šablóny sú východiskový bod: overte ich podľa predpisov svojej krajiny a kolektívnej zmluvy.';

  @override
  String get printMine => 'Môj rozpis';

  @override
  String get printOwn => 'Len vlastný rozpis';

  @override
  String get printPdf => 'Tlač / PDF';

  @override
  String get printRights => 'Čo môžu zamestnanci tlačiť';

  @override
  String get printTeam => 'Rozpis celého tímu';

  @override
  String get printTeamOption => 'Rozpis tímu';

  @override
  String get totalsHint =>
      'Vrátane konceptov. Exporty do Excelu a CSV berú zverejnený rozpis.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value dní za sebou (najviac $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value za deň (najviac $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: len $value odpočinku (najmenej $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value za týždeň (najviac $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Zákonné upozornenia: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Zmeny: $count';
  }

  @override
  String get actionMakeDeputy => 'Vymenovať za zástupcu vedúceho';

  @override
  String get actionRemoveDeputy => 'Odobrať rolu zástupcu';

  @override
  String get busyHere => 'V tomto čase už pracuje v tejto firme';

  @override
  String get calendarByLink => 'Odkazom (Kalendár Google na počítači)';

  @override
  String get calendarDenied =>
      'Prístup ku kalendáru bol zamietnutý. Povoľte ho v nastaveniach telefónu.';

  @override
  String get calendarLinkHint =>
      'Pridajte z Kalendára Google na počítači; Google ho aktualizuje do niekoľkých hodín.';

  @override
  String get calendarNone => 'V telefóne nie je žiadny upraviteľný kalendár.';

  @override
  String get calendarOnPhone => 'Pridať moje zmeny do kalendára telefónu';

  @override
  String get calendarOnPhoneHint =>
      'Vo vašom kalendári Google: hneď viditeľné v telefóne aj v Kalendári Google.';

  @override
  String get chooseCalendar => 'Vybrať kalendár';

  @override
  String get otherSiteHint =>
      'Zamestnanec inej pobočky: jeho vedúci budú upozornení.';

  @override
  String get subManager => 'Zástupca vedúceho';

  @override
  String calendarSynced(String count) {
    return 'Zmeny v kalendári: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Zástupca vedúceho: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by zaradil $name na pobočku $site $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company vás pridala ako posilu.';
  }

  @override
  String get companyNotificationsHint =>
      'Vypnuté: v tomto telefóne nič nezvoní, ale všetko zostáva v zvončeku.';

  @override
  String get companyNotificationsOn => 'Dostávať oznámenia tejto firmy';

  @override
  String get companyTimezone => 'Časové pásmo firmy';

  @override
  String get companyTimezoneHint =>
      'Všetky časy tejto firmy sú v tomto pásme (vrátane letného času). Kalendáre ich prepočítajú automaticky.';

  @override
  String get iosInstallHint =>
      'Na iPhone: ťuknite na Zdieľať a potom na „Pridať na plochu“ a nainštalujte Staff Flow.';

  @override
  String get searchCity => 'Hľadať mesto';

  @override
  String get thisPhone => 'Toto zariadenie';

  @override
  String companyNotifications(String name) {
    return 'Oznámenia: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Časy podľa času $zone ($company). Vaše zariadenie: $here.';
  }

  @override
  String get addPreset => 'Pridať predvoľbu';

  @override
  String get addPresets => 'Vytvoriť predvoľby';

  @override
  String get appearance => 'Vzhľad';

  @override
  String get chooseLogo => 'Vybrať obrázok PNG';

  @override
  String get conversationMuted => 'Oznámenia tejto konverzácie stlmené.';

  @override
  String get conversationUnmuted => 'Oznámenia tejto konverzácie opäť zapnuté.';

  @override
  String get customization => 'Prispôsobenie';

  @override
  String get disableGroup => 'Vypnúť skupinu';

  @override
  String get disableGroupConfirm =>
      'Skupina celej firmy bude pre všetkých skrytá. Znova ju zapnete v Správach.';

  @override
  String get editPresets => 'Predvoľby';

  @override
  String get enable => 'Znova zapnúť';

  @override
  String get groupDisabled => 'Skupina vypnutá (vidíte ju len vy)';

  @override
  String get logoHint =>
      'Malý obrázok PNG (vaše logo) zobrazený na karte firmy pre všetkých členov.';

  @override
  String get logoPngOnly => 'Vyberte obrázok PNG do 1 MB.';

  @override
  String get muteConversation => 'Stlmiť túto konverzáciu';

  @override
  String get myIdentifier => 'Môj identifikátor';

  @override
  String get myProfile => 'Môj profil';

  @override
  String get presetName => 'Názov (napr. Ranná)';

  @override
  String get removeLogo => 'Odstrániť obrázok';

  @override
  String get resetGroup => 'Vymazať skupinu';

  @override
  String get resetGroupConfirm =>
      'Všetky správy skupiny firmy budú vymazané pre všetkých.';

  @override
  String get settingsTitle => 'Nastavenia';

  @override
  String get shiftPresets => 'Predvoľby zmien';

  @override
  String get shiftPresetsHint =>
      'Hotové časy (ranná, poobedná, nočná…): jedným ťuknutím v zmene vyplníte začiatok aj koniec.';

  @override
  String get themeDark => 'Tmavý';

  @override
  String get themeLight => 'Svetlý';

  @override
  String get themeSystem => 'Systémový';

  @override
  String get unmuteConversation => 'Zapnúť oznámenia tejto konverzácie';

  @override
  String get awaitingApproval => 'Na schválenie';

  @override
  String get placementNeedsApproval =>
      '! Táto osoba nie je z vašich miest: zmena počká na schválenie nadriadeným alebo majiteľom, kým ju bude možné zverejniť. Inak vyberte niekoho iného.';

  @override
  String get placementAwaiting =>
      'Čaká na schválenie nadriadeným alebo majiteľom.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by chce naplánovať $name z iného miesta na $date: treba schváliť.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by schválil(a) naplánovanie $name na $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by zamietol(a) naplánovanie $name na $date.';
  }
}
