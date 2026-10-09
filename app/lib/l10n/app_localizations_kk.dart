// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class L10nKk extends L10n {
  L10nKk([String locale = 'kk']) : super(locale);

  @override
  String get cancel => 'Бас тарту';

  @override
  String get save => 'Сақтау';

  @override
  String get confirm => 'Растау';

  @override
  String get validate => 'Растау';

  @override
  String get add => 'Қосу';

  @override
  String get rename => 'Атын өзгерту';

  @override
  String get delete => 'Жою';

  @override
  String get accept => 'Қабылдау';

  @override
  String get decline => 'Бас тарту';

  @override
  String get close => 'Жабу';

  @override
  String get retry => 'Қайталау';

  @override
  String get name => 'Атауы';

  @override
  String get serverUnreachable => 'Серверге қосылу мүмкін емес.';

  @override
  String errorStatus(int status) {
    return 'Қате $status';
  }

  @override
  String get roleOwner => 'Иесі';

  @override
  String get roleManager => 'Жетекші';

  @override
  String get roleEmployee => 'Қызметкер';

  @override
  String get roleExtra => 'Уақытша қызметкер';

  @override
  String get taglineStart => 'Командаңыздың кестесі — ';

  @override
  String get taglineEnd => 'кез келген жерде.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Google арқылы кіру';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google арқылы кіру қолжетімсіз: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google арқылы кіру сәтсіз: $detail';
  }

  @override
  String get newCompany => 'Жаңа компания';

  @override
  String get timezone => 'Уақыт белдеуі';

  @override
  String get create => 'Жасау';

  @override
  String get noCompanyTitle => 'Сіз әлі ешбір компанияда жоқсыз.';

  @override
  String get noCompanyHint =>
      'Жұмыс берушіңіздің компаниясына қосылу үшін код жасап, оны жетекшіңізге беріңіз.';

  @override
  String get joinCompany => 'Компанияға қосылу';

  @override
  String get createCompany => 'Компания жасау';

  @override
  String transferOffer(String company) {
    return 'Сізге «$company» компаниясының иесі болу ұсынылды.';
  }

  @override
  String get someCompany => 'компания';

  @override
  String get becameOwner => 'Енді сіз иесісіз.';

  @override
  String get myAccount => 'Менің аккаунтым';

  @override
  String get idCopied => 'Идентификатор көшірілді.';

  @override
  String myId(String id) {
    return 'Менің идентификаторым: $id';
  }

  @override
  String get signOut => 'Шығу';

  @override
  String joinInvite(String company, String role) {
    return '«$company» сізді шақырады: $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Сіз «$company» компаниясына қосылдыңыз.';
  }

  @override
  String get viewPlanning => 'Кесте';

  @override
  String get viewTeam => 'Команда';

  @override
  String get viewPositions => 'Лауазымдар';

  @override
  String get readOnlyCompany => 'Компания тек көруге арналған.';

  @override
  String get team => 'Команда';

  @override
  String get leaveCompany => 'Компаниядан шығу';

  @override
  String meSuffix(String name) {
    return '$name (сіз)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Компанияны беру: $name?';
  }

  @override
  String get transferConfirmBody =>
      'Қабылдағаннан кейін бұл адам иесі болады (жазылым, шоттар, жетекшілер), ал сіз жетекші боласыз.';

  @override
  String transferSent(String name) {
    return 'Ұсыныс жіберілді: $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Шығару: $name?';
  }

  @override
  String get removeConfirmBody => 'Тарихы сақталады.';

  @override
  String get addPersonTitle => 'Адам қосу';

  @override
  String get addPersonHint =>
      'Одан Staff Flow ашып, аккаунт мәзірінде «Компанияға қосылу» таңдауын сұраңыз, сосын көрсетілген кодты енгізіңіз.';

  @override
  String get sixDigitCode => '6 таңбалы код';

  @override
  String invitationSent(String name) {
    return 'Шақыру жіберілді: $name. Оны қабылдау керек.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '«$company» компаниясынан шығасыз ба?';
  }

  @override
  String get leaveConfirmBody => 'Оның кестесін енді көрмейсіз.';

  @override
  String get renameCompany => 'Компания атын өзгерту';

  @override
  String get actionMakeManager => 'Жетекші ету';

  @override
  String get actionMakeEmployee => 'Қайта қызметкер ету';

  @override
  String get actionToEmployee => 'Қызметкер ету';

  @override
  String get actionToExtra => 'Уақытша ету';

  @override
  String get actionTransfer => 'Иелікті беру';

  @override
  String get actionRemove => 'Компаниядан шығару';

  @override
  String get positions => 'Лауазымдар';

  @override
  String get sites => 'Нысандар';

  @override
  String get positionsHint => 'Адам не істейді: касса, ас үй, ресепшн…';

  @override
  String get sitesHint =>
      'Компанияның бірнеше нысаны болса, ауысым қай жерде өтеді.';

  @override
  String get archived => 'Мұрағатта';

  @override
  String get archive => 'Мұрағаттау';

  @override
  String get reactivate => 'Қайта қосу';

  @override
  String weekOf(String date) {
    return '$date аптасы';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count өзгеріс жарияланды.',
      one: '1 өзгеріс жарияланды.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Ауысым';

  @override
  String get display => 'Көрініс';

  @override
  String get week => 'Апта';

  @override
  String get month => 'Ай';

  @override
  String get today => 'Бүгін';

  @override
  String get onlyMine => 'Тек менің ауысымдарым';

  @override
  String get replacePersonMenu => 'Адамды ауыстыру…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count жарияланбаған өзгеріс',
      one: '1 жарияланбаған өзгеріс',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Қызметкерлер оларды әлі көрмейді.';

  @override
  String get publish => 'Жариялау';

  @override
  String yourHours(String duration) {
    return 'Кезеңдегі сағаттарыңыз: $duration';
  }

  @override
  String get addShiftThisDay => 'Осы күнге ауысым қосу';

  @override
  String get noShift => 'Ауысым жоқ';

  @override
  String get unassigned => 'Тағайындалмаған';

  @override
  String get formerMember => 'Бұрынғы мүше';

  @override
  String get statusDraft => 'Жоба';

  @override
  String get statusModified => 'Өзгертілген';

  @override
  String get statusDeleted => 'Жойылған';

  @override
  String durationHours(int hours) {
    return '$hours сағ';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours сағ $minutes мин';
  }

  @override
  String get editShift => 'Ауысымды өзгерту';

  @override
  String get newShift => 'Жаңа ауысым';

  @override
  String get thisShift => 'Тек осы ауысым';

  @override
  String get thisAndFollowing => 'Осы және келесілері';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Күндер',
      one: 'Күн',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Басқа күн';

  @override
  String get start => 'Басталуы';

  @override
  String get end => 'Аяқталуы';

  @override
  String get endsNextDay => 'Келесі күні аяқталады.';

  @override
  String get person => 'Адам';

  @override
  String get position => 'Лауазым';

  @override
  String get site => 'Нысан';

  @override
  String get noteOptional => 'Ескертпе (міндетті емес)';

  @override
  String get repetition => 'Қайталау';

  @override
  String get repeatNone => 'Жоқ';

  @override
  String get repeatDaily => 'Күн сайын';

  @override
  String get repeatWeekly => 'Апта сайын';

  @override
  String get repeatForPrefix => 'Мерзімі ';

  @override
  String get repeatDaysSuffix => ' күн';

  @override
  String get repeatWeeksSuffix => ' апта';

  @override
  String get repeatUntilPrefix => 'Дейін ';

  @override
  String get replacePersonTitle => 'Адамды ауыстыру';

  @override
  String get replaceFrom => 'Кімді ауыстыру';

  @override
  String get replaceBy => 'Кімге';

  @override
  String dateRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ауысым өзгертілді.',
      one: '1 ауысым өзгертілді.',
      zero: 'Ешбір ауысым өзгермеді.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Ауыстыру';

  @override
  String get joinHint =>
      'Бұл кодты жетекшіңізге беріңіз. Ол қолданбаға енгізгеннен кейін сізге шақыру келеді.';

  @override
  String get codeExpired => 'Кодтың мерзімі өтті.';

  @override
  String codeValidFor(String time) {
    return 'Тағы $time жарамды';
  }

  @override
  String get newCode => 'Жаңа код';

  @override
  String get language => 'Тіл';

  @override
  String get languageAuto => 'Автоматты (құрылғы тілі)';

  @override
  String get syncUpToDate => 'Жаңартылған';

  @override
  String get syncOffline => 'Желіден тыс';

  @override
  String syncPending(int count) {
    return 'Күтудегі өзгерістер: $count';
  }

  @override
  String get syncNow => 'Қазір синхрондау';

  @override
  String syncRejected(String reason) {
    return 'Сервер өзгерісті қабылдамады: $reason';
  }

  @override
  String get pendingBadge => 'Күтуде';

  @override
  String get offlineUnavailable => 'Желісіз қолжетімсіз.';

  @override
  String get offlineCached => 'Желіден тыс: соңғы сақталған деректер.';

  @override
  String get savedOffline =>
      'Құрылғыда сақталды, желі қалпына келгенде жіберіледі.';

  @override
  String get notices => 'Хабарламалар';

  @override
  String get noNotices => 'Хабарлама жоқ.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name сіздің $date ауысымындағы өзгерісіңізді ауыстырды.';
  }

  @override
  String get history => 'Тарих';

  @override
  String get recentChanges => 'Соңғы өзгерістер';

  @override
  String get undoChange => 'Бұл өзгерісті болдырмау';

  @override
  String get undoDone => 'Өзгеріс болдырылмады.';

  @override
  String get historyCreate => 'Құрылды';

  @override
  String get historyUpdate => 'Өзгертілді';

  @override
  String get historyDelete => 'Жойылды';

  @override
  String get historyUndo => 'Болдырылмады';

  @override
  String get noHistory => 'Өзгеріс жоқ.';

  @override
  String get pendingNotEditable =>
      'Бұл ауысым әлі синхрондалмаған: желіде болғанда қайталаңыз.';

  @override
  String get myQrCode => 'Менің QR-кодым';

  @override
  String get myQrCodeHint =>
      'Басшы сізді компаниясына қосу үшін осы кодты сканерлейді; содан кейін сіз растайсыз. Код ешқашан өзгермейді.';

  @override
  String get changeMyName => 'Атымды өзгерту';

  @override
  String get nameShownToTeam =>
      'Әріптестеріңіз Google атыңыздың орнына осы атты көреді.';

  @override
  String googleName(String name) {
    return 'Google аты: $name';
  }

  @override
  String get useGoogleName => 'Google атымды қолдану';

  @override
  String renameMemberTitle(String name) {
    return 'Атын өзгерту: $name';
  }

  @override
  String get renameMemberHint => 'Бұл ат тек осы компанияда қолданылады.';

  @override
  String get useOwnName => 'Өз атын қолдану';

  @override
  String get scanQrCode => 'QR-кодты сканерлеу';

  @override
  String get scanQrHint =>
      'Камераны оның қолданбасындағы QR-кодқа бағыттаңыз (аккаунт мәзірі, «Менің QR-кодым»).';

  @override
  String get orEnterCode => 'Немесе оның 6 таңбалы кодын енгізіңіз';

  @override
  String get qrInvalid => 'Бұл Staff Flow QR-коды емес.';

  @override
  String cameraUnavailable(String error) {
    return 'Камера қолжетімсіз ($error).';
  }

  @override
  String get notificationsTitle => 'Хабарландырулар';

  @override
  String get notifChooseHint =>
      'Қандай хабарландыру алатыныңызды таңдаңыз. Бәрі қоңырауда көрініп тұрады.';

  @override
  String get notifPlanning => 'Кесте жарияланды немесе өзгертілді';

  @override
  String get notifRequests => 'Сұраулар: ауысулар, демалыс, шақырулар';

  @override
  String get notifMessages => 'Жаңа хабарлар';

  @override
  String get notifOverlap => 'Компаниялар арасындағы қабаттасқан ауысымдар';

  @override
  String get notifConflicts => 'Өзгерісіңізді басқа басшы ауыстырды';

  @override
  String get notifBilling => 'Жазылым туралы еске салғыштар';

  @override
  String get pushEnabled => 'Бұл құрылғыда хабарландырулар қосулы.';

  @override
  String get pushOff => 'Бұл құрылғыда хабарландырулар өшірулі.';

  @override
  String get pushBlocked =>
      'Хабарландырулар бұғатталған: телефон немесе браузер параметрлерінде рұқсат етіңіз.';

  @override
  String get pushUnavailable => 'Бұл құрылғыда хабарландырулар қолжетімсіз.';

  @override
  String get enablePush => 'Қосу';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: кестеңіз жарияланды немесе өзгертілді.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company сізді командасына қосқысы келеді.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name сізге $company иесі болуды ұсынады.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name $company компаниясына қосылды.';
  }

  @override
  String get messagesTab => 'Хабарлар';

  @override
  String get wholeTeam => 'Бүкіл команда';

  @override
  String get newConversation => 'Жаңа әңгіме';

  @override
  String get noMessages => 'Әзірге хабар жоқ.';

  @override
  String get messageHint => 'Хабар жазыңыз';

  @override
  String get earlierMessages => 'Бұрынғы хабарлар';

  @override
  String get personLeftCompany => 'Бұл адам енді компанияда емес.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Жаңа топ';

  @override
  String get editGroup => 'Топты өңдеу';

  @override
  String get groupName => 'Топ атауы';

  @override
  String get groupMembersHint =>
      'Осы топтағы адамдарды таңдаңыз. Хабарларын тек солар көреді.';

  @override
  String get chooseAtLeastOne => 'Кемінде бір адамды таңдаңыз.';

  @override
  String get replyAction => 'Жауап беру';

  @override
  String get translateAction => 'Аудару';

  @override
  String replyingTo(String name) {
    return '$name үшін жауап';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name соңғы хабарлары';
  }

  @override
  String get deleteAllNotices => 'Бәрін жою';

  @override
  String get deleteAllNoticesConfirm =>
      'Барлық хабарландыруларды жою керек пе?';

  @override
  String get noticeRetention => 'Оқылған хабарландыруларды жою мерзімі';

  @override
  String get retentionDay => '1 күн';

  @override
  String get retentionWeek => '1 апта';

  @override
  String get retentionMonth => '1 ай';

  @override
  String get billingOwnersOnly => 'Тек компанияңыз болса ғана қосулы.';

  @override
  String get readOnlyPastDays => 'Бір айдан асқан күндерді тек қарауға болады.';

  @override
  String get wholeCompany => 'Бүкіл компания';

  @override
  String get sitesLabel => 'Нысандар';

  @override
  String get actionSites => 'Нысандар…';

  @override
  String managerOf(String name) {
    return '$name жауапты';
  }

  @override
  String teamSitesOf(String name) {
    return '$name командасы';
  }

  @override
  String get notYourSite => 'Бұл нысан сіздің жауапкершілігіңізде емес.';

  @override
  String get chooseYourSite => 'Кемінде бір нысанды таңдаңыз.';
}
