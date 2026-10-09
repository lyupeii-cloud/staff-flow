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

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name се присъедини към $company.';
  }

  @override
  String get messagesTab => 'Съобщения';

  @override
  String get wholeTeam => 'Целият екип';

  @override
  String get newConversation => 'Нов разговор';

  @override
  String get noMessages => 'Все още няма съобщения.';

  @override
  String get messageHint => 'Напишете съобщение';

  @override
  String get earlierMessages => 'По-стари съобщения';

  @override
  String get personLeftCompany => 'Този човек вече не е част от фирмата.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Нова група';

  @override
  String get editGroup => 'Редактиране на групата';

  @override
  String get groupName => 'Име на групата';

  @override
  String get groupMembersHint =>
      'Изберете хората в тази група. Само те ще виждат съобщенията ѝ.';

  @override
  String get chooseAtLeastOne => 'Изберете поне един човек.';

  @override
  String get replyAction => 'Отговор';

  @override
  String get translateAction => 'Превод';

  @override
  String replyingTo(String name) {
    return 'Отговор на $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Последни съобщения от $name';
  }

  @override
  String get deleteAllNotices => 'Изтрий всички';

  @override
  String get deleteAllNoticesConfirm => 'Да се изтрият ли всички известия?';

  @override
  String get noticeRetention => 'Изтриване на прочетените известия след';

  @override
  String get retentionDay => '1 ден';

  @override
  String get retentionWeek => '1 седмица';

  @override
  String get retentionMonth => '1 месец';

  @override
  String get billingOwnersOnly => 'Активно само ако притежавате фирма.';

  @override
  String get readOnlyPastDays =>
      'Дните отпреди повече от месец са само за четене.';

  @override
  String get wholeCompany => 'Цялата фирма';

  @override
  String get sitesLabel => 'Обекти';

  @override
  String get actionSites => 'Обекти…';

  @override
  String managerOf(String name) {
    return '$name отговаря за';
  }

  @override
  String teamSitesOf(String name) {
    return 'Екипът на $name';
  }

  @override
  String get notYourSite => 'Този обект не е под ваша отговорност.';

  @override
  String get chooseYourSite => 'Изберете поне един обект.';

  @override
  String get viewRequests => 'Заявки';

  @override
  String get newRequest => 'Нова заявка';

  @override
  String get requestLeave => 'Отпуск';

  @override
  String get requestUnavailability => 'Недостъпност';

  @override
  String get requestSwap => 'Размяна на смени';

  @override
  String get swapHint =>
      'За да предложите размяна, докоснете една от предстоящите си смени в графика.';

  @override
  String get noRequests => 'Все още няма заявки.';

  @override
  String get requestsToHandle => 'За обработка';

  @override
  String get myRequests => 'Моите заявки';

  @override
  String get otherRequests => 'Заявки на екипа';

  @override
  String get statusPendingPeer => 'Чака колегата';

  @override
  String get statusPendingManager => 'Чака ръководителя';

  @override
  String get statusApproved => 'Одобрена';

  @override
  String get statusRefused => 'Отказана';

  @override
  String get statusCancelled => 'Отменена';

  @override
  String get cancelRequest => 'Отмени заявката';

  @override
  String get acceptSwap => 'Поемам тази смяна';

  @override
  String get approve => 'Одобри';

  @override
  String periodLabel(String from, String to) {
    return 'От $from до $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Предложено на $name';
  }

  @override
  String get swapToTeam => 'Целият екип';

  @override
  String everyWeekdays(String days) {
    return 'Всяка седмица: $days';
  }

  @override
  String get unavailableEveryWeek =>
      'Дни, в които никога не сте на разположение:';

  @override
  String get choosePeriod => 'Изберете дати';

  @override
  String get choosePeriodOptional => 'Ограничи до период (по избор)';

  @override
  String get clearPeriod => 'Без период';

  @override
  String get sendRequest => 'Изпрати заявката';

  @override
  String get proposeSwap => 'Предложи размяна';

  @override
  String get swapWith => 'Предложи на';

  @override
  String get swapSteps =>
      'Колегата приема, после ръководител одобрява. Графикът се променя едва тогава.';

  @override
  String get absentThatDay => 'Одобрено отсъствие този ден';

  @override
  String get requestSent => 'Заявката е изпратена.';

  @override
  String noticeSwapOffer(String name) {
    return '$name ви предлага една от своите смени.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name отказа предложението ви за размяна.';
  }

  @override
  String get noticeSwapToApprove => 'Размяна на смени чака вашето одобрение.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name иска отпуск.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name съобщава, че не е на разположение.';
  }

  @override
  String get noticeRequestApproved => 'Заявката ви е одобрена.';

  @override
  String get noticeRequestRefused => 'Заявката ви е отказана.';

  @override
  String get choosePeer => 'Кой поема тази смяна?';

  @override
  String get discardAll => 'Отмени всичко';

  @override
  String get notifySitesHint =>
      'Изберете обектите, за които получавате известия за заявки. Всички заявки остават видими в списъка.';

  @override
  String get notifySitesTitle => 'Известия по обект';

  @override
  String get pendingRequestTooltip =>
      'Чакаща заявка: докоснете, за да я отворите';

  @override
  String get requestsHistory => 'Всички заявки';

  @override
  String get revertChange => 'Отмени тази промяна';

  @override
  String get statusExpired => 'Неактуална';

  @override
  String get swapWithHint => 'Докоснете, за да изберете конкретен колега';

  @override
  String changesDiscarded(String count) {
    return 'Отменени промени: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Да се отменят ли $count непубликувани промени?';
  }

  @override
  String get allSchedules => 'Всички мои графици';

  @override
  String get busyElsewhere => 'Вече е на смяна в друга фирма по това време';

  @override
  String get overlapTooltip => 'Застъпва се със смяна в друга фирма';

  @override
  String get overlapWarning => 'Някои ваши смени в две фирми се застъпват.';

  @override
  String noticeOverlap(String date) {
    return 'Две ваши смени в различни фирми се застъпват на $date.';
  }

  @override
  String get allMyCompanies => 'Всички мои фирми';

  @override
  String get deleteGroup => 'Изтрий групата';

  @override
  String get openRequest => 'Виж заявката';

  @override
  String get thisCompany => 'Тази фирма';

  @override
  String get withExtras => 'С допълнителните служители';

  @override
  String deleteGroupConfirm(String name) {
    return 'Да се изтрие ли „$name“ и всички съобщения за всички?';
  }

  @override
  String reinforcementHint(String company) {
    return 'От $company: ще бъде добавен като подкрепление и уведомен.';
  }

  @override
  String get addToGoogle => 'Добави в Google Календар';

  @override
  String get calendarEnabled => 'Синхронизирай моите смени';

  @override
  String get calendarHint =>
      'Добавете смените си от всички фирми в Google Календар. Те се обновяват сами и можете да изключите по всяко време.';

  @override
  String get changeSettings => 'Промени';

  @override
  String get copyCalendarLink => 'Копирай връзката към календара';

  @override
  String get countryBelgium => 'Белгия';

  @override
  String get countryCanada => 'Канада';

  @override
  String get countryFrance => 'Франция';

  @override
  String get countrySwitzerland => 'Швейцария';

  @override
  String get employeesSection => 'Служители';

  @override
  String get emptyNoAlert => 'Празно: без предупреждение';

  @override
  String get extrasSection => 'Допълнителни';

  @override
  String get googleCalendar => 'Google Календар';

  @override
  String get hoursTotals => 'Общо часове';

  @override
  String get legalAlerts => 'Законови предупреждения';

  @override
  String get legalAlertsHint =>
      'Само предупреждения, никога блокиране. Изберете правилата, които важат за вас, или никакви.';

  @override
  String get legalPreset => 'Шаблон по държава';

  @override
  String get linkCopied => 'Връзката е копирана.';

  @override
  String get maxConsecutiveLabel => 'Максимум последователни работни дни';

  @override
  String get maxDayLabel => 'Максимална продължителност на ден (часове)';

  @override
  String get maxWeekLabel => 'Максимална продължителност на седмица (часове)';

  @override
  String get minRestLabel => 'Минимална почивка между смени (часове)';

  @override
  String get noLegalRules => 'Няма избрани предупреждения.';

  @override
  String get presetNone => 'Няма';

  @override
  String get presetsCheck =>
      'Шаблоните са отправна точка: проверете ги според законите на вашата държава и колективния трудов договор.';

  @override
  String get printMine => 'Моят график';

  @override
  String get printOwn => 'Само собствения си график';

  @override
  String get printPdf => 'Печат / PDF';

  @override
  String get printRights => 'Какво могат да печатат служителите';

  @override
  String get printTeam => 'Графика на целия екип';

  @override
  String get printTeamOption => 'Графика на екипа';

  @override
  String get totalsHint =>
      'Включително чернови. Експортът в Excel и CSV използва публикувания график.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value поредни дни (максимум $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value за деня (максимум $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: само $value почивка (минимум $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value за седмицата (максимум $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Законови предупреждения: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Смени: $count';
  }

  @override
  String get actionMakeDeputy => 'Назначи за заместник-ръководител';

  @override
  String get actionRemoveDeputy => 'Премахни ролята на заместник';

  @override
  String get busyHere => 'Вече е на смяна във фирмата по това време';

  @override
  String get calendarByLink => 'Чрез връзка (Google Календар на компютър)';

  @override
  String get calendarDenied =>
      'Достъпът до календара е отказан. Разрешете го в настройките на телефона.';

  @override
  String get calendarLinkHint =>
      'Добавете го от Google Календар на компютър; Google го обновява до няколко часа.';

  @override
  String get calendarNone => 'Няма календар за редактиране на този телефон.';

  @override
  String get calendarOnPhone => 'Добави смените ми в календара на телефона';

  @override
  String get calendarOnPhoneHint =>
      'Във вашия Google календар: видимо веднага, на телефона и в Google Календар.';

  @override
  String get chooseCalendar => 'Избери календар';

  @override
  String get otherSiteHint =>
      'Служител от друг обект: ръководителите му ще бъдат уведомени.';

  @override
  String get subManager => 'Заместник-ръководител';

  @override
  String calendarSynced(String count) {
    return 'Смени в календара: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Заместник-ръководител: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by постави $name на обект $site на $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company ви добави като подкрепление.';
  }

  @override
  String get companyNotificationsHint =>
      'Изключени: на този телефон нищо не звъни, но всичко остава в звънчето.';

  @override
  String get companyNotificationsOn => 'Получавай известия от тази фирма';

  @override
  String get companyTimezone => 'Часова зона на фирмата';

  @override
  String get companyTimezoneHint =>
      'Всички часове на тази фирма са в тази зона (с лятното време). Календарите ги преобразуват автоматично.';

  @override
  String get iosInstallHint =>
      'На iPhone: докоснете „Сподели“, после „Добави към началния екран“, за да инсталирате Staff Flow.';

  @override
  String get searchCity => 'Търси град';

  @override
  String get thisPhone => 'Това устройство';

  @override
  String companyNotifications(String name) {
    return 'Известия: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Часове по времето в $zone ($company). Вашето устройство: $here.';
  }

  @override
  String get addPreset => 'Добави шаблон';

  @override
  String get addPresets => 'Създай шаблони';

  @override
  String get appearance => 'Външен вид';

  @override
  String get chooseLogo => 'Избери PNG изображение';

  @override
  String get conversationMuted => 'Известията за този разговор са заглушени.';

  @override
  String get conversationUnmuted =>
      'Известията за този разговор отново са включени.';

  @override
  String get customization => 'Персонализиране';

  @override
  String get disableGroup => 'Изключи групата';

  @override
  String get disableGroupConfirm =>
      'Групата на цялата фирма ще бъде скрита за всички. Можете да я включите отново в Съобщения.';

  @override
  String get editPresets => 'Шаблони';

  @override
  String get enable => 'Включи отново';

  @override
  String get groupDisabled => 'Групата е изключена (виждате я само вие)';

  @override
  String get logoHint =>
      'Малко PNG изображение (вашето лого) в раздела на фирмата за всички членове.';

  @override
  String get logoPngOnly => 'Изберете PNG изображение до 1 MB.';

  @override
  String get muteConversation => 'Заглуши този разговор';

  @override
  String get myIdentifier => 'Моят идентификатор';

  @override
  String get myProfile => 'Моят профил';

  @override
  String get presetName => 'Име (напр. Сутрин)';

  @override
  String get removeLogo => 'Премахни изображението';

  @override
  String get resetGroup => 'Нулирай групата';

  @override
  String get resetGroupConfirm =>
      'Всички съобщения в групата на фирмата ще бъдат изтрити за всички.';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get shiftPresets => 'Шаблони за смени';

  @override
  String get shiftPresetsHint =>
      'Готови часове (сутрин, вечер, нощ…): едно докосване в смяна попълва началото и края.';

  @override
  String get themeDark => 'Тъмен';

  @override
  String get themeLight => 'Светъл';

  @override
  String get themeSystem => 'Системен';

  @override
  String get unmuteConversation => 'Включи известията за този разговор';

  @override
  String get awaitingApproval => 'За одобрение';

  @override
  String get placementNeedsApproval =>
      '! Този човек не е от вашите обекти: смяната ще чака одобрение от вашия началник или собственика, преди да бъде публикувана. Иначе изберете друг.';

  @override
  String get placementAwaiting => 'Чака одобрение от началник или собственика.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by иска да планира $name от друг обект на $date: нужно е одобрение.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by одобри планирането на $name на $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by отказа планирането на $name на $date.';
  }

  @override
  String get addSubSite => 'Добавяне на подобект';

  @override
  String get moveSite => 'Преместване';

  @override
  String get topLevel => 'Първо ниво';

  @override
  String moveSiteTitle(String name) {
    return 'Преместване на „$name“ под…';
  }

  @override
  String subSiteOf(String name) {
    return 'Подобект на $name';
  }

  @override
  String get siteTreeHint =>
      'До 3 нива, напр. Регион › Град › Магазин. Управителят на обект управлява и всичко под него.';

  @override
  String get subSitesOnlyHint => 'Тук добавяте подобекти към своите обекти.';
}
