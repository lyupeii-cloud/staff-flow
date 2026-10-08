// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class L10nBg extends L10n {
  L10nBg([String locale = 'bg']) : super(locale);

  @override
  String get cancel => 'Отказ';

  @override
  String get save => 'Запазване';

  @override
  String get confirm => 'Потвърждаване';

  @override
  String get validate => 'Потвърждаване';

  @override
  String get add => 'Добавяне';

  @override
  String get rename => 'Преименуване';

  @override
  String get delete => 'Изтриване';

  @override
  String get accept => 'Приемане';

  @override
  String get decline => 'Отказване';

  @override
  String get close => 'Затваряне';

  @override
  String get retry => 'Нов опит';

  @override
  String get name => 'Име';

  @override
  String get serverUnreachable => 'Няма връзка със сървъра.';

  @override
  String errorStatus(int status) {
    return 'Грешка $status';
  }

  @override
  String get roleOwner => 'Собственик';

  @override
  String get roleManager => 'Управител';

  @override
  String get roleEmployee => 'Служител';

  @override
  String get roleExtra => 'Временен служител';

  @override
  String get taglineStart => 'Графиците на екипа ви, ';

  @override
  String get taglineEnd => 'навсякъде.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Вход с Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Входът с Google не е достъпен: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Входът с Google е неуспешен: $detail';
  }

  @override
  String get newCompany => 'Нова фирма';

  @override
  String get timezone => 'Часова зона';

  @override
  String get create => 'Създаване';

  @override
  String get noCompanyTitle => 'Още не сте в нито една фирма.';

  @override
  String get noCompanyHint =>
      'За да се присъедините към фирмата на работодателя си, създайте код и го дайте на управителя си.';

  @override
  String get joinCompany => 'Присъединяване към фирма';

  @override
  String get createCompany => 'Създаване на фирма';

  @override
  String transferOffer(String company) {
    return 'Предлагат ви да станете собственик на „$company“.';
  }

  @override
  String get someCompany => 'фирма';

  @override
  String get becameOwner => 'Вече сте собственик.';

  @override
  String get myAccount => 'Моят профил';

  @override
  String get idCopied => 'Идентификаторът е копиран.';

  @override
  String myId(String id) {
    return 'Моят идентификатор: $id';
  }

  @override
  String get signOut => 'Изход';

  @override
  String joinInvite(String company, String role) {
    return '„$company“ ви кани като $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Присъединихте се към $company.';
  }

  @override
  String get viewPlanning => 'График';

  @override
  String get viewTeam => 'Екип';

  @override
  String get viewPositions => 'Длъжности';

  @override
  String get readOnlyCompany => 'Фирмата е само за четене.';

  @override
  String get team => 'Екип';

  @override
  String get leaveCompany => 'Напускане на фирмата';

  @override
  String meSuffix(String name) {
    return '$name (вие)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Прехвърляне на фирмата на $name?';
  }

  @override
  String get transferConfirmBody =>
      'След приемане този човек става собственик (абонамент, фактури, управители), а вие ставате управител.';

  @override
  String transferSent(String name) {
    return 'Предложението е изпратено на $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Премахване на $name?';
  }

  @override
  String get removeConfirmBody => 'Историята се запазва.';

  @override
  String get addPersonTitle => 'Добавяне на човек';

  @override
  String get addPersonHint =>
      'Помолете го да отвори Staff Flow, менюто на профила, „Присъединяване към фирма“, и въведете показания код.';

  @override
  String get sixDigitCode => 'Шестцифрен код';

  @override
  String invitationSent(String name) {
    return 'Поканата е изпратена на $name: трябва да я приеме.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Напускане на $company?';
  }

  @override
  String get leaveConfirmBody => 'Вече няма да виждате графика ѝ.';

  @override
  String get renameCompany => 'Преименуване на фирмата';

  @override
  String get actionMakeManager => 'Назначаване за управител';

  @override
  String get actionMakeEmployee => 'Отново служител';

  @override
  String get actionToEmployee => 'Промяна на служител';

  @override
  String get actionToExtra => 'Промяна на временен';

  @override
  String get actionTransfer => 'Прехвърляне на собствеността';

  @override
  String get actionRemove => 'Премахване от фирмата';

  @override
  String get positions => 'Длъжности';

  @override
  String get sites => 'Обекти';

  @override
  String get positionsHint => 'Какво прави човекът: каса, кухня, рецепция…';

  @override
  String get sitesHint => 'Къде е смяната, ако фирмата има няколко обекта.';

  @override
  String get archived => 'Архивирано';

  @override
  String get archive => 'Архивиране';

  @override
  String get reactivate => 'Възстановяване';

  @override
  String weekOf(String date) {
    return 'Седмицата от $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Публикувани са $count промени.',
      one: 'Публикувана е 1 промяна.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Смяна';

  @override
  String get display => 'Изглед';

  @override
  String get week => 'Седмица';

  @override
  String get month => 'Месец';

  @override
  String get today => 'Днес';

  @override
  String get onlyMine => 'Само моите смени';

  @override
  String get replacePersonMenu => 'Замяна на човек…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count непубликувани промени',
      one: '1 непубликувана промяна',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Служителите още не ги виждат.';

  @override
  String get publish => 'Публикуване';

  @override
  String yourHours(String duration) {
    return 'Вашите часове за периода: $duration';
  }

  @override
  String get addShiftThisDay => 'Добавяне на смяна в този ден';

  @override
  String get noShift => 'Няма смени';

  @override
  String get unassigned => 'Неразпределена';

  @override
  String get formerMember => 'Бивш член';

  @override
  String get statusDraft => 'Чернова';

  @override
  String get statusModified => 'Променена';

  @override
  String get statusDeleted => 'Изтрита';

  @override
  String durationHours(int hours) {
    return '$hours ч';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ч $minutes мин';
  }

  @override
  String get editShift => 'Редактиране на смяната';

  @override
  String get newShift => 'Нова смяна';

  @override
  String get thisShift => 'Само тази смяна';

  @override
  String get thisAndFollowing => 'Тази и следващите';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Дни',
      one: 'Ден',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Друг ден';

  @override
  String get start => 'Начало';

  @override
  String get end => 'Край';

  @override
  String get endsNextDay => 'Приключва на следващия ден.';

  @override
  String get person => 'Човек';

  @override
  String get position => 'Длъжност';

  @override
  String get site => 'Обект';

  @override
  String get noteOptional => 'Бележка (по избор)';

  @override
  String get repetition => 'Повторение';

  @override
  String get repeatNone => 'Без';

  @override
  String get repeatDaily => 'Всеки ден';

  @override
  String get repeatWeekly => 'Всяка седмица';

  @override
  String get repeatForPrefix => 'За ';

  @override
  String get repeatDaysSuffix => ' дни';

  @override
  String get repeatWeeksSuffix => ' седмици';

  @override
  String get repeatUntilPrefix => 'До ';

  @override
  String get replacePersonTitle => 'Замяна на човек';

  @override
  String get replaceFrom => 'Замяна на';

  @override
  String get replaceBy => 'С';

  @override
  String dateRange(String from, String to) {
    return 'От $from до $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Променени са $count смени.',
      one: 'Променена е 1 смяна.',
      zero: 'Няма променени смени.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Замяна';

  @override
  String get joinHint =>
      'Дайте този код на управителя си. След като го въведе в приложението, ще получите покана.';

  @override
  String get codeExpired => 'Кодът е изтекъл.';

  @override
  String codeValidFor(String time) {
    return 'Валиден още $time';
  }

  @override
  String get newCode => 'Нов код';

  @override
  String get language => 'Език';

  @override
  String get languageAuto => 'Автоматично (езикът на устройството)';

  @override
  String get syncUpToDate => 'Актуално';

  @override
  String get syncOffline => 'Офлайн';

  @override
  String syncPending(int count) {
    return 'Чакащи промени: $count';
  }

  @override
  String get syncNow => 'Синхронизиране';

  @override
  String syncRejected(String reason) {
    return 'Сървърът отказа промяната: $reason';
  }

  @override
  String get pendingBadge => 'Чака';

  @override
  String get offlineUnavailable => 'Не е достъпно офлайн.';

  @override
  String get offlineCached => 'Офлайн: последните запазени данни.';

  @override
  String get savedOffline =>
      'Запазено на устройството, ще се изпрати при връщане на мрежата.';

  @override
  String get notices => 'Известия';

  @override
  String get noNotices => 'Няма известия.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name замени вашата промяна на смяната от $date.';
  }

  @override
  String get history => 'История';

  @override
  String get recentChanges => 'Последни промени';

  @override
  String get undoChange => 'Отмяна на тази промяна';

  @override
  String get undoDone => 'Промяната е отменена.';

  @override
  String get historyCreate => 'Създаване';

  @override
  String get historyUpdate => 'Промяна';

  @override
  String get historyDelete => 'Изтриване';

  @override
  String get historyUndo => 'Отмяна';

  @override
  String get noHistory => 'Няма промени.';

  @override
  String get pendingNotEditable =>
      'Тази смяна още не е синхронизирана: опитайте отново онлайн.';

  @override
  String get myQrCode => 'Моят QR код';

  @override
  String get myQrCodeHint =>
      'Ръководител сканира този код, за да ви добави към фирмата си; след това потвърждавате. Кодът никога не се променя.';

  @override
  String get changeMyName => 'Промяна на името ми';

  @override
  String get nameShownToTeam =>
      'Това име се показва на колегите ви вместо името ви от Google.';

  @override
  String googleName(String name) {
    return 'Име в Google: $name';
  }

  @override
  String get useGoogleName => 'Използване на името от Google';

  @override
  String renameMemberTitle(String name) {
    return 'Преименуване: $name';
  }

  @override
  String get renameMemberHint => 'Това име се използва само в тази фирма.';

  @override
  String get useOwnName => 'Използване на собственото име';

  @override
  String get scanQrCode => 'Сканиране на QR код';

  @override
  String get scanQrHint =>
      'Насочете камерата към QR кода в приложението на човека (меню на профила, „Моят QR код“).';

  @override
  String get orEnterCode => 'Или въведете 6-цифрения му код';

  @override
  String get qrInvalid => 'Това не е QR код на Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Камерата не е достъпна ($error).';
  }

  @override
  String get notificationsTitle => 'Известия';

  @override
  String get notifChooseHint =>
      'Изберете за какво да получавате известия. Всичко остава видимо в камбанката.';

  @override
  String get notifPlanning => 'Графикът е публикуван или променен';

  @override
  String get notifRequests => 'Заявки: размени, отпуски, покани';

  @override
  String get notifMessages => 'Нови съобщения';

  @override
  String get notifOverlap => 'Застъпващи се смени между фирми';

  @override
  String get notifConflicts => 'Вашите промени, заменени от друг ръководител';

  @override
  String get notifBilling => 'Напомняния за абонамента';

  @override
  String get pushEnabled => 'Известията са включени на това устройство.';

  @override
  String get pushOff => 'Известията са изключени на това устройство.';

  @override
  String get pushBlocked =>
      'Известията са блокирани: разрешете ги в настройките на телефона или браузъра.';

  @override
  String get pushUnavailable => 'Известията не са достъпни на това устройство.';

  @override
  String get enablePush => 'Включване';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: графикът ви е публикуван или променен.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company иска да ви добави към екипа си.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name ви предлага да станете собственик на $company.';
  }
}
