// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class L10nCs extends L10n {
  L10nCs([String locale = 'cs']) : super(locale);

  @override
  String get cancel => 'Zrušit';

  @override
  String get save => 'Uložit';

  @override
  String get confirm => 'Potvrdit';

  @override
  String get validate => 'Potvrdit';

  @override
  String get add => 'Přidat';

  @override
  String get rename => 'Přejmenovat';

  @override
  String get delete => 'Smazat';

  @override
  String get accept => 'Přijmout';

  @override
  String get decline => 'Odmítnout';

  @override
  String get close => 'Zavřít';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get name => 'Název';

  @override
  String get serverUnreachable => 'Server není dostupný.';

  @override
  String errorStatus(int status) {
    return 'Chyba $status';
  }

  @override
  String get roleOwner => 'Vlastník';

  @override
  String get roleManager => 'Vedoucí';

  @override
  String get roleEmployee => 'Zaměstnanec';

  @override
  String get roleExtra => 'Brigádník';

  @override
  String get taglineStart => 'Rozpisy směn vašeho týmu, ';

  @override
  String get taglineEnd => 'kdekoli.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Přihlásit se přes Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Přihlášení přes Google není dostupné: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Přihlášení přes Google se nezdařilo: $detail';
  }

  @override
  String get newCompany => 'Nová firma';

  @override
  String get timezone => 'Časové pásmo';

  @override
  String get create => 'Vytvořit';

  @override
  String get noCompanyTitle => 'Zatím nepatříte do žádné firmy.';

  @override
  String get noCompanyHint =>
      'Chcete-li se připojit k firmě zaměstnavatele, vygenerujte kód a dejte ho svému vedoucímu.';

  @override
  String get joinCompany => 'Připojit se k firmě';

  @override
  String get createCompany => 'Vytvořit firmu';

  @override
  String transferOffer(String company) {
    return 'Bylo vám nabídnuto stát se vlastníkem firmy „$company“.';
  }

  @override
  String get someCompany => 'firma';

  @override
  String get becameOwner => 'Nyní jste vlastník.';

  @override
  String get myAccount => 'Můj účet';

  @override
  String get idCopied => 'Identifikátor zkopírován.';

  @override
  String myId(String id) {
    return 'Můj identifikátor: $id';
  }

  @override
  String get signOut => 'Odhlásit se';

  @override
  String joinInvite(String company, String role) {
    return '„$company“ vás zve jako: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Připojili jste se k firmě $company.';
  }

  @override
  String get viewPlanning => 'Rozpis';

  @override
  String get viewTeam => 'Tým';

  @override
  String get viewPositions => 'Pozice';

  @override
  String get readOnlyCompany => 'Firma je pouze pro čtení.';

  @override
  String get team => 'Tým';

  @override
  String get leaveCompany => 'Opustit tuto firmu';

  @override
  String meSuffix(String name) {
    return '$name (vy)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Převést firmu na: $name?';
  }

  @override
  String get transferConfirmBody =>
      'Po přijetí se tato osoba stane vlastníkem (předplatné, faktury, vedoucí) a vy se stanete vedoucím.';

  @override
  String transferSent(String name) {
    return 'Nabídka odeslána: $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Odebrat: $name?';
  }

  @override
  String get removeConfirmBody => 'Historie zůstane zachována.';

  @override
  String get addPersonTitle => 'Přidat osobu';

  @override
  String get addPersonHint =>
      'Požádejte ji, aby otevřela Staff Flow, nabídku účtu, „Připojit se k firmě“, a zadejte zobrazený kód.';

  @override
  String get sixDigitCode => 'Šestimístný kód';

  @override
  String invitationSent(String name) {
    return 'Pozvánka odeslána: $name. Musí ji přijmout.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Opustit $company?';
  }

  @override
  String get leaveConfirmBody => 'Její rozpis už neuvidíte.';

  @override
  String get renameCompany => 'Přejmenovat firmu';

  @override
  String get actionMakeManager => 'Jmenovat vedoucím';

  @override
  String get actionMakeEmployee => 'Vrátit na zaměstnance';

  @override
  String get actionToEmployee => 'Změnit na zaměstnance';

  @override
  String get actionToExtra => 'Změnit na brigádníka';

  @override
  String get actionTransfer => 'Převést vlastnictví';

  @override
  String get actionRemove => 'Odebrat z firmy';

  @override
  String get positions => 'Pozice';

  @override
  String get sites => 'Pobočky';

  @override
  String get positionsHint => 'Co osoba dělá: pokladna, kuchyně, recepce…';

  @override
  String get sitesHint => 'Kde se směna koná, pokud má firma více poboček.';

  @override
  String get archived => 'Archivováno';

  @override
  String get archive => 'Archivovat';

  @override
  String get reactivate => 'Obnovit';

  @override
  String weekOf(String date) {
    return 'Týden od $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zveřejněno $count změn.',
      many: 'Zveřejněno $count změny.',
      few: 'Zveřejněny $count změny.',
      one: 'Zveřejněna $count změna.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Směna';

  @override
  String get display => 'Zobrazení';

  @override
  String get week => 'Týden';

  @override
  String get month => 'Měsíc';

  @override
  String get today => 'Dnes';

  @override
  String get onlyMine => 'Jen moje směny';

  @override
  String get replacePersonMenu => 'Nahradit osobu…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nezveřejněných změn',
      many: '$count nezveřejněné změny',
      few: '$count nezveřejněné změny',
      one: '$count nezveřejněná změna',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Zaměstnanci je zatím nevidí.';

  @override
  String get publish => 'Zveřejnit';

  @override
  String yourHours(String duration) {
    return 'Vaše hodiny za období: $duration';
  }

  @override
  String get addShiftThisDay => 'Přidat směnu na tento den';

  @override
  String get noShift => 'Žádné směny';

  @override
  String get unassigned => 'Nepřiřazeno';

  @override
  String get formerMember => 'Bývalý člen';

  @override
  String get statusDraft => 'Koncept';

  @override
  String get statusModified => 'Změněno';

  @override
  String get statusDeleted => 'Smazáno';

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get editShift => 'Upravit směnu';

  @override
  String get newShift => 'Nová směna';

  @override
  String get thisShift => 'Jen tato směna';

  @override
  String get thisAndFollowing => 'Tato a následující';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dny',
      one: 'Den',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Jiný den';

  @override
  String get start => 'Začátek';

  @override
  String get end => 'Konec';

  @override
  String get endsNextDay => 'Končí následující den.';

  @override
  String get person => 'Osoba';

  @override
  String get position => 'Pozice';

  @override
  String get site => 'Pobočka';

  @override
  String get noteOptional => 'Poznámka (nepovinné)';

  @override
  String get repetition => 'Opakování';

  @override
  String get repeatNone => 'Žádné';

  @override
  String get repeatDaily => 'Každý den';

  @override
  String get repeatWeekly => 'Každý týden';

  @override
  String get repeatForPrefix => 'Po dobu ';

  @override
  String get repeatDaysSuffix => ' dní';

  @override
  String get repeatWeeksSuffix => ' týdnů';

  @override
  String get repeatUntilPrefix => 'Do ';

  @override
  String get replacePersonTitle => 'Nahradit osobu';

  @override
  String get replaceFrom => 'Nahradit';

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
      other: 'Změněno $count směn.',
      many: 'Změněno $count směny.',
      few: 'Změněny $count směny.',
      one: 'Změněna $count směna.',
      zero: 'Žádná směna nebyla změněna.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Nahradit';

  @override
  String get joinHint =>
      'Dejte tento kód svému vedoucímu. Po zadání v jeho aplikaci dostanete pozvánku.';

  @override
  String get codeExpired => 'Platnost kódu vypršela.';

  @override
  String codeValidFor(String time) {
    return 'Platí ještě $time';
  }

  @override
  String get newCode => 'Nový kód';

  @override
  String get language => 'Jazyk';

  @override
  String get languageAuto => 'Automaticky (jazyk zařízení)';

  @override
  String get syncUpToDate => 'Aktuální';

  @override
  String get syncOffline => 'Offline';

  @override
  String syncPending(int count) {
    return 'Čekající změny: $count';
  }

  @override
  String get syncNow => 'Synchronizovat';

  @override
  String syncRejected(String reason) {
    return 'Server změnu odmítl: $reason';
  }

  @override
  String get pendingBadge => 'Čeká';

  @override
  String get offlineUnavailable => 'Offline nedostupné.';

  @override
  String get offlineCached => 'Offline: poslední uložená data.';

  @override
  String get savedOffline => 'Uloženo v zařízení, odešle se po obnovení sítě.';

  @override
  String get notices => 'Oznámení';

  @override
  String get noNotices => 'Žádná oznámení.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name nahradil(a) vaši úpravu směny z $date.';
  }

  @override
  String get history => 'Historie';

  @override
  String get recentChanges => 'Poslední změny';

  @override
  String get undoChange => 'Vrátit tuto změnu';

  @override
  String get undoDone => 'Změna vrácena.';

  @override
  String get historyCreate => 'Vytvoření';

  @override
  String get historyUpdate => 'Úprava';

  @override
  String get historyDelete => 'Smazání';

  @override
  String get historyUndo => 'Vrácení';

  @override
  String get noHistory => 'Žádné změny.';

  @override
  String get pendingNotEditable =>
      'Tato směna ještě není synchronizována: zkuste to znovu online.';

  @override
  String get myQrCode => 'Můj QR kód';

  @override
  String get myQrCodeHint =>
      'Vedoucí naskenuje tento kód, aby vás přidal do své firmy; pak to potvrdíte. Kód se nikdy nemění.';

  @override
  String get changeMyName => 'Změnit mé jméno';

  @override
  String get nameShownToTeam =>
      'Toto jméno uvidí kolegové místo vašeho jména z Googlu.';

  @override
  String googleName(String name) {
    return 'Jméno z Googlu: $name';
  }

  @override
  String get useGoogleName => 'Použít jméno z Googlu';

  @override
  String renameMemberTitle(String name) {
    return 'Přejmenovat: $name';
  }

  @override
  String get renameMemberHint => 'Toto jméno se používá jen v této firmě.';

  @override
  String get useOwnName => 'Použít vlastní jméno';

  @override
  String get scanQrCode => 'Naskenovat QR kód';

  @override
  String get scanQrHint =>
      'Namiřte fotoaparát na QR kód v jeho aplikaci (nabídka účtu, „Můj QR kód“).';

  @override
  String get orEnterCode => 'Nebo zadejte jeho 6místný kód';

  @override
  String get qrInvalid => 'Toto není QR kód Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Fotoaparát není dostupný ($error).';
  }

  @override
  String get notificationsTitle => 'Oznámení';

  @override
  String get notifChooseHint =>
      'Vyberte, o čem chcete dostávat oznámení. Vše zůstává vidět pod zvonečkem.';

  @override
  String get notifPlanning => 'Rozpis zveřejněn nebo změněn';

  @override
  String get notifRequests => 'Žádosti: výměny, dovolená, pozvánky';

  @override
  String get notifMessages => 'Nové zprávy';

  @override
  String get notifOverlap => 'Překrývající se směny mezi firmami';

  @override
  String get notifConflicts => 'Vaše změny nahrazené jiným vedoucím';

  @override
  String get notifBilling => 'Připomínky předplatného';

  @override
  String get pushEnabled => 'Oznámení jsou na tomto zařízení zapnutá.';

  @override
  String get pushOff => 'Oznámení jsou na tomto zařízení vypnutá.';

  @override
  String get pushBlocked =>
      'Oznámení jsou blokovaná: povolte je v nastavení telefonu nebo prohlížeče.';

  @override
  String get pushUnavailable => 'Oznámení nejsou na tomto zařízení dostupná.';

  @override
  String get enablePush => 'Zapnout';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: váš rozpis byl zveřejněn nebo změněn.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company vás chce přidat do svého týmu.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name vám nabízí, abyste se stali vlastníkem $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name se připojil k $company.';
  }

  @override
  String get messagesTab => 'Zprávy';

  @override
  String get wholeTeam => 'Celý tým';

  @override
  String get newConversation => 'Nová konverzace';

  @override
  String get noMessages => 'Zatím žádné zprávy.';

  @override
  String get messageHint => 'Napište zprávu';

  @override
  String get earlierMessages => 'Starší zprávy';

  @override
  String get personLeftCompany => 'Tato osoba už ve firmě není.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Nová skupina';

  @override
  String get editGroup => 'Upravit skupinu';

  @override
  String get groupName => 'Název skupiny';

  @override
  String get groupMembersHint =>
      'Vyberte lidi do této skupiny. Jen oni uvidí její zprávy.';

  @override
  String get chooseAtLeastOne => 'Vyberte alespoň jednu osobu.';

  @override
  String get replyAction => 'Odpovědět';

  @override
  String get translateAction => 'Přeložit';

  @override
  String replyingTo(String name) {
    return 'Odpověď pro: $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Poslední zprávy od: $name';
  }

  @override
  String get deleteAllNotices => 'Smazat vše';

  @override
  String get deleteAllNoticesConfirm => 'Smazat všechna oznámení?';

  @override
  String get noticeRetention => 'Mazat přečtená oznámení po';

  @override
  String get retentionDay => '1 dni';

  @override
  String get retentionWeek => '1 týdnu';

  @override
  String get retentionMonth => '1 měsíci';

  @override
  String get billingOwnersOnly => 'Aktivní, jen pokud vlastníte firmu.';

  @override
  String get readOnlyPastDays => 'Dny starší než měsíc jsou jen pro čtení.';

  @override
  String get wholeCompany => 'Celá firma';

  @override
  String get sitesLabel => 'Pracoviště';

  @override
  String get actionSites => 'Pracoviště…';

  @override
  String managerOf(String name) {
    return '$name má na starosti';
  }

  @override
  String teamSitesOf(String name) {
    return 'Tým: $name';
  }

  @override
  String get notYourSite => 'Toto pracoviště nemáte na starosti.';

  @override
  String get chooseYourSite => 'Vyberte alespoň jedno pracoviště.';

  @override
  String get viewRequests => 'Žádosti';

  @override
  String get newRequest => 'Nová žádost';

  @override
  String get requestLeave => 'Dovolená';

  @override
  String get requestUnavailability => 'Nedostupnost';

  @override
  String get requestSwap => 'Výměna směny';

  @override
  String get swapHint =>
      'Chcete-li nabídnout výměnu, klepněte v plánu na jednu ze svých nadcházejících směn.';

  @override
  String get noRequests => 'Zatím žádné žádosti.';

  @override
  String get requestsToHandle => 'K vyřízení';

  @override
  String get myRequests => 'Moje žádosti';

  @override
  String get otherRequests => 'Žádosti týmu';

  @override
  String get statusPendingPeer => 'Čeká na kolegu';

  @override
  String get statusPendingManager => 'Čeká na vedoucího';

  @override
  String get statusApproved => 'Schváleno';

  @override
  String get statusRefused => 'Zamítnuto';

  @override
  String get statusCancelled => 'Zrušeno';

  @override
  String get cancelRequest => 'Zrušit žádost';

  @override
  String get acceptSwap => 'Převzít tuto směnu';

  @override
  String get approve => 'Schválit';

  @override
  String periodLabel(String from, String to) {
    return 'Od $from do $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Nabídnuto: $name';
  }

  @override
  String get swapToTeam => 'Celý tým';

  @override
  String everyWeekdays(String days) {
    return 'Každý týden: $days';
  }

  @override
  String get unavailableEveryWeek => 'Dny, kdy nikdy nejste k dispozici:';

  @override
  String get choosePeriod => 'Vybrat data';

  @override
  String get choosePeriodOptional => 'Omezit na období (volitelné)';

  @override
  String get clearPeriod => 'Bez období';

  @override
  String get sendRequest => 'Odeslat žádost';

  @override
  String get proposeSwap => 'Nabídnout výměnu';

  @override
  String get swapWith => 'Nabídnout';

  @override
  String get swapSteps =>
      'Kolega přijme, pak vedoucí schválí. Plán se změní až potom.';

  @override
  String get absentThatDay => 'Schválená nepřítomnost v tento den';

  @override
  String get requestSent => 'Žádost odeslána.';

  @override
  String noticeSwapOffer(String name) {
    return '$name vám nabízí jednu ze svých směn.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name odmítl vaši nabídku výměny.';
  }

  @override
  String get noticeSwapToApprove => 'Výměna směny čeká na vaše schválení.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name žádá o dovolenou.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name hlásí nedostupnost.';
  }

  @override
  String get noticeRequestApproved => 'Vaše žádost byla schválena.';

  @override
  String get noticeRequestRefused => 'Vaše žádost byla zamítnuta.';

  @override
  String get choosePeer => 'Kdo převezme tuto směnu?';

  @override
  String get discardAll => 'Zrušit vše';

  @override
  String get notifySitesHint =>
      'Vyberte pobočky, ze kterých dostáváte oznámení o žádostech. Všechny žádosti zůstávají vidět v seznamu.';

  @override
  String get notifySitesTitle => 'Oznámení podle pobočky';

  @override
  String get pendingRequestTooltip => 'Čekající žádost: klepnutím otevřete';

  @override
  String get requestsHistory => 'Všechny žádosti';

  @override
  String get revertChange => 'Vrátit tuto změnu';

  @override
  String get statusExpired => 'Neaktuální';

  @override
  String get swapWithHint => 'Klepnutím vyberte konkrétního kolegu';

  @override
  String changesDiscarded(String count) {
    return 'Zrušené změny: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Zrušit $count nezveřejněných změn?';
  }

  @override
  String get allSchedules => 'Všechny moje plány';

  @override
  String get busyElsewhere => 'V tuto dobu už pracuje v jiné firmě';

  @override
  String get overlapTooltip => 'Překrývá se se směnou v jiné firmě';

  @override
  String get overlapWarning =>
      'Některé vaše směny ve dvou firmách se překrývají.';

  @override
  String noticeOverlap(String date) {
    return 'Dvě vaše směny v různých firmách se překrývají $date.';
  }

  @override
  String get allMyCompanies => 'Všechny moje firmy';

  @override
  String get deleteGroup => 'Smazat skupinu';

  @override
  String get openRequest => 'Zobrazit žádost';

  @override
  String get thisCompany => 'Tato firma';

  @override
  String get withExtras => 'Včetně brigádníků';

  @override
  String deleteGroupConfirm(String name) {
    return 'Smazat „$name“ a všechny zprávy pro všechny?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Z firmy $company: bude přidán jako posila a upozorněn.';
  }

  @override
  String get addToGoogle => 'Přidat do Kalendáře Google';

  @override
  String get calendarEnabled => 'Synchronizovat mé směny';

  @override
  String get calendarHint =>
      'Přidejte své směny ze všech firem do Kalendáře Google. Aktualizují se samy a vypnout to můžete kdykoli.';

  @override
  String get changeSettings => 'Upravit';

  @override
  String get copyCalendarLink => 'Kopírovat odkaz na kalendář';

  @override
  String get countryBelgium => 'Belgie';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Francie';

  @override
  String get countrySwitzerland => 'Švýcarsko';

  @override
  String get employeesSection => 'Zaměstnanci';

  @override
  String get emptyNoAlert => 'Prázdné: bez upozornění';

  @override
  String get extrasSection => 'Brigádníci';

  @override
  String get googleCalendar => 'Kalendář Google';

  @override
  String get hoursTotals => 'Součty hodin';

  @override
  String get legalAlerts => 'Zákonná upozornění';

  @override
  String get legalAlertsHint =>
      'Jen upozornění, nikdy blokování. Zvolte pravidla, která u vás platí, nebo žádná.';

  @override
  String get legalPreset => 'Šablona země';

  @override
  String get linkCopied => 'Odkaz zkopírován.';

  @override
  String get maxConsecutiveLabel => 'Nejvíce pracovních dnů v řadě';

  @override
  String get maxDayLabel => 'Nejvyšší délka za den (hodiny)';

  @override
  String get maxWeekLabel => 'Nejvyšší délka za týden (hodiny)';

  @override
  String get minRestLabel => 'Nejmenší odpočinek mezi směnami (hodiny)';

  @override
  String get noLegalRules => 'Žádná upozornění nezvolena.';

  @override
  String get presetNone => 'Žádná';

  @override
  String get presetsCheck =>
      'Šablony jsou výchozí bod: ověřte je podle předpisů své země a kolektivní smlouvy.';

  @override
  String get printMine => 'Můj rozpis';

  @override
  String get printOwn => 'Jen vlastní rozpis';

  @override
  String get printPdf => 'Tisk / PDF';

  @override
  String get printRights => 'Co mohou zaměstnanci tisknout';

  @override
  String get printTeam => 'Rozpis celého týmu';

  @override
  String get printTeamOption => 'Rozpis týmu';

  @override
  String get totalsHint =>
      'Včetně konceptů. Exporty do Excelu a CSV berou zveřejněný rozpis.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value dní v řadě (nejvýše $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value za den (nejvýše $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: jen $value odpočinku (nejméně $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value za týden (nejvýše $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Zákonná upozornění: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Směny: $count';
  }

  @override
  String get actionMakeDeputy => 'Jmenovat zástupcem vedoucího';

  @override
  String get actionRemoveDeputy => 'Odebrat roli zástupce';

  @override
  String get busyHere => 'V tuto dobu už pracuje v této firmě';

  @override
  String get calendarByLink => 'Odkazem (Kalendář Google na počítači)';

  @override
  String get calendarDenied =>
      'Přístup ke kalendáři byl odepřen. Povolte ho v nastavení telefonu.';

  @override
  String get calendarLinkHint =>
      'Přidejte z Kalendáře Google na počítači; Google ho aktualizuje během několika hodin.';

  @override
  String get calendarNone => 'V telefonu není žádný upravitelný kalendář.';

  @override
  String get calendarOnPhone => 'Přidat mé směny do kalendáře telefonu';

  @override
  String get calendarOnPhoneHint =>
      'Ve vašem kalendáři Google: hned vidět v telefonu i v Kalendáři Google.';

  @override
  String get chooseCalendar => 'Vybrat kalendář';

  @override
  String get otherSiteHint =>
      'Zaměstnanec jiné pobočky: jeho vedoucí budou upozorněni.';

  @override
  String get subManager => 'Zástupce vedoucího';

  @override
  String calendarSynced(String count) {
    return 'Směny v kalendáři: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Zástupce vedoucího: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by zařadil $name na pobočku $site $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company vás přidala jako posilu.';
  }

  @override
  String get companyNotificationsHint =>
      'Vypnuto: v tomto telefonu nic nezvoní, ale vše zůstává ve zvonečku.';

  @override
  String get companyNotificationsOn => 'Dostávat oznámení této firmy';

  @override
  String get companyTimezone => 'Časové pásmo firmy';

  @override
  String get companyTimezoneHint =>
      'Všechny časy této firmy jsou v tomto pásmu (včetně letního času). Kalendáře je převádějí automaticky.';

  @override
  String get iosInstallHint =>
      'Na iPhonu: klepněte na Sdílet a pak na „Přidat na plochu“ a nainstalujte Staff Flow.';

  @override
  String get searchCity => 'Hledat město';

  @override
  String get thisPhone => 'Toto zařízení';

  @override
  String companyNotifications(String name) {
    return 'Oznámení: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Časy podle času $zone ($company). Vaše zařízení: $here.';
  }

  @override
  String get addPreset => 'Přidat předvolbu';

  @override
  String get addPresets => 'Vytvořit předvolby';

  @override
  String get appearance => 'Vzhled';

  @override
  String get chooseLogo => 'Vybrat obrázek PNG';

  @override
  String get conversationMuted => 'Oznámení této konverzace ztlumena.';

  @override
  String get conversationUnmuted => 'Oznámení této konverzace opět zapnuta.';

  @override
  String get customization => 'Přizpůsobení';

  @override
  String get disableGroup => 'Vypnout skupinu';

  @override
  String get disableGroupConfirm =>
      'Skupina celé firmy bude pro všechny skryta. Znovu ji zapnete ve Zprávách.';

  @override
  String get editPresets => 'Předvolby';

  @override
  String get enable => 'Znovu zapnout';

  @override
  String get groupDisabled => 'Skupina vypnuta (vidíte ji jen vy)';

  @override
  String get logoHint =>
      'Malý obrázek PNG (vaše logo) zobrazený na kartě firmy pro všechny její členy.';

  @override
  String get logoPngOnly => 'Vyberte obrázek PNG do 1 MB.';

  @override
  String get muteConversation => 'Ztlumit tuto konverzaci';

  @override
  String get myIdentifier => 'Můj identifikátor';

  @override
  String get myProfile => 'Můj profil';

  @override
  String get presetName => 'Název (např. Ranní)';

  @override
  String get removeLogo => 'Odebrat obrázek';

  @override
  String get resetGroup => 'Vymazat skupinu';

  @override
  String get resetGroupConfirm =>
      'Všechny zprávy skupiny firmy budou smazány pro všechny.';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get shiftPresets => 'Předvolby směn';

  @override
  String get shiftPresetsHint =>
      'Hotové časy (ranní, odpolední, noční…): jedním klepnutím ve směně vyplníte začátek i konec.';

  @override
  String get themeDark => 'Tmavý';

  @override
  String get themeLight => 'Světlý';

  @override
  String get themeSystem => 'Systémový';

  @override
  String get unmuteConversation => 'Zapnout oznámení této konverzace';

  @override
  String get awaitingApproval => 'Ke schválení';

  @override
  String get placementNeedsApproval =>
      '! Tato osoba není z vašich míst: směna počká na schválení nadřízeným nebo majitelem, než ji bude možné zveřejnit. Jinak vyberte někoho jiného.';

  @override
  String get placementAwaiting =>
      'Čeká na schválení nadřízeným nebo majitelem.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by chce naplánovat $name z jiného místa na $date: je třeba schválit.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by schválil(a) naplánování $name na $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by odmítl(a) naplánování $name na $date.';
  }
}
