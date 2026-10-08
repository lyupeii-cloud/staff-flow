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
}
