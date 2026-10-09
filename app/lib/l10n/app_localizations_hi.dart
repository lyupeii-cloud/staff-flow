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
}
