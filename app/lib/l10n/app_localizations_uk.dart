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
  String get viewTeam => 'Управління';

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
  String get notifMessages => 'Нові оголошення';

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
  String get translateAction => 'Перекласти';

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
  String get openRequest => 'Переглянути запит';

  @override
  String get thisCompany => 'Ця компанія';

  @override
  String get withExtras => 'Разом із позаштатними';

  @override
  String reinforcementHint(String company) {
    return 'З компанії $company: буде додано як підсилення й повідомлено.';
  }

  @override
  String get addToGoogle => 'Додати в Google Календар';

  @override
  String get calendarEnabled => 'Синхронізувати мої зміни';

  @override
  String get changeSettings => 'Змінити';

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
  String get calendarDenied =>
      'Доступ до календаря заборонено. Дозвольте його в налаштуваннях телефона.';

  @override
  String get calendarLinkHint =>
      'Додайте з Google Календаря на комп\'ютері; Google оновлює його за кілька годин.';

  @override
  String get calendarNone => 'На цьому телефоні немає календаря для запису.';

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
  String get customization => 'Персоналізація';

  @override
  String get editPresets => 'Шаблони';

  @override
  String get enable => 'Увімкнути знову';

  @override
  String get logoHint =>
      'Невелике зображення PNG (ваш логотип) на вкладці компанії для всіх її учасників.';

  @override
  String get logoPngOnly => 'Виберіть зображення PNG до 1 МБ.';

  @override
  String get myIdentifier => 'Мій ідентифікатор';

  @override
  String get myProfile => 'Мій профіль';

  @override
  String get presetName => 'Назва (напр. Ранок)';

  @override
  String get removeLogo => 'Прибрати зображення';

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

  @override
  String get addSubSite => 'Додати підоб\'єкт';

  @override
  String get moveSite => 'Перемістити';

  @override
  String get topLevel => 'Верхній рівень';

  @override
  String moveSiteTitle(String name) {
    return 'Перемістити «$name» під…';
  }

  @override
  String subSiteOf(String name) {
    return 'Підоб\'єкт $name';
  }

  @override
  String get siteTreeHint =>
      'До 10 рівнів, наприклад Регіон › Місто › Магазин. Перші 3 включено в підписку; далі потрібна опція «Каскадні об\'єкти». Керівник об\'єкта керує також усім, що нижче.';

  @override
  String get subSitesOnlyHint =>
      'Тут ви додаєте підоб\'єкти до своїх об\'єктів.';

  @override
  String get messagingSetting => 'Стрічка новин';

  @override
  String get messagingSettingHint =>
      'Увімкнено: власник і керівники публікують оголошення (для всіх, посади, об\'єкта або вибраних людей); кожен їх читає й може перекласти. Вимкнено: вкладка зникає для всіх.';

  @override
  String get billingTitle => 'Підписка';

  @override
  String billingStatusTrial(String date) {
    return 'Безкоштовний пробний період до $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Оплачено до $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Лише читання: без оплати компанію буде видалено $date.';
  }

  @override
  String get billingStatusComped => 'Безкоштовно';

  @override
  String billingStaff(String count) {
    return '$count працівників і керівників (без власника та позаштатних)';
  }

  @override
  String get billingMonthly => 'Щомісяця';

  @override
  String billingYearly(String months) {
    return 'Щороку (оплачується $months міс.)';
  }

  @override
  String get billingCascade => 'Опція «Каскадні об\'єкти» (рівні 4–10)';

  @override
  String billingCascadeIncluded(String count) {
    return 'Включено від $count працівників';
  }

  @override
  String billingPay(String amount) {
    return 'Оплатити $amount';
  }

  @override
  String get billingTestNotice => 'Тестова оплата: кошти не списуються.';

  @override
  String get billingSoon => 'Онлайн-оплата незабаром.';

  @override
  String get billingPaidOk => 'Оплату зараховано.';

  @override
  String get billingInvoices => 'Рахунки';

  @override
  String get billingNoInvoices => 'Рахунків поки немає.';

  @override
  String get billingManage => 'Керувати підпискою';

  @override
  String get billingReadOnlyStaff =>
      'Компанія доступна лише для читання, доки власник не поновить підписку.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / міс.';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / рік';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: безкоштовний пробний період закінчиться менш ніж за 24 години.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company доступна лише для читання через несплату; видалення $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Нагадування: без оплати $company буде видалено $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company видалено через несплату.';
  }

  @override
  String billingCompanyId(String id) {
    return 'Ідентифікатор компанії: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Сьогодні: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Включає решту поточного місяця ($days дн., пропорційно), далі повні місяці з 1-го числа.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Ще не прив\'язано. Він потрібен для підтвердження особи, наприклад щоб змінити обліковий запис Google.';

  @override
  String telegramLinked(String name) {
    return 'Прив\'язано: $name';
  }

  @override
  String get telegramNoUsername => 'без імені користувача';

  @override
  String get telegramLink => 'Прив\'язати мій Telegram';

  @override
  String get telegramLinkHint =>
      'Відкриється Telegram: натисніть «Почати», потім поверніться сюди.';

  @override
  String get telegramUnlink => 'Відв\'язати';

  @override
  String get telegramUnavailable => 'Telegram поки недоступний.';

  @override
  String get telegramShowIn => 'Показувати мій Telegram у:';

  @override
  String get newQrCode => 'Змінити QR-код';

  @override
  String get newQrCodeConfirm =>
      'Старий QR-код і старий ідентифікатор більше не працюватимуть. Ваше місце в компаніях не зміниться.';

  @override
  String get newQrCodeDone => 'Новий QR-код створено.';

  @override
  String get changeGoogle => 'Змінити обліковий запис Google';

  @override
  String get changeGoogleSub => 'Той самий обліковий запис, номер і компанії';

  @override
  String changeGoogleSteps(String id) {
    return '1. Прив\'яжіть Telegram у цьому профілі (обов\'язково).\n2. Вийдіть, потім увійдіть з новим обліковим записом Google.\n3. Виберіть «У мене вже є обліковий запис Staff Flow» і введіть свій ідентифікатор $id.\n4. Введіть код, отриманий у Telegram.\nВаш обліковий запис, номер і компанії залишаться тими самими.';
  }

  @override
  String get recoverAccount => 'У мене вже є обліковий запис Staff Flow';

  @override
  String get recoverHint =>
      'Введіть ідентифікатор старого облікового запису (SF-…). Код буде надіслано в Telegram, прив\'язаний до нього.';

  @override
  String get recoverIdLabel => 'Ідентифікатор (SF-…)';

  @override
  String get recoverSend => 'Надіслати код';

  @override
  String get recoverCodeSent => 'Код надіслано в Telegram.';

  @override
  String get recoverCodeLabel => 'Отриманий код (6 цифр)';

  @override
  String get recoverConfirm => 'Відновити мій обліковий запис';

  @override
  String get recoverDone =>
      'Готово: ви повернулися до свого облікового запису.';

  @override
  String get exportData => 'Експортувати мої дані';

  @override
  String get exportDataSub => 'Файл з усіма вашими особистими даними';

  @override
  String get deleteAccount => 'Видалити мій обліковий запис';

  @override
  String get deleteGhost => 'Видалити, залишивши «привида»';

  @override
  String get deleteGhostHint =>
      'Ви вийдете з усіх компаній. Пізніше увійдіть з тим самим обліковим записом Google, щоб повернути обліковий запис і номер.';

  @override
  String get deleteErase => 'Стерти все назавжди';

  @override
  String get deleteEraseHint =>
      'Ім\'я, e-mail, фото, Telegram, повідомлення та сповіщення буде стерто. Скасувати неможливо.';

  @override
  String get deleteGhostNote =>
      'В обох випадках історія компаній зберігає анонімного «Ghost» замість вас (заяви на відпустку, минулі зміни…), щоб власник і керівники могли відстежити події.';

  @override
  String get deleteOwnerNote =>
      'Ви власник компанії? Спочатку передайте її або дочекайтеся завершення підписки.';

  @override
  String get deleteConfirmButton => 'Видалити';

  @override
  String get accountRestored =>
      'З поверненням! Ваш обліковий запис знову активний.';

  @override
  String get closedInvoices => 'Рахунки закритих компаній';

  @override
  String get downloadAllInvoices => 'Завантажити всі рахунки (ZIP)';

  @override
  String get legalTerms => 'Умови використання та продажу';

  @override
  String get legalPrivacy => 'Політика конфіденційності';

  @override
  String get billingDetailTitle => 'Деталі оплати';

  @override
  String billingLineProrata(String days, String total) {
    return 'Решта поточного місяця ($days дн. з $total): підписка';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Решта поточного місяця ($days дн. з $total): опція «вкладені локації»';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Підписка, $staff місць: 1 міс.';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Підписка, $staff місць: 12 міс. за ціною $paid';
  }

  @override
  String billingLineCascade(String months) {
    return 'Опція «вкладені локації»: $months міс., без знижки';
  }

  @override
  String get billingTotal => 'Разом';

  @override
  String billingCovers(String from, String to) {
    return 'Оплачений період: з $from до $to';
  }

  @override
  String get billingGraceInvoices =>
      'Цю компанію не буде продовжено: завантажте всі її рахунки вже зараз.';

  @override
  String get billingYearLabel => 'Рік';

  @override
  String get sitesNoneChosen => 'Локацію не вибрано';

  @override
  String get avatarTitle => 'Мій аватар';

  @override
  String get avatarSub => 'Зображення замість вашого фото';

  @override
  String get avatarUseGoogle => 'Використовувати фото Google';

  @override
  String get avatarColor => 'Колір';

  @override
  String get hidePhotosTitle => 'Приховати фото Google';

  @override
  String get hidePhotosSub =>
      'У цій компанії кожного показано з аватаром або ініціалом.';

  @override
  String get billingApi => 'Опція «доступ до API»';

  @override
  String billingLineApi(String months) {
    return 'Опція «доступ до API»: $months міс., без знижки';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Решта поточного місяця ($days дн. з $total): опція «доступ до API»';
  }

  @override
  String get apiTitle => 'Доступ до API (бухгалтерія, CRM)';

  @override
  String get apiSub =>
      'Ваші програми (зарплата, облік, CRM, планування) читають опублікований графік, години й відсутності; з «API Pro» вони також надсилають графіки, працівників і оголошення.';

  @override
  String get apiNeedsOption =>
      'Платна опція: додайте «Доступ до API» або «API Pro» у «Керувати підпискою».';

  @override
  String get apiNewKey => 'Новий ключ';

  @override
  String get apiKeyName => 'Назва ключа (напр.: програма зарплати)';

  @override
  String get apiKeyCreated =>
      'Скопіюйте цей ключ зараз і зберігайте його надійно: більше він не показуватиметься.';

  @override
  String get apiKeyCopy => 'Копіювати';

  @override
  String get apiKeyCopied => 'Ключ скопійовано.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Останнє використання: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Ще не використовувався';

  @override
  String get apiRevoke => 'Відкликати';

  @override
  String get apiRevokeConfirm =>
      'Програми, що використовують цей ключ, втратять доступ.';

  @override
  String get apiDocs => 'Документація API';

  @override
  String get memberGoogleLink => 'Повторний вхід працівника через Google';

  @override
  String googleLinkHint(String name) {
    return 'Надішліть це посилання $name. Воно відкривається в браузері (не в застосунку Android), один раз, протягом 24 годин: $name входить зі своїм новим обліковим записом Google і повертає свій обліковий запис. Усі інші пристрої при цьому від\'єднуються.';
  }

  @override
  String get googleLinkCopied => 'Посилання скопійовано.';

  @override
  String get switchBanner =>
      'Посилання для зміни облікового запису Google: увійдіть з новим обліковим записом Google, щоб повернути свій обліковий запис Staff Flow.';

  @override
  String get switchSignOutFirst =>
      'Це посилання прив\'язує обліковий запис Staff Flow до нового облікового запису Google. Спершу вийдіть, потім увійдіть з новим обліковим записом Google.';

  @override
  String get switchDone =>
      'Готово: ваш обліковий запис Staff Flow прив\'язано до цього облікового запису Google. Інші ваші пристрої від\'єднано.';

  @override
  String changeGoogleBot(String bot) {
    return 'Найпростіше: у Telegram надішліть /changegoogle боту $bot і виконайте його вказівки, потім увійдіть з новим обліковим записом Google протягом 10 хвилин.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Без Telegram: попросіть власника чи керівника посилання для зміни облікового запису Google.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name створив(-ла) посилання, щоб прив\'язати ваш обліковий запис до нового облікового запису Google. Якщо ви цього не просили, повідомте свого керівника.';
  }

  @override
  String get sessionRevoked =>
      'Вас від’єднано: ваш обліковий запис тепер прив’язано до іншого облікового запису Google.';

  @override
  String telegramLoginHint(String bot) {
    return 'Порада: надішліть /connexion боту $bot, щоб отримати посилання й відкрити Staff Flow у браузері — без застосунку й облікового запису Google.';
  }

  @override
  String get timeFormat => 'Формат часу';

  @override
  String get timeFormatAuto => 'Авто';

  @override
  String get people => 'Люди';

  @override
  String get sortNatural => 'Звичайний порядок';

  @override
  String get sortName => 'Ім\'я';

  @override
  String get employeeNumber => 'Табельний номер';

  @override
  String get sfIdLabel => 'ID Staff Flow';

  @override
  String get pickSearch => 'Пошук';

  @override
  String get pickSearchPeople => 'Пошук: ім\'я, табельний номер, ID SF';

  @override
  String get pickSortTitle => 'Сортувати й показувати за';

  @override
  String pickSelected(String count) {
    return 'Позначено: $count';
  }

  @override
  String get pickCheckAll => 'Позначити всіх';

  @override
  String get pickClear => 'Зняти всі позначки';

  @override
  String get pickNoResult => 'Нічого не знайдено';

  @override
  String get pickMultiHint =>
      'Позначте кількох людей: для кожного буде створено зміну, усе за один раз.';

  @override
  String get filterAll => 'Усі';

  @override
  String filterValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String get noPositionGroup => 'Без посади';

  @override
  String get noSiteGroup => 'Без об\'єкта';

  @override
  String get groupByTitle => 'Групувати за';

  @override
  String get groupRole => 'Роль';

  @override
  String get groupNone => 'Без групування';

  @override
  String showMore(String count, String left) {
    return 'Показати ще $count (залишилося $left)';
  }

  @override
  String get findByQr => 'Знайти учасника за його QR-кодом';

  @override
  String get qrNotMember => 'Цей QR-код не відповідає нікому в цій компанії.';

  @override
  String get memberProfile => 'Табельний номер і посада';

  @override
  String get employeeNumberHint =>
      'Власний номер вашої компанії (необов\'язково). ID Staff Flow зберігається.';

  @override
  String get usualPosition => 'Звичайна посада';

  @override
  String get inviteCodeTitle => 'Код запрошення';

  @override
  String get inviteCodeHint =>
      'Введіть код, отриманий від роботодавця, або відскануйте QR-код запрошення.';

  @override
  String inviteJoined(String company) {
    return 'Ви приєдналися до $company.';
  }

  @override
  String get importTitle => 'Імпорт працівників';

  @override
  String get importIntro =>
      'Імпортуйте список працівників із файлу Excel або CSV. Кожен отримує особистий код і QR-код: активує обліковий запис через застосунок 2FA (або Google). Нікого не додають без згоди.';

  @override
  String get importTemplate => 'Завантажити шаблон Excel';

  @override
  String get importTemplateHint =>
      'Стовпці: ім\'я, табельний номер, посада, об\'єкт. Обов\'язкове лише ім\'я.';

  @override
  String get importChooseFile => 'Вибрати файл (.xlsx або .csv)';

  @override
  String importNew(String count) {
    return 'Нові: $count';
  }

  @override
  String importUpdate(String count) {
    return 'Оновлено: $count';
  }

  @override
  String importSkip(String count) {
    return 'Уже запрошені: $count';
  }

  @override
  String importErrors(String count) {
    return 'Помилки: $count';
  }

  @override
  String importConfirm(String count) {
    return 'Імпортувати ($count)';
  }

  @override
  String get importErrorsIgnored =>
      'Рядки з помилками буде пропущено: виправте їх у файлі й імпортуйте знову.';

  @override
  String get importCreated => 'новий';

  @override
  String importDone(String count) {
    return 'Створено запрошень: $count';
  }

  @override
  String get invitesTitle => 'Запрошення в очікуванні';

  @override
  String get invitesPrint => 'Надрукувати коди';

  @override
  String get inviteShowHint =>
      'Людина вибирає «Активувати обліковий запис» на екрані входу (або «У мене є код запрошення», якщо вже має обліковий запис), потім сканує цей QR-код або вводить цей код. Дійсний 90 днів, один раз.';

  @override
  String invitesHint(String count) {
    return 'Запрошень в очікуванні: $count. Торкніться людини, щоб показати її код і QR-код, або надрукуйте всі.';
  }

  @override
  String get inviteSeenByEmail => 'запрошення побачено (e-mail)';

  @override
  String get invitesNone => 'Немає запрошень в очікуванні.';

  @override
  String get haveInviteCode => 'У мене є код запрошення';

  @override
  String get newsTab => 'Новини';

  @override
  String get newsNew => 'Нове оголошення';

  @override
  String get newsEmpty => 'Оголошень поки немає.';

  @override
  String get newsEmptyManager =>
      'Оголошень поки немає. Опублікуйте перше: для всієї компанії, посади, об\'єкта або вибраних людей.';

  @override
  String get newsOlder => 'Старіші оголошення';

  @override
  String get newsEdited => 'змінено';

  @override
  String get newsEdit => 'Змінити оголошення';

  @override
  String get newsDeleteTitle => 'Прибрати це оголошення?';

  @override
  String get newsForEveryone => 'Для всіх';

  @override
  String get newsEveryoneMySites => 'Усі на моїх об\'єктах';

  @override
  String newsFor(String names) {
    return 'Для: $names';
  }

  @override
  String newsReadCount(String count) {
    return 'Прочитали: $count';
  }

  @override
  String newsReadOf(String count, String total) {
    return 'Прочитали $count з $total';
  }

  @override
  String get newsTranslated => 'Перекладено автоматично';

  @override
  String get newsTitleField => 'Заголовок (необов\'язково)';

  @override
  String get newsBodyField => 'Текст оголошення';

  @override
  String get newsRecipients => 'Одержувачі';

  @override
  String get newsTargetHint =>
      'Позначте одну чи кілька груп: оголошення отримає кожен, хто належить до будь-якої з них.';

  @override
  String get newsPublish => 'Опублікувати';

  @override
  String newsSent(String count) {
    return 'Оголошення надіслано: $count ос.';
  }

  @override
  String billingLineApiAddon(String from, String to, String months) {
    return 'Опція «Доступ до API», додана під час підписки, з $from по $to: $months міс., без знижки';
  }

  @override
  String billingLineCascadeAddon(String from, String to, String months) {
    return 'Опція «Каскадні об\'єкти», додана під час підписки, з $from по $to: $months міс., без знижки';
  }

  @override
  String get billingRenewalOptions =>
      'Позначені опції буде включено в наступні продовження. Опція без позначки діє до кінця вже оплаченого періоду.';

  @override
  String billingAddonTitle(String option) {
    return 'Додати зараз: $option';
  }

  @override
  String billingAddonHint(String date) {
    return 'Поточний місяць повністю, потім кожен місяць до $date (кінець оплаченого періоду), без знижки. Опція діє одразу після оплати й включається в наступні продовження.';
  }

  @override
  String get billingAddonInvoice => 'опція';

  @override
  String billingAccessRemoved(String name) {
    return '$name більше не керує підпискою.';
  }

  @override
  String billingAccessGiven(String name) {
    return '$name тепер може керувати підпискою та рахунками.';
  }

  @override
  String get actionBillingRemove => 'Забрати керування підпискою';

  @override
  String get actionBillingGive => 'Дозволити керувати підпискою';

  @override
  String get billingAccessTag => 'Керує підпискою';

  @override
  String get billingOptionRenewed => 'Продовження опції відновлено.';

  @override
  String get billingOptionStopped =>
      'Опцію не буде продовжено: вона діє до кінця оплаченого періоду.';

  @override
  String billingOptionEnds(String date) {
    return 'Діє до $date, не буде продовжена (позначте, щоб залишити)';
  }

  @override
  String get billingOptionActive =>
      'Діє й продовжується (зніміть позначку, щоб не продовжувати)';

  @override
  String get statusCancelRequested => 'Запитано скасування';

  @override
  String get requestEndedEarly => 'Завершено раніше самою людиною.';

  @override
  String get confirmCancelRequest =>
      'Скасувати цей запит? Керівники більше його не побачать.';

  @override
  String get endUnavailability => 'Завершити мою недоступність';

  @override
  String get confirmEndUnavailability =>
      'Завершити вашу недоступність? Ви знову будете доступні з сьогодні, а керівників буде повідомлено.';

  @override
  String get askLeaveCancel => 'Попросити скасувати цю відпустку';

  @override
  String get confirmAskLeaveCancel =>
      'Попросити скасувати цю відпустку? Керівник має це погодити; доти відпустка залишається в плані.';

  @override
  String get refuseLeaveCancel => 'Відхилити скасування';

  @override
  String get acceptLeaveCancel => 'Погодити скасування';

  @override
  String get requestsSearchHint =>
      'Пошук: ім\'я, табельний номер, ID SF, примітка';

  @override
  String get filterType => 'Тип';

  @override
  String get filterState => 'Стан';

  @override
  String get statePending => 'Очікують';

  @override
  String get stateClosed => 'Відхилені або скасовані';

  @override
  String billingLineSlotsAddon(
    String from,
    String to,
    String start,
    String end,
    String months,
  ) {
    return 'Додано місця, з $from до $to, з $start по $end: $months міс., без знижки';
  }

  @override
  String billingSeats(String used, String limit) {
    return 'Оплачено місць: $used · до $limit осіб із запасом 5 %';
  }

  @override
  String get billingSeatsTitle => 'Кількість місць';

  @override
  String get billingSeatsHint =>
      'Працівники й керівники (без власника та позаштатних), блоками по 10. 10 місць при створенні; понад це — запас 5 %, далі додавати не можна.';

  @override
  String get billingSeatsUnit => 'місць';

  @override
  String billingSeatsAddon(String from, String to) {
    return 'Місця: $from → $to';
  }

  @override
  String billingSeatsRange(String min) {
    return 'Від $min до 5000, блоками по 10.';
  }

  @override
  String get printWeek => 'Тиждень';

  @override
  String get printMonth => 'Місяць';

  @override
  String teamCount(String team, String count) {
    return '$team · $count';
  }

  @override
  String teamCountSeats(String team, String count, String slots) {
    return '$team · $count/$slots';
  }

  @override
  String get rememberMe => 'Залишатися в системі на цьому пристрої';

  @override
  String get rememberMeHint =>
      'Увімкнено: як із Google, не треба вводити код щоразу. Не вмикайте на спільному пристрої.';

  @override
  String get totpLoginTitle => 'Вхід через 2FA';

  @override
  String get totpLoginHint =>
      'Введіть свій ідентифікатор Staff Flow (SF-…) або табельний номер, а потім 6-значний код із застосунку автентифікації.';

  @override
  String get totpLoginField => 'Ідентифікатор SF або табельний номер';

  @override
  String get totpCompanyCode => 'Код компанії';

  @override
  String get totpCompanyCodeHint =>
      '6 символів від роботодавця (лише з табельним номером).';

  @override
  String get totpBackupCode => 'Резервний код';

  @override
  String get totpCode => 'Код застосунку';

  @override
  String get totpUseApp => 'Використати застосунок 2FA';

  @override
  String get totpUseBackup => 'Використати резервний код';

  @override
  String get totpSignIn => 'Увійти';

  @override
  String get totpLostPhone =>
      'Загубили телефон або видалили застосунок? Попросіть у керівника новий код активації.';

  @override
  String get activateTitle => 'Активувати обліковий запис';

  @override
  String get activateStep1 => 'Крок 1: ваш код запрошення';

  @override
  String get activateStep1Hint =>
      'Відскануйте QR-код від роботодавця або введіть код, написаний під ним.';

  @override
  String get activateScan => 'Сканувати QR-код';

  @override
  String get activateCodeField => 'Код запрошення';

  @override
  String get activateContinue => 'Продовжити';

  @override
  String activateHello(String name, String company) {
    return 'Вітаємо, $name · $company';
  }

  @override
  String get activateStep2 =>
      'Крок 2: прив\'яжіть застосунок автентифікації (Google Authenticator, Microsoft Authenticator…). Він даватиме 6-значний код при кожному вході.';

  @override
  String get activateOpenApp => 'Додати до мого застосунку автентифікації';

  @override
  String get activateOrScan =>
      'Або з іншого пристрою відскануйте цей QR-код застосунком:';

  @override
  String get activateManualKey => 'Ключ для ручного введення:';

  @override
  String get activateFirstCode => 'Перший код із застосунку';

  @override
  String get activateDone => 'Активувати';

  @override
  String get totpReadyTitle => 'Ваш обліковий запис готовий';

  @override
  String get totpYourId => 'Ваш ідентифікатор Staff Flow:';

  @override
  String get totpBackupHint =>
      'Резервні коди (кожен діє один раз): запишіть їх або збережіть у надійному місці. Вони знадобляться, якщо застосунку більше немає.';

  @override
  String get totpBackupSaved => 'Записав(-ла)';

  @override
  String get linkGoogleTitle => 'Прив\'язати обліковий запис Google';

  @override
  String get linkGoogleHint =>
      'Щоб створити компанію, прив\'яжіть обліковий запис Google до свого облікового запису Staff Flow. Він потрібен лише для захисту творця компанії та її підписки: вашу адресу Google ніколи не показують ні працівникам, ні будь-кому іншому, вона залишається в Staff Flow. Ви й надалі зможете входити через застосунок 2FA.';

  @override
  String get linkGoogleButton => 'Прив\'язати мій Google';

  @override
  String get linkGoogleBanner =>
      'Увійдіть з обліковим записом Google, який треба прив\'язати до Staff Flow.';

  @override
  String get totpLoginButton => 'Увійти через застосунок 2FA';

  @override
  String get activateButton => 'Активувати обліковий запис (код роботодавця)';

  @override
  String get activationCodeAction => 'Новий код активації';

  @override
  String activationCodeTitle(String name) {
    return 'Новий код для $name?';
  }

  @override
  String get activationCodeConfirm =>
      'Старий телефон і старий застосунок 2FA більше не працюватимуть. Людина знову активує обліковий запис цим кодом (діє 7 днів).';

  @override
  String get activationCodeHint =>
      'Людина вибирає «Активувати обліковий запис» на екрані входу, потім сканує цей QR-код або вводить цей код.';

  @override
  String get signupTitle => 'Створити обліковий запис';

  @override
  String get signupStep1 => 'Крок 1: ваше ім\'я';

  @override
  String get signupStep1Hint =>
      'Ім\'я, яке бачитимуть колеги й роботодавці. Без Google і без e-mail: обліковий запис захищає застосунок автентифікації.';

  @override
  String get signupName => 'Ім\'я та прізвище';

  @override
  String signupHello(String name) {
    return 'Вітаємо, $name';
  }

  @override
  String get signupButton => 'Створити обліковий запис із застосунком 2FA';

  @override
  String get totpCardTitle => 'Вхід через застосунок 2FA';

  @override
  String totpCardLocal(String id) {
    return 'Ваш обліковий запис входить через застосунок автентифікації. Ідентифікатор: $id';
  }

  @override
  String totpCardOn(String id) {
    return 'Увімкнено: ви можете також входити з ідентифікатором $id і кодом застосунку, без Google.';
  }

  @override
  String get totpCardOff =>
      'Налаштуйте застосунок автентифікації, щоб входити без Google (ідентифікатор SF + 6-значний код).';

  @override
  String get totpEnable => 'Увімкнути';

  @override
  String get totpDisable => 'Вимкнути';

  @override
  String get totpEnableTitle => 'Увімкнути вхід через 2FA';

  @override
  String get totpEnabledTitle => 'Вхід через 2FA готовий';

  @override
  String get totpDisableConfirm =>
      'Вимкнути вхід через застосунок 2FA? Ви входитимете лише через Google.';

  @override
  String get googlePrivacyNote =>
      'Ваш обліковий запис Google служить лише для захисту компанії та її підписки: його ніколи не показують працівникам чи будь-кому іншому.';

  @override
  String get scopeRead =>
      'Читання: опублікований графік, години, відсутності, працівники';

  @override
  String get scopeShifts => 'Графік: створювати, змінювати, видаляти зміни';

  @override
  String get scopePublish => 'Публікувати графік';

  @override
  String get scopeMembers => 'Працівники: імпорт, табельний номер і посада';

  @override
  String get scopeCatalog => 'Посади й об\'єкти';

  @override
  String get scopeNews => 'Оголошення';

  @override
  String get scopeRequests => 'Запити: погоджувати або відхиляти';

  @override
  String get apiScopesTitle => 'Права ключа';

  @override
  String get apiProNeeded =>
      'Права на запис потребують опції «API Pro» (оплачена підписка).';

  @override
  String billingLinePro(String months) {
    return 'Опція «API Pro»: $months міс.';
  }

  @override
  String billingLineProAddon(String start, String end, String months) {
    return 'Опція «API Pro», додана під час підписки, з $start по $end: $months міс., без знижки';
  }

  @override
  String get billingApiPro => 'Опція «API Pro»';

  @override
  String billingApiProHint(String price) {
    return '«API Pro» ($price / міс., без знижки): ваші програми записують у Staff Flow (графік, працівники, оголошення, запити). Доступно з оплаченою підпискою: додайте нижче.';
  }

  @override
  String get whTitle => 'Вебхуки';

  @override
  String get whSub =>
      'Staff Flow сам повідомляє ваші програми, коли щось відбувається: опубліковано графік, запит, новий працівник, оголошення. Входить в опцію «API Pro».';

  @override
  String get whNew => 'Новий вебхук';

  @override
  String get whUrl => 'Адреса (https://…)';

  @override
  String get whEvents => 'Події, що надсилаються';

  @override
  String get whCreated =>
      'Секрет підпису, показується лише раз: ваша програма перевіряє ним, що кожне надсилання справді від Staff Flow.';

  @override
  String get whTest => 'Перевірити';

  @override
  String whTestOk(String status) {
    return 'Отримано (код $status)';
  }

  @override
  String whTestFail(String error) {
    return 'Помилка: $error';
  }

  @override
  String get whDisabled => 'Вимкнено після 10 невдалих надсилань поспіль';

  @override
  String get whEnable => 'Увімкнути знову';

  @override
  String get whDelete => 'Видалити';

  @override
  String get whDeleteConfirm => 'Цей вебхук більше нічого не отримуватиме.';

  @override
  String get whNone => 'Поки що немає вебхуків.';

  @override
  String whLast(String date, String status) {
    return 'Останнє надсилання: $date · $status';
  }

  @override
  String get whEvSchedulePublished => 'Графік опубліковано';

  @override
  String get whEvRequestCreated => 'Новий запит';

  @override
  String get whEvRequestDecided => 'Запит погоджено або відхилено';

  @override
  String get whEvRequestCancelled => 'Запит скасовано';

  @override
  String get whEvRequestCancelAsked => 'Запит на скасування відпустки';

  @override
  String get whEvRequestCancelDecided => 'Рішення щодо скасування відпустки';

  @override
  String get whEvRequestEnded => 'Недоступність завершено';

  @override
  String get whEvMemberJoined => 'Новий працівник';

  @override
  String get whEvAnnouncementPublished => 'Оголошення опубліковано';

  @override
  String get whStDelivered => 'отримано';

  @override
  String get whStPending => 'очікує';

  @override
  String get whStFailed => 'помилка';

  @override
  String get whStDropped => 'скасовано';

  @override
  String get lgTitle => 'Журнали';

  @override
  String get lgSub =>
      'Кожен виклик ваших ключів API та асистента MCP і кожне надсилання вебхука. Гортайте, щоб змінити місяць.';

  @override
  String get lgSearch => 'Пошук: людина, табельний номер, дія…';

  @override
  String get lgAllHistory => 'Шукати в усій історії (разом з архівами)';

  @override
  String get lgArchived => 'Місяць в архіві';

  @override
  String get lgNone => 'За цей місяць нічого.';

  @override
  String get lgMore => 'Показати більше';

  @override
  String get lgExport => 'Завантажити рік (ZIP)';

  @override
  String get lgAllKeys => 'Усі ключі';

  @override
  String get lgSourceApi => 'API';

  @override
  String get lgSourceMcp => 'Асистент MCP';

  @override
  String get lgSourceWebhook => 'Вебхук';

  @override
  String get lgKindRead => 'Читання';

  @override
  String get lgKindWrite => 'Запис';

  @override
  String get lgOk => 'Успішно';

  @override
  String get lgError => 'Помилка';

  @override
  String get lgBefore => 'До';

  @override
  String get lgAfter => 'Після';

  @override
  String lgStats(String today, String month) {
    return 'Сьогодні: $today · цього місяця: $month';
  }

  @override
  String lgLastFailure(String date) {
    return 'Остання помилка: $date';
  }

  @override
  String get lgActShiftsCreate => 'Зміни створено';

  @override
  String get lgActShiftUpdate => 'Зміну змінено';

  @override
  String get lgActShiftDelete => 'Зміну видалено';

  @override
  String get lgActPublish => 'Графік опубліковано';

  @override
  String get lgActImport => 'Працівників імпортовано';

  @override
  String get lgActProfile => 'Табельний номер або посаду змінено';

  @override
  String get lgActPosition => 'Посаду створено';

  @override
  String get lgActSite => 'Об\'єкт створено';

  @override
  String get lgActNews => 'Оголошення опубліковано';

  @override
  String get lgActApprove => 'Запит погоджено';

  @override
  String get lgActRefuse => 'Запит відхилено';

  @override
  String get lgActRead => 'Читання';

  @override
  String get lgActWebhook => 'Вебхук надіслано';

  @override
  String get lgFDay => 'День';

  @override
  String get lgFStart => 'Початок';

  @override
  String get lgFEnd => 'Кінець';

  @override
  String get lgFPerson => 'Людина';

  @override
  String get lgFSite => 'Об\'єкт';

  @override
  String get lgFPosition => 'Посада';

  @override
  String get lgFNote => 'Примітка';

  @override
  String get lgFNumber => 'Табельний номер';

  @override
  String noticeApiFailing(String key, String count) {
    return 'Ключ API «$key» дав збій $count разів за годину: перевірте програму, яка його використовує.';
  }

  @override
  String noticeApiNewIp(String key, String ip) {
    return 'Ключ API «$key» використано з нової адреси ($ip). Якщо це не ви, відкличте його.';
  }

  @override
  String get lgYear => 'Рік';

  @override
  String get lgResults => 'Результати в усій історії';

  @override
  String get lgAllSources => 'Усі джерела';

  @override
  String get lgAllKinds => 'Читання і запис';

  @override
  String get lgAllResults => 'Успішні й помилки';

  @override
  String get lgFDate => 'Дата';

  @override
  String get lgFKey => 'Ключ';

  @override
  String get lgFSource => 'Джерело';

  @override
  String get lgFStatus => 'Статус';
}
