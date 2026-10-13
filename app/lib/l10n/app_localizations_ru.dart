// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class L10nRu extends L10n {
  L10nRu([String locale = 'ru']) : super(locale);

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get validate => 'Подтвердить';

  @override
  String get add => 'Добавить';

  @override
  String get rename => 'Переименовать';

  @override
  String get delete => 'Удалить';

  @override
  String get accept => 'Принять';

  @override
  String get decline => 'Отклонить';

  @override
  String get close => 'Закрыть';

  @override
  String get retry => 'Повторить';

  @override
  String get name => 'Название';

  @override
  String get serverUnreachable => 'Сервер недоступен.';

  @override
  String errorStatus(int status) {
    return 'Ошибка $status';
  }

  @override
  String get roleOwner => 'Владелец';

  @override
  String get roleManager => 'Руководитель';

  @override
  String get roleEmployee => 'Сотрудник';

  @override
  String get roleExtra => 'Временный сотрудник';

  @override
  String get taglineStart => 'Графики вашей команды — ';

  @override
  String get taglineEnd => 'где угодно.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Вход через Google недоступен: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Не удалось войти через Google: $detail';
  }

  @override
  String get newCompany => 'Новая компания';

  @override
  String get timezone => 'Часовой пояс';

  @override
  String get create => 'Создать';

  @override
  String get noCompanyTitle => 'Вы пока не состоите ни в одной компании.';

  @override
  String get noCompanyHint =>
      'Чтобы присоединиться к компании работодателя, создайте код и передайте его руководителю.';

  @override
  String get joinCompany => 'Присоединиться к компании';

  @override
  String get createCompany => 'Создать компанию';

  @override
  String transferOffer(String company) {
    return 'Вам предлагают стать владельцем «$company».';
  }

  @override
  String get someCompany => 'компания';

  @override
  String get becameOwner => 'Теперь вы владелец.';

  @override
  String get myAccount => 'Мой аккаунт';

  @override
  String get idCopied => 'Идентификатор скопирован.';

  @override
  String get signOut => 'Выйти';

  @override
  String joinInvite(String company, String role) {
    return '«$company» приглашает вас в роли: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Вы присоединились к «$company».';
  }

  @override
  String get viewPlanning => 'График';

  @override
  String get viewTeam => 'Управление';

  @override
  String get viewPositions => 'Должности';

  @override
  String get readOnlyCompany => 'Компания доступна только для просмотра.';

  @override
  String get team => 'Команда';

  @override
  String get leaveCompany => 'Покинуть компанию';

  @override
  String meSuffix(String name) {
    return '$name (вы)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Передать компанию: $name?';
  }

  @override
  String get transferConfirmBody =>
      'После подтверждения этот человек станет владельцем (подписка, счета, руководители), а вы — руководителем.';

  @override
  String transferSent(String name) {
    return 'Предложение отправлено: $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Удалить: $name?';
  }

  @override
  String get removeConfirmBody => 'История сохранится.';

  @override
  String get addPersonTitle => 'Добавить человека';

  @override
  String get addPersonHint =>
      'Попросите открыть Staff Flow, меню аккаунта, «Присоединиться к компании», и введите показанный код.';

  @override
  String get sixDigitCode => '6-значный код';

  @override
  String invitationSent(String name) {
    return 'Приглашение отправлено: $name. Его нужно принять.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Покинуть «$company»?';
  }

  @override
  String get leaveConfirmBody => 'Вы больше не будете видеть её график.';

  @override
  String get renameCompany => 'Переименовать компанию';

  @override
  String get actionMakeManager => 'Назначить руководителем';

  @override
  String get actionMakeEmployee => 'Снова сделать сотрудником';

  @override
  String get actionToEmployee => 'Сделать сотрудником';

  @override
  String get actionToExtra => 'Сделать временным';

  @override
  String get actionTransfer => 'Передать права владельца';

  @override
  String get actionRemove => 'Удалить из компании';

  @override
  String get positions => 'Должности';

  @override
  String get sites => 'Объекты';

  @override
  String get positionsHint => 'Что делает человек: касса, кухня, ресепшен…';

  @override
  String get sitesHint => 'Где проходит смена, если у компании несколько мест.';

  @override
  String get archived => 'В архиве';

  @override
  String get archive => 'В архив';

  @override
  String get reactivate => 'Восстановить';

  @override
  String weekOf(String date) {
    return 'Неделя с $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Опубликовано $count изменения.',
      many: 'Опубликовано $count изменений.',
      few: 'Опубликовано $count изменения.',
      one: 'Опубликовано $count изменение.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Смена';

  @override
  String get display => 'Вид';

  @override
  String get week => 'Неделя';

  @override
  String get month => 'Месяц';

  @override
  String get today => 'Сегодня';

  @override
  String get onlyMine => 'Только мои смены';

  @override
  String get replacePersonMenu => 'Заменить человека…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count неопубликованного изменения',
      many: '$count неопубликованных изменений',
      few: '$count неопубликованных изменения',
      one: '$count неопубликованное изменение',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Сотрудники их пока не видят.';

  @override
  String get publish => 'Опубликовать';

  @override
  String yourHours(String duration) {
    return 'Ваши часы за период: $duration';
  }

  @override
  String get addShiftThisDay => 'Добавить смену в этот день';

  @override
  String get noShift => 'Нет смен';

  @override
  String get unassigned => 'Не назначено';

  @override
  String get formerMember => 'Бывший участник';

  @override
  String get statusDraft => 'Черновик';

  @override
  String get statusModified => 'Изменено';

  @override
  String get statusDeleted => 'Удалено';

  @override
  String durationHours(int hours) {
    return '$hours ч';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ч $minutes мин';
  }

  @override
  String get editShift => 'Изменить смену';

  @override
  String get newShift => 'Новая смена';

  @override
  String get thisShift => 'Только эта смена';

  @override
  String get thisAndFollowing => 'Эта и следующие';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Дни',
      one: 'День',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Другой день';

  @override
  String get start => 'Начало';

  @override
  String get end => 'Конец';

  @override
  String get endsNextDay => 'Заканчивается на следующий день.';

  @override
  String get person => 'Человек';

  @override
  String get position => 'Должность';

  @override
  String get site => 'Объект';

  @override
  String get noteOptional => 'Примечание (необязательно)';

  @override
  String get repetition => 'Повтор';

  @override
  String get repeatNone => 'Нет';

  @override
  String get repeatDaily => 'Каждый день';

  @override
  String get repeatWeekly => 'Каждую неделю';

  @override
  String get repeatForPrefix => 'В течение ';

  @override
  String get repeatDaysSuffix => ' дн.';

  @override
  String get repeatWeeksSuffix => ' нед.';

  @override
  String get repeatUntilPrefix => 'До ';

  @override
  String get replacePersonTitle => 'Заменить человека';

  @override
  String get replaceFrom => 'Заменить';

  @override
  String get replaceBy => 'На';

  @override
  String dateRange(String from, String to) {
    return 'С $from по $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Изменено $count смены.',
      many: 'Изменено $count смен.',
      few: 'Изменены $count смены.',
      one: 'Изменена $count смена.',
      zero: 'Ни одна смена не изменена.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Заменить';

  @override
  String get joinHint =>
      'Передайте этот код руководителю. Он введёт его в своём приложении, а вы получите приглашение.';

  @override
  String get codeExpired => 'Срок действия кода истёк.';

  @override
  String codeValidFor(String time) {
    return 'Действителен ещё $time';
  }

  @override
  String get newCode => 'Новый код';

  @override
  String get language => 'Язык';

  @override
  String get languageAuto => 'Автоматически (язык устройства)';

  @override
  String get syncUpToDate => 'Актуально';

  @override
  String get syncOffline => 'Нет подключения';

  @override
  String syncPending(int count) {
    return 'Изменения в очереди: $count';
  }

  @override
  String get syncNow => 'Синхронизировать';

  @override
  String syncRejected(String reason) {
    return 'Сервер отклонил изменение: $reason';
  }

  @override
  String get pendingBadge => 'В очереди';

  @override
  String get offlineUnavailable => 'Недоступно без подключения.';

  @override
  String get offlineCached =>
      'Нет подключения: показаны последние сохранённые данные.';

  @override
  String get savedOffline =>
      'Сохранено на устройстве, будет отправлено при появлении сети.';

  @override
  String get notices => 'Уведомления';

  @override
  String get noNotices => 'Уведомлений нет.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name заменил(а) ваше изменение смены на $date.';
  }

  @override
  String get history => 'История';

  @override
  String get recentChanges => 'Последние изменения';

  @override
  String get undoChange => 'Отменить это изменение';

  @override
  String get undoDone => 'Изменение отменено.';

  @override
  String get historyCreate => 'Создание';

  @override
  String get historyUpdate => 'Изменение';

  @override
  String get historyDelete => 'Удаление';

  @override
  String get historyUndo => 'Отмена';

  @override
  String get noHistory => 'Изменений нет.';

  @override
  String get pendingNotEditable =>
      'Эта смена ещё не синхронизирована: повторите, когда будет подключение.';

  @override
  String get myQrCode => 'Мой QR-код';

  @override
  String get myQrCodeHint =>
      'Руководитель сканирует этот код, чтобы добавить вас в свою компанию; затем вы подтверждаете. Код никогда не меняется.';

  @override
  String get changeMyName => 'Изменить моё имя';

  @override
  String get nameShownToTeam =>
      'Это имя видят ваши коллеги вместо имени из Google.';

  @override
  String googleName(String name) {
    return 'Имя в Google: $name';
  }

  @override
  String get useGoogleName => 'Вернуть имя из Google';

  @override
  String renameMemberTitle(String name) {
    return 'Переименовать: $name';
  }

  @override
  String get renameMemberHint => 'Это имя используется только в этой компании.';

  @override
  String get useOwnName => 'Вернуть собственное имя';

  @override
  String get scanQrCode => 'Сканировать QR-код';

  @override
  String get scanQrHint =>
      'Наведите камеру на QR-код в его приложении (меню аккаунта, «Мой QR-код»).';

  @override
  String get orEnterCode => 'Или введите его 6-значный код';

  @override
  String get qrInvalid => 'Это не QR-код Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Камера недоступна ($error).';
  }

  @override
  String get notificationsTitle => 'Уведомления';

  @override
  String get notifChooseHint =>
      'Выберите, о чём получать уведомления. Всё остаётся видно в колокольчике.';

  @override
  String get notifPlanning => 'График опубликован или изменён';

  @override
  String get notifRequests => 'Запросы: обмены, отпуска, приглашения';

  @override
  String get notifMessages => 'Новые объявления';

  @override
  String get notifOverlap => 'Наложение смен между компаниями';

  @override
  String get notifConflicts => 'Ваши изменения заменил другой руководитель';

  @override
  String get notifBilling => 'Напоминания о подписке';

  @override
  String get pushEnabled => 'Уведомления на этом устройстве включены.';

  @override
  String get pushOff => 'Уведомления на этом устройстве выключены.';

  @override
  String get pushBlocked =>
      'Уведомления заблокированы: разрешите их в настройках телефона или браузера.';

  @override
  String get pushUnavailable => 'Уведомления недоступны на этом устройстве.';

  @override
  String get enablePush => 'Включить';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: ваш график опубликован или изменён.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company хочет добавить вас в свою команду.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name предлагает вам стать владельцем $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name присоединился к $company.';
  }

  @override
  String get translateAction => 'Перевести';

  @override
  String get deleteAllNotices => 'Удалить всё';

  @override
  String get deleteAllNoticesConfirm => 'Удалить все уведомления?';

  @override
  String get noticeRetention => 'Удалять прочитанные уведомления через';

  @override
  String get retentionDay => '1 день';

  @override
  String get retentionWeek => '1 неделю';

  @override
  String get retentionMonth => '1 месяц';

  @override
  String get billingOwnersOnly =>
      'Действует, только если вы владелец компании.';

  @override
  String get readOnlyPastDays =>
      'Дни, прошедшие более месяца назад, доступны только для просмотра.';

  @override
  String get wholeCompany => 'Вся компания';

  @override
  String get sitesLabel => 'Объекты';

  @override
  String get actionSites => 'Объекты…';

  @override
  String managerOf(String name) {
    return '$name руководит';
  }

  @override
  String teamSitesOf(String name) {
    return 'Команда: $name';
  }

  @override
  String get notYourSite => 'Этот объект не находится в вашем ведении.';

  @override
  String get chooseYourSite => 'Выберите хотя бы один объект.';

  @override
  String get viewRequests => 'Запросы';

  @override
  String get newRequest => 'Новый запрос';

  @override
  String get requestLeave => 'Отпуск';

  @override
  String get requestUnavailability => 'Недоступность';

  @override
  String get requestSwap => 'Обмен сменами';

  @override
  String get swapHint =>
      'Чтобы предложить обмен, нажмите на одну из своих будущих смен в графике.';

  @override
  String get noRequests => 'Запросов пока нет.';

  @override
  String get requestsToHandle => 'Требуют действия';

  @override
  String get statusPendingPeer => 'Ожидает коллегу';

  @override
  String get statusPendingManager => 'Ожидает руководителя';

  @override
  String get statusApproved => 'Одобрено';

  @override
  String get statusRefused => 'Отклонено';

  @override
  String get statusCancelled => 'Отменено';

  @override
  String get cancelRequest => 'Отменить запрос';

  @override
  String get acceptSwap => 'Взять эту смену';

  @override
  String get approve => 'Одобрить';

  @override
  String periodLabel(String from, String to) {
    return 'С $from по $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Предложено: $name';
  }

  @override
  String get swapToTeam => 'Вся команда';

  @override
  String everyWeekdays(String days) {
    return 'Каждую неделю: $days';
  }

  @override
  String get unavailableEveryWeek => 'Дни, когда вы никогда не доступны:';

  @override
  String get choosePeriod => 'Выбрать даты';

  @override
  String get choosePeriodOptional => 'Ограничить периодом (необязательно)';

  @override
  String get clearPeriod => 'Без периода';

  @override
  String get sendRequest => 'Отправить запрос';

  @override
  String get proposeSwap => 'Предложить обмен';

  @override
  String get swapWith => 'Предложить';

  @override
  String get swapSteps =>
      'Коллега соглашается, затем руководитель одобряет. График меняется только после этого.';

  @override
  String get absentThatDay => 'Одобренное отсутствие в этот день';

  @override
  String get requestSent => 'Запрос отправлен.';

  @override
  String noticeSwapOffer(String name) {
    return '$name предлагает вам одну из своих смен.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name отклонил ваше предложение обмена.';
  }

  @override
  String get noticeSwapToApprove => 'Обмен сменами ждёт вашего подтверждения.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name просит отпуск.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name сообщает о недоступности.';
  }

  @override
  String get noticeRequestApproved => 'Ваш запрос одобрен.';

  @override
  String get noticeRequestRefused => 'Ваш запрос отклонён.';

  @override
  String get choosePeer => 'Кто возьмёт эту смену?';

  @override
  String get discardAll => 'Отменить всё';

  @override
  String get notifySitesHint =>
      'Выберите площадки, по которым вы получаете уведомления о запросах. Все запросы остаются видны в списке.';

  @override
  String get pendingRequestTooltip => 'Запрос ожидает: нажмите, чтобы открыть';

  @override
  String get requestsHistory => 'Все запросы';

  @override
  String get revertChange => 'Отменить это изменение';

  @override
  String get statusExpired => 'Неактуально';

  @override
  String get swapWithHint => 'Нажмите, чтобы выбрать конкретного коллегу';

  @override
  String changesDiscarded(String count) {
    return 'Отменено изменений: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Отменить $count неопубликованных изменений?';
  }

  @override
  String get allSchedules => 'Все мои графики';

  @override
  String get busyElsewhere => 'Уже работает в другой компании в это время';

  @override
  String get overlapTooltip => 'Пересекается со сменой в другой компании';

  @override
  String get overlapWarning =>
      'Некоторые ваши смены в двух компаниях пересекаются.';

  @override
  String noticeOverlap(String date) {
    return 'Две ваши смены в разных компаниях пересекаются $date.';
  }

  @override
  String get allMyCompanies => 'Все мои компании';

  @override
  String get openRequest => 'Открыть запрос';

  @override
  String get thisCompany => 'Эта компания';

  @override
  String get withExtras => 'Вместе с внештатными';

  @override
  String reinforcementHint(String company) {
    return 'Из компании $company: будет добавлен как подкрепление и уведомлён.';
  }

  @override
  String get addToGoogle => 'Добавить в Google Календарь';

  @override
  String get calendarEnabled => 'Синхронизировать мои смены';

  @override
  String get changeSettings => 'Изменить';

  @override
  String get countryBelgium => 'Бельгия';

  @override
  String get countryCanada => 'Канада';

  @override
  String get countryFrance => 'Франция';

  @override
  String get countrySwitzerland => 'Швейцария';

  @override
  String get employeesSection => 'Сотрудники';

  @override
  String get emptyNoAlert => 'Пусто: без предупреждения';

  @override
  String get extrasSection => 'Внештатные';

  @override
  String get googleCalendar => 'Google Календарь';

  @override
  String get hoursTotals => 'Итоги часов';

  @override
  String get legalAlerts => 'Предупреждения по закону';

  @override
  String get legalAlertsHint =>
      'Только предупреждения, без блокировок. Выберите правила, которые действуют у вас, или никакие.';

  @override
  String get legalPreset => 'Шаблон страны';

  @override
  String get maxConsecutiveLabel => 'Максимум рабочих дней подряд';

  @override
  String get maxDayLabel => 'Максимум часов в день';

  @override
  String get maxWeekLabel => 'Максимум часов в неделю';

  @override
  String get minRestLabel => 'Минимальный отдых между сменами (часы)';

  @override
  String get noLegalRules => 'Предупреждения не выбраны.';

  @override
  String get presetNone => 'Нет';

  @override
  String get presetsCheck =>
      'Шаблоны — лишь отправная точка: проверьте их по законам вашей страны и коллективному договору.';

  @override
  String get printMine => 'Мой график';

  @override
  String get printOwn => 'Только свой график';

  @override
  String get printPdf => 'Печать / PDF';

  @override
  String get printRights => 'Что могут печатать сотрудники';

  @override
  String get printTeam => 'График всей команды';

  @override
  String get printTeamOption => 'График команды';

  @override
  String get totalsHint =>
      'С учётом черновиков. Экспорт в Excel и CSV берёт опубликованный график.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value дней подряд (максимум $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value за день (максимум $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: всего $value отдыха (минимум $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value за неделю (максимум $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Предупреждения по закону: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Смен: $count';
  }

  @override
  String get actionMakeDeputy => 'Назначить заместителем руководителя';

  @override
  String get actionRemoveDeputy => 'Снять роль заместителя';

  @override
  String get busyHere => 'Уже работает в компании в это время';

  @override
  String get calendarDenied =>
      'Доступ к календарю запрещён. Разрешите его в настройках телефона.';

  @override
  String get calendarLinkHint =>
      'Добавьте из Google Календаря на компьютере; Google обновляет его за несколько часов.';

  @override
  String get calendarNone => 'На этом телефоне нет календаря для записи.';

  @override
  String get calendarOnPhoneHint =>
      'В вашем календаре Google: сразу видно на телефоне и в Google Календаре.';

  @override
  String get chooseCalendar => 'Выбрать календарь';

  @override
  String get otherSiteHint =>
      'Сотрудник другой площадки: его руководители будут уведомлены.';

  @override
  String get subManager => 'Заместитель руководителя';

  @override
  String calendarSynced(String count) {
    return 'Смен в календаре: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Заместитель руководителя: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by поставил $name на площадку $site $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company добавила вас как подкрепление.';
  }

  @override
  String get companyNotificationsHint =>
      'Выключено: на этом телефоне ничего не звучит, но всё остаётся в колокольчике.';

  @override
  String get companyNotificationsOn => 'Получать уведомления от этой компании';

  @override
  String get companyTimezone => 'Часовой пояс компании';

  @override
  String get companyTimezoneHint =>
      'Все часы этой компании указаны по этому времени (с учётом летнего времени). Календари пересчитывают их автоматически.';

  @override
  String get iosInstallHint =>
      'На iPhone: нажмите «Поделиться», затем «На экран „Домой“», чтобы установить Staff Flow.';

  @override
  String get searchCity => 'Найти город';

  @override
  String get thisPhone => 'Это устройство';

  @override
  String companyNotifications(String name) {
    return 'Уведомления: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Часы по времени $zone ($company). Ваше устройство: $here.';
  }

  @override
  String get addPreset => 'Добавить шаблон';

  @override
  String get addPresets => 'Создать шаблоны';

  @override
  String get appearance => 'Оформление';

  @override
  String get chooseLogo => 'Выбрать изображение PNG';

  @override
  String get customization => 'Персонализация';

  @override
  String get editPresets => 'Шаблоны';

  @override
  String get enable => 'Включить снова';

  @override
  String get logoHint =>
      'Небольшое изображение PNG (ваш логотип) на вкладке компании для всех её участников.';

  @override
  String get logoPngOnly => 'Выберите изображение PNG не более 1 МБ.';

  @override
  String get myIdentifier => 'Мой идентификатор';

  @override
  String get myProfile => 'Мой профиль';

  @override
  String get presetName => 'Название (напр. Утро)';

  @override
  String get removeLogo => 'Убрать изображение';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get shiftPresets => 'Шаблоны смен';

  @override
  String get shiftPresetsHint =>
      'Готовые часы (утро, вечер, ночь…): одно касание в смене заполняет начало и конец.';

  @override
  String get themeDark => 'Тёмное';

  @override
  String get themeLight => 'Светлое';

  @override
  String get themeSystem => 'Системное';

  @override
  String get awaitingApproval => 'На утверждении';

  @override
  String get placementNeedsApproval =>
      '! Этот человек не из ваших объектов: смена будет ждать утверждения вашего руководителя или владельца, прежде чем её можно будет опубликовать. Иначе выберите другого сотрудника.';

  @override
  String get placementAwaiting =>
      'Ожидает утверждения руководителем или владельцем.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by хочет поставить $name с другого объекта на $date: нужно утверждение.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by утвердил(а) назначение $name на $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by отклонил(а) назначение $name на $date.';
  }

  @override
  String get addSubSite => 'Добавить подобъект';

  @override
  String get moveSite => 'Переместить';

  @override
  String get topLevel => 'Верхний уровень';

  @override
  String moveSiteTitle(String name) {
    return 'Переместить «$name» под…';
  }

  @override
  String subSiteOf(String name) {
    return 'Подобъект $name';
  }

  @override
  String get siteTreeHint =>
      'До 10 уровней, например Регион › Город › Магазин. Первые 3 входят в подписку; дальше нужна опция «Каскадные объекты». Руководитель объекта управляет и всем, что ниже.';

  @override
  String get subSitesOnlyHint =>
      'Здесь вы добавляете подобъекты к своим объектам.';

  @override
  String get messagingSetting => 'Лента новостей';

  @override
  String get messagingSettingHint =>
      'Включено: владелец и руководители публикуют объявления (для всех, должности, объекта или выбранных людей); каждый их читает и может перевести. Выключено: вкладка исчезает для всех.';

  @override
  String get billingTitle => 'Подписка';

  @override
  String billingStatusTrial(String date) {
    return 'Бесплатный пробный период до $date';
  }

  @override
  String billingStatusActive(String date) {
    return 'Оплачено до $date';
  }

  @override
  String billingStatusGrace(String date) {
    return 'Только чтение: без оплаты компания будет удалена $date.';
  }

  @override
  String get billingStatusComped => 'Бесплатно';

  @override
  String billingStaff(String count) {
    return '$count сотрудников и руководителей (без владельца и внештатных)';
  }

  @override
  String get billingMonthly => 'Ежемесячно';

  @override
  String billingYearly(String months) {
    return 'Ежегодно (оплачивается $months мес.)';
  }

  @override
  String get billingCascade => 'Опция «Каскадные объекты» (уровни 4–10)';

  @override
  String billingCascadeIncluded(String count) {
    return 'Включено от $count сотрудников';
  }

  @override
  String billingPay(String amount) {
    return 'Оплатить $amount';
  }

  @override
  String get billingTestNotice => 'Тестовая оплата: деньги не списываются.';

  @override
  String get billingSoon => 'Онлайн-оплата скоро появится.';

  @override
  String get billingPaidOk => 'Оплата зачислена.';

  @override
  String get billingInvoices => 'Счета';

  @override
  String get billingNoInvoices => 'Счетов пока нет.';

  @override
  String get billingManage => 'Управлять подпиской';

  @override
  String get billingReadOnlyStaff =>
      'Компания доступна только для чтения, пока владелец не продлит подписку.';

  @override
  String billingPerMonth(String amount) {
    return '$amount / мес.';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / год';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company: бесплатный пробный период закончится менее чем через 24 часа.';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company доступна только для чтения из-за неоплаты; удаление $date.';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'Напоминание: без оплаты $company будет удалена $date.';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company удалена из-за неоплаты.';
  }

  @override
  String billingCompanyId(String id) {
    return 'Идентификатор компании: $id';
  }

  @override
  String billingDueToday(String amount) {
    return 'Сегодня: $amount';
  }

  @override
  String billingProrataNote(String days) {
    return 'Включает остаток текущего месяца ($days дн., пропорционально), далее полные месяцы с 1-го числа.';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked =>
      'Ещё не привязан. Он нужен для подтверждения личности, например чтобы сменить аккаунт Google.';

  @override
  String telegramLinked(String name) {
    return 'Привязан: $name';
  }

  @override
  String get telegramNoUsername => 'без имени пользователя';

  @override
  String get telegramLink => 'Привязать мой Telegram';

  @override
  String get telegramLinkHint =>
      'Откроется Telegram: нажмите «Запустить», затем вернитесь сюда.';

  @override
  String get telegramUnlink => 'Отвязать';

  @override
  String get telegramUnavailable => 'Telegram пока недоступен.';

  @override
  String get telegramShowIn => 'Показывать мой Telegram в:';

  @override
  String get newQrCode => 'Сменить QR-код';

  @override
  String get newQrCodeConfirm =>
      'Старый QR-код и старый идентификатор перестанут работать. Ваше место в компаниях не изменится.';

  @override
  String get newQrCodeDone => 'Новый QR-код создан.';

  @override
  String get changeGoogle => 'Сменить аккаунт Google';

  @override
  String get changeGoogleSub => 'Тот же аккаунт, номер и компании';

  @override
  String changeGoogleSteps(String id) {
    return '1. Привяжите Telegram в этом профиле (обязательно).\n2. Выйдите, затем войдите с новым аккаунтом Google.\n3. Выберите «У меня уже есть аккаунт Staff Flow» и введите свой идентификатор $id.\n4. Введите код, полученный в Telegram.\nВаш аккаунт, номер и компании останутся прежними.';
  }

  @override
  String get recoverAccount => 'У меня уже есть аккаунт Staff Flow';

  @override
  String get recoverHint =>
      'Введите идентификатор старого аккаунта (SF-…). Код будет отправлен в Telegram, привязанный к нему.';

  @override
  String get recoverIdLabel => 'Идентификатор (SF-…)';

  @override
  String get recoverSend => 'Отправить код';

  @override
  String get recoverCodeSent => 'Код отправлен в Telegram.';

  @override
  String get recoverCodeLabel => 'Полученный код (6 цифр)';

  @override
  String get recoverConfirm => 'Восстановить мой аккаунт';

  @override
  String get recoverDone => 'Готово: вы вернулись в свой аккаунт.';

  @override
  String get exportData => 'Экспортировать мои данные';

  @override
  String get exportDataSub => 'Файл со всеми вашими личными данными';

  @override
  String get deleteAccount => 'Удалить мой аккаунт';

  @override
  String get deleteGhost => 'Удалить, оставив «призрака»';

  @override
  String get deleteGhostHint =>
      'Вы покинете все компании. Позже войдите с тем же аккаунтом Google, чтобы вернуть аккаунт и номер.';

  @override
  String get deleteErase => 'Стереть всё навсегда';

  @override
  String get deleteEraseHint =>
      'Имя, e-mail, фото, Telegram, сообщения и уведомления будут стёрты. Отменить нельзя.';

  @override
  String get deleteGhostNote =>
      'В обоих случаях история компаний сохраняет анонимного «Ghost» вместо вас (заявления на отпуск, прошлые смены…), чтобы владелец и руководители могли восстановить события.';

  @override
  String get deleteOwnerNote =>
      'Вы владелец компании? Сначала передайте её или дождитесь окончания подписки.';

  @override
  String get deleteConfirmButton => 'Удалить';

  @override
  String get accountRestored => 'С возвращением! Ваш аккаунт снова активен.';

  @override
  String get closedInvoices => 'Счета закрытых компаний';

  @override
  String get downloadAllInvoices => 'Скачать все счета (ZIP)';

  @override
  String get legalTerms => 'Условия использования и продажи';

  @override
  String get legalPrivacy => 'Политика конфиденциальности';

  @override
  String get billingDetailTitle => 'Детали оплаты';

  @override
  String billingLineProrata(String days, String total) {
    return 'Остаток текущего месяца ($days дн. из $total): подписка';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return 'Остаток текущего месяца ($days дн. из $total): опция «вложенные объекты»';
  }

  @override
  String billingLineMonth(String staff) {
    return 'Подписка, $staff мест: 1 мес.';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'Подписка, $staff мест: 12 мес. по цене $paid';
  }

  @override
  String billingLineCascade(String months) {
    return 'Опция «вложенные объекты»: $months мес., без скидки';
  }

  @override
  String get billingTotal => 'Итого';

  @override
  String billingCovers(String from, String to) {
    return 'Оплаченный период: с $from по $to';
  }

  @override
  String get billingGraceInvoices =>
      'Эта компания не продлевается: скачайте все её счета прямо сейчас.';

  @override
  String get billingYearLabel => 'Год';

  @override
  String get sitesNoneChosen => 'Объект не выбран';

  @override
  String get avatarTitle => 'Мой аватар';

  @override
  String get avatarSub => 'Изображение вместо вашего фото';

  @override
  String get avatarUseGoogle => 'Использовать фото Google';

  @override
  String get avatarColor => 'Цвет';

  @override
  String get hidePhotosTitle => 'Скрыть фото Google';

  @override
  String get hidePhotosSub =>
      'В этой компании каждого показывают с аватаром или инициалом.';

  @override
  String get billingApi => 'Опция «доступ к API»';

  @override
  String billingLineApi(String months) {
    return 'Опция «доступ к API»: $months мес., без скидки';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return 'Остаток текущего месяца ($days дн. из $total): опция «доступ к API»';
  }

  @override
  String get apiTitle => 'Доступ к API (бухгалтерия, CRM)';

  @override
  String get apiSub =>
      'Ваши программы бухгалтерии, зарплаты или CRM читают опубликованный график, часы и отсутствия.';

  @override
  String get apiNeedsOption =>
      'Платная опция: добавьте «доступ к API» в «Управлять подпиской».';

  @override
  String get apiNewKey => 'Новый ключ';

  @override
  String get apiKeyName => 'Название ключа (напр.: программа зарплаты)';

  @override
  String get apiKeyCreated =>
      'Скопируйте этот ключ сейчас и храните его надёжно: больше он не будет показан.';

  @override
  String get apiKeyCopy => 'Копировать';

  @override
  String get apiKeyCopied => 'Ключ скопирован.';

  @override
  String apiKeyLastUsed(String date) {
    return 'Последнее использование: $date';
  }

  @override
  String get apiKeyNeverUsed => 'Ещё не использовался';

  @override
  String get apiRevoke => 'Отозвать';

  @override
  String get apiRevokeConfirm =>
      'Программы, использующие этот ключ, потеряют доступ.';

  @override
  String get apiDocs => 'Документация API';

  @override
  String get memberGoogleLink => 'Повторный вход сотрудника через Google';

  @override
  String googleLinkHint(String name) {
    return 'Отправьте эту ссылку $name. Она открывается в браузере (не в приложении Android), один раз, в течение 24 часов: $name входит со своим новым аккаунтом Google и возвращает свой аккаунт. На всех остальных устройствах будет выполнен выход.';
  }

  @override
  String get googleLinkCopied => 'Ссылка скопирована.';

  @override
  String get switchBanner =>
      'Ссылка для смены аккаунта Google: войдите с новым аккаунтом Google, чтобы вернуть свой аккаунт Staff Flow.';

  @override
  String get switchSignOutFirst =>
      'Эта ссылка привязывает аккаунт Staff Flow к новому аккаунту Google. Сначала выйдите, затем войдите с новым аккаунтом Google.';

  @override
  String get switchDone =>
      'Готово: ваш аккаунт Staff Flow привязан к этому аккаунту Google. На остальных ваших устройствах выполнен выход.';

  @override
  String changeGoogleBot(String bot) {
    return 'Проще всего: в Telegram отправьте /changegoogle боту $bot и следуйте его указаниям, затем войдите с новым аккаунтом Google в течение 10 минут.';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Без Telegram: попросите у владельца или руководителя ссылку для смены аккаунта Google.';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name создал(а) ссылку, чтобы привязать ваш аккаунт к новому аккаунту Google. Если вы этого не просили, сообщите своему руководителю.';
  }

  @override
  String get sessionRevoked =>
      'Вы вышли из аккаунта: ваш аккаунт теперь привязан к другому аккаунту Google.';

  @override
  String telegramLoginHint(String bot) {
    return 'Совет: отправьте /connexion боту $bot, чтобы получить ссылку и открыть Staff Flow в браузере — без приложения и аккаунта Google.';
  }

  @override
  String get timeFormat => 'Формат времени';

  @override
  String get timeFormatAuto => 'Авто';

  @override
  String get people => 'Люди';

  @override
  String get sortNatural => 'Обычный порядок';

  @override
  String get sortName => 'Имя';

  @override
  String get employeeNumber => 'Табельный номер';

  @override
  String get sfIdLabel => 'ID Staff Flow';

  @override
  String get pickSearch => 'Поиск';

  @override
  String get pickSearchPeople => 'Поиск: имя, табельный номер, ID SF';

  @override
  String get pickSortTitle => 'Сортировать и показывать по';

  @override
  String pickSelected(String count) {
    return 'Отмечено: $count';
  }

  @override
  String get pickCheckAll => 'Отметить всех';

  @override
  String get pickClear => 'Снять все отметки';

  @override
  String get pickNoResult => 'Ничего не найдено';

  @override
  String get pickMultiHint =>
      'Отметьте нескольких человек: для каждого будет создана смена, всё за один раз.';

  @override
  String get filterAll => 'Все';

  @override
  String filterValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String get noPositionGroup => 'Без должности';

  @override
  String get noSiteGroup => 'Без объекта';

  @override
  String get groupByTitle => 'Группировать по';

  @override
  String get groupRole => 'Роль';

  @override
  String get groupNone => 'Без группировки';

  @override
  String showMore(String count, String left) {
    return 'Показать ещё $count (осталось $left)';
  }

  @override
  String get findByQr => 'Найти участника по его QR-коду';

  @override
  String get qrNotMember =>
      'Этот QR-код не соответствует никому в этой компании.';

  @override
  String get memberProfile => 'Табельный номер и должность';

  @override
  String get employeeNumberHint =>
      'Собственный номер вашей компании (необязательно). ID Staff Flow сохраняется.';

  @override
  String get usualPosition => 'Обычная должность';

  @override
  String get inviteCodeTitle => 'Код приглашения';

  @override
  String get inviteCodeHint =>
      'Введите код, полученный от работодателя, или отсканируйте QR-код приглашения.';

  @override
  String inviteJoined(String company) {
    return 'Вы присоединились к $company.';
  }

  @override
  String get importTitle => 'Импорт сотрудников';

  @override
  String get importIntro =>
      'Импортируйте список сотрудников из файла Excel или CSV. Каждый получает личный код и QR-код: активирует аккаунт через приложение 2FA (или Google). Никого не добавляют без согласия.';

  @override
  String get importTemplate => 'Скачать шаблон Excel';

  @override
  String get importTemplateHint =>
      'Столбцы: имя, табельный номер, должность, объект. Обязательно только имя.';

  @override
  String get importChooseFile => 'Выбрать файл (.xlsx или .csv)';

  @override
  String importNew(String count) {
    return 'Новые: $count';
  }

  @override
  String importUpdate(String count) {
    return 'Обновлено: $count';
  }

  @override
  String importSkip(String count) {
    return 'Уже приглашены: $count';
  }

  @override
  String importErrors(String count) {
    return 'Ошибки: $count';
  }

  @override
  String importConfirm(String count) {
    return 'Импортировать ($count)';
  }

  @override
  String get importErrorsIgnored =>
      'Строки с ошибками будут пропущены: исправьте их в файле и импортируйте снова.';

  @override
  String get importCreated => 'новый';

  @override
  String importDone(String count) {
    return 'Создано приглашений: $count';
  }

  @override
  String get invitesTitle => 'Ожидающие приглашения';

  @override
  String get invitesPrint => 'Распечатать коды';

  @override
  String get inviteShowHint =>
      'Человек выбирает «Активировать аккаунт» на экране входа (или «У меня есть код приглашения», если аккаунт уже есть), затем сканирует этот QR-код или вводит этот код. Действует 90 дней, один раз.';

  @override
  String invitesHint(String count) {
    return 'Ожидающих приглашений: $count. Нажмите на человека, чтобы показать его код и QR-код, или распечатайте все.';
  }

  @override
  String get inviteSeenByEmail => 'приглашение увидено (e-mail)';

  @override
  String get invitesNone => 'Нет ожидающих приглашений.';

  @override
  String get haveInviteCode => 'У меня есть код приглашения';

  @override
  String get newsTab => 'Новости';

  @override
  String get newsNew => 'Новое объявление';

  @override
  String get newsEmpty => 'Объявлений пока нет.';

  @override
  String get newsEmptyManager =>
      'Объявлений пока нет. Опубликуйте первое: для всей компании, должности, объекта или выбранных людей.';

  @override
  String get newsOlder => 'Более старые объявления';

  @override
  String get newsEdited => 'изменено';

  @override
  String get newsEdit => 'Изменить объявление';

  @override
  String get newsDeleteTitle => 'Убрать это объявление?';

  @override
  String get newsForEveryone => 'Для всех';

  @override
  String get newsEveryoneMySites => 'Все на моих объектах';

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
    return 'Прочитали $count из $total';
  }

  @override
  String get newsTranslated => 'Переведено автоматически';

  @override
  String get newsTitleField => 'Заголовок (необязательно)';

  @override
  String get newsBodyField => 'Текст объявления';

  @override
  String get newsRecipients => 'Получатели';

  @override
  String get newsTargetHint =>
      'Отметьте одну или несколько групп: объявление получит каждый, кто входит в любую из них.';

  @override
  String get newsPublish => 'Опубликовать';

  @override
  String newsSent(String count) {
    return 'Объявление отправлено: $count чел.';
  }

  @override
  String billingLineApiAddon(String from, String to, String months) {
    return 'Опция «Доступ к API», добавленная во время подписки, с $from по $to: $months мес., без скидки';
  }

  @override
  String billingLineCascadeAddon(String from, String to, String months) {
    return 'Опция «Каскадные объекты», добавленная во время подписки, с $from по $to: $months мес., без скидки';
  }

  @override
  String get billingRenewalOptions =>
      'Отмеченные опции будут включены в следующие продления. Опция без отметки действует до конца уже оплаченного периода.';

  @override
  String billingAddonTitle(String option) {
    return 'Добавить сейчас: $option';
  }

  @override
  String billingAddonHint(String date) {
    return 'Текущий месяц целиком, затем каждый месяц до $date (конец оплаченного периода), без скидки. Опция действует сразу после оплаты и включается в следующие продления.';
  }

  @override
  String get billingAddonInvoice => 'опция';

  @override
  String billingAccessRemoved(String name) {
    return '$name больше не управляет подпиской.';
  }

  @override
  String billingAccessGiven(String name) {
    return '$name теперь может управлять подпиской и счетами.';
  }

  @override
  String get actionBillingRemove => 'Отозвать управление подпиской';

  @override
  String get actionBillingGive => 'Разрешить управлять подпиской';

  @override
  String get billingAccessTag => 'Управляет подпиской';

  @override
  String get billingOptionRenewed => 'Продление опции возобновлено.';

  @override
  String get billingOptionStopped =>
      'Опция не будет продлена: она действует до конца оплаченного периода.';

  @override
  String billingOptionEnds(String date) {
    return 'Действует до $date, не будет продлена (отметьте, чтобы сохранить)';
  }

  @override
  String get billingOptionActive =>
      'Действует и продлевается (снимите отметку, чтобы не продлевать)';

  @override
  String get statusCancelRequested => 'Запрошена отмена';

  @override
  String get requestEndedEarly => 'Завершено раньше самим человеком.';

  @override
  String get confirmCancelRequest =>
      'Отменить этот запрос? Руководители больше его не увидят.';

  @override
  String get endUnavailability => 'Завершить мою недоступность';

  @override
  String get confirmEndUnavailability =>
      'Завершить вашу недоступность? Вы снова будете доступны с сегодняшнего дня, а руководители будут уведомлены.';

  @override
  String get askLeaveCancel => 'Попросить отменить этот отпуск';

  @override
  String get confirmAskLeaveCancel =>
      'Попросить отменить этот отпуск? Руководитель должен это одобрить; до тех пор отпуск остаётся в плане.';

  @override
  String get refuseLeaveCancel => 'Отклонить отмену';

  @override
  String get acceptLeaveCancel => 'Одобрить отмену';

  @override
  String get requestsSearchHint =>
      'Поиск: имя, табельный номер, ID SF, примечание';

  @override
  String get filterType => 'Тип';

  @override
  String get filterState => 'Статус';

  @override
  String get statePending => 'Ожидают';

  @override
  String get stateClosed => 'Отклонённые или отменённые';

  @override
  String billingLineSlotsAddon(
    String from,
    String to,
    String start,
    String end,
    String months,
  ) {
    return 'Добавлены места, с $from до $to, с $start по $end: $months мес., без скидки';
  }

  @override
  String billingSeats(String used, String limit) {
    return 'Оплачено мест: $used · до $limit человек с запасом 5 %';
  }

  @override
  String get billingSeatsTitle => 'Количество мест';

  @override
  String get billingSeatsHint =>
      'Сотрудники и руководители (без владельца и внештатных), блоками по 10. 10 мест при создании; сверх того — запас 5 %, дальше добавлять нельзя.';

  @override
  String get billingSeatsUnit => 'мест';

  @override
  String billingSeatsAddon(String from, String to) {
    return 'Места: $from → $to';
  }

  @override
  String billingSeatsRange(String min) {
    return 'От $min до 5000, блоками по 10.';
  }

  @override
  String get printWeek => 'Неделя';

  @override
  String get printMonth => 'Месяц';

  @override
  String teamCount(String team, String count) {
    return '$team · $count';
  }

  @override
  String teamCountSeats(String team, String count, String slots) {
    return '$team · $count/$slots';
  }

  @override
  String get rememberMe => 'Оставаться в системе на этом устройстве';

  @override
  String get rememberMeHint =>
      'Включено: как с Google, не нужно вводить код при каждом открытии. Не включайте на общем устройстве.';

  @override
  String get totpLoginTitle => 'Вход через 2FA';

  @override
  String get totpLoginHint =>
      'Введите свой идентификатор Staff Flow (SF-…) или табельный номер, затем 6-значный код из приложения аутентификации.';

  @override
  String get totpLoginField => 'Идентификатор SF или табельный номер';

  @override
  String get totpCompanyCode => 'Код компании';

  @override
  String get totpCompanyCodeHint =>
      '6 символов от работодателя (только с табельным номером).';

  @override
  String get totpBackupCode => 'Резервный код';

  @override
  String get totpCode => 'Код приложения';

  @override
  String get totpUseApp => 'Использовать приложение 2FA';

  @override
  String get totpUseBackup => 'Использовать резервный код';

  @override
  String get totpSignIn => 'Войти';

  @override
  String get totpLostPhone =>
      'Потеряли телефон или удалили приложение? Попросите у руководителя новый код активации.';

  @override
  String get activateTitle => 'Активировать аккаунт';

  @override
  String get activateStep1 => 'Шаг 1: ваш код приглашения';

  @override
  String get activateStep1Hint =>
      'Отсканируйте QR-код от работодателя или введите код, написанный под ним.';

  @override
  String get activateScan => 'Сканировать QR-код';

  @override
  String get activateCodeField => 'Код приглашения';

  @override
  String get activateContinue => 'Продолжить';

  @override
  String activateHello(String name, String company) {
    return 'Здравствуйте, $name · $company';
  }

  @override
  String get activateStep2 =>
      'Шаг 2: привяжите приложение аутентификации (Google Authenticator, Microsoft Authenticator…). Оно будет давать 6-значный код при каждом входе.';

  @override
  String get activateOpenApp => 'Добавить в моё приложение аутентификации';

  @override
  String get activateOrScan =>
      'Или с другого устройства отсканируйте этот QR-код приложением:';

  @override
  String get activateManualKey => 'Ключ для ручного ввода:';

  @override
  String get activateFirstCode => 'Первый код из приложения';

  @override
  String get activateDone => 'Активировать';

  @override
  String get totpReadyTitle => 'Ваш аккаунт готов';

  @override
  String get totpYourId => 'Ваш идентификатор Staff Flow:';

  @override
  String get totpBackupHint =>
      'Резервные коды (каждый работает один раз): запишите их или храните в надёжном месте. Они понадобятся, если приложения больше нет.';

  @override
  String get totpBackupSaved => 'Записал(а)';

  @override
  String get linkGoogleTitle => 'Привязать аккаунт Google';

  @override
  String get linkGoogleHint =>
      'Чтобы создать компанию, привяжите аккаунт Google к своему аккаунту Staff Flow. Он нужен только для защиты создателя компании и её подписки: ваш адрес Google никогда не показывают ни сотрудникам, ни кому-либо ещё, он остаётся в Staff Flow. Вы по-прежнему сможете входить через приложение 2FA.';

  @override
  String get linkGoogleButton => 'Привязать мой Google';

  @override
  String get linkGoogleBanner =>
      'Войдите с аккаунтом Google, который нужно привязать к Staff Flow.';

  @override
  String get totpLoginButton => 'Войти через приложение 2FA';

  @override
  String get activateButton => 'Активировать аккаунт (код работодателя)';

  @override
  String get activationCodeAction => 'Новый код активации';

  @override
  String activationCodeTitle(String name) {
    return 'Новый код для $name?';
  }

  @override
  String get activationCodeConfirm =>
      'Старый телефон и старое приложение 2FA перестанут работать. Человек снова активирует аккаунт этим кодом (действует 7 дней).';

  @override
  String get activationCodeHint =>
      'Человек выбирает «Активировать аккаунт» на экране входа, затем сканирует этот QR-код или вводит этот код.';

  @override
  String get signupTitle => 'Создать аккаунт';

  @override
  String get signupStep1 => 'Шаг 1: ваше имя';

  @override
  String get signupStep1Hint =>
      'Имя, которое увидят коллеги и работодатели. Без Google и без e-mail: аккаунт защищает приложение аутентификации.';

  @override
  String get signupName => 'Имя и фамилия';

  @override
  String signupHello(String name) {
    return 'Здравствуйте, $name';
  }

  @override
  String get signupButton => 'Создать аккаунт с приложением 2FA';

  @override
  String get totpCardTitle => 'Вход через приложение 2FA';

  @override
  String totpCardLocal(String id) {
    return 'Ваш аккаунт входит через приложение аутентификации. Идентификатор: $id';
  }

  @override
  String totpCardOn(String id) {
    return 'Включено: вы можете также входить с идентификатором $id и кодом приложения, без Google.';
  }

  @override
  String get totpCardOff =>
      'Настройте приложение аутентификации, чтобы входить без Google (идентификатор SF + 6-значный код).';

  @override
  String get totpEnable => 'Включить';

  @override
  String get totpDisable => 'Отключить';

  @override
  String get totpEnableTitle => 'Включить вход через 2FA';

  @override
  String get totpEnabledTitle => 'Вход через 2FA готов';

  @override
  String get totpDisableConfirm =>
      'Отключить вход через приложение 2FA? Вы будете входить только через Google.';

  @override
  String get googlePrivacyNote =>
      'Ваш аккаунт Google служит только для защиты компании и её подписки: его никогда не показывают сотрудникам или кому-либо ещё.';
}
