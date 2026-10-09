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
  String myId(String id) {
    return 'Мой идентификатор: $id';
  }

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
  String get viewTeam => 'Команда';

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
  String get notifMessages => 'Новые сообщения';

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
  String get messagesTab => 'Сообщения';

  @override
  String get wholeTeam => 'Вся команда';

  @override
  String get newConversation => 'Новая беседа';

  @override
  String get noMessages => 'Сообщений пока нет.';

  @override
  String get messageHint => 'Напишите сообщение';

  @override
  String get earlierMessages => 'Предыдущие сообщения';

  @override
  String get personLeftCompany => 'Этот человек больше не состоит в компании.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Новая группа';

  @override
  String get editGroup => 'Изменить группу';

  @override
  String get groupName => 'Название группы';

  @override
  String get groupMembersHint =>
      'Выберите людей для этой группы. Только они увидят её сообщения.';

  @override
  String get chooseAtLeastOne => 'Выберите хотя бы одного человека.';

  @override
  String get replyAction => 'Ответить';

  @override
  String get translateAction => 'Перевести';

  @override
  String replyingTo(String name) {
    return 'Ответ для $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Последние сообщения от $name';
  }

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
  String get myRequests => 'Мои запросы';

  @override
  String get otherRequests => 'Запросы команды';

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
  String get notifySitesTitle => 'Уведомления по площадкам';

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
  String get deleteGroup => 'Удалить группу';

  @override
  String get openRequest => 'Открыть запрос';

  @override
  String get thisCompany => 'Эта компания';

  @override
  String get withExtras => 'Вместе с внештатными';

  @override
  String deleteGroupConfirm(String name) {
    return 'Удалить «$name» и все сообщения для всех?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Из компании $company: будет добавлен как подкрепление и уведомлён.';
  }

  @override
  String get addToGoogle => 'Добавить в Google Календарь';

  @override
  String get calendarEnabled => 'Синхронизировать мои смены';

  @override
  String get calendarHint =>
      'Добавьте свои смены из всех компаний в Google Календарь. Они обновляются сами, и вы можете отключить это в любой момент.';

  @override
  String get changeSettings => 'Изменить';

  @override
  String get copyCalendarLink => 'Копировать ссылку на календарь';

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
  String get linkCopied => 'Ссылка скопирована.';

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
  String get calendarByLink => 'По ссылке (Google Календарь на компьютере)';

  @override
  String get calendarDenied =>
      'Доступ к календарю запрещён. Разрешите его в настройках телефона.';

  @override
  String get calendarLinkHint =>
      'Добавьте из Google Календаря на компьютере; Google обновляет его за несколько часов.';

  @override
  String get calendarNone => 'На этом телефоне нет календаря для записи.';

  @override
  String get calendarOnPhone => 'Добавить мои смены в календарь телефона';

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
  String get conversationMuted => 'Уведомления этого разговора отключены.';

  @override
  String get conversationUnmuted =>
      'Уведомления этого разговора снова включены.';

  @override
  String get customization => 'Персонализация';

  @override
  String get disableGroup => 'Отключить группу';

  @override
  String get disableGroupConfirm =>
      'Группа всей компании будет скрыта для всех. Включить её снова можно в «Сообщениях».';

  @override
  String get editPresets => 'Шаблоны';

  @override
  String get enable => 'Включить снова';

  @override
  String get groupDisabled => 'Группа отключена (видите только вы)';

  @override
  String get logoHint =>
      'Небольшое изображение PNG (ваш логотип) на вкладке компании для всех её участников.';

  @override
  String get logoPngOnly => 'Выберите изображение PNG не более 1 МБ.';

  @override
  String get muteConversation => 'Отключить уведомления этого разговора';

  @override
  String get myIdentifier => 'Мой идентификатор';

  @override
  String get myProfile => 'Мой профиль';

  @override
  String get presetName => 'Название (напр. Утро)';

  @override
  String get removeLogo => 'Убрать изображение';

  @override
  String get resetGroup => 'Очистить группу';

  @override
  String get resetGroupConfirm =>
      'Все сообщения группы компании будут удалены для всех.';

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
  String get unmuteConversation => 'Включить уведомления этого разговора';

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
}
