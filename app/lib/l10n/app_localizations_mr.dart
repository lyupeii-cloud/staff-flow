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

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name $company मध्ये सामील झाले.';
  }

  @override
  String get messagesTab => 'संदेश';

  @override
  String get wholeTeam => 'संपूर्ण संघ';

  @override
  String get newConversation => 'नवीन संभाषण';

  @override
  String get noMessages => 'अद्याप संदेश नाहीत.';

  @override
  String get messageHint => 'संदेश लिहा';

  @override
  String get earlierMessages => 'आधीचे संदेश';

  @override
  String get personLeftCompany => 'ही व्यक्ती आता कंपनीचा भाग नाही.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'नवीन गट';

  @override
  String get editGroup => 'गट संपादित करा';

  @override
  String get groupName => 'गटाचे नाव';

  @override
  String get groupMembersHint =>
      'या गटातील लोक निवडा. फक्त तेच त्याचे संदेश पाहतील.';

  @override
  String get chooseAtLeastOne => 'किमान एक व्यक्ती निवडा.';

  @override
  String get replyAction => 'उत्तर द्या';

  @override
  String get translateAction => 'भाषांतर करा';

  @override
  String replyingTo(String name) {
    return '$name यांना उत्तर';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name यांचे अलीकडील संदेश';
  }

  @override
  String get deleteAllNotices => 'सर्व हटवा';

  @override
  String get deleteAllNoticesConfirm => 'सर्व सूचना हटवायच्या?';

  @override
  String get noticeRetention => 'वाचलेल्या सूचना यानंतर हटवा';

  @override
  String get retentionDay => '1 दिवस';

  @override
  String get retentionWeek => '1 आठवडा';

  @override
  String get retentionMonth => '1 महिना';

  @override
  String get billingOwnersOnly => 'तुमची कंपनी असेल तरच सक्रिय.';

  @override
  String get readOnlyPastDays => 'एक महिन्यापेक्षा जुने दिवस फक्त वाचता येतात.';

  @override
  String get wholeCompany => 'संपूर्ण कंपनी';

  @override
  String get sitesLabel => 'साइट्स';

  @override
  String get actionSites => 'साइट्स…';

  @override
  String managerOf(String name) {
    return '$name यांच्याकडे जबाबदारी';
  }

  @override
  String teamSitesOf(String name) {
    return '$name यांचा संघ';
  }

  @override
  String get notYourSite => 'ही साइट तुमच्या जबाबदारीत नाही.';

  @override
  String get chooseYourSite => 'किमान एक साइट निवडा.';

  @override
  String get viewRequests => 'विनंत्या';

  @override
  String get newRequest => 'नवीन विनंती';

  @override
  String get requestLeave => 'रजा';

  @override
  String get requestUnavailability => 'अनुपलब्धता';

  @override
  String get requestSwap => 'शिफ्ट अदलाबदल';

  @override
  String get swapHint =>
      'अदलाबदल सुचवण्यासाठी वेळापत्रकातील तुमच्या आगामी शिफ्टवर टॅप करा.';

  @override
  String get noRequests => 'अद्याप कोणतीही विनंती नाही.';

  @override
  String get requestsToHandle => 'हाताळायच्या';

  @override
  String get myRequests => 'माझ्या विनंत्या';

  @override
  String get otherRequests => 'टीमच्या विनंत्या';

  @override
  String get statusPendingPeer => 'सहकाऱ्याची प्रतीक्षा';

  @override
  String get statusPendingManager => 'व्यवस्थापकाची प्रतीक्षा';

  @override
  String get statusApproved => 'मंजूर';

  @override
  String get statusRefused => 'नाकारली';

  @override
  String get statusCancelled => 'रद्द';

  @override
  String get cancelRequest => 'विनंती रद्द करा';

  @override
  String get acceptSwap => 'ही शिफ्ट घ्या';

  @override
  String get approve => 'मंजूर करा';

  @override
  String periodLabel(String from, String to) {
    return '$from ते $to';
  }

  @override
  String swapToPeer(String name) {
    return '$name यांना सुचवले';
  }

  @override
  String get swapToTeam => 'संपूर्ण टीम';

  @override
  String everyWeekdays(String days) {
    return 'दर आठवड्याला: $days';
  }

  @override
  String get unavailableEveryWeek => 'ज्या दिवशी तुम्ही कधीच उपलब्ध नसता:';

  @override
  String get choosePeriod => 'तारखा निवडा';

  @override
  String get choosePeriodOptional => 'कालावधीपुरते मर्यादित करा (ऐच्छिक)';

  @override
  String get clearPeriod => 'कालावधी नाही';

  @override
  String get sendRequest => 'विनंती पाठवा';

  @override
  String get proposeSwap => 'अदलाबदल सुचवा';

  @override
  String get swapWith => 'यांना सुचवा';

  @override
  String get swapSteps =>
      'सहकारी स्वीकारतो, नंतर व्यवस्थापक मंजूर करतो. त्यानंतरच वेळापत्रक बदलते.';

  @override
  String get absentThatDay => 'त्या दिवशी मंजूर अनुपस्थिती';

  @override
  String get requestSent => 'विनंती पाठवली.';

  @override
  String noticeSwapOffer(String name) {
    return '$name तुम्हाला त्यांची एक शिफ्ट देऊ इच्छितात.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name यांनी तुमचा अदलाबदलीचा प्रस्ताव नाकारला.';
  }

  @override
  String get noticeSwapToApprove =>
      'एक शिफ्ट अदलाबदल तुमच्या मंजुरीची वाट पाहत आहे.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name रजा मागत आहेत.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name यांनी अनुपलब्धता कळवली आहे.';
  }

  @override
  String get noticeRequestApproved => 'तुमची विनंती मंजूर झाली.';

  @override
  String get noticeRequestRefused => 'तुमची विनंती नाकारली गेली.';

  @override
  String get choosePeer => 'ही शिफ्ट कोण घेईल?';

  @override
  String get discardAll => 'सर्व रद्द करा';

  @override
  String get notifySitesHint =>
      'ज्या ठिकाणांच्या विनंत्यांच्या सूचना हव्यात ती निवडा. सर्व विनंत्या यादीत दिसत राहतील.';

  @override
  String get notifySitesTitle => 'ठिकाणानुसार सूचना';

  @override
  String get pendingRequestTooltip => 'प्रलंबित विनंती: उघडण्यासाठी टॅप करा';

  @override
  String get requestsHistory => 'सर्व विनंत्या';

  @override
  String get revertChange => 'हा बदल रद्द करा';

  @override
  String get statusExpired => 'आता लागू नाही';

  @override
  String get swapWithHint => 'विशिष्ट सहकारी निवडण्यासाठी टॅप करा';

  @override
  String changesDiscarded(String count) {
    return 'रद्द केलेले बदल: $count';
  }

  @override
  String discardConfirm(String count) {
    return '$count अप्रकाशित बदल रद्द करायचे?';
  }

  @override
  String get allSchedules => 'माझी सर्व वेळापत्रके';

  @override
  String get busyElsewhere => 'या वेळी आधीच दुसऱ्या कंपनीत कामावर';

  @override
  String get overlapTooltip => 'दुसऱ्या कंपनीतील शिफ्टशी एकाच वेळी येते';

  @override
  String get overlapWarning =>
      'दोन कंपन्यांमधील तुमच्या काही शिफ्ट एकमेकांवर येतात.';

  @override
  String noticeOverlap(String date) {
    return '$date रोजी वेगवेगळ्या कंपन्यांमधील तुमच्या दोन शिफ्ट एकमेकांवर येतात.';
  }

  @override
  String get allMyCompanies => 'माझ्या सर्व कंपन्या';

  @override
  String get deleteGroup => 'गट हटवा';

  @override
  String get openRequest => 'विनंती पाहा';

  @override
  String get thisCompany => 'ही कंपनी';

  @override
  String get withExtras => 'तात्पुरत्या कर्मचाऱ्यांसह';

  @override
  String deleteGroupConfirm(String name) {
    return 'सर्वांसाठी “$name” आणि त्याचे सर्व संदेश हटवायचे?';
  }

  @override
  String reinforcementHint(String company) {
    return '$company मधून: मदतनीस म्हणून जोडले जाईल आणि कळवले जाईल.';
  }

  @override
  String get addToGoogle => 'Google कॅलेंडरमध्ये जोडा';

  @override
  String get calendarEnabled => 'माझ्या शिफ्ट सिंक करा';

  @override
  String get calendarHint =>
      'तुमच्या सर्व कंपन्यांच्या शिफ्ट Google कॅलेंडरमध्ये जोडा. त्या आपोआप अद्ययावत होतात आणि तुम्ही कधीही बंद करू शकता.';

  @override
  String get changeSettings => 'बदला';

  @override
  String get copyCalendarLink => 'कॅलेंडर लिंक कॉपी करा';

  @override
  String get countryBelgium => 'बेल्जियम';

  @override
  String get countryCanada => 'कॅनडा';

  @override
  String get countryFrance => 'फ्रान्स';

  @override
  String get countrySwitzerland => 'स्वित्झर्लंड';

  @override
  String get employeesSection => 'कर्मचारी';

  @override
  String get emptyNoAlert => 'रिकामे: सूचना नाही';

  @override
  String get extrasSection => 'तात्पुरते कर्मचारी';

  @override
  String get googleCalendar => 'Google कॅलेंडर';

  @override
  String get hoursTotals => 'तासांची बेरीज';

  @override
  String get legalAlerts => 'कायदेशीर सूचना';

  @override
  String get legalAlertsHint =>
      'फक्त सूचना, कधीही अडथळा नाही. तुम्हाला लागू नियम निवडा, किंवा काहीच नाही.';

  @override
  String get legalPreset => 'देशाचा साचा';

  @override
  String get linkCopied => 'लिंक कॉपी झाली.';

  @override
  String get maxConsecutiveLabel => 'सलग कामाचे जास्तीत जास्त दिवस';

  @override
  String get maxDayLabel => 'दिवसाला जास्तीत जास्त वेळ (तास)';

  @override
  String get maxWeekLabel => 'आठवड्याला जास्तीत जास्त वेळ (तास)';

  @override
  String get minRestLabel => 'दोन शिफ्टमधील किमान विश्रांती (तास)';

  @override
  String get noLegalRules => 'कोणतीही सूचना निवडलेली नाही.';

  @override
  String get presetNone => 'काहीच नाही';

  @override
  String get presetsCheck =>
      'साचे फक्त सुरुवात आहेत: तुमच्या देशाचे नियम व सामूहिक करारानुसार तपासा.';

  @override
  String get printMine => 'माझे वेळापत्रक';

  @override
  String get printOwn => 'फक्त स्वतःचे वेळापत्रक';

  @override
  String get printPdf => 'प्रिंट / PDF';

  @override
  String get printRights => 'कर्मचारी काय प्रिंट करू शकतात';

  @override
  String get printTeam => 'संपूर्ण टीमचे वेळापत्रक';

  @override
  String get printTeamOption => 'टीमचे वेळापत्रक';

  @override
  String get totalsHint =>
      'मसुद्यांसह. Excel आणि CSV निर्यात प्रकाशित वेळापत्रक वापरते.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: सलग $value दिवस (कमाल $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: दिवसात $value (कमाल $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: फक्त $value विश्रांती (किमान $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: आठवड्यात $value (कमाल $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'कायदेशीर सूचना: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'शिफ्ट: $count';
  }

  @override
  String get actionMakeDeputy => 'उप-व्यवस्थापक नेमा';

  @override
  String get actionRemoveDeputy => 'उप-व्यवस्थापकाची भूमिका काढा';

  @override
  String get busyHere => 'या वेळी आधीच या कंपनीत कामावर';

  @override
  String get calendarByLink => 'लिंकद्वारे (संगणकावर Google कॅलेंडर)';

  @override
  String get calendarDenied =>
      'कॅलेंडरचा प्रवेश नाकारला. फोनच्या सेटिंग्जमध्ये परवानगी द्या.';

  @override
  String get calendarLinkHint =>
      'संगणकावरील Google कॅलेंडरमधून जोडा; Google काही तासांत अद्ययावत करते.';

  @override
  String get calendarNone => 'या फोनवर बदलता येणारे कॅलेंडर नाही.';

  @override
  String get calendarOnPhone => 'माझ्या शिफ्ट फोनच्या कॅलेंडरमध्ये जोडा';

  @override
  String get calendarOnPhoneHint =>
      'तुमच्या Google कॅलेंडरमध्ये: फोनवर आणि Google कॅलेंडरमध्ये लगेच दिसेल.';

  @override
  String get chooseCalendar => 'कॅलेंडर निवडा';

  @override
  String get otherSiteHint =>
      'दुसऱ्या ठिकाणचा कर्मचारी: त्याच्या व्यवस्थापकांना कळवले जाईल.';

  @override
  String get subManager => 'उप-व्यवस्थापक';

  @override
  String calendarSynced(String count) {
    return 'कॅलेंडरमधील शिफ्ट: $count';
  }

  @override
  String deputyOf(String name) {
    return 'उप-व्यवस्थापक: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by यांनी $date रोजी $name यांना $site येथे नेमले.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company ने तुम्हाला मदतनीस म्हणून जोडले.';
  }

  @override
  String get companyNotificationsHint =>
      'बंद: या फोनवर काही वाजणार नाही, पण सगळे घंटीत राहील.';

  @override
  String get companyNotificationsOn => 'या कंपनीच्या सूचना मिळवा';

  @override
  String get companyTimezone => 'कंपनीचा वेळ क्षेत्र';

  @override
  String get companyTimezoneHint =>
      'या कंपनीच्या सर्व वेळा याच वेळ क्षेत्रात आहेत (उन्हाळी वेळेसह). कॅलेंडर त्या आपोआप बदलतात.';

  @override
  String get iosInstallHint =>
      'iPhone वर: शेअर टॅप करा, मग “होम स्क्रीनवर जोडा” निवडून Staff Flow इंस्टॉल करा.';

  @override
  String get searchCity => 'शहर शोधा';

  @override
  String get thisPhone => 'हे उपकरण';

  @override
  String companyNotifications(String name) {
    return 'सूचना: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'वेळा $zone च्या वेळेनुसार ($company). तुमचे उपकरण: $here.';
  }
}
