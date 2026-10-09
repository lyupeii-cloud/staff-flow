// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class L10nUk extends L10n {
  L10nUk([String locale = 'uk']) : super(locale);

  @override
  String get cancel => 'Скасувати';

  @override
  String get save => 'Зберегти';

  @override
  String get confirm => 'Підтвердити';

  @override
  String get validate => 'Підтвердити';

  @override
  String get add => 'Додати';

  @override
  String get rename => 'Перейменувати';

  @override
  String get delete => 'Видалити';

  @override
  String get accept => 'Прийняти';

  @override
  String get decline => 'Відхилити';

  @override
  String get close => 'Закрити';

  @override
  String get retry => 'Спробувати ще';

  @override
  String get name => 'Назва';

  @override
  String get serverUnreachable => 'Сервер недоступний.';

  @override
  String errorStatus(int status) {
    return 'Помилка $status';
  }

  @override
  String get roleOwner => 'Власник';

  @override
  String get roleManager => 'Керівник';

  @override
  String get roleEmployee => 'Працівник';

  @override
  String get roleExtra => 'Тимчасовий працівник';

  @override
  String get taglineStart => 'Графіки вашої команди — ';

  @override
  String get taglineEnd => 'будь-де.';

  @override
  String get googleNotConfigured =>
      'Вхід через Google не налаштовано (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Увійти через Google';

  @override
  String get devSection => 'Розробка';

  @override
  String get emailLabel => 'Електронна адреса';

  @override
  String get devSignIn => 'Тестовий вхід';

  @override
  String googleUnavailable(String detail) {
    return 'Вхід через Google недоступний: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Не вдалося увійти через Google: $detail';
  }

  @override
  String get newCompany => 'Нова компанія';

  @override
  String get timezone => 'Часовий пояс';

  @override
  String get create => 'Створити';

  @override
  String get noCompanyTitle => 'Ви ще не входите до жодної компанії.';

  @override
  String get noCompanyHint =>
      'Щоб приєднатися до компанії роботодавця, згенеруйте код і передайте його керівнику.';

  @override
  String get joinCompany => 'Приєднатися до компанії';

  @override
  String get createCompany => 'Створити компанію';

  @override
  String transferOffer(String company) {
    return 'Вам пропонують стати власником компанії «$company».';
  }

  @override
  String get someCompany => 'компанія';

  @override
  String get becameOwner => 'Тепер ви власник.';

  @override
  String get myAccount => 'Мій обліковий запис';

  @override
  String get idCopied => 'Ідентифікатор скопійовано.';

  @override
  String myId(String id) {
    return 'Мій ідентифікатор: $id';
  }

  @override
  String get signOut => 'Вийти';

  @override
  String joinInvite(String company, String role) {
    return '«$company» запрошує вас як: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Ви приєдналися до «$company».';
  }

  @override
  String get viewPlanning => 'Графік';

  @override
  String get viewTeam => 'Команда';

  @override
  String get viewPositions => 'Посади';

  @override
  String get readOnlyCompany => 'Компанія доступна лише для перегляду.';

  @override
  String get team => 'Команда';

  @override
  String get leaveCompany => 'Вийти з компанії';

  @override
  String meSuffix(String name) {
    return '$name (ви)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Передати компанію: $name?';
  }

  @override
  String get transferConfirmBody =>
      'Після підтвердження ця особа стане власником (підписка, рахунки, керівники), а ви — керівником.';

  @override
  String transferSent(String name) {
    return 'Пропозицію надіслано: $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Вилучити: $name?';
  }

  @override
  String get removeConfirmBody => 'Історію буде збережено.';

  @override
  String get addPersonTitle => 'Додати особу';

  @override
  String get addPersonHint =>
      'Попросіть відкрити Staff Flow, меню облікового запису, «Приєднатися до компанії», і введіть показаний код.';

  @override
  String get sixDigitCode => '6-значний код';

  @override
  String invitationSent(String name) {
    return 'Запрошення надіслано: $name. Його потрібно прийняти.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Вийти з «$company»?';
  }

  @override
  String get leaveConfirmBody => 'Ви більше не бачитимете її графік.';

  @override
  String get renameCompany => 'Перейменувати компанію';

  @override
  String get actionMakeManager => 'Призначити керівником';

  @override
  String get actionMakeEmployee => 'Знову зробити працівником';

  @override
  String get actionToEmployee => 'Зробити працівником';

  @override
  String get actionToExtra => 'Зробити тимчасовим';

  @override
  String get actionTransfer => 'Передати право власності';

  @override
  String get actionRemove => 'Вилучити з компанії';

  @override
  String get positions => 'Посади';

  @override
  String get sites => 'Об’єкти';

  @override
  String get positionsHint => 'Що робить людина: каса, кухня, рецепція…';

  @override
  String get sitesHint =>
      'Де відбувається зміна, якщо в компанії кілька місць.';

  @override
  String get archived => 'В архіві';

  @override
  String get archive => 'Архівувати';

  @override
  String get reactivate => 'Відновити';

  @override
  String weekOf(String date) {
    return 'Тиждень з $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Опубліковано $count зміни.',
      many: 'Опубліковано $count змін.',
      few: 'Опубліковано $count зміни.',
      one: 'Опубліковано $count зміну.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Зміна';

  @override
  String get display => 'Вигляд';

  @override
  String get week => 'Тиждень';

  @override
  String get month => 'Місяць';

  @override
  String get today => 'Сьогодні';

  @override
  String get onlyMine => 'Лише мої зміни';

  @override
  String get replacePersonMenu => 'Замінити особу…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count неопублікованої зміни',
      many: '$count неопублікованих змін',
      few: '$count неопубліковані зміни',
      one: '$count неопублікована зміна',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Працівники їх ще не бачать.';

  @override
  String get publish => 'Опублікувати';

  @override
  String yourHours(String duration) {
    return 'Ваші години за період: $duration';
  }

  @override
  String get addShiftThisDay => 'Додати зміну цього дня';

  @override
  String get noShift => 'Немає змін';

  @override
  String get unassigned => 'Не призначено';

  @override
  String get formerMember => 'Колишній учасник';

  @override
  String get statusDraft => 'Чернетка';

  @override
  String get statusModified => 'Змінено';

  @override
  String get statusDeleted => 'Видалено';

  @override
  String durationHours(int hours) {
    return '$hours год';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours год $minutes хв';
  }

  @override
  String get editShift => 'Редагувати зміну';

  @override
  String get newShift => 'Нова зміна';

  @override
  String get thisShift => 'Лише ця зміна';

  @override
  String get thisAndFollowing => 'Ця й наступні';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Дні',
      one: 'День',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Інший день';

  @override
  String get start => 'Початок';

  @override
  String get end => 'Кінець';

  @override
  String get endsNextDay => 'Закінчується наступного дня.';

  @override
  String get person => 'Особа';

  @override
  String get position => 'Посада';

  @override
  String get site => 'Об’єкт';

  @override
  String get noteOptional => 'Примітка (необов’язково)';

  @override
  String get repetition => 'Повторення';

  @override
  String get repeatNone => 'Немає';

  @override
  String get repeatDaily => 'Щодня';

  @override
  String get repeatWeekly => 'Щотижня';

  @override
  String get repeatForPrefix => 'Протягом ';

  @override
  String get repeatDaysSuffix => ' дн.';

  @override
  String get repeatWeeksSuffix => ' тиж.';

  @override
  String get repeatUntilPrefix => 'До ';

  @override
  String get replacePersonTitle => 'Замінити особу';

  @override
  String get replaceFrom => 'Замінити';

  @override
  String get replaceBy => 'На';

  @override
  String dateRange(String from, String to) {
    return 'З $from по $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Змінено $count зміни.',
      many: 'Змінено $count змін.',
      few: 'Змінено $count зміни.',
      one: 'Змінено $count зміну.',
      zero: 'Жодну зміну не змінено.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Замінити';

  @override
  String get joinHint =>
      'Передайте цей код керівнику. Він введе його у своєму застосунку, а ви отримаєте запрошення.';

  @override
  String get codeExpired => 'Термін дії коду минув.';

  @override
  String codeValidFor(String time) {
    return 'Дійсний ще $time';
  }

  @override
  String get newCode => 'Новий код';

  @override
  String get language => 'Мова';

  @override
  String get languageAuto => 'Автоматично (мова пристрою)';

  @override
  String get syncUpToDate => 'Актуально';

  @override
  String get syncOffline => 'Немає з’єднання';

  @override
  String syncPending(int count) {
    return 'Зміни в черзі: $count';
  }

  @override
  String get syncNow => 'Синхронізувати';

  @override
  String syncRejected(String reason) {
    return 'Сервер відхилив зміну: $reason';
  }

  @override
  String get pendingBadge => 'У черзі';

  @override
  String get offlineUnavailable => 'Недоступно без з’єднання.';

  @override
  String get offlineCached =>
      'Немає з’єднання: показано останні збережені дані.';

  @override
  String get savedOffline =>
      'Збережено на пристрої, буде надіслано, коли з’явиться мережа.';

  @override
  String get notices => 'Сповіщення';

  @override
  String get noNotices => 'Сповіщень немає.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name замінив(ла) вашу зміну у зміні за $date.';
  }

  @override
  String get history => 'Історія';

  @override
  String get recentChanges => 'Останні зміни';

  @override
  String get undoChange => 'Скасувати цю зміну';

  @override
  String get undoDone => 'Зміну скасовано.';

  @override
  String get historyCreate => 'Створення';

  @override
  String get historyUpdate => 'Редагування';

  @override
  String get historyDelete => 'Видалення';

  @override
  String get historyUndo => 'Скасування';

  @override
  String get noHistory => 'Змін немає.';

  @override
  String get pendingNotEditable =>
      'Цю зміну ще не синхронізовано: спробуйте знову, коли буде з’єднання.';

  @override
  String get myQrCode => 'Мій QR-код';

  @override
  String get myQrCodeHint =>
      'Керівник сканує цей код, щоб додати вас до своєї компанії; потім ви підтверджуєте. Код ніколи не змінюється.';

  @override
  String get changeMyName => 'Змінити моє ім\'я';

  @override
  String get nameShownToTeam =>
      'Це ім\'я бачать ваші колеги замість імені з Google.';

  @override
  String googleName(String name) {
    return 'Ім\'я в Google: $name';
  }

  @override
  String get useGoogleName => 'Повернути ім\'я з Google';

  @override
  String renameMemberTitle(String name) {
    return 'Перейменувати: $name';
  }

  @override
  String get renameMemberHint =>
      'Це ім\'я використовується лише в цій компанії.';

  @override
  String get useOwnName => 'Повернути власне ім\'я';

  @override
  String get scanQrCode => 'Сканувати QR-код';

  @override
  String get scanQrHint =>
      'Наведіть камеру на QR-код у його застосунку (меню облікового запису, «Мій QR-код»).';

  @override
  String get orEnterCode => 'Або введіть його 6-значний код';

  @override
  String get qrInvalid => 'Це не QR-код Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Камера недоступна ($error).';
  }

  @override
  String get notificationsTitle => 'Сповіщення';

  @override
  String get notifChooseHint =>
      'Оберіть, про що отримувати сповіщення. Усе залишається видимим у дзвіночку.';

  @override
  String get notifPlanning => 'Графік опубліковано або змінено';

  @override
  String get notifRequests => 'Запити: обміни, відпустки, запрошення';

  @override
  String get notifMessages => 'Нові повідомлення';

  @override
  String get notifOverlap => 'Накладання змін між компаніями';

  @override
  String get notifConflicts => 'Ваші зміни замінив інший керівник';

  @override
  String get notifBilling => 'Нагадування про підписку';

  @override
  String get pushEnabled => 'Сповіщення на цьому пристрої увімкнено.';

  @override
  String get pushOff => 'Сповіщення на цьому пристрої вимкнено.';

  @override
  String get pushBlocked =>
      'Сповіщення заблоковано: дозвольте їх у налаштуваннях телефона або браузера.';

  @override
  String get pushUnavailable => 'Сповіщення недоступні на цьому пристрої.';

  @override
  String get enablePush => 'Увімкнути';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: ваш графік опубліковано або змінено.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company хоче додати вас до своєї команди.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name пропонує вам стати власником $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name приєднався до $company.';
  }

  @override
  String get messagesTab => 'Повідомлення';

  @override
  String get wholeTeam => 'Уся команда';

  @override
  String get newConversation => 'Нова розмова';

  @override
  String get noMessages => 'Ще немає повідомлень.';

  @override
  String get messageHint => 'Напишіть повідомлення';

  @override
  String get earlierMessages => 'Попередні повідомлення';

  @override
  String get personLeftCompany => 'Ця особа більше не є учасником компанії.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Нова група';

  @override
  String get editGroup => 'Змінити групу';

  @override
  String get groupName => 'Назва групи';

  @override
  String get groupMembersHint =>
      'Оберіть людей для цієї групи. Лише вони бачитимуть її повідомлення.';

  @override
  String get chooseAtLeastOne => 'Оберіть щонайменше одну людину.';

  @override
  String get replyAction => 'Відповісти';

  @override
  String get translateAction => 'Перекласти';

  @override
  String replyingTo(String name) {
    return 'Відповідь для $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Останні повідомлення від $name';
  }

  @override
  String get deleteAllNotices => 'Видалити все';

  @override
  String get deleteAllNoticesConfirm => 'Видалити всі сповіщення?';

  @override
  String get noticeRetention => 'Видаляти прочитані сповіщення через';

  @override
  String get retentionDay => '1 день';

  @override
  String get retentionWeek => '1 тиждень';

  @override
  String get retentionMonth => '1 місяць';

  @override
  String get billingOwnersOnly => 'Діє лише, якщо ви власник компанії.';

  @override
  String get readOnlyPastDays =>
      'Дні, що минули понад місяць тому, доступні лише для перегляду.';

  @override
  String get wholeCompany => 'Уся компанія';

  @override
  String get sitesLabel => 'Підрозділи';

  @override
  String get actionSites => 'Підрозділи…';

  @override
  String managerOf(String name) {
    return '$name керує';
  }

  @override
  String teamSitesOf(String name) {
    return 'Команда: $name';
  }

  @override
  String get notYourSite => 'Цей підрозділ не у вашому віданні.';

  @override
  String get chooseYourSite => 'Оберіть щонайменше один підрозділ.';

  @override
  String get viewRequests => 'Запити';

  @override
  String get newRequest => 'Новий запит';

  @override
  String get requestLeave => 'Відпустка';

  @override
  String get requestUnavailability => 'Недоступність';

  @override
  String get requestSwap => 'Обмін змінами';

  @override
  String get swapHint =>
      'Щоб запропонувати обмін, торкніться однієї зі своїх майбутніх змін у графіку.';

  @override
  String get noRequests => 'Запитів поки немає.';

  @override
  String get requestsToHandle => 'Потребують дії';

  @override
  String get myRequests => 'Мої запити';

  @override
  String get otherRequests => 'Запити команди';

  @override
  String get statusPendingPeer => 'Очікує колегу';

  @override
  String get statusPendingManager => 'Очікує керівника';

  @override
  String get statusApproved => 'Схвалено';

  @override
  String get statusRefused => 'Відхилено';

  @override
  String get statusCancelled => 'Скасовано';

  @override
  String get cancelRequest => 'Скасувати запит';

  @override
  String get acceptSwap => 'Взяти цю зміну';

  @override
  String get approve => 'Схвалити';

  @override
  String periodLabel(String from, String to) {
    return 'З $from по $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Запропоновано: $name';
  }

  @override
  String get swapToTeam => 'Уся команда';

  @override
  String everyWeekdays(String days) {
    return 'Щотижня: $days';
  }

  @override
  String get unavailableEveryWeek => 'Дні, коли ви ніколи не доступні:';

  @override
  String get choosePeriod => 'Вибрати дати';

  @override
  String get choosePeriodOptional => 'Обмежити періодом (необов\'язково)';

  @override
  String get clearPeriod => 'Без періоду';

  @override
  String get sendRequest => 'Надіслати запит';

  @override
  String get proposeSwap => 'Запропонувати обмін';

  @override
  String get swapWith => 'Запропонувати';

  @override
  String get swapSteps =>
      'Колега погоджується, потім керівник схвалює. Графік змінюється лише після цього.';

  @override
  String get absentThatDay => 'Схвалена відсутність цього дня';

  @override
  String get requestSent => 'Запит надіслано.';

  @override
  String noticeSwapOffer(String name) {
    return '$name пропонує вам одну зі своїх змін.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name відхилив вашу пропозицію обміну.';
  }

  @override
  String get noticeSwapToApprove => 'Обмін змінами чекає вашого підтвердження.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name просить відпустку.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name повідомляє про недоступність.';
  }

  @override
  String get noticeRequestApproved => 'Ваш запит схвалено.';

  @override
  String get noticeRequestRefused => 'Ваш запит відхилено.';

  @override
  String get choosePeer => 'Хто візьме цю зміну?';

  @override
  String get discardAll => 'Скасувати все';

  @override
  String get notifySitesHint =>
      'Оберіть локації, з яких ви отримуєте сповіщення про запити. Усі запити залишаються видимими у списку.';

  @override
  String get notifySitesTitle => 'Сповіщення за локаціями';

  @override
  String get pendingRequestTooltip => 'Запит очікує: торкніться, щоб відкрити';

  @override
  String get requestsHistory => 'Усі запити';

  @override
  String get revertChange => 'Скасувати цю зміну';

  @override
  String get statusExpired => 'Неактуально';

  @override
  String get swapWithHint => 'Торкніться, щоб обрати конкретного колегу';

  @override
  String changesDiscarded(String count) {
    return 'Скасовано змін: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Скасувати $count неопублікованих змін?';
  }

  @override
  String get allSchedules => 'Усі мої графіки';

  @override
  String get busyElsewhere => 'Уже працює в іншій компанії в цей час';

  @override
  String get overlapTooltip => 'Перетинається зі зміною в іншій компанії';

  @override
  String get overlapWarning =>
      'Деякі ваші зміни у двох компаніях перетинаються.';

  @override
  String noticeOverlap(String date) {
    return 'Дві ваші зміни в різних компаніях перетинаються $date.';
  }

  @override
  String get allMyCompanies => 'Усі мої компанії';

  @override
  String get deleteGroup => 'Видалити групу';

  @override
  String get openRequest => 'Переглянути запит';

  @override
  String get thisCompany => 'Ця компанія';

  @override
  String get withExtras => 'Разом із позаштатними';

  @override
  String deleteGroupConfirm(String name) {
    return 'Видалити «$name» і всі повідомлення для всіх?';
  }

  @override
  String reinforcementHint(String company) {
    return 'З компанії $company: буде додано як підсилення й повідомлено.';
  }

  @override
  String get addToGoogle => 'Додати в Google Календар';

  @override
  String get calendarEnabled => 'Синхронізувати мої зміни';

  @override
  String get calendarHint =>
      'Додайте свої зміни з усіх компаній у Google Календар. Вони оновлюються самі, і ви можете вимкнути це будь-коли.';

  @override
  String get changeSettings => 'Змінити';

  @override
  String get copyCalendarLink => 'Копіювати посилання на календар';

  @override
  String get countryBelgium => 'Бельгія';

  @override
  String get countryCanada => 'Канада';

  @override
  String get countryFrance => 'Франція';

  @override
  String get countrySwitzerland => 'Швейцарія';

  @override
  String get employeesSection => 'Працівники';

  @override
  String get emptyNoAlert => 'Порожньо: без попередження';

  @override
  String get extrasSection => 'Позаштатні';

  @override
  String get googleCalendar => 'Google Календар';

  @override
  String get hoursTotals => 'Підсумки годин';

  @override
  String get legalAlerts => 'Попередження за законом';

  @override
  String get legalAlertsHint =>
      'Лише попередження, без блокувань. Оберіть правила, що діють у вас, або жодних.';

  @override
  String get legalPreset => 'Шаблон країни';

  @override
  String get linkCopied => 'Посилання скопійовано.';

  @override
  String get maxConsecutiveLabel => 'Максимум робочих днів поспіль';

  @override
  String get maxDayLabel => 'Максимум годин на день';

  @override
  String get maxWeekLabel => 'Максимум годин на тиждень';

  @override
  String get minRestLabel => 'Мінімальний відпочинок між змінами (години)';

  @override
  String get noLegalRules => 'Попередження не вибрано.';

  @override
  String get presetNone => 'Жодного';

  @override
  String get presetsCheck =>
      'Шаблони — лише відправна точка: перевірте їх за законами вашої країни та колективним договором.';

  @override
  String get printMine => 'Мій графік';

  @override
  String get printOwn => 'Лише власний графік';

  @override
  String get printPdf => 'Друк / PDF';

  @override
  String get printRights => 'Що можуть друкувати працівники';

  @override
  String get printTeam => 'Графік усієї команди';

  @override
  String get printTeamOption => 'Графік команди';

  @override
  String get totalsHint =>
      'Разом із чернетками. Експорт в Excel і CSV бере опублікований графік.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value днів поспіль (максимум $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value за день (максимум $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: лише $value відпочинку (мінімум $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value за тиждень (максимум $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Попередження за законом: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Змін: $count';
  }

  @override
  String get actionMakeDeputy => 'Призначити заступником керівника';

  @override
  String get actionRemoveDeputy => 'Зняти роль заступника';

  @override
  String get busyHere => 'Уже працює в компанії в цей час';

  @override
  String get calendarByLink => 'За посиланням (Google Календар на комп\'ютері)';

  @override
  String get calendarDenied =>
      'Доступ до календаря заборонено. Дозвольте його в налаштуваннях телефона.';

  @override
  String get calendarLinkHint =>
      'Додайте з Google Календаря на комп\'ютері; Google оновлює його за кілька годин.';

  @override
  String get calendarNone => 'На цьому телефоні немає календаря для запису.';

  @override
  String get calendarOnPhone => 'Додати мої зміни в календар телефона';

  @override
  String get calendarOnPhoneHint =>
      'У вашому календарі Google: одразу видно на телефоні та в Google Календарі.';

  @override
  String get chooseCalendar => 'Вибрати календар';

  @override
  String get otherSiteHint =>
      'Працівник іншої локації: його керівників буде повідомлено.';

  @override
  String get subManager => 'Заступник керівника';

  @override
  String calendarSynced(String count) {
    return 'Змін у календарі: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Заступник керівника: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by поставив $name на локацію $site $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company додала вас як підсилення.';
  }

  @override
  String get companyNotificationsHint =>
      'Вимкнено: на цьому телефоні нічого не дзвенить, але все лишається в дзвіночку.';

  @override
  String get companyNotificationsOn =>
      'Отримувати сповіщення від цієї компанії';

  @override
  String get companyTimezone => 'Часовий пояс компанії';

  @override
  String get companyTimezoneHint =>
      'Усі години цієї компанії — за цим часом (з урахуванням літнього часу). Календарі перераховують їх автоматично.';

  @override
  String get iosInstallHint =>
      'На iPhone: торкніться «Поділитися», потім «На початковий екран», щоб установити Staff Flow.';

  @override
  String get searchCity => 'Шукати місто';

  @override
  String get thisPhone => 'Цей пристрій';

  @override
  String companyNotifications(String name) {
    return 'Сповіщення: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Години за часом $zone ($company). Ваш пристрій: $here.';
  }

  @override
  String get addPreset => 'Додати шаблон';

  @override
  String get addPresets => 'Створити шаблони';

  @override
  String get appearance => 'Вигляд';

  @override
  String get chooseLogo => 'Вибрати зображення PNG';

  @override
  String get conversationMuted => 'Сповіщення цієї розмови вимкнено.';

  @override
  String get conversationUnmuted => 'Сповіщення цієї розмови знову ввімкнено.';

  @override
  String get customization => 'Персоналізація';

  @override
  String get disableGroup => 'Вимкнути групу';

  @override
  String get disableGroupConfirm =>
      'Групу всієї компанії буде приховано для всіх. Увімкнути її знову можна в «Повідомленнях».';

  @override
  String get editPresets => 'Шаблони';

  @override
  String get enable => 'Увімкнути знову';

  @override
  String get groupDisabled => 'Групу вимкнено (бачите лише ви)';

  @override
  String get logoHint =>
      'Невелике зображення PNG (ваш логотип) на вкладці компанії для всіх її учасників.';

  @override
  String get logoPngOnly => 'Виберіть зображення PNG до 1 МБ.';

  @override
  String get muteConversation => 'Вимкнути сповіщення цієї розмови';

  @override
  String get myIdentifier => 'Мій ідентифікатор';

  @override
  String get myProfile => 'Мій профіль';

  @override
  String get presetName => 'Назва (напр. Ранок)';

  @override
  String get removeLogo => 'Прибрати зображення';

  @override
  String get resetGroup => 'Очистити групу';

  @override
  String get resetGroupConfirm =>
      'Усі повідомлення групи компанії буде видалено для всіх.';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get shiftPresets => 'Шаблони змін';

  @override
  String get shiftPresetsHint =>
      'Готові години (ранок, вечір, ніч…): один дотик у зміні заповнює початок і кінець.';

  @override
  String get themeDark => 'Темний';

  @override
  String get themeLight => 'Світлий';

  @override
  String get themeSystem => 'Системний';

  @override
  String get unmuteConversation => 'Увімкнути сповіщення цієї розмови';

  @override
  String get awaitingApproval => 'На затвердженні';

  @override
  String get placementNeedsApproval =>
      '! Ця людина не з ваших об\'єктів: зміна чекатиме затвердження вашого керівника або власника, перш ніж її можна буде опублікувати. Інакше оберіть іншого працівника.';

  @override
  String get placementAwaiting =>
      'Очікує затвердження керівником або власником.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by хоче поставити $name з іншого об\'єкта на $date: потрібне затвердження.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by затвердив(ла) призначення $name на $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by відхилив(ла) призначення $name на $date.';
  }
}
