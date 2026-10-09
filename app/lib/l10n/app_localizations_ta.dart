// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class L10nTa extends L10n {
  L10nTa([String locale = 'ta']) : super(locale);

  @override
  String get cancel => 'ரத்துசெய்';

  @override
  String get save => 'சேமி';

  @override
  String get confirm => 'உறுதிசெய்';

  @override
  String get validate => 'உறுதிசெய்';

  @override
  String get add => 'சேர்';

  @override
  String get rename => 'பெயர் மாற்று';

  @override
  String get delete => 'நீக்கு';

  @override
  String get accept => 'ஏற்றுக்கொள்';

  @override
  String get decline => 'நிராகரி';

  @override
  String get close => 'மூடு';

  @override
  String get retry => 'மீண்டும் முயல்க';

  @override
  String get name => 'பெயர்';

  @override
  String get serverUnreachable => 'சர்வரை அணுக முடியவில்லை.';

  @override
  String errorStatus(int status) {
    return 'பிழை $status';
  }

  @override
  String get roleOwner => 'உரிமையாளர்';

  @override
  String get roleManager => 'மேலாளர்';

  @override
  String get roleEmployee => 'பணியாளர்';

  @override
  String get roleExtra => 'தற்காலிகப் பணியாளர்';

  @override
  String get taglineStart => 'உங்கள் குழுவின் பணி அட்டவணை, ';

  @override
  String get taglineEnd => 'எங்கும்.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Google மூலம் உள்நுழை';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google உள்நுழைவு கிடைக்கவில்லை: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google மூலம் உள்நுழைய முடியவில்லை: $detail';
  }

  @override
  String get newCompany => 'புதிய நிறுவனம்';

  @override
  String get timezone => 'நேர மண்டலம்';

  @override
  String get create => 'உருவாக்கு';

  @override
  String get noCompanyTitle => 'நீங்கள் இன்னும் எந்த நிறுவனத்திலும் இல்லை.';

  @override
  String get noCompanyHint =>
      'உங்கள் முதலாளியின் நிறுவனத்தில் சேர, ஒரு குறியீட்டை உருவாக்கி உங்கள் மேலாளரிடம் கொடுங்கள்.';

  @override
  String get joinCompany => 'நிறுவனத்தில் சேர்';

  @override
  String get createCompany => 'நிறுவனத்தை உருவாக்கு';

  @override
  String transferOffer(String company) {
    return '“$company” இன் உரிமையாளராக ஆக உங்களுக்கு அழைப்பு வந்துள்ளது.';
  }

  @override
  String get someCompany => 'ஒரு நிறுவனம்';

  @override
  String get becameOwner => 'இப்போது நீங்கள் உரிமையாளர்.';

  @override
  String get myAccount => 'என் கணக்கு';

  @override
  String get idCopied => 'அடையாள எண் நகலெடுக்கப்பட்டது.';

  @override
  String myId(String id) {
    return 'என் அடையாள எண்: $id';
  }

  @override
  String get signOut => 'வெளியேறு';

  @override
  String joinInvite(String company, String role) {
    return '“$company” உங்களை $role ஆக அழைக்கிறது.';
  }

  @override
  String joinedCompany(String company) {
    return 'நீங்கள் $company இல் சேர்ந்தீர்கள்.';
  }

  @override
  String get viewPlanning => 'அட்டவணை';

  @override
  String get viewTeam => 'குழு';

  @override
  String get viewPositions => 'பணிகள்';

  @override
  String get readOnlyCompany => 'இந்த நிறுவனம் பார்வைக்கு மட்டும்.';

  @override
  String get team => 'குழு';

  @override
  String get leaveCompany => 'இந்த நிறுவனத்தை விட்டு வெளியேறு';

  @override
  String meSuffix(String name) {
    return '$name (நீங்கள்)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'நிறுவனத்தை $name இடம் ஒப்படைக்கவா?';
  }

  @override
  String get transferConfirmBody =>
      'அவர் ஏற்றுக்கொண்டதும் உரிமையாளர் ஆவார் (சந்தா, கட்டணச்சீட்டுகள், மேலாளர்கள்); நீங்கள் மேலாளர் ஆவீர்கள்.';

  @override
  String transferSent(String name) {
    return '$name க்கு அழைப்பு அனுப்பப்பட்டது.';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$name ஐ நீக்கவா?';
  }

  @override
  String get removeConfirmBody => 'வரலாறு பாதுகாக்கப்படும்.';

  @override
  String get addPersonTitle => 'ஒருவரைச் சேர்';

  @override
  String get addPersonHint =>
      'Staff Flow ஐத் திறந்து, கணக்கு மெனுவில் “நிறுவனத்தில் சேர்” என்பதைத் தேர்வுசெய்யச் சொல்லுங்கள், பிறகு காட்டப்படும் குறியீட்டை உள்ளிடுங்கள்.';

  @override
  String get sixDigitCode => '6 இலக்கக் குறியீடு';

  @override
  String invitationSent(String name) {
    return '$name க்கு அழைப்பு அனுப்பப்பட்டது: அவர் ஏற்க வேண்டும்.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company ஐ விட்டு வெளியேறவா?';
  }

  @override
  String get leaveConfirmBody => 'இனி அதன் அட்டவணையைப் பார்க்க முடியாது.';

  @override
  String get renameCompany => 'நிறுவனத்தின் பெயரை மாற்று';

  @override
  String get actionMakeManager => 'மேலாளராக்கு';

  @override
  String get actionMakeEmployee => 'மீண்டும் பணியாளராக்கு';

  @override
  String get actionToEmployee => 'பணியாளராக்கு';

  @override
  String get actionToExtra => 'தற்காலிகப் பணியாளராக்கு';

  @override
  String get actionTransfer => 'உரிமையை ஒப்படை';

  @override
  String get actionRemove => 'நிறுவனத்திலிருந்து நீக்கு';

  @override
  String get positions => 'பணிகள்';

  @override
  String get sites => 'இடங்கள்';

  @override
  String get positionsHint => 'அவர் செய்யும் வேலை: காசாளர், சமையலறை, வரவேற்பு…';

  @override
  String get sitesHint =>
      'நிறுவனத்துக்குப் பல இடங்கள் இருந்தால், பணி எங்கு நடக்கிறது.';

  @override
  String get archived => 'காப்பகப்படுத்தப்பட்டது';

  @override
  String get archive => 'காப்பகப்படுத்து';

  @override
  String get reactivate => 'மீண்டும் இயக்கு';

  @override
  String weekOf(String date) {
    return '$date வாரம்';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count மாற்றங்கள் வெளியிடப்பட்டன.',
      one: '1 மாற்றம் வெளியிடப்பட்டது.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'பணி நேரம்';

  @override
  String get display => 'காட்சி';

  @override
  String get week => 'வாரம்';

  @override
  String get month => 'மாதம்';

  @override
  String get today => 'இன்று';

  @override
  String get onlyMine => 'என் பணி நேரங்கள் மட்டும்';

  @override
  String get replacePersonMenu => 'ஒருவரை மாற்று…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'வெளியிடப்படாத $count மாற்றங்கள்',
      one: 'வெளியிடப்படாத 1 மாற்றம்',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'பணியாளர்களுக்கு இவை இன்னும் தெரியாது.';

  @override
  String get publish => 'வெளியிடு';

  @override
  String yourHours(String duration) {
    return 'இந்தக் காலத்தில் உங்கள் மணிநேரம்: $duration';
  }

  @override
  String get addShiftThisDay => 'இந்த நாளில் பணி நேரம் சேர்';

  @override
  String get noShift => 'பணி நேரம் இல்லை';

  @override
  String get unassigned => 'ஒதுக்கப்படவில்லை';

  @override
  String get formerMember => 'முன்னாள் உறுப்பினர்';

  @override
  String get statusDraft => 'வரைவு';

  @override
  String get statusModified => 'மாற்றப்பட்டது';

  @override
  String get statusDeleted => 'நீக்கப்பட்டது';

  @override
  String durationHours(int hours) {
    return '$hours மணி';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours மணி $minutes நிமி';
  }

  @override
  String get editShift => 'பணி நேரத்தைத் திருத்து';

  @override
  String get newShift => 'புதிய பணி நேரம்';

  @override
  String get thisShift => 'இது மட்டும்';

  @override
  String get thisAndFollowing => 'இதுவும் அடுத்தவையும்';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'நாட்கள்',
      one: 'நாள்',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'வேறு நாள்';

  @override
  String get start => 'தொடக்கம்';

  @override
  String get end => 'முடிவு';

  @override
  String get endsNextDay => 'அடுத்த நாள் முடிகிறது.';

  @override
  String get person => 'நபர்';

  @override
  String get position => 'பணி';

  @override
  String get site => 'இடம்';

  @override
  String get noteOptional => 'குறிப்பு (விருப்பம்)';

  @override
  String get repetition => 'மீண்டும் செய்தல்';

  @override
  String get repeatNone => 'இல்லை';

  @override
  String get repeatDaily => 'ஒவ்வொரு நாளும்';

  @override
  String get repeatWeekly => 'ஒவ்வொரு வாரமும்';

  @override
  String get repeatForPrefix => 'காலம் ';

  @override
  String get repeatDaysSuffix => ' நாட்கள்';

  @override
  String get repeatWeeksSuffix => ' வாரங்கள்';

  @override
  String get repeatUntilPrefix => 'வரை ';

  @override
  String get replacePersonTitle => 'ஒருவரை மாற்று';

  @override
  String get replaceFrom => 'மாற்ற வேண்டியவர்';

  @override
  String get replaceBy => 'பதிலாக';

  @override
  String dateRange(String from, String to) {
    return '$from முதல் $to வரை';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count பணி நேரங்கள் மாற்றப்பட்டன.',
      one: '1 பணி நேரம் மாற்றப்பட்டது.',
      zero: 'எந்தப் பணி நேரமும் மாறவில்லை.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'மாற்று';

  @override
  String get joinHint =>
      'இந்தக் குறியீட்டை உங்கள் மேலாளரிடம் கொடுங்கள். அவர் செயலியில் உள்ளிட்டதும் உங்களுக்கு அழைப்பு வரும்.';

  @override
  String get codeExpired => 'குறியீடு காலாவதியானது.';

  @override
  String codeValidFor(String time) {
    return 'இன்னும் $time செல்லும்';
  }

  @override
  String get newCode => 'புதிய குறியீடு';

  @override
  String get language => 'மொழி';

  @override
  String get languageAuto => 'தானியங்கு (சாதனத்தின் மொழி)';

  @override
  String get syncUpToDate => 'புதுப்பிக்கப்பட்டது';

  @override
  String get syncOffline => 'இணைப்பில்லை';

  @override
  String syncPending(int count) {
    return 'நிலுவையிலுள்ள மாற்றங்கள்: $count';
  }

  @override
  String get syncNow => 'இப்போது ஒத்திசை';

  @override
  String syncRejected(String reason) {
    return 'சர்வர் மாற்றத்தை நிராகரித்தது: $reason';
  }

  @override
  String get pendingBadge => 'நிலுவையில்';

  @override
  String get offlineUnavailable => 'இணைப்பின்றி கிடைக்காது.';

  @override
  String get offlineCached => 'இணைப்பில்லை: கடைசியாகச் சேமித்த தரவு.';

  @override
  String get savedOffline =>
      'சாதனத்தில் சேமிக்கப்பட்டது, இணைப்பு வந்ததும் அனுப்பப்படும்.';

  @override
  String get notices => 'அறிவிப்புகள்';

  @override
  String get noNotices => 'அறிவிப்புகள் இல்லை.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$date பணி நேரத்தில் உங்கள் மாற்றத்தை $name மாற்றினார்.';
  }

  @override
  String get history => 'வரலாறு';

  @override
  String get recentChanges => 'சமீபத்திய மாற்றங்கள்';

  @override
  String get undoChange => 'இந்த மாற்றத்தைச் செயல்தவிர்';

  @override
  String get undoDone => 'மாற்றம் செயல்தவிர்க்கப்பட்டது.';

  @override
  String get historyCreate => 'உருவாக்கம்';

  @override
  String get historyUpdate => 'மாற்றம்';

  @override
  String get historyDelete => 'நீக்கம்';

  @override
  String get historyUndo => 'செயல்தவிர்ப்பு';

  @override
  String get noHistory => 'மாற்றங்கள் இல்லை.';

  @override
  String get pendingNotEditable =>
      'இந்தப் பணி நேரம் இன்னும் ஒத்திசைக்கப்படவில்லை: இணைப்பில் இருக்கும்போது மீண்டும் முயலவும்.';

  @override
  String get myQrCode => 'எனது QR குறியீடு';

  @override
  String get myQrCodeHint =>
      'மேலாளர் இந்தக் குறியீட்டை ஸ்கேன் செய்து உங்களை நிறுவனத்தில் சேர்ப்பார்; பிறகு நீங்கள் உறுதிப்படுத்துவீர்கள். இது ஒருபோதும் மாறாது.';

  @override
  String get changeMyName => 'என் பெயரை மாற்று';

  @override
  String get nameShownToTeam =>
      'உங்கள் Google பெயருக்குப் பதிலாக இந்தப் பெயர் சக ஊழியர்களுக்குக் காட்டப்படும்.';

  @override
  String googleName(String name) {
    return 'Google பெயர்: $name';
  }

  @override
  String get useGoogleName => 'என் Google பெயரைப் பயன்படுத்து';

  @override
  String renameMemberTitle(String name) {
    return '$name பெயரை மாற்று';
  }

  @override
  String get renameMemberHint =>
      'இந்தப் பெயர் இந்த நிறுவனத்தில் மட்டுமே பயன்படும்.';

  @override
  String get useOwnName => 'அவரது சொந்தப் பெயரைப் பயன்படுத்து';

  @override
  String get scanQrCode => 'QR குறியீட்டை ஸ்கேன் செய்';

  @override
  String get scanQrHint =>
      'அவரது செயலியில் காட்டப்படும் QR குறியீட்டை நோக்கி கேமராவைக் காட்டுங்கள் (கணக்கு மெனு, “எனது QR குறியீடு”).';

  @override
  String get orEnterCode => 'அல்லது அவரது 6 இலக்கக் குறியீட்டை உள்ளிடுங்கள்';

  @override
  String get qrInvalid => 'இது Staff Flow QR குறியீடு அல்ல.';

  @override
  String cameraUnavailable(String error) {
    return 'கேமரா கிடைக்கவில்லை ($error).';
  }

  @override
  String get notificationsTitle => 'அறிவிப்புகள்';

  @override
  String get notifChooseHint =>
      'எவற்றுக்கு அறிவிப்பு வேண்டும் என்பதைத் தேர்ந்தெடுங்கள். எல்லாம் மணியில் தெரியும்.';

  @override
  String get notifPlanning => 'அட்டவணை வெளியிடப்பட்டது அல்லது மாற்றப்பட்டது';

  @override
  String get notifRequests => 'கோரிக்கைகள்: மாற்றங்கள், விடுப்பு, அழைப்புகள்';

  @override
  String get notifMessages => 'புதிய செய்திகள்';

  @override
  String get notifOverlap =>
      'நிறுவனங்களுக்கு இடையே ஒன்றின் மேல் ஒன்று வரும் ஷிஃப்ட்கள்';

  @override
  String get notifConflicts =>
      'உங்கள் மாற்றத்தை மற்றொரு மேலாளர் மாற்றியமைத்தார்';

  @override
  String get notifBilling => 'சந்தா நினைவூட்டல்கள்';

  @override
  String get pushEnabled => 'இந்தச் சாதனத்தில் அறிவிப்புகள் இயக்கத்தில் உள்ளன.';

  @override
  String get pushOff => 'இந்தச் சாதனத்தில் அறிவிப்புகள் முடக்கத்தில் உள்ளன.';

  @override
  String get pushBlocked =>
      'அறிவிப்புகள் தடுக்கப்பட்டுள்ளன: தொலைபேசி அல்லது உலாவி அமைப்புகளில் அனுமதியுங்கள்.';

  @override
  String get pushUnavailable => 'இந்தச் சாதனத்தில் அறிவிப்புகள் கிடைக்கவில்லை.';

  @override
  String get enablePush => 'இயக்கு';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: உங்கள் அட்டவணை வெளியிடப்பட்டது அல்லது மாற்றப்பட்டது.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company உங்களைத் தன் குழுவில் சேர்க்க விரும்புகிறது.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name உங்களை $company உரிமையாளராக்க முன்மொழிகிறார்.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name $company இல் சேர்ந்தார்.';
  }

  @override
  String get messagesTab => 'செய்திகள்';

  @override
  String get wholeTeam => 'முழுக் குழு';

  @override
  String get newConversation => 'புதிய உரையாடல்';

  @override
  String get noMessages => 'இன்னும் செய்திகள் இல்லை.';

  @override
  String get messageHint => 'செய்தியை எழுதுங்கள்';

  @override
  String get earlierMessages => 'முந்தைய செய்திகள்';

  @override
  String get personLeftCompany => 'இவர் இப்போது நிறுவனத்தில் இல்லை.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'புதிய குழு';

  @override
  String get editGroup => 'குழுவைத் திருத்து';

  @override
  String get groupName => 'குழுவின் பெயர்';

  @override
  String get groupMembersHint =>
      'இந்தக் குழுவிலுள்ளவர்களைத் தேர்ந்தெடுங்கள். அவர்கள் மட்டுமே செய்திகளைப் பார்ப்பார்கள்.';

  @override
  String get chooseAtLeastOne => 'குறைந்தது ஒருவரைத் தேர்ந்தெடுங்கள்.';

  @override
  String get replyAction => 'பதிலளி';

  @override
  String get translateAction => 'மொழிபெயர்';

  @override
  String replyingTo(String name) {
    return '$name அவர்களுக்குப் பதில்';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name அவர்களின் சமீபத்திய செய்திகள்';
  }

  @override
  String get deleteAllNotices => 'அனைத்தையும் நீக்கு';

  @override
  String get deleteAllNoticesConfirm => 'எல்லா அறிவிப்புகளையும் நீக்கவா?';

  @override
  String get noticeRetention => 'படித்த அறிவிப்புகளை நீக்கும் காலம்';

  @override
  String get retentionDay => '1 நாள்';

  @override
  String get retentionWeek => '1 வாரம்';

  @override
  String get retentionMonth => '1 மாதம்';

  @override
  String get billingOwnersOnly =>
      'நீங்கள் ஒரு நிறுவனத்தின் உரிமையாளராக இருந்தால் மட்டுமே செயல்படும்.';

  @override
  String get readOnlyPastDays =>
      'ஒரு மாதத்துக்கு மேல் பழைய நாட்கள் படிக்க மட்டுமே.';

  @override
  String get wholeCompany => 'முழு நிறுவனம்';

  @override
  String get sitesLabel => 'தளங்கள்';

  @override
  String get actionSites => 'தளங்கள்…';

  @override
  String managerOf(String name) {
    return '$name பொறுப்பில்';
  }

  @override
  String teamSitesOf(String name) {
    return '$name அவர்களின் குழு';
  }

  @override
  String get notYourSite => 'இந்தத் தளம் உங்கள் பொறுப்பில் இல்லை.';

  @override
  String get chooseYourSite => 'குறைந்தது ஒரு தளத்தைத் தேர்ந்தெடுங்கள்.';
}
