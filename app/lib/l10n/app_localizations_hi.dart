// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class L10nHi extends L10n {
  L10nHi([String locale = 'hi']) : super(locale);

  @override
  String get cancel => 'रद्द करें';

  @override
  String get save => 'सहेजें';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get validate => 'पुष्टि करें';

  @override
  String get add => 'जोड़ें';

  @override
  String get rename => 'नाम बदलें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get accept => 'स्वीकार करें';

  @override
  String get decline => 'अस्वीकार करें';

  @override
  String get close => 'बंद करें';

  @override
  String get retry => 'फिर से कोशिश करें';

  @override
  String get name => 'नाम';

  @override
  String get serverUnreachable => 'सर्वर से संपर्क नहीं हो पा रहा है।';

  @override
  String errorStatus(int status) {
    return 'त्रुटि $status';
  }

  @override
  String get roleOwner => 'मालिक';

  @override
  String get roleManager => 'प्रबंधक';

  @override
  String get roleEmployee => 'कर्मचारी';

  @override
  String get roleExtra => 'अस्थायी कर्मचारी';

  @override
  String get taglineStart => 'आपकी टीम की शिफ़्ट, ';

  @override
  String get taglineEnd => 'हर जगह।';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Google से साइन इन करें';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google साइन-इन उपलब्ध नहीं है: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google से साइन इन नहीं हो सका: $detail';
  }

  @override
  String get newCompany => 'नई कंपनी';

  @override
  String get timezone => 'समय क्षेत्र';

  @override
  String get create => 'बनाएँ';

  @override
  String get noCompanyTitle => 'आप अभी किसी कंपनी में शामिल नहीं हैं।';

  @override
  String get noCompanyHint =>
      'अपने नियोक्ता की कंपनी में शामिल होने के लिए एक कोड बनाएँ और उसे अपने प्रबंधक को दें।';

  @override
  String get joinCompany => 'कंपनी में शामिल हों';

  @override
  String get createCompany => 'कंपनी बनाएँ';

  @override
  String transferOffer(String company) {
    return 'आपको “$company” का मालिक बनने का प्रस्ताव मिला है।';
  }

  @override
  String get someCompany => 'एक कंपनी';

  @override
  String get becameOwner => 'अब आप मालिक हैं।';

  @override
  String get myAccount => 'मेरा खाता';

  @override
  String get idCopied => 'पहचान कॉपी हो गई।';

  @override
  String myId(String id) {
    return 'मेरी पहचान: $id';
  }

  @override
  String get signOut => 'साइन आउट';

  @override
  String joinInvite(String company, String role) {
    return '“$company” ने आपको $role के रूप में आमंत्रित किया है।';
  }

  @override
  String joinedCompany(String company) {
    return 'आप $company में शामिल हो गए।';
  }

  @override
  String get viewPlanning => 'शेड्यूल';

  @override
  String get viewTeam => 'टीम';

  @override
  String get viewPositions => 'पद';

  @override
  String get readOnlyCompany => 'यह कंपनी केवल देखने के लिए है।';

  @override
  String get team => 'टीम';

  @override
  String get leaveCompany => 'यह कंपनी छोड़ें';

  @override
  String meSuffix(String name) {
    return '$name (आप)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'कंपनी $name को सौंपें?';
  }

  @override
  String get transferConfirmBody =>
      'स्वीकार करने पर वह व्यक्ति मालिक (सदस्यता, बिल, प्रबंधक) बन जाएगा और आप प्रबंधक बन जाएँगे।';

  @override
  String transferSent(String name) {
    return '$name को प्रस्ताव भेजा गया।';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$name को हटाएँ?';
  }

  @override
  String get removeConfirmBody => 'इतिहास सुरक्षित रहेगा।';

  @override
  String get addPersonTitle => 'व्यक्ति जोड़ें';

  @override
  String get addPersonHint =>
      'उनसे Staff Flow खोलने, खाता मेनू में “कंपनी में शामिल हों” चुनने को कहें, फिर दिखाया गया कोड दर्ज करें।';

  @override
  String get sixDigitCode => '6 अंकों का कोड';

  @override
  String invitationSent(String name) {
    return '$name को आमंत्रण भेजा गया: उसे स्वीकार करना होगा।';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company छोड़ें?';
  }

  @override
  String get leaveConfirmBody => 'आप इसका शेड्यूल फिर नहीं देख पाएँगे।';

  @override
  String get renameCompany => 'कंपनी का नाम बदलें';

  @override
  String get actionMakeManager => 'प्रबंधक बनाएँ';

  @override
  String get actionMakeEmployee => 'फिर से कर्मचारी बनाएँ';

  @override
  String get actionToEmployee => 'कर्मचारी बनाएँ';

  @override
  String get actionToExtra => 'अस्थायी कर्मचारी बनाएँ';

  @override
  String get actionTransfer => 'स्वामित्व सौंपें';

  @override
  String get actionRemove => 'कंपनी से हटाएँ';

  @override
  String get positions => 'पद';

  @override
  String get sites => 'स्थान';

  @override
  String get positionsHint =>
      'व्यक्ति क्या करता है: कैश काउंटर, रसोई, रिसेप्शन…';

  @override
  String get sitesHint => 'अगर कंपनी के कई स्थान हैं, तो शिफ़्ट कहाँ होगी।';

  @override
  String get archived => 'संग्रहीत';

  @override
  String get archive => 'संग्रहीत करें';

  @override
  String get reactivate => 'फिर से सक्रिय करें';

  @override
  String weekOf(String date) {
    return '$date वाला सप्ताह';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बदलाव प्रकाशित हुए।',
      one: '1 बदलाव प्रकाशित हुआ।',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'शिफ़्ट';

  @override
  String get display => 'दृश्य';

  @override
  String get week => 'सप्ताह';

  @override
  String get month => 'महीना';

  @override
  String get today => 'आज';

  @override
  String get onlyMine => 'केवल मेरी शिफ़्ट';

  @override
  String get replacePersonMenu => 'व्यक्ति बदलें…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बदलाव प्रकाशित नहीं हुए',
      one: '1 बदलाव प्रकाशित नहीं हुआ',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'कर्मचारी इन्हें अभी नहीं देख सकते।';

  @override
  String get publish => 'प्रकाशित करें';

  @override
  String yourHours(String duration) {
    return 'इस अवधि में आपके घंटे: $duration';
  }

  @override
  String get addShiftThisDay => 'इस दिन शिफ़्ट जोड़ें';

  @override
  String get noShift => 'कोई शिफ़्ट नहीं';

  @override
  String get unassigned => 'किसी को नहीं सौंपा';

  @override
  String get formerMember => 'पूर्व सदस्य';

  @override
  String get statusDraft => 'ड्राफ़्ट';

  @override
  String get statusModified => 'बदला गया';

  @override
  String get statusDeleted => 'हटाया गया';

  @override
  String durationHours(int hours) {
    return '$hours घं.';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours घं. $minutes मि.';
  }

  @override
  String get editShift => 'शिफ़्ट संपादित करें';

  @override
  String get newShift => 'नई शिफ़्ट';

  @override
  String get thisShift => 'केवल यह शिफ़्ट';

  @override
  String get thisAndFollowing => 'यह और आगे की सभी';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'दिन',
      one: 'दिन',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'दूसरा दिन';

  @override
  String get start => 'शुरुआत';

  @override
  String get end => 'समाप्ति';

  @override
  String get endsNextDay => 'अगले दिन समाप्त होती है।';

  @override
  String get person => 'व्यक्ति';

  @override
  String get position => 'पद';

  @override
  String get site => 'स्थान';

  @override
  String get noteOptional => 'नोट (वैकल्पिक)';

  @override
  String get repetition => 'दोहराव';

  @override
  String get repeatNone => 'कोई नहीं';

  @override
  String get repeatDaily => 'हर दिन';

  @override
  String get repeatWeekly => 'हर सप्ताह';

  @override
  String get repeatForPrefix => 'अवधि ';

  @override
  String get repeatDaysSuffix => ' दिन';

  @override
  String get repeatWeeksSuffix => ' सप्ताह';

  @override
  String get repeatUntilPrefix => 'तक ';

  @override
  String get replacePersonTitle => 'व्यक्ति बदलें';

  @override
  String get replaceFrom => 'किसे बदलें';

  @override
  String get replaceBy => 'किससे';

  @override
  String dateRange(String from, String to) {
    return '$from से $to तक';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count शिफ़्ट बदली गईं।',
      one: '1 शिफ़्ट बदली गई।',
      zero: 'कोई शिफ़्ट नहीं बदली।',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'बदलें';

  @override
  String get joinHint =>
      'यह कोड अपने प्रबंधक को दें। वे इसे अपने ऐप में दर्ज करेंगे, फिर आपको स्वीकार करने के लिए आमंत्रण मिलेगा।';

  @override
  String get codeExpired => 'कोड की समय-सीमा समाप्त हो गई।';

  @override
  String codeValidFor(String time) {
    return '$time तक मान्य';
  }

  @override
  String get newCode => 'नया कोड';

  @override
  String get language => 'भाषा';

  @override
  String get languageAuto => 'स्वचालित (डिवाइस की भाषा)';

  @override
  String get syncUpToDate => 'अपडेट है';

  @override
  String get syncOffline => 'ऑफ़लाइन';

  @override
  String syncPending(int count) {
    return 'लंबित बदलाव: $count';
  }

  @override
  String get syncNow => 'अभी सिंक करें';

  @override
  String syncRejected(String reason) {
    return 'सर्वर ने बदलाव अस्वीकार किया: $reason';
  }

  @override
  String get pendingBadge => 'लंबित';

  @override
  String get offlineUnavailable => 'ऑफ़लाइन उपलब्ध नहीं।';

  @override
  String get offlineCached => 'ऑफ़लाइन: आख़िरी सहेजा गया डेटा।';

  @override
  String get savedOffline => 'डिवाइस पर सहेजा गया, नेटवर्क आने पर भेजा जाएगा।';

  @override
  String get notices => 'सूचनाएँ';

  @override
  String get noNotices => 'कोई सूचना नहीं।';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name ने $date की शिफ़्ट में आपका बदलाव बदल दिया।';
  }

  @override
  String get history => 'इतिहास';

  @override
  String get recentChanges => 'हाल के बदलाव';

  @override
  String get undoChange => 'यह बदलाव पूर्ववत करें';

  @override
  String get undoDone => 'बदलाव पूर्ववत हुआ।';

  @override
  String get historyCreate => 'बनाया गया';

  @override
  String get historyUpdate => 'बदला गया';

  @override
  String get historyDelete => 'हटाया गया';

  @override
  String get historyUndo => 'पूर्ववत';

  @override
  String get noHistory => 'कोई बदलाव नहीं।';

  @override
  String get pendingNotEditable =>
      'यह शिफ़्ट अभी सिंक नहीं हुई: ऑनलाइन होने पर फिर कोशिश करें।';

  @override
  String get myQrCode => 'मेरा QR कोड';

  @override
  String get myQrCodeHint =>
      'मैनेजर यह कोड स्कैन करके आपको अपनी कंपनी में जोड़ता है; फिर आप पुष्टि करते हैं। यह कभी नहीं बदलता।';

  @override
  String get changeMyName => 'मेरा नाम बदलें';

  @override
  String get nameShownToTeam =>
      'आपके सहकर्मियों को आपके Google नाम की जगह यह नाम दिखेगा।';

  @override
  String googleName(String name) {
    return 'Google नाम: $name';
  }

  @override
  String get useGoogleName => 'मेरा Google नाम इस्तेमाल करें';

  @override
  String renameMemberTitle(String name) {
    return '$name का नाम बदलें';
  }

  @override
  String get renameMemberHint => 'यह नाम केवल इसी कंपनी में इस्तेमाल होता है।';

  @override
  String get useOwnName => 'उनका अपना नाम इस्तेमाल करें';

  @override
  String get scanQrCode => 'QR कोड स्कैन करें';

  @override
  String get scanQrHint =>
      'उनके ऐप में दिख रहे QR कोड पर कैमरा रखें (खाता मेनू, “मेरा QR कोड”)।';

  @override
  String get orEnterCode => 'या उनका 6 अंकों का कोड डालें';

  @override
  String get qrInvalid => 'यह Staff Flow QR कोड नहीं है।';

  @override
  String cameraUnavailable(String error) {
    return 'कैमरा उपलब्ध नहीं है ($error)।';
  }

  @override
  String get notificationsTitle => 'सूचनाएँ';

  @override
  String get notifChooseHint =>
      'चुनें कि आपको किन बातों की सूचना मिले। सब कुछ घंटी में दिखता रहेगा।';

  @override
  String get notifPlanning => 'शेड्यूल प्रकाशित या बदला गया';

  @override
  String get notifRequests => 'अनुरोध: अदला-बदली, छुट्टी, आमंत्रण';

  @override
  String get notifMessages => 'नए संदेश';

  @override
  String get notifOverlap => 'कंपनियों के बीच टकराती शिफ़्ट';

  @override
  String get notifConflicts => 'किसी दूसरे मैनेजर ने आपका बदलाव बदला';

  @override
  String get notifBilling => 'सदस्यता अनुस्मारक';

  @override
  String get pushEnabled => 'इस डिवाइस पर सूचनाएँ चालू हैं।';

  @override
  String get pushOff => 'इस डिवाइस पर सूचनाएँ बंद हैं।';

  @override
  String get pushBlocked =>
      'सूचनाएँ ब्लॉक हैं: फ़ोन या ब्राउज़र की सेटिंग में इन्हें अनुमति दें।';

  @override
  String get pushUnavailable => 'इस डिवाइस पर सूचनाएँ उपलब्ध नहीं हैं।';

  @override
  String get enablePush => 'चालू करें';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: आपका शेड्यूल प्रकाशित या बदला गया है।';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company आपको अपनी टीम में जोड़ना चाहती है।';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name आपको $company का मालिक बनाने का प्रस्ताव दे रहे हैं।';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name $company में शामिल हो गए।';
  }

  @override
  String get messagesTab => 'संदेश';

  @override
  String get wholeTeam => 'पूरी टीम';

  @override
  String get newConversation => 'नई बातचीत';

  @override
  String get noMessages => 'अभी कोई संदेश नहीं।';

  @override
  String get messageHint => 'संदेश लिखें';

  @override
  String get earlierMessages => 'पुराने संदेश';

  @override
  String get personLeftCompany => 'यह व्यक्ति अब कंपनी का हिस्सा नहीं है।';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'नया समूह';

  @override
  String get editGroup => 'समूह संपादित करें';

  @override
  String get groupName => 'समूह का नाम';

  @override
  String get groupMembersHint =>
      'इस समूह के लोग चुनें। केवल वही इसके संदेश देखेंगे।';

  @override
  String get chooseAtLeastOne => 'कम से कम एक व्यक्ति चुनें।';

  @override
  String get replyAction => 'जवाब दें';

  @override
  String get translateAction => 'अनुवाद करें';

  @override
  String replyingTo(String name) {
    return '$name को जवाब';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name के हाल के संदेश';
  }

  @override
  String get deleteAllNotices => 'सब हटाएँ';

  @override
  String get deleteAllNoticesConfirm => 'सभी सूचनाएँ हटाएँ?';

  @override
  String get noticeRetention => 'पढ़ी गई सूचनाएँ इसके बाद हटाएँ';

  @override
  String get retentionDay => '1 दिन';

  @override
  String get retentionWeek => '1 सप्ताह';

  @override
  String get retentionMonth => '1 महीना';

  @override
  String get billingOwnersOnly =>
      'केवल तभी सक्रिय जब आप किसी कंपनी के मालिक हों।';

  @override
  String get readOnlyPastDays =>
      'एक महीने से पुराने दिन केवल देखे जा सकते हैं।';

  @override
  String get wholeCompany => 'पूरी कंपनी';

  @override
  String get sitesLabel => 'साइटें';

  @override
  String get actionSites => 'साइटें…';

  @override
  String managerOf(String name) {
    return '$name की ज़िम्मेदारी';
  }

  @override
  String teamSitesOf(String name) {
    return '$name की टीम';
  }

  @override
  String get notYourSite => 'यह साइट आपकी ज़िम्मेदारी में नहीं है।';

  @override
  String get chooseYourSite => 'कम से कम एक साइट चुनें।';

  @override
  String get viewRequests => 'अनुरोध';

  @override
  String get newRequest => 'नया अनुरोध';

  @override
  String get requestLeave => 'छुट्टी';

  @override
  String get requestUnavailability => 'अनुपलब्धता';

  @override
  String get requestSwap => 'शिफ़्ट अदला-बदली';

  @override
  String get swapHint =>
      'अदला-बदली का प्रस्ताव देने के लिए, शेड्यूल में अपनी किसी आने वाली शिफ़्ट पर टैप करें।';

  @override
  String get noRequests => 'अभी कोई अनुरोध नहीं।';

  @override
  String get requestsToHandle => 'निपटाने हैं';

  @override
  String get myRequests => 'मेरे अनुरोध';

  @override
  String get otherRequests => 'टीम के अनुरोध';

  @override
  String get statusPendingPeer => 'सहकर्मी का इंतज़ार';

  @override
  String get statusPendingManager => 'प्रबंधक का इंतज़ार';

  @override
  String get statusApproved => 'स्वीकृत';

  @override
  String get statusRefused => 'अस्वीकृत';

  @override
  String get statusCancelled => 'रद्द';

  @override
  String get cancelRequest => 'अनुरोध रद्द करें';

  @override
  String get acceptSwap => 'यह शिफ़्ट लें';

  @override
  String get approve => 'स्वीकृत करें';

  @override
  String periodLabel(String from, String to) {
    return '$from से $to तक';
  }

  @override
  String swapToPeer(String name) {
    return '$name को प्रस्तावित';
  }

  @override
  String get swapToTeam => 'पूरी टीम';

  @override
  String everyWeekdays(String days) {
    return 'हर सप्ताह: $days';
  }

  @override
  String get unavailableEveryWeek => 'वे दिन जब आप कभी उपलब्ध नहीं होते:';

  @override
  String get choosePeriod => 'तारीखें चुनें';

  @override
  String get choosePeriodOptional => 'किसी अवधि तक सीमित करें (वैकल्पिक)';

  @override
  String get clearPeriod => 'कोई अवधि नहीं';

  @override
  String get sendRequest => 'अनुरोध भेजें';

  @override
  String get proposeSwap => 'अदला-बदली का प्रस्ताव दें';

  @override
  String get swapWith => 'प्रस्ताव दें';

  @override
  String get swapSteps =>
      'सहकर्मी स्वीकार करता है, फिर प्रबंधक मंज़ूरी देता है। शेड्यूल उसके बाद ही बदलता है।';

  @override
  String get absentThatDay => 'उस दिन स्वीकृत अनुपस्थिति';

  @override
  String get requestSent => 'अनुरोध भेजा गया।';

  @override
  String noticeSwapOffer(String name) {
    return '$name आपको अपनी एक शिफ़्ट दे रहे हैं।';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name ने आपकी अदला-बदली का प्रस्ताव ठुकरा दिया।';
  }

  @override
  String get noticeSwapToApprove =>
      'एक शिफ़्ट अदला-बदली आपकी मंज़ूरी का इंतज़ार कर रही है।';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name छुट्टी माँग रहे हैं।';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name ने अनुपलब्धता बताई है।';
  }

  @override
  String get noticeRequestApproved => 'आपका अनुरोध स्वीकार हो गया।';

  @override
  String get noticeRequestRefused => 'आपका अनुरोध अस्वीकार हो गया।';

  @override
  String get choosePeer => 'यह शिफ़्ट कौन लेगा?';

  @override
  String get discardAll => 'सब रद्द करें';

  @override
  String get notifySitesHint =>
      'वे स्थान चुनें जिनके अनुरोधों की सूचनाएँ आपको मिलें। सभी अनुरोध सूची में दिखते रहेंगे।';

  @override
  String get notifySitesTitle => 'स्थान के अनुसार सूचनाएँ';

  @override
  String get pendingRequestTooltip => 'लंबित अनुरोध: खोलने के लिए टैप करें';

  @override
  String get requestsHistory => 'सभी अनुरोध';

  @override
  String get revertChange => 'यह बदलाव रद्द करें';

  @override
  String get statusExpired => 'अब लागू नहीं';

  @override
  String get swapWithHint => 'किसी खास सहकर्मी को चुनने के लिए टैप करें';

  @override
  String changesDiscarded(String count) {
    return 'रद्द किए गए बदलाव: $count';
  }

  @override
  String discardConfirm(String count) {
    return '$count अप्रकाशित बदलाव रद्द करें?';
  }

  @override
  String get allSchedules => 'मेरे सभी शेड्यूल';

  @override
  String get busyElsewhere => 'इस समय पहले से किसी दूसरी कंपनी में ड्यूटी पर';

  @override
  String get overlapTooltip => 'किसी दूसरी कंपनी की शिफ़्ट से टकराती है';

  @override
  String get overlapWarning =>
      'दो कंपनियों में आपकी कुछ शिफ़्ट आपस में टकरा रही हैं।';

  @override
  String noticeOverlap(String date) {
    return '$date को अलग-अलग कंपनियों में आपकी दो शिफ़्ट आपस में टकरा रही हैं।';
  }

  @override
  String get allMyCompanies => 'मेरी सभी कंपनियाँ';

  @override
  String get deleteGroup => 'समूह हटाएँ';

  @override
  String get openRequest => 'अनुरोध देखें';

  @override
  String get thisCompany => 'यह कंपनी';

  @override
  String get withExtras => 'अस्थायी कर्मियों सहित';

  @override
  String deleteGroupConfirm(String name) {
    return 'सभी के लिए “$name” और उसके सभी संदेश हटाएँ?';
  }

  @override
  String reinforcementHint(String company) {
    return '$company से: सहायक कर्मी के रूप में जोड़ा जाएगा और सूचित किया जाएगा।';
  }

  @override
  String get addToGoogle => 'Google कैलेंडर में जोड़ें';

  @override
  String get calendarEnabled => 'मेरी शिफ़्ट सिंक करें';

  @override
  String get calendarHint =>
      'अपनी सभी कंपनियों की शिफ़्ट Google कैलेंडर में जोड़ें। वे अपने आप अपडेट होती हैं, और आप कभी भी बंद कर सकते हैं।';

  @override
  String get changeSettings => 'बदलें';

  @override
  String get copyCalendarLink => 'कैलेंडर लिंक कॉपी करें';

  @override
  String get countryBelgium => 'बेल्जियम';

  @override
  String get countryCanada => 'कनाडा';

  @override
  String get countryFrance => 'फ़्रांस';

  @override
  String get countrySwitzerland => 'स्विट्ज़रलैंड';

  @override
  String get employeesSection => 'कर्मचारी';

  @override
  String get emptyNoAlert => 'खाली: कोई चेतावनी नहीं';

  @override
  String get extrasSection => 'अस्थायी कर्मी';

  @override
  String get googleCalendar => 'Google कैलेंडर';

  @override
  String get hoursTotals => 'घंटों का योग';

  @override
  String get legalAlerts => 'कानूनी चेतावनियाँ';

  @override
  String get legalAlertsHint =>
      'केवल चेतावनियाँ, कभी रोक नहीं। अपने ऊपर लागू नियम चुनें, या कोई नहीं।';

  @override
  String get legalPreset => 'देश का टेम्पलेट';

  @override
  String get linkCopied => 'लिंक कॉपी हो गया।';

  @override
  String get maxConsecutiveLabel => 'लगातार काम के अधिकतम दिन';

  @override
  String get maxDayLabel => 'प्रति दिन अधिकतम अवधि (घंटे)';

  @override
  String get maxWeekLabel => 'प्रति सप्ताह अधिकतम अवधि (घंटे)';

  @override
  String get minRestLabel => 'दो शिफ़्ट के बीच न्यूनतम आराम (घंटे)';

  @override
  String get noLegalRules => 'कोई चेतावनी नहीं चुनी गई।';

  @override
  String get presetNone => 'कोई नहीं';

  @override
  String get presetsCheck =>
      'टेम्पलेट केवल शुरुआत हैं: अपने देश के नियमों और सामूहिक समझौते के अनुसार जाँचें।';

  @override
  String get printMine => 'मेरा शेड्यूल';

  @override
  String get printOwn => 'केवल उनका अपना शेड्यूल';

  @override
  String get printPdf => 'प्रिंट / PDF';

  @override
  String get printRights => 'कर्मचारी क्या प्रिंट कर सकते हैं';

  @override
  String get printTeam => 'पूरी टीम का शेड्यूल';

  @override
  String get printTeamOption => 'टीम का शेड्यूल';

  @override
  String get totalsHint =>
      'ड्राफ़्ट शामिल हैं। Excel और CSV निर्यात प्रकाशित शेड्यूल का उपयोग करते हैं।';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: लगातार $value दिन (अधिकतम $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: दिन में $value (अधिकतम $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: केवल $value आराम (न्यूनतम $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: सप्ताह में $value (अधिकतम $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'कानूनी चेतावनियाँ: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'शिफ़्ट: $count';
  }

  @override
  String get actionMakeDeputy => 'उप-प्रबंधक नियुक्त करें';

  @override
  String get actionRemoveDeputy => 'उप-प्रबंधक की भूमिका हटाएँ';

  @override
  String get busyHere => 'इस समय पहले से इस कंपनी में ड्यूटी पर';

  @override
  String get calendarByLink => 'लिंक से (कंप्यूटर पर Google कैलेंडर)';

  @override
  String get calendarDenied =>
      'कैलेंडर की अनुमति नहीं मिली। फ़ोन की सेटिंग में अनुमति दें।';

  @override
  String get calendarLinkHint =>
      'कंप्यूटर पर Google कैलेंडर से जोड़ें; Google कुछ घंटों में अपडेट करता है।';

  @override
  String get calendarNone => 'इस फ़ोन पर कोई बदलने योग्य कैलेंडर नहीं है।';

  @override
  String get calendarOnPhone => 'मेरी शिफ़्ट फ़ोन के कैलेंडर में जोड़ें';

  @override
  String get calendarOnPhoneHint =>
      'आपके Google कैलेंडर में: फ़ोन और Google कैलेंडर पर तुरंत दिखेगा।';

  @override
  String get chooseCalendar => 'कैलेंडर चुनें';

  @override
  String get otherSiteHint =>
      'दूसरे स्थान का कर्मचारी: उसके प्रबंधकों को सूचित किया जाएगा।';

  @override
  String get subManager => 'उप-प्रबंधक';

  @override
  String calendarSynced(String count) {
    return 'कैलेंडर में शिफ़्ट: $count';
  }

  @override
  String deputyOf(String name) {
    return 'उप-प्रबंधक: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by ने $date को $name को $site पर लगाया है।';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company ने आपको सहायक कर्मी के रूप में जोड़ा है।';
  }

  @override
  String get companyNotificationsHint =>
      'बंद: इस फ़ोन पर कुछ नहीं बजेगा, पर सब कुछ घंटी में रहेगा।';

  @override
  String get companyNotificationsOn => 'इस कंपनी की सूचनाएँ पाएँ';

  @override
  String get companyTimezone => 'कंपनी का समय क्षेत्र';

  @override
  String get companyTimezoneHint =>
      'इस कंपनी के सभी समय इसी समय क्षेत्र में हैं (डेलाइट सेविंग सहित)। कैलेंडर उन्हें अपने आप बदल देते हैं।';

  @override
  String get iosInstallHint =>
      'iPhone पर: शेयर पर टैप करें, फिर “होम स्क्रीन में जोड़ें” से Staff Flow इंस्टॉल करें।';

  @override
  String get searchCity => 'शहर खोजें';

  @override
  String get thisPhone => 'यह डिवाइस';

  @override
  String companyNotifications(String name) {
    return 'सूचनाएँ: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'समय $zone के अनुसार ($company)। आपका डिवाइस: $here।';
  }

  @override
  String get addPreset => 'प्रीसेट जोड़ें';

  @override
  String get addPresets => 'प्रीसेट बनाएँ';

  @override
  String get appearance => 'रूप-रंग';

  @override
  String get chooseLogo => 'PNG छवि चुनें';

  @override
  String get conversationMuted => 'इस बातचीत की सूचनाएँ बंद कीं।';

  @override
  String get conversationUnmuted => 'इस बातचीत की सूचनाएँ फिर चालू कीं।';

  @override
  String get customization => 'अनुकूलन';

  @override
  String get disableGroup => 'समूह बंद करें';

  @override
  String get disableGroupConfirm =>
      'पूरी कंपनी का समूह सभी से छिप जाएगा। आप इसे संदेशों में फिर चालू कर सकते हैं।';

  @override
  String get editPresets => 'प्रीसेट';

  @override
  String get enable => 'फिर चालू करें';

  @override
  String get groupDisabled => 'समूह बंद है (केवल आप देख सकते हैं)';

  @override
  String get logoHint =>
      'कंपनी के टैब पर दिखने वाली छोटी PNG छवि (आपका लोगो), सभी सदस्यों के लिए।';

  @override
  String get logoPngOnly => '1 MB तक की PNG छवि चुनें।';

  @override
  String get muteConversation => 'इस बातचीत को म्यूट करें';

  @override
  String get myIdentifier => 'मेरी पहचान';

  @override
  String get myProfile => 'मेरी प्रोफ़ाइल';

  @override
  String get presetName => 'नाम (जैसे सुबह)';

  @override
  String get removeLogo => 'छवि हटाएँ';

  @override
  String get resetGroup => 'समूह रीसेट करें';

  @override
  String get resetGroupConfirm =>
      'कंपनी समूह के सभी संदेश सभी के लिए मिट जाएँगे।';

  @override
  String get settingsTitle => 'सेटिंग';

  @override
  String get shiftPresets => 'शिफ़्ट समय प्रीसेट';

  @override
  String get shiftPresetsHint =>
      'तैयार समय (सुबह, शाम, रात…): शिफ़्ट में एक टैप से शुरुआत और अंत भर जाता है।';

  @override
  String get themeDark => 'गहरा';

  @override
  String get themeLight => 'हल्का';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get unmuteConversation => 'इस बातचीत की सूचनाएँ फिर चालू करें';

  @override
  String get awaitingApproval => 'मंज़ूरी बाकी';

  @override
  String get placementNeedsApproval =>
      '! यह व्यक्ति आपकी साइटों का नहीं है: प्रकाशित होने से पहले शिफ्ट आपके वरिष्ठ या मालिक की मंज़ूरी का इंतज़ार करेगी। वरना किसी और को चुनें।';

  @override
  String get placementAwaiting => 'वरिष्ठ या मालिक की मंज़ूरी का इंतज़ार।';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by दूसरी साइट के $name को $date को लगाना चाहते हैं: मंज़ूरी चाहिए।';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by ने $date को $name की नियुक्ति मंज़ूर की।';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by ने $date को $name की नियुक्ति अस्वीकार की।';
  }

  @override
  String get addSubSite => 'उप-साइट जोड़ें';

  @override
  String get moveSite => 'ले जाएँ';

  @override
  String get topLevel => 'पहला स्तर';

  @override
  String moveSiteTitle(String name) {
    return '“$name” को इसके नीचे ले जाएँ…';
  }

  @override
  String subSiteOf(String name) {
    return '$name की उप-साइट';
  }

  @override
  String get siteTreeHint =>
      'अधिकतम 3 स्तर, जैसे क्षेत्र › शहर › दुकान। किसी साइट का मैनेजर उसके नीचे की हर चीज़ भी संभालता है।';

  @override
  String get subSitesOnlyHint =>
      'यहाँ आप अपनी साइटों के नीचे उप-साइटें जोड़ते हैं।';

  @override
  String get messagingSetting => 'कंपनी के संदेश';

  @override
  String get messagingSettingHint =>
      'चालू: टीम के पास संदेश टैब होता है। बंद: कोई इसे देख या लिख नहीं सकता (पुराने संदेश रखे जाते हैं)।';
}
