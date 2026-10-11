// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class L10nHu extends L10n {
  L10nHu([String locale = 'hu']) : super(locale);

  @override
  String get cancel => 'Mégse';

  @override
  String get save => 'Mentés';

  @override
  String get confirm => 'Megerősítés';

  @override
  String get validate => 'Megerősítés';

  @override
  String get add => 'Hozzáadás';

  @override
  String get rename => 'Átnevezés';

  @override
  String get delete => 'Törlés';

  @override
  String get accept => 'Elfogadás';

  @override
  String get decline => 'Elutasítás';

  @override
  String get close => 'Bezárás';

  @override
  String get retry => 'Újra';

  @override
  String get name => 'Név';

  @override
  String get serverUnreachable => 'A szerver nem érhető el.';

  @override
  String errorStatus(int status) {
    return 'Hiba: $status';
  }

  @override
  String get roleOwner => 'Tulajdonos';

  @override
  String get roleManager => 'Vezető';

  @override
  String get roleEmployee => 'Munkavállaló';

  @override
  String get roleExtra => 'Kisegítő';

  @override
  String get taglineStart => 'A csapatod beosztása, ';

  @override
  String get taglineEnd => 'bárhol.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Bejelentkezés Google-fiókkal';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'A Google-bejelentkezés nem érhető el: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Nem sikerült Google-fiókkal bejelentkezni: $detail';
  }

  @override
  String get newCompany => 'Új cég';

  @override
  String get timezone => 'Időzóna';

  @override
  String get create => 'Létrehozás';

  @override
  String get noCompanyTitle => 'Még egyetlen céghez sem tartozol.';

  @override
  String get noCompanyHint =>
      'A munkáltatód cégéhez való csatlakozáshoz hozz létre egy kódot, és add oda a vezetődnek.';

  @override
  String get joinCompany => 'Csatlakozás céghez';

  @override
  String get createCompany => 'Cég létrehozása';

  @override
  String transferOffer(String company) {
    return 'Felajánlották, hogy legyél a(z) „$company” tulajdonosa.';
  }

  @override
  String get someCompany => 'egy cég';

  @override
  String get becameOwner => 'Mostantól te vagy a tulajdonos.';

  @override
  String get myAccount => 'Fiókom';

  @override
  String get idCopied => 'Azonosító másolva.';

  @override
  String myId(String id) {
    return 'Azonosítóm: $id';
  }

  @override
  String get signOut => 'Kijelentkezés';

  @override
  String joinInvite(String company, String role) {
    return 'A(z) „$company” meghív téged ebben a szerepkörben: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Csatlakoztál: $company.';
  }

  @override
  String get viewPlanning => 'Beosztás';

  @override
  String get viewTeam => 'Vezetés';

  @override
  String get viewPositions => 'Munkakörök';

  @override
  String get readOnlyCompany => 'A cég csak olvasható.';

  @override
  String get team => 'Csapat';

  @override
  String get leaveCompany => 'Kilépés a cégből';

  @override
  String meSuffix(String name) {
    return '$name (te)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Átadod a céget neki: $name?';
  }

  @override
  String get transferConfirmBody =>
      'Elfogadás után ő lesz a tulajdonos (előfizetés, számlák, vezetők), te pedig vezető leszel.';

  @override
  String transferSent(String name) {
    return 'Ajánlat elküldve: $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Eltávolítod: $name?';
  }

  @override
  String get removeConfirmBody => 'Az előzmények megmaradnak.';

  @override
  String get addPersonTitle => 'Személy hozzáadása';

  @override
  String get addPersonHint =>
      'Kérd meg, hogy nyissa meg a Staff Flow-t, a fiókmenüben válassza a „Csatlakozás céghez” lehetőséget, majd írd be a megjelenő kódot.';

  @override
  String get sixDigitCode => '6 jegyű kód';

  @override
  String invitationSent(String name) {
    return 'Meghívó elküldve: $name. El kell fogadnia.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Kilépsz innen: $company?';
  }

  @override
  String get leaveConfirmBody => 'Többé nem látod a beosztását.';

  @override
  String get renameCompany => 'Cég átnevezése';

  @override
  String get actionMakeManager => 'Vezetővé tesz';

  @override
  String get actionMakeEmployee => 'Vissza munkavállalóvá';

  @override
  String get actionToEmployee => 'Munkavállalóvá tesz';

  @override
  String get actionToExtra => 'Kisegítővé tesz';

  @override
  String get actionTransfer => 'Tulajdonjog átadása';

  @override
  String get actionRemove => 'Eltávolítás a cégből';

  @override
  String get positions => 'Munkakörök';

  @override
  String get sites => 'Telephelyek';

  @override
  String get positionsHint =>
      'Mit csinál a személy: pénztár, konyha, recepció…';

  @override
  String get sitesHint => 'Hol van a műszak, ha a cégnek több telephelye van.';

  @override
  String get archived => 'Archivált';

  @override
  String get archive => 'Archiválás';

  @override
  String get reactivate => 'Újraaktiválás';

  @override
  String weekOf(String date) {
    return '$date hete';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count módosítás közzétéve.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Műszak';

  @override
  String get display => 'Nézet';

  @override
  String get week => 'Hét';

  @override
  String get month => 'Hónap';

  @override
  String get today => 'Ma';

  @override
  String get onlyMine => 'Csak a saját műszakjaim';

  @override
  String get replacePersonMenu => 'Személy cseréje…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count közzé nem tett módosítás',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'A munkavállalók még nem látják.';

  @override
  String get publish => 'Közzététel';

  @override
  String yourHours(String duration) {
    return 'Óráid az időszakban: $duration';
  }

  @override
  String get addShiftThisDay => 'Műszak hozzáadása erre a napra';

  @override
  String get noShift => 'Nincs műszak';

  @override
  String get unassigned => 'Nincs kiosztva';

  @override
  String get formerMember => 'Korábbi tag';

  @override
  String get statusDraft => 'Piszkozat';

  @override
  String get statusModified => 'Módosítva';

  @override
  String get statusDeleted => 'Törölve';

  @override
  String durationHours(int hours) {
    return '$hours ó';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ó $minutes p';
  }

  @override
  String get editShift => 'Műszak szerkesztése';

  @override
  String get newShift => 'Új műszak';

  @override
  String get thisShift => 'Csak ez a műszak';

  @override
  String get thisAndFollowing => 'Ez és a következők';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nap',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Másik nap';

  @override
  String get start => 'Kezdés';

  @override
  String get end => 'Befejezés';

  @override
  String get endsNextDay => 'Másnap ér véget.';

  @override
  String get person => 'Személy';

  @override
  String get position => 'Munkakör';

  @override
  String get site => 'Telephely';

  @override
  String get noteOptional => 'Megjegyzés (nem kötelező)';

  @override
  String get repetition => 'Ismétlés';

  @override
  String get repeatNone => 'Nincs';

  @override
  String get repeatDaily => 'Minden nap';

  @override
  String get repeatWeekly => 'Minden héten';

  @override
  String get repeatForPrefix => 'Időtartam: ';

  @override
  String get repeatDaysSuffix => ' nap';

  @override
  String get repeatWeeksSuffix => ' hét';

  @override
  String get repeatUntilPrefix => 'Eddig: ';

  @override
  String get replacePersonTitle => 'Személy cseréje';

  @override
  String get replaceFrom => 'Csere';

  @override
  String get replaceBy => 'Erre';

  @override
  String dateRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count műszak módosítva.',
      zero: 'Egy műszak sem változott.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Csere';

  @override
  String get joinHint =>
      'Add oda ezt a kódot a vezetődnek. Miután beírja az alkalmazásba, kapsz egy meghívót.';

  @override
  String get codeExpired => 'A kód lejárt.';

  @override
  String codeValidFor(String time) {
    return 'Még $time érvényes';
  }

  @override
  String get newCode => 'Új kód';

  @override
  String get language => 'Nyelv';

  @override
  String get languageAuto => 'Automatikus (eszköz nyelve)';

  @override
  String get syncUpToDate => 'Naprakész';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Függő módosítások: $count';
  }

  @override
  String get syncNow => 'Szinkronizálás';

  @override
  String syncRejected(String reason) {
    return 'A szerver elutasította a módosítást: $reason';
  }

  @override
  String get pendingBadge => 'Függőben';

  @override
  String get offlineUnavailable => 'Offline nem érhető el.';

  @override
  String get offlineCached => 'Offline: az utoljára mentett adatok.';

  @override
  String get savedOffline =>
      'Mentve az eszközön, a hálózat visszatérésekor elküldjük.';

  @override
  String get notices => 'Értesítések';

  @override
  String get noNotices => 'Nincs értesítés.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name felülírta a(z) $date műszakon végzett módosításodat.';
  }

  @override
  String get history => 'Előzmények';

  @override
  String get recentChanges => 'Legutóbbi módosítások';

  @override
  String get undoChange => 'Módosítás visszavonása';

  @override
  String get undoDone => 'Módosítás visszavonva.';

  @override
  String get historyCreate => 'Létrehozás';

  @override
  String get historyUpdate => 'Módosítás';

  @override
  String get historyDelete => 'Törlés';

  @override
  String get historyUndo => 'Visszavonás';

  @override
  String get noHistory => 'Nincs módosítás.';

  @override
  String get pendingNotEditable =>
      'Ez a műszak még nincs szinkronizálva: próbáld újra online.';

  @override
  String get myQrCode => 'Saját QR-kódom';

  @override
  String get myQrCodeHint =>
      'Egy vezető beolvassa ezt a kódot, hogy felvegyen a cégébe; ezután te megerősíted. Soha nem változik.';

  @override
  String get changeMyName => 'Nevem módosítása';

  @override
  String get nameShownToTeam =>
      'A kollégáid ezt a nevet látják a Google-neved helyett.';

  @override
  String googleName(String name) {
    return 'Google-név: $name';
  }

  @override
  String get useGoogleName => 'Google-nevem használata';

  @override
  String renameMemberTitle(String name) {
    return '$name átnevezése';
  }

  @override
  String get renameMemberHint => 'Ezt a nevet csak ebben a cégben használjuk.';

  @override
  String get useOwnName => 'Saját név használata';

  @override
  String get scanQrCode => 'QR-kód beolvasása';

  @override
  String get scanQrHint =>
      'Irányítsd a kamerát az alkalmazásában látható QR-kódra (fiókmenü, „Saját QR-kódom”).';

  @override
  String get orEnterCode => 'Vagy írd be a 6 jegyű kódját';

  @override
  String get qrInvalid => 'Ez nem Staff Flow QR-kód.';

  @override
  String cameraUnavailable(String error) {
    return 'A kamera nem érhető el ($error).';
  }

  @override
  String get notificationsTitle => 'Értesítések';

  @override
  String get notifChooseHint =>
      'Válaszd ki, miről kapj értesítést. Minden látható marad a csengőnél.';

  @override
  String get notifPlanning => 'Beosztás közzétéve vagy módosítva';

  @override
  String get notifRequests => 'Kérések: cserék, szabadság, meghívások';

  @override
  String get notifMessages => 'Új üzenetek';

  @override
  String get notifOverlap => 'Átfedő műszakok cégek között';

  @override
  String get notifConflicts => 'A módosításaidat egy másik vezető felülírta';

  @override
  String get notifBilling => 'Előfizetési emlékeztetők';

  @override
  String get pushEnabled =>
      'Az értesítések be vannak kapcsolva ezen az eszközön.';

  @override
  String get pushOff => 'Az értesítések ki vannak kapcsolva ezen az eszközön.';

  @override
  String get pushBlocked =>
      'Az értesítések le vannak tiltva: engedélyezd őket a telefon vagy a böngésző beállításaiban.';

  @override
  String get pushUnavailable =>
      'Az értesítések nem érhetők el ezen az eszközön.';

  @override
  String get enablePush => 'Bekapcsolás';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: a beosztásodat közzétették vagy módosították.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company fel szeretne venni a csapatába.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name felajánlja, hogy te legyél a(z) $company tulajdonosa.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name csatlakozott: $company.';
  }

  @override
  String get messagesTab => 'Üzenetek';

  @override
  String get wholeTeam => 'Az egész csapat';

  @override
  String get newConversation => 'Új beszélgetés';

  @override
  String get noMessages => 'Még nincs üzenet.';

  @override
  String get messageHint => 'Írj üzenetet';

  @override
  String get earlierMessages => 'Korábbi üzenetek';

  @override
  String get personLeftCompany => 'Ez a személy már nem tagja a cégnek.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Új csoport';

  @override
  String get editGroup => 'Csoport szerkesztése';

  @override
  String get groupName => 'Csoport neve';

  @override
  String get groupMembersHint =>
      'Válaszd ki a csoport tagjait. Csak ők látják az üzeneteit.';

  @override
  String get chooseAtLeastOne => 'Válassz legalább egy személyt.';

  @override
  String get replyAction => 'Válasz';

  @override
  String get translateAction => 'Fordítás';

  @override
  String replyingTo(String name) {
    return 'Válasz neki: $name';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name legutóbbi üzenetei';
  }

  @override
  String get deleteAllNotices => 'Összes törlése';

  @override
  String get deleteAllNoticesConfirm => 'Törlöd az összes értesítést?';

  @override
  String get noticeRetention => 'Olvasott értesítések törlése ennyi idő után';

  @override
  String get retentionDay => '1 nap';

  @override
  String get retentionWeek => '1 hét';

  @override
  String get retentionMonth => '1 hónap';

  @override
  String get billingOwnersOnly => 'Csak akkor aktív, ha van saját céged.';

  @override
  String get readOnlyPastDays =>
      'Az egy hónapnál régebbi napok csak olvashatók.';

  @override
  String get wholeCompany => 'Az egész cég';

  @override
  String get sitesLabel => 'Telephelyek';

  @override
  String get actionSites => 'Telephelyek…';

  @override
  String managerOf(String name) {
    return '$name felelős ezekért:';
  }

  @override
  String teamSitesOf(String name) {
    return '$name csapata';
  }

  @override
  String get notYourSite => 'Ez a telephely nem a te felelősséged.';

  @override
  String get chooseYourSite => 'Válassz legalább egy telephelyet.';

  @override
  String get viewRequests => 'Kérések';

  @override
  String get newRequest => 'Új kérés';

  @override
  String get requestLeave => 'Szabadság';

  @override
  String get requestUnavailability => 'Nem elérhető';

  @override
  String get requestSwap => 'Műszakcsere';

  @override
  String get swapHint =>
      'Csere felajánlásához koppints egyik közelgő műszakodra a beosztásban.';

  @override
  String get noRequests => 'Még nincs kérés.';

  @override
  String get requestsToHandle => 'Teendő';

  @override
  String get myRequests => 'Saját kéréseim';

  @override
  String get otherRequests => 'A csapat kérései';

  @override
  String get statusPendingPeer => 'A kollégára vár';

  @override
  String get statusPendingManager => 'A vezetőre vár';

  @override
  String get statusApproved => 'Elfogadva';

  @override
  String get statusRefused => 'Elutasítva';

  @override
  String get statusCancelled => 'Visszavonva';

  @override
  String get cancelRequest => 'Kérés visszavonása';

  @override
  String get acceptSwap => 'Átveszem a műszakot';

  @override
  String get approve => 'Jóváhagyás';

  @override
  String periodLabel(String from, String to) {
    return '$from – $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Felajánlva neki: $name';
  }

  @override
  String get swapToTeam => 'Az egész csapat';

  @override
  String everyWeekdays(String days) {
    return 'Minden héten: $days';
  }

  @override
  String get unavailableEveryWeek => 'Napok, amikor soha nem vagy elérhető:';

  @override
  String get choosePeriod => 'Dátumok kiválasztása';

  @override
  String get choosePeriodOptional => 'Időszakra korlátozás (nem kötelező)';

  @override
  String get clearPeriod => 'Időszak nélkül';

  @override
  String get sendRequest => 'Kérés elküldése';

  @override
  String get proposeSwap => 'Csere felajánlása';

  @override
  String get swapWith => 'Felajánlás neki';

  @override
  String get swapSteps =>
      'A kolléga elfogadja, majd egy vezető jóváhagyja. A beosztás csak ezután változik.';

  @override
  String get absentThatDay => 'Jóváhagyott távollét aznap';

  @override
  String get requestSent => 'Kérés elküldve.';

  @override
  String noticeSwapOffer(String name) {
    return '$name felajánlja neked egyik műszakját.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name elutasította a cserére vonatkozó ajánlatodat.';
  }

  @override
  String get noticeSwapToApprove => 'Egy műszakcsere a jóváhagyásodra vár.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name szabadságot kér.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name jelzi, hogy nem elérhető.';
  }

  @override
  String get noticeRequestApproved => 'A kérésedet elfogadták.';

  @override
  String get noticeRequestRefused => 'A kérésedet elutasították.';

  @override
  String get choosePeer => 'Ki veszi át ezt a műszakot?';

  @override
  String get discardAll => 'Összes elvetése';

  @override
  String get notifySitesHint =>
      'Válaszd ki, mely telephelyekről kapsz értesítést a kérésekről. Minden kérés látható marad a listában.';

  @override
  String get notifySitesTitle => 'Értesítések telephelyenként';

  @override
  String get pendingRequestTooltip => 'Függő kérés: koppints a megnyitáshoz';

  @override
  String get requestsHistory => 'Összes kérés';

  @override
  String get revertChange => 'Módosítás visszavonása';

  @override
  String get statusExpired => 'Tárgytalan';

  @override
  String get swapWithHint => 'Koppints egy adott kolléga kiválasztásához';

  @override
  String changesDiscarded(String count) {
    return 'Elvetett módosítások: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Elveted a(z) $count közzé nem tett módosítást?';
  }

  @override
  String get allSchedules => 'Összes beosztásom';

  @override
  String get busyElsewhere => 'Ebben az időben már egy másik cégnél dolgozik';

  @override
  String get overlapTooltip => 'Átfedésben van egy másik cég műszakjával';

  @override
  String get overlapWarning => 'Néhány műszakod két cégnél átfedésben van.';

  @override
  String noticeOverlap(String date) {
    return 'Két műszakod különböző cégeknél átfedésben van ekkor: $date.';
  }

  @override
  String get allMyCompanies => 'Összes cégem';

  @override
  String get deleteGroup => 'Csoport törlése';

  @override
  String get openRequest => 'Kérés megnyitása';

  @override
  String get thisCompany => 'Ez a cég';

  @override
  String get withExtras => 'Kisegítőkkel együtt';

  @override
  String deleteGroupConfirm(String name) {
    return 'Törlöd a(z) „$name” csoportot és minden üzenetét mindenkinél?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Innen: $company – kisegítőként hozzáadjuk és értesítjük.';
  }

  @override
  String get addToGoogle => 'Hozzáadás a Google Naptárhoz';

  @override
  String get calendarEnabled => 'Műszakjaim szinkronizálása';

  @override
  String get calendarHint =>
      'Add hozzá az összes cégedben lévő műszakodat a Google Naptárhoz. Maguktól frissülnek, és bármikor kikapcsolhatod.';

  @override
  String get changeSettings => 'Módosítás';

  @override
  String get copyCalendarLink => 'Naptárhivatkozás másolása';

  @override
  String get countryBelgium => 'Belgium';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Franciaország';

  @override
  String get countrySwitzerland => 'Svájc';

  @override
  String get employeesSection => 'Munkavállalók';

  @override
  String get emptyNoAlert => 'Üres: nincs figyelmeztetés';

  @override
  String get extrasSection => 'Kisegítők';

  @override
  String get googleCalendar => 'Google Naptár';

  @override
  String get hoursTotals => 'Óraösszesítők';

  @override
  String get legalAlerts => 'Jogszabályi figyelmeztetések';

  @override
  String get legalAlertsHint =>
      'Csak figyelmeztetések, soha nem tiltás. Válaszd ki a nálad érvényes szabályokat, vagy egyet se.';

  @override
  String get legalPreset => 'Országsablon';

  @override
  String get linkCopied => 'Hivatkozás másolva.';

  @override
  String get maxConsecutiveLabel => 'Legtöbb egymást követő munkanap';

  @override
  String get maxDayLabel => 'Napi legnagyobb időtartam (óra)';

  @override
  String get maxWeekLabel => 'Heti legnagyobb időtartam (óra)';

  @override
  String get minRestLabel => 'Legkisebb pihenőidő két műszak között (óra)';

  @override
  String get noLegalRules => 'Nincs kiválasztott figyelmeztetés.';

  @override
  String get presetNone => 'Egyik sem';

  @override
  String get presetsCheck =>
      'A sablonok csak kiindulópontok: ellenőrizd őket országod szabályai és a kollektív szerződés szerint.';

  @override
  String get printMine => 'Saját beosztásom';

  @override
  String get printOwn => 'Csak a saját beosztásukat';

  @override
  String get printPdf => 'Nyomtatás / PDF';

  @override
  String get printRights => 'Mit nyomtathatnak a munkavállalók';

  @override
  String get printTeam => 'Az egész csapat beosztását';

  @override
  String get printTeamOption => 'A csapat beosztása';

  @override
  String get totalsHint =>
      'Piszkozatokkal együtt. Az Excel- és CSV-export a közzétett beosztást használja.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value nap egymás után (legfeljebb $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value egy napon (legfeljebb $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: csak $value pihenő (legalább $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value egy héten (legfeljebb $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Jogszabályi figyelmeztetések: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Műszakok: $count';
  }

  @override
  String get actionMakeDeputy => 'Kinevezés helyettes vezetőnek';

  @override
  String get actionRemoveDeputy => 'Helyettesi szerep visszavonása';

  @override
  String get busyHere => 'Ebben az időben már dolgozik ennél a cégnél';

  @override
  String get calendarByLink => 'Hivatkozással (Google Naptár számítógépen)';

  @override
  String get calendarDenied =>
      'A naptárhozzáférés megtagadva. Engedélyezd a telefon beállításaiban.';

  @override
  String get calendarLinkHint =>
      'Számítógépen add hozzá a Google Naptárban; a Google néhány órán belül frissíti.';

  @override
  String get calendarNone => 'Nincs szerkeszthető naptár ezen a telefonon.';

  @override
  String get calendarOnPhone => 'Műszakjaim hozzáadása a telefon naptárához';

  @override
  String get calendarOnPhoneHint =>
      'A Google-naptáradban: azonnal látható a telefonon és a Google Naptárban.';

  @override
  String get chooseCalendar => 'Naptár kiválasztása';

  @override
  String get otherSiteHint =>
      'Másik telephely munkavállalója: a vezetőit értesítjük.';

  @override
  String get subManager => 'Helyettes vezető';

  @override
  String calendarSynced(String count) {
    return 'Műszakok a naptárban: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Helyettes vezető: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by beosztotta $name személyt a(z) $site telephelyre ekkor: $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company kisegítőként hozzáadott.';
  }

  @override
  String get companyNotificationsHint =>
      'Kikapcsolva: ezen a telefonon semmi sem szól, de minden megmarad a csengőben.';

  @override
  String get companyNotificationsOn => 'Értesítések fogadása ettől a cégtől';

  @override
  String get companyTimezone => 'A cég időzónája';

  @override
  String get companyTimezoneHint =>
      'A cég minden időpontja ebben az időzónában van (nyári időszámítással). A naptárak automatikusan átszámítják.';

  @override
  String get iosInstallHint =>
      'iPhone-on: koppints a Megosztás gombra, majd a „Főképernyőhöz adás” lehetőségre a Staff Flow telepítéséhez.';

  @override
  String get searchCity => 'Város keresése';

  @override
  String get thisPhone => 'Ez az eszköz';

  @override
  String companyNotifications(String name) {
    return 'Értesítések: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Időpontok $zone idő szerint ($company). Az eszközöd: $here.';
  }

  @override
  String get addPreset => 'Előbeállítás hozzáadása';

  @override
  String get addPresets => 'Előbeállítások létrehozása';

  @override
  String get appearance => 'Megjelenés';

  @override
  String get chooseLogo => 'PNG-kép kiválasztása';

  @override
  String get conversationMuted => 'A beszélgetés értesítései némítva.';

  @override
  String get conversationUnmuted =>
      'A beszélgetés értesítései újra bekapcsolva.';

  @override
  String get customization => 'Testreszabás';

  @override
  String get disableGroup => 'Csoport kikapcsolása';

  @override
  String get disableGroupConfirm =>
      'Az egész cég csoportja mindenki elől el lesz rejtve. Az Üzenetekben újra bekapcsolhatod.';

  @override
  String get editPresets => 'Előbeállítások';

  @override
  String get enable => 'Újra bekapcsolás';

  @override
  String get groupDisabled => 'Csoport kikapcsolva (csak te látod)';

  @override
  String get logoHint =>
      'Kis PNG-kép (a logód), amely a cég fülén jelenik meg minden tag számára.';

  @override
  String get logoPngOnly => 'Legfeljebb 1 MB-os PNG-képet válassz.';

  @override
  String get muteConversation => 'Beszélgetés némítása';

  @override
  String get myIdentifier => 'Azonosítóm';

  @override
  String get myProfile => 'Profilom';

  @override
  String get presetName => 'Név (pl. Reggeli)';

  @override
  String get removeLogo => 'Kép eltávolítása';

  @override
  String get resetGroup => 'Csoport visszaállítása';

  @override
  String get resetGroupConfirm =>
      'A cég csoportjának minden üzenete mindenkinél törlődik.';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get shiftPresets => 'Műszak-előbeállítások';

  @override
  String get shiftPresetsHint =>
      'Kész időpontok (reggel, este, éjjel…): egy koppintás a műszakban kitölti a kezdést és a végét.';

  @override
  String get themeDark => 'Sötét';

  @override
  String get themeLight => 'Világos';

  @override
  String get themeSystem => 'Rendszer';

  @override
  String get unmuteConversation =>
      'Beszélgetés értesítéseinek visszakapcsolása';

  @override
  String get awaitingApproval => 'Jóváhagyandó';

  @override
  String get placementNeedsApproval =>
      '! Ez a személy nem az Ön telephelyeihez tartozik: a műszak a felettese vagy a tulajdonos jóváhagyására vár, mielőtt közzétehető. Különben válasszon mást.';

  @override
  String get placementAwaiting =>
      'Felettes vagy a tulajdonos jóváhagyására vár.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by be szeretné osztani $name munkatársat egy másik telephelyről ekkor: $date – jóváhagyás szükséges.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by jóváhagyta $name beosztását ekkor: $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by elutasította $name beosztását ekkor: $date.';
  }

  @override
  String get addSubSite => 'Altelephely hozzáadása';

  @override
  String get moveSite => 'Áthelyezés';

  @override
  String get topLevel => 'Legfelső szint';

  @override
  String moveSiteTitle(String name) {
    return '„$name” áthelyezése ez alá…';
  }

  @override
  String subSiteOf(String name) {
    return '$name altelephelye';
  }

  @override
  String get siteTreeHint =>
      'Legfeljebb 3 szint, pl. Régió › Város › Üzlet. Egy telephely vezetője az alatta lévőket is kezeli.';

  @override
  String get subSitesOnlyHint =>
      'Itt a saját telephelyei alá adhat altelephelyeket.';

  @override
  String get messagingSetting => 'Céges üzenetek';

  @override
  String get messagingSettingHint =>
      'Be: a csapatnak van Üzenetek lapja. Ki: senki sem látja, és senki sem írhat (a régi üzenetek megmaradnak).';
}
