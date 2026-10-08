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
}
