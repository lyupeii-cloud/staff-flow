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
}
