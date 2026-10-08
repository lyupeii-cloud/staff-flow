// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class L10nMr extends L10n {
  L10nMr([String locale = 'mr']) : super(locale);

  @override
  String get cancel => 'रद्द करा';

  @override
  String get save => 'जतन करा';

  @override
  String get confirm => 'निश्चित करा';

  @override
  String get validate => 'निश्चित करा';

  @override
  String get add => 'जोडा';

  @override
  String get rename => 'नाव बदला';

  @override
  String get delete => 'हटवा';

  @override
  String get accept => 'स्वीकारा';

  @override
  String get decline => 'नाकारा';

  @override
  String get close => 'बंद करा';

  @override
  String get retry => 'पुन्हा प्रयत्न करा';

  @override
  String get name => 'नाव';

  @override
  String get serverUnreachable => 'सर्व्हरशी संपर्क होत नाही.';

  @override
  String errorStatus(int status) {
    return 'त्रुटी $status';
  }

  @override
  String get roleOwner => 'मालक';

  @override
  String get roleManager => 'व्यवस्थापक';

  @override
  String get roleEmployee => 'कर्मचारी';

  @override
  String get roleExtra => 'तात्पुरता कर्मचारी';

  @override
  String get taglineStart => 'तुमच्या टीमचे वेळापत्रक, ';

  @override
  String get taglineEnd => 'कुठेही.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Google ने साइन इन करा';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google साइन-इन उपलब्ध नाही: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google ने साइन इन करता आले नाही: $detail';
  }

  @override
  String get newCompany => 'नवीन कंपनी';

  @override
  String get timezone => 'वेळ क्षेत्र';

  @override
  String get create => 'तयार करा';

  @override
  String get noCompanyTitle => 'तुम्ही अद्याप कोणत्याही कंपनीत नाही.';

  @override
  String get noCompanyHint =>
      'तुमच्या नियोक्त्याच्या कंपनीत सामील होण्यासाठी कोड तयार करा आणि तो तुमच्या व्यवस्थापकाला द्या.';

  @override
  String get joinCompany => 'कंपनीत सामील व्हा';

  @override
  String get createCompany => 'कंपनी तयार करा';

  @override
  String transferOffer(String company) {
    return 'तुम्हाला “$company” चे मालक होण्याचा प्रस्ताव आला आहे.';
  }

  @override
  String get someCompany => 'एक कंपनी';

  @override
  String get becameOwner => 'आता तुम्ही मालक आहात.';

  @override
  String get myAccount => 'माझे खाते';

  @override
  String get idCopied => 'ओळख क्रमांक कॉपी केला.';

  @override
  String myId(String id) {
    return 'माझा ओळख क्रमांक: $id';
  }

  @override
  String get signOut => 'साइन आउट';

  @override
  String joinInvite(String company, String role) {
    return '“$company” ने तुम्हाला $role म्हणून आमंत्रित केले आहे.';
  }

  @override
  String joinedCompany(String company) {
    return 'तुम्ही $company मध्ये सामील झालात.';
  }

  @override
  String get viewPlanning => 'वेळापत्रक';

  @override
  String get viewTeam => 'टीम';

  @override
  String get viewPositions => 'पदे';

  @override
  String get readOnlyCompany => 'ही कंपनी फक्त पाहण्यासाठी आहे.';

  @override
  String get team => 'टीम';

  @override
  String get leaveCompany => 'ही कंपनी सोडा';

  @override
  String meSuffix(String name) {
    return '$name (तुम्ही)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'कंपनी $name कडे सोपवायची?';
  }

  @override
  String get transferConfirmBody =>
      'त्यांनी स्वीकारल्यावर ते मालक होतील (सदस्यता, बिले, व्यवस्थापक) आणि तुम्ही व्यवस्थापक व्हाल.';

  @override
  String transferSent(String name) {
    return '$name ला प्रस्ताव पाठवला.';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$name ला काढायचे?';
  }

  @override
  String get removeConfirmBody => 'इतिहास जतन राहील.';

  @override
  String get addPersonTitle => 'व्यक्ती जोडा';

  @override
  String get addPersonHint =>
      'त्यांना Staff Flow उघडून खाते मेनूमध्ये “कंपनीत सामील व्हा” निवडायला सांगा, मग दाखवलेला कोड टाका.';

  @override
  String get sixDigitCode => '6 अंकी कोड';

  @override
  String invitationSent(String name) {
    return '$name ला आमंत्रण पाठवले: त्यांनी ते स्वीकारले पाहिजे.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company सोडायची?';
  }

  @override
  String get leaveConfirmBody =>
      'तुम्हाला त्याचे वेळापत्रक पुन्हा दिसणार नाही.';

  @override
  String get renameCompany => 'कंपनीचे नाव बदला';

  @override
  String get actionMakeManager => 'व्यवस्थापक करा';

  @override
  String get actionMakeEmployee => 'पुन्हा कर्मचारी करा';

  @override
  String get actionToEmployee => 'कर्मचारी करा';

  @override
  String get actionToExtra => 'तात्पुरता कर्मचारी करा';

  @override
  String get actionTransfer => 'मालकी सोपवा';

  @override
  String get actionRemove => 'कंपनीतून काढा';

  @override
  String get positions => 'पदे';

  @override
  String get sites => 'ठिकाणे';

  @override
  String get positionsHint => 'व्यक्ती काय करते: कॅश, स्वयंपाकघर, स्वागत…';

  @override
  String get sitesHint => 'कंपनीची अनेक ठिकाणे असल्यास शिफ्ट कुठे होते.';

  @override
  String get archived => 'संग्रहित';

  @override
  String get archive => 'संग्रहित करा';

  @override
  String get reactivate => 'पुन्हा सुरू करा';

  @override
  String weekOf(String date) {
    return '$date चा आठवडा';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बदल प्रकाशित झाले.',
      one: '1 बदल प्रकाशित झाला.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'शिफ्ट';

  @override
  String get display => 'दृश्य';

  @override
  String get week => 'आठवडा';

  @override
  String get month => 'महिना';

  @override
  String get today => 'आज';

  @override
  String get onlyMine => 'फक्त माझ्या शिफ्ट';

  @override
  String get replacePersonMenu => 'व्यक्ती बदला…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बदल अप्रकाशित',
      one: '1 बदल अप्रकाशित',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'कर्मचाऱ्यांना हे अजून दिसत नाहीत.';

  @override
  String get publish => 'प्रकाशित करा';

  @override
  String yourHours(String duration) {
    return 'या कालावधीतील तुमचे तास: $duration';
  }

  @override
  String get addShiftThisDay => 'या दिवशी शिफ्ट जोडा';

  @override
  String get noShift => 'शिफ्ट नाही';

  @override
  String get unassigned => 'नेमणूक नाही';

  @override
  String get formerMember => 'माजी सदस्य';

  @override
  String get statusDraft => 'मसुदा';

  @override
  String get statusModified => 'बदललेले';

  @override
  String get statusDeleted => 'हटवलेले';

  @override
  String durationHours(int hours) {
    return '$hours ता.';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ता. $minutes मि.';
  }

  @override
  String get editShift => 'शिफ्ट संपादित करा';

  @override
  String get newShift => 'नवीन शिफ्ट';

  @override
  String get thisShift => 'फक्त ही शिफ्ट';

  @override
  String get thisAndFollowing => 'ही आणि पुढील';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'दिवस',
      one: 'दिवस',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'दुसरा दिवस';

  @override
  String get start => 'सुरुवात';

  @override
  String get end => 'शेवट';

  @override
  String get endsNextDay => 'दुसऱ्या दिवशी संपते.';

  @override
  String get person => 'व्यक्ती';

  @override
  String get position => 'पद';

  @override
  String get site => 'ठिकाण';

  @override
  String get noteOptional => 'टीप (ऐच्छिक)';

  @override
  String get repetition => 'पुनरावृत्ती';

  @override
  String get repeatNone => 'नाही';

  @override
  String get repeatDaily => 'दररोज';

  @override
  String get repeatWeekly => 'दर आठवड्याला';

  @override
  String get repeatForPrefix => 'कालावधी ';

  @override
  String get repeatDaysSuffix => ' दिवस';

  @override
  String get repeatWeeksSuffix => ' आठवडे';

  @override
  String get repeatUntilPrefix => 'पर्यंत ';

  @override
  String get replacePersonTitle => 'व्यक्ती बदला';

  @override
  String get replaceFrom => 'कोणाला बदलायचे';

  @override
  String get replaceBy => 'कोणाने';

  @override
  String dateRange(String from, String to) {
    return '$from ते $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count शिफ्ट बदलल्या.',
      one: '1 शिफ्ट बदलली.',
      zero: 'कोणतीही शिफ्ट बदलली नाही.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'बदला';

  @override
  String get joinHint =>
      'हा कोड तुमच्या व्यवस्थापकाला द्या. त्यांनी ॲपमध्ये टाकल्यावर तुम्हाला आमंत्रण मिळेल.';

  @override
  String get codeExpired => 'कोडची मुदत संपली.';

  @override
  String codeValidFor(String time) {
    return 'अजून $time वैध';
  }

  @override
  String get newCode => 'नवीन कोड';

  @override
  String get language => 'भाषा';

  @override
  String get languageAuto => 'स्वयंचलित (डिव्हाइसची भाषा)';

  @override
  String get syncUpToDate => 'अद्ययावत';

  @override
  String get syncOffline => 'ऑफलाइन';

  @override
  String syncPending(int count) {
    return 'प्रलंबित बदल: $count';
  }

  @override
  String get syncNow => 'आता सिंक करा';

  @override
  String syncRejected(String reason) {
    return 'सर्व्हरने बदल नाकारला: $reason';
  }

  @override
  String get pendingBadge => 'प्रलंबित';

  @override
  String get offlineUnavailable => 'ऑफलाइन उपलब्ध नाही.';

  @override
  String get offlineCached => 'ऑफलाइन: शेवटचा जतन केलेला डेटा.';

  @override
  String get savedOffline =>
      'डिव्हाइसवर जतन केले, नेटवर्क आल्यावर पाठवले जाईल.';

  @override
  String get notices => 'सूचना';

  @override
  String get noNotices => 'कोणत्याही सूचना नाहीत.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name यांनी $date च्या शिफ्टमधील तुमचा बदल बदलला.';
  }

  @override
  String get history => 'इतिहास';

  @override
  String get recentChanges => 'अलीकडील बदल';

  @override
  String get undoChange => 'हा बदल रद्द करा';

  @override
  String get undoDone => 'बदल रद्द केला.';

  @override
  String get historyCreate => 'निर्मिती';

  @override
  String get historyUpdate => 'बदल';

  @override
  String get historyDelete => 'हटवणे';

  @override
  String get historyUndo => 'रद्द करणे';

  @override
  String get noHistory => 'कोणतेही बदल नाहीत.';

  @override
  String get pendingNotEditable =>
      'ही शिफ्ट अजून सिंक झालेली नाही: ऑनलाइन असताना पुन्हा प्रयत्न करा.';

  @override
  String get myQrCode => 'माझा QR कोड';

  @override
  String get myQrCodeHint =>
      'व्यवस्थापक हा कोड स्कॅन करून तुम्हाला त्यांच्या कंपनीत जोडतात; नंतर तुम्ही पुष्टी करता. तो कधीही बदलत नाही.';

  @override
  String get changeMyName => 'माझे नाव बदला';

  @override
  String get nameShownToTeam =>
      'तुमच्या सहकाऱ्यांना तुमच्या Google नावाऐवजी हे नाव दिसेल.';

  @override
  String googleName(String name) {
    return 'Google नाव: $name';
  }

  @override
  String get useGoogleName => 'माझे Google नाव वापरा';

  @override
  String renameMemberTitle(String name) {
    return '$name चे नाव बदला';
  }

  @override
  String get renameMemberHint => 'हे नाव फक्त या कंपनीत वापरले जाते.';

  @override
  String get useOwnName => 'त्यांचे स्वतःचे नाव वापरा';

  @override
  String get scanQrCode => 'QR कोड स्कॅन करा';

  @override
  String get scanQrHint =>
      'त्यांच्या अॅपमध्ये दिसणाऱ्या QR कोडकडे कॅमेरा धरा (खाते मेनू, “माझा QR कोड”).';

  @override
  String get orEnterCode => 'किंवा त्यांचा ६ अंकी कोड टाका';

  @override
  String get qrInvalid => 'हा Staff Flow QR कोड नाही.';

  @override
  String cameraUnavailable(String error) {
    return 'कॅमेरा उपलब्ध नाही ($error).';
  }

  @override
  String get notificationsTitle => 'सूचना';

  @override
  String get notifChooseHint =>
      'कोणत्या गोष्टींच्या सूचना हव्यात ते निवडा. सर्व काही घंटीत दिसत राहील.';

  @override
  String get notifPlanning => 'वेळापत्रक प्रकाशित किंवा बदलले';

  @override
  String get notifRequests => 'विनंत्या: अदलाबदल, रजा, आमंत्रणे';

  @override
  String get notifMessages => 'नवीन संदेश';

  @override
  String get notifOverlap => 'कंपन्यांमधील एकमेकांवर येणाऱ्या शिफ्ट';

  @override
  String get notifConflicts => 'दुसऱ्या व्यवस्थापकाने तुमचा बदल बदलला';

  @override
  String get notifBilling => 'सदस्यता स्मरणपत्रे';

  @override
  String get pushEnabled => 'या डिव्हाइसवर सूचना सुरू आहेत.';

  @override
  String get pushOff => 'या डिव्हाइसवर सूचना बंद आहेत.';

  @override
  String get pushBlocked =>
      'सूचना अवरोधित आहेत: फोन किंवा ब्राउझरच्या सेटिंग्जमध्ये परवानगी द्या.';

  @override
  String get pushUnavailable => 'या डिव्हाइसवर सूचना उपलब्ध नाहीत.';

  @override
  String get enablePush => 'सुरू करा';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: तुमचे वेळापत्रक प्रकाशित किंवा बदलले आहे.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company तुम्हाला त्यांच्या संघात जोडू इच्छिते.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name तुम्हाला $company चे मालक होण्याचा प्रस्ताव देत आहेत.';
  }
}
