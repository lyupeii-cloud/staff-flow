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

  @override
  String get viewRequests => 'Сұраулар';

  @override
  String get newRequest => 'Жаңа сұрау';

  @override
  String get requestLeave => 'Демалыс';

  @override
  String get requestUnavailability => 'Қолжетімсіздік';

  @override
  String get requestSwap => 'Ауысым алмасу';

  @override
  String get swapHint =>
      'Алмасуды ұсыну үшін кестеден алдағы ауысымдарыңыздың біреуін түртіңіз.';

  @override
  String get noRequests => 'Әзірге сұраулар жоқ.';

  @override
  String get requestsToHandle => 'Өңдеу керек';

  @override
  String get myRequests => 'Менің сұрауларым';

  @override
  String get otherRequests => 'Команданың сұраулары';

  @override
  String get statusPendingPeer => 'Әріптесті күтуде';

  @override
  String get statusPendingManager => 'Басшыны күтуде';

  @override
  String get statusApproved => 'Мақұлданды';

  @override
  String get statusRefused => 'Қабылданбады';

  @override
  String get statusCancelled => 'Бас тартылды';

  @override
  String get cancelRequest => 'Сұраудан бас тарту';

  @override
  String get acceptSwap => 'Бұл ауысымды алу';

  @override
  String get approve => 'Мақұлдау';

  @override
  String periodLabel(String from, String to) {
    return '$from – $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Ұсынылды: $name';
  }

  @override
  String get swapToTeam => 'Бүкіл команда';

  @override
  String everyWeekdays(String days) {
    return 'Әр апта: $days';
  }

  @override
  String get unavailableEveryWeek => 'Сіз ешқашан қолжетімді емес күндер:';

  @override
  String get choosePeriod => 'Күндерді таңдау';

  @override
  String get choosePeriodOptional => 'Кезеңмен шектеу (міндетті емес)';

  @override
  String get clearPeriod => 'Кезеңсіз';

  @override
  String get sendRequest => 'Сұрауды жіберу';

  @override
  String get proposeSwap => 'Алмасуды ұсыну';

  @override
  String get swapWith => 'Кімге ұсыну';

  @override
  String get swapSteps =>
      'Әріптес келіседі, содан кейін басшы мақұлдайды. Кесте тек содан кейін өзгереді.';

  @override
  String get absentThatDay => 'Сол күні мақұлданған болмау';

  @override
  String get requestSent => 'Сұрау жіберілді.';

  @override
  String noticeSwapOffer(String name) {
    return '$name сізге өз ауысымдарының бірін ұсынады.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name ауысу ұсынысыңызды қабылдамады.';
  }

  @override
  String get noticeSwapToApprove =>
      'Ауысым алмасуы сіздің мақұлдауыңызды күтуде.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name демалыс сұрайды.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name қолжетімсіз екенін хабарлады.';
  }

  @override
  String get noticeRequestApproved => 'Сұрауыңыз мақұлданды.';

  @override
  String get noticeRequestRefused => 'Сұрауыңыз қабылданбады.';

  @override
  String get choosePeer => 'Бұл ауысымды кім алады?';

  @override
  String get discardAll => 'Барлығын болдырмау';

  @override
  String get notifySitesHint =>
      'Сұраулар туралы хабарландыру алатын нысандарды таңдаңыз. Барлық сұраулар тізімде көрініп тұрады.';

  @override
  String get notifySitesTitle => 'Нысан бойынша хабарландырулар';

  @override
  String get pendingRequestTooltip => 'Күтудегі сұрау: ашу үшін түртіңіз';

  @override
  String get requestsHistory => 'Барлық сұраулар';

  @override
  String get revertChange => 'Бұл өзгерісті болдырмау';

  @override
  String get statusExpired => 'Өзектілігін жойды';

  @override
  String get swapWithHint => 'Нақты әріптесті таңдау үшін түртіңіз';

  @override
  String changesDiscarded(String count) {
    return 'Болдырылмаған өзгерістер: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Жарияланбаған $count өзгерісті болдырмау керек пе?';
  }

  @override
  String get allSchedules => 'Барлық кестелерім';

  @override
  String get busyElsewhere => 'Бұл уақытта басқа компанияда жұмыста';

  @override
  String get overlapTooltip => 'Басқа компаниядағы ауысыммен сәйкес келеді';

  @override
  String get overlapWarning =>
      'Екі компаниядағы кейбір ауысымдарыңыз бір-біріне сәйкес келеді.';

  @override
  String noticeOverlap(String date) {
    return '$date күні әртүрлі компаниялардағы екі ауысымыңыз бір-біріне сәйкес келеді.';
  }

  @override
  String get allMyCompanies => 'Барлық компанияларым';

  @override
  String get deleteGroup => 'Топты жою';

  @override
  String get openRequest => 'Сұрауды көру';

  @override
  String get thisCompany => 'Осы компания';

  @override
  String get withExtras => 'Уақытша қызметкерлермен';

  @override
  String deleteGroupConfirm(String name) {
    return 'Барлығы үшін «$name» тобын және барлық хабарламаларын жою керек пе?';
  }

  @override
  String reinforcementHint(String company) {
    return '$company компаниясынан: қосымша қызметкер ретінде қосылып, хабарланады.';
  }

  @override
  String get addToGoogle => 'Google Күнтізбеге қосу';

  @override
  String get calendarEnabled => 'Ауысымдарымды синхрондау';

  @override
  String get calendarHint =>
      'Барлық компанияларыңыздағы ауысымдарды Google Күнтізбеге қосыңыз. Олар өздігінен жаңарады, кез келген уақытта өшіре аласыз.';

  @override
  String get changeSettings => 'Өзгерту';

  @override
  String get copyCalendarLink => 'Күнтізбе сілтемесін көшіру';

  @override
  String get countryBelgium => 'Бельгия';

  @override
  String get countryCanada => 'Канада';

  @override
  String get countryFrance => 'Франция';

  @override
  String get countrySwitzerland => 'Швейцария';

  @override
  String get employeesSection => 'Қызметкерлер';

  @override
  String get emptyNoAlert => 'Бос: ескерту жоқ';

  @override
  String get extrasSection => 'Уақытша қызметкерлер';

  @override
  String get googleCalendar => 'Google Күнтізбе';

  @override
  String get hoursTotals => 'Сағат жиыны';

  @override
  String get legalAlerts => 'Заңды ескертулер';

  @override
  String get legalAlertsHint =>
      'Тек ескертулер, ешқашан бұғаттау емес. Сізге қатысты ережелерді таңдаңыз немесе ешқайсысын.';

  @override
  String get legalPreset => 'Ел үлгісі';

  @override
  String get linkCopied => 'Сілтеме көшірілді.';

  @override
  String get maxConsecutiveLabel => 'Қатарынан ең көп жұмыс күні';

  @override
  String get maxDayLabel => 'Күніне ең ұзақ уақыт (сағат)';

  @override
  String get maxWeekLabel => 'Аптасына ең ұзақ уақыт (сағат)';

  @override
  String get minRestLabel => 'Екі ауысым арасындағы ең аз демалыс (сағат)';

  @override
  String get noLegalRules => 'Ешқандай ескерту таңдалмаған.';

  @override
  String get presetNone => 'Ешқандай';

  @override
  String get presetsCheck =>
      'Үлгілер тек бастама: еліңіздің ережелері мен ұжымдық шартқа сай тексеріңіз.';

  @override
  String get printMine => 'Менің кестем';

  @override
  String get printOwn => 'Тек өз кестесі';

  @override
  String get printPdf => 'Басып шығару / PDF';

  @override
  String get printRights => 'Қызметкерлер нені басып шығара алады';

  @override
  String get printTeam => 'Бүкіл команданың кестесі';

  @override
  String get printTeamOption => 'Команда кестесі';

  @override
  String get totalsHint =>
      'Жобаларымен бірге. Excel және CSV экспорты жарияланған кестені пайдаланады.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: қатарынан $value күн (ең көбі $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: бір күнде $value (ең көбі $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: тек $value демалыс (ең азы $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: бір аптада $value (ең көбі $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Заңды ескертулер: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Ауысымдар: $count';
  }

  @override
  String get actionMakeDeputy => 'Басшы орынбасары етіп тағайындау';

  @override
  String get actionRemoveDeputy => 'Орынбасар рөлін алып тастау';

  @override
  String get busyHere => 'Бұл уақытта осы компанияда жұмыста';

  @override
  String get calendarByLink => 'Сілтеме арқылы (компьютердегі Google Күнтізбе)';

  @override
  String get calendarDenied =>
      'Күнтізбеге кіруге рұқсат жоқ. Телефон баптауларында рұқсат етіңіз.';

  @override
  String get calendarLinkHint =>
      'Компьютердегі Google Күнтізбеден қосыңыз; Google оны бірнеше сағатта жаңартады.';

  @override
  String get calendarNone => 'Бұл телефонда өзгертуге болатын күнтізбе жоқ.';

  @override
  String get calendarOnPhone => 'Ауысымдарымды телефон күнтізбесіне қосу';

  @override
  String get calendarOnPhoneHint =>
      'Google күнтізбеңізде: телефонда да, Google Күнтізбеде де бірден көрінеді.';

  @override
  String get chooseCalendar => 'Күнтізбені таңдау';

  @override
  String get otherSiteHint =>
      'Басқа нысанның қызметкері: оның басшыларына хабарланады.';

  @override
  String get subManager => 'Басшы орынбасары';

  @override
  String calendarSynced(String count) {
    return 'Күнтізбедегі ауысымдар: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Басшы орынбасары: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by $date күні $name қызметкерін $site нысанына қойды.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company сізді қосымша қызметкер ретінде қосты.';
  }

  @override
  String get companyNotificationsHint =>
      'Өшірулі: бұл телефонда ештеңе дыбыс бермейді, бірақ бәрі қоңырауда қалады.';

  @override
  String get companyNotificationsOn => 'Осы компанияның хабарландыруларын алу';

  @override
  String get companyTimezone => 'Компанияның уақыт белдеуі';

  @override
  String get companyTimezoneHint =>
      'Осы компанияның барлық уақыттары осы белдеу бойынша (жазғы уақытты қоса). Күнтізбелер оларды өздігінен түрлендіреді.';

  @override
  String get iosInstallHint =>
      'iPhone-да: «Бөлісу» түймесін, содан кейін «Басты экранға қосу» түймесін басып, Staff Flow-ды орнатыңыз.';

  @override
  String get searchCity => 'Қала іздеу';

  @override
  String get thisPhone => 'Осы құрылғы';

  @override
  String companyNotifications(String name) {
    return 'Хабарландырулар: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Уақыттар $zone уақыты бойынша ($company). Құрылғыңыз: $here.';
  }

  @override
  String get addPreset => 'Үлгі қосу';

  @override
  String get addPresets => 'Үлгілер жасау';

  @override
  String get appearance => 'Көрініс';

  @override
  String get chooseLogo => 'PNG суретін таңдау';

  @override
  String get conversationMuted => 'Бұл әңгіменің хабарландырулары өшірілді.';

  @override
  String get conversationUnmuted =>
      'Бұл әңгіменің хабарландырулары қайта қосылды.';

  @override
  String get customization => 'Жекелендіру';

  @override
  String get disableGroup => 'Топты өшіру';

  @override
  String get disableGroupConfirm =>
      'Бүкіл компания тобы бәрінен жасырылады. Оны «Хабарламалар» бөлімінде қайта қосуға болады.';

  @override
  String get editPresets => 'Үлгілер';

  @override
  String get enable => 'Қайта қосу';

  @override
  String get groupDisabled => 'Топ өшірулі (тек сіз көресіз)';

  @override
  String get logoHint =>
      'Компания қойындысында барлық мүшелерге көрінетін шағын PNG сурет (логотипіңіз).';

  @override
  String get logoPngOnly => 'Көлемі 1 МБ-тан аспайтын PNG суретін таңдаңыз.';

  @override
  String get muteConversation => 'Бұл әңгімені дыбыссыз ету';

  @override
  String get myIdentifier => 'Менің идентификаторым';

  @override
  String get myProfile => 'Менің профилім';

  @override
  String get presetName => 'Атауы (мыс. Таңертең)';

  @override
  String get removeLogo => 'Суретті алып тастау';

  @override
  String get resetGroup => 'Топты тазалау';

  @override
  String get resetGroupConfirm =>
      'Компания тобындағы барлық хабарламалар бәрі үшін жойылады.';

  @override
  String get settingsTitle => 'Баптаулар';

  @override
  String get shiftPresets => 'Ауысым уақыты үлгілері';

  @override
  String get shiftPresetsHint =>
      'Дайын уақыттар (таң, кеш, түн…): ауысымда бір рет басқанда басы мен соңы толтырылады.';

  @override
  String get themeDark => 'Қараңғы';

  @override
  String get themeLight => 'Ашық';

  @override
  String get themeSystem => 'Жүйелік';

  @override
  String get unmuteConversation => 'Бұл әңгіменің хабарландыруларын қосу';

  @override
  String get awaitingApproval => 'Бекітуді күтуде';

  @override
  String get placementNeedsApproval =>
      '! Бұл адам сіздің нысандарыңыздан емес: ауысым жарияланбас бұрын басшыңыздың немесе иесінің бекітуін күтеді. Әйтпесе басқа адамды таңдаңыз.';

  @override
  String get placementAwaiting => 'Басшының немесе иесінің бекітуін күтуде.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by басқа нысандағы $name қызметкерін $date күні қойғысы келеді: бекіту қажет.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by $date күні $name қызметкерін қоюды бекітті.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by $date күні $name қызметкерін қоюдан бас тартты.';
  }
}
