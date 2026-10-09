// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class L10nTe extends L10n {
  L10nTe([String locale = 'te']) : super(locale);

  @override
  String get cancel => 'రద్దు చేయి';

  @override
  String get save => 'సేవ్ చేయి';

  @override
  String get confirm => 'నిర్ధారించు';

  @override
  String get validate => 'నిర్ధారించు';

  @override
  String get add => 'జోడించు';

  @override
  String get rename => 'పేరు మార్చు';

  @override
  String get delete => 'తొలగించు';

  @override
  String get accept => 'అంగీకరించు';

  @override
  String get decline => 'తిరస్కరించు';

  @override
  String get close => 'మూసివేయి';

  @override
  String get retry => 'మళ్లీ ప్రయత్నించు';

  @override
  String get name => 'పేరు';

  @override
  String get serverUnreachable => 'సర్వర్‌ను చేరుకోలేకపోతున్నాం.';

  @override
  String errorStatus(int status) {
    return 'లోపం $status';
  }

  @override
  String get roleOwner => 'యజమాని';

  @override
  String get roleManager => 'మేనేజర్';

  @override
  String get roleEmployee => 'ఉద్యోగి';

  @override
  String get roleExtra => 'తాత్కాలిక ఉద్యోగి';

  @override
  String get taglineStart => 'మీ బృందం షిఫ్ట్‌లు, ';

  @override
  String get taglineEnd => 'ఎక్కడైనా.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Googleతో సైన్ ఇన్ చేయండి';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google సైన్-ఇన్ అందుబాటులో లేదు: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Googleతో సైన్ ఇన్ కాలేదు: $detail';
  }

  @override
  String get newCompany => 'కొత్త సంస్థ';

  @override
  String get timezone => 'టైమ్ జోన్';

  @override
  String get create => 'సృష్టించు';

  @override
  String get noCompanyTitle => 'మీరు ఇంకా ఏ సంస్థలోనూ లేరు.';

  @override
  String get noCompanyHint =>
      'మీ యజమాని సంస్థలో చేరడానికి ఒక కోడ్‌ను సృష్టించి మీ మేనేజర్‌కు ఇవ్వండి.';

  @override
  String get joinCompany => 'సంస్థలో చేరండి';

  @override
  String get createCompany => 'సంస్థను సృష్టించండి';

  @override
  String transferOffer(String company) {
    return '“$company” యజమానిగా మారమని మీకు ప్రతిపాదన వచ్చింది.';
  }

  @override
  String get someCompany => 'ఒక సంస్థ';

  @override
  String get becameOwner => 'ఇప్పుడు మీరు యజమాని.';

  @override
  String get myAccount => 'నా ఖాతా';

  @override
  String get idCopied => 'ఐడీ కాపీ అయింది.';

  @override
  String myId(String id) {
    return 'నా ఐడీ: $id';
  }

  @override
  String get signOut => 'సైన్ అవుట్';

  @override
  String joinInvite(String company, String role) {
    return '“$company” మిమ్మల్ని $roleగా ఆహ్వానిస్తోంది.';
  }

  @override
  String joinedCompany(String company) {
    return 'మీరు $companyలో చేరారు.';
  }

  @override
  String get viewPlanning => 'షెడ్యూల్';

  @override
  String get viewTeam => 'బృందం';

  @override
  String get viewPositions => 'పదవులు';

  @override
  String get readOnlyCompany => 'ఈ సంస్థ చూడటానికి మాత్రమే.';

  @override
  String get team => 'బృందం';

  @override
  String get leaveCompany => 'ఈ సంస్థ నుండి వైదొలగండి';

  @override
  String meSuffix(String name) {
    return '$name (మీరు)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'సంస్థను $nameకి బదిలీ చేయాలా?';
  }

  @override
  String get transferConfirmBody =>
      'వారు అంగీకరించాక యజమాని అవుతారు (సబ్‌స్క్రిప్షన్, బిల్లులు, మేనేజర్లు), మీరు మేనేజర్ అవుతారు.';

  @override
  String transferSent(String name) {
    return '$nameకి ప్రతిపాదన పంపబడింది.';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$nameను తొలగించాలా?';
  }

  @override
  String get removeConfirmBody => 'చరిత్ర భద్రంగా ఉంటుంది.';

  @override
  String get addPersonTitle => 'వ్యక్తిని జోడించండి';

  @override
  String get addPersonHint =>
      'Staff Flow తెరిచి, ఖాతా మెనూలో “సంస్థలో చేరండి” ఎంచుకోమని చెప్పండి, ఆపై చూపిన కోడ్‌ను నమోదు చేయండి.';

  @override
  String get sixDigitCode => '6 అంకెల కోడ్';

  @override
  String invitationSent(String name) {
    return '$nameకి ఆహ్వానం పంపబడింది: వారు అంగీకరించాలి.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company నుండి వైదొలగాలా?';
  }

  @override
  String get leaveConfirmBody => 'మీరు ఇకపై దాని షెడ్యూల్ చూడలేరు.';

  @override
  String get renameCompany => 'సంస్థ పేరు మార్చండి';

  @override
  String get actionMakeManager => 'మేనేజర్‌గా చేయండి';

  @override
  String get actionMakeEmployee => 'మళ్లీ ఉద్యోగిగా చేయండి';

  @override
  String get actionToEmployee => 'ఉద్యోగిగా చేయండి';

  @override
  String get actionToExtra => 'తాత్కాలిక ఉద్యోగిగా చేయండి';

  @override
  String get actionTransfer => 'యాజమాన్యాన్ని బదిలీ చేయండి';

  @override
  String get actionRemove => 'సంస్థ నుండి తొలగించండి';

  @override
  String get positions => 'పదవులు';

  @override
  String get sites => 'ప్రదేశాలు';

  @override
  String get positionsHint => 'వ్యక్తి చేసే పని: క్యాష్, వంటగది, రిసెప్షన్…';

  @override
  String get sitesHint =>
      'సంస్థకు అనేక ప్రదేశాలు ఉంటే షిఫ్ట్ ఎక్కడ జరుగుతుంది.';

  @override
  String get archived => 'ఆర్కైవ్ చేయబడింది';

  @override
  String get archive => 'ఆర్కైవ్ చేయి';

  @override
  String get reactivate => 'మళ్లీ ప్రారంభించు';

  @override
  String weekOf(String date) {
    return '$date వారం';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count మార్పులు ప్రచురించబడ్డాయి.',
      one: '1 మార్పు ప్రచురించబడింది.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'షిఫ్ట్';

  @override
  String get display => 'వీక్షణ';

  @override
  String get week => 'వారం';

  @override
  String get month => 'నెల';

  @override
  String get today => 'ఈరోజు';

  @override
  String get onlyMine => 'నా షిఫ్ట్‌లు మాత్రమే';

  @override
  String get replacePersonMenu => 'వ్యక్తిని మార్చండి…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ప్రచురించని $count మార్పులు',
      one: 'ప్రచురించని 1 మార్పు',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'ఉద్యోగులకు ఇవి ఇంకా కనిపించవు.';

  @override
  String get publish => 'ప్రచురించు';

  @override
  String yourHours(String duration) {
    return 'ఈ కాలంలో మీ గంటలు: $duration';
  }

  @override
  String get addShiftThisDay => 'ఈ రోజున షిఫ్ట్ జోడించండి';

  @override
  String get noShift => 'షిఫ్ట్‌లు లేవు';

  @override
  String get unassigned => 'కేటాయించలేదు';

  @override
  String get formerMember => 'మాజీ సభ్యుడు';

  @override
  String get statusDraft => 'చిత్తుప్రతి';

  @override
  String get statusModified => 'మార్చబడింది';

  @override
  String get statusDeleted => 'తొలగించబడింది';

  @override
  String durationHours(int hours) {
    return '$hours గం.';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours గం. $minutes ని.';
  }

  @override
  String get editShift => 'షిఫ్ట్‌ను సవరించండి';

  @override
  String get newShift => 'కొత్త షిఫ్ట్';

  @override
  String get thisShift => 'ఈ షిఫ్ట్ మాత్రమే';

  @override
  String get thisAndFollowing => 'ఇది మరియు తర్వాతివి';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'రోజులు',
      one: 'రోజు',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'మరో రోజు';

  @override
  String get start => 'ప్రారంభం';

  @override
  String get end => 'ముగింపు';

  @override
  String get endsNextDay => 'మరుసటి రోజు ముగుస్తుంది.';

  @override
  String get person => 'వ్యక్తి';

  @override
  String get position => 'పదవి';

  @override
  String get site => 'ప్రదేశం';

  @override
  String get noteOptional => 'గమనిక (ఐచ్ఛికం)';

  @override
  String get repetition => 'పునరావృతం';

  @override
  String get repeatNone => 'లేదు';

  @override
  String get repeatDaily => 'ప్రతిరోజూ';

  @override
  String get repeatWeekly => 'ప్రతి వారం';

  @override
  String get repeatForPrefix => 'వ్యవధి ';

  @override
  String get repeatDaysSuffix => ' రోజులు';

  @override
  String get repeatWeeksSuffix => ' వారాలు';

  @override
  String get repeatUntilPrefix => 'వరకు ';

  @override
  String get replacePersonTitle => 'వ్యక్తిని మార్చండి';

  @override
  String get replaceFrom => 'మార్చవలసినవారు';

  @override
  String get replaceBy => 'బదులుగా';

  @override
  String dateRange(String from, String to) {
    return '$from నుండి $to వరకు';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count షిఫ్ట్‌లు మార్చబడ్డాయి.',
      one: '1 షిఫ్ట్ మార్చబడింది.',
      zero: 'ఏ షిఫ్ట్ మారలేదు.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'మార్చు';

  @override
  String get joinHint =>
      'ఈ కోడ్‌ను మీ మేనేజర్‌కు ఇవ్వండి. వారు యాప్‌లో నమోదు చేశాక మీకు ఆహ్వానం వస్తుంది.';

  @override
  String get codeExpired => 'కోడ్ గడువు ముగిసింది.';

  @override
  String codeValidFor(String time) {
    return 'ఇంకా $time చెల్లుతుంది';
  }

  @override
  String get newCode => 'కొత్త కోడ్';

  @override
  String get language => 'భాష';

  @override
  String get languageAuto => 'ఆటోమేటిక్ (పరికరం భాష)';

  @override
  String get syncUpToDate => 'తాజాగా ఉంది';

  @override
  String get syncOffline => 'ఆఫ్‌లైన్';

  @override
  String syncPending(int count) {
    return 'పెండింగ్ మార్పులు: $count';
  }

  @override
  String get syncNow => 'ఇప్పుడే సింక్ చేయి';

  @override
  String syncRejected(String reason) {
    return 'సర్వర్ మార్పును తిరస్కరించింది: $reason';
  }

  @override
  String get pendingBadge => 'పెండింగ్';

  @override
  String get offlineUnavailable => 'ఆఫ్‌లైన్‌లో అందుబాటులో లేదు.';

  @override
  String get offlineCached => 'ఆఫ్‌లైన్: చివరిగా సేవ్ చేసిన డేటా.';

  @override
  String get savedOffline =>
      'పరికరంలో సేవ్ చేయబడింది, నెట్‌వర్క్ వచ్చాక పంపబడుతుంది.';

  @override
  String get notices => 'నోటీసులు';

  @override
  String get noNotices => 'నోటీసులు లేవు.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$date షిఫ్ట్‌లో మీ మార్పును $name భర్తీ చేశారు.';
  }

  @override
  String get history => 'చరిత్ర';

  @override
  String get recentChanges => 'ఇటీవలి మార్పులు';

  @override
  String get undoChange => 'ఈ మార్పును రద్దు చేయి';

  @override
  String get undoDone => 'మార్పు రద్దు చేయబడింది.';

  @override
  String get historyCreate => 'సృష్టి';

  @override
  String get historyUpdate => 'మార్పు';

  @override
  String get historyDelete => 'తొలగింపు';

  @override
  String get historyUndo => 'రద్దు';

  @override
  String get noHistory => 'మార్పులు లేవు.';

  @override
  String get pendingNotEditable =>
      'ఈ షిఫ్ట్ ఇంకా సింక్ కాలేదు: ఆన్‌లైన్‌లో మళ్లీ ప్రయత్నించండి.';

  @override
  String get myQrCode => 'నా QR కోడ్';

  @override
  String get myQrCodeHint =>
      'మేనేజర్ ఈ కోడ్‌ను స్కాన్ చేసి మిమ్మల్ని తమ కంపెనీలో చేరుస్తారు; ఆ తర్వాత మీరు నిర్ధారిస్తారు. ఇది ఎప్పటికీ మారదు.';

  @override
  String get changeMyName => 'నా పేరు మార్చు';

  @override
  String get nameShownToTeam =>
      'మీ Google పేరుకు బదులుగా ఈ పేరు మీ సహోద్యోగులకు కనిపిస్తుంది.';

  @override
  String googleName(String name) {
    return 'Google పేరు: $name';
  }

  @override
  String get useGoogleName => 'నా Google పేరు వాడు';

  @override
  String renameMemberTitle(String name) {
    return '$name పేరు మార్చు';
  }

  @override
  String get renameMemberHint => 'ఈ పేరు ఈ కంపెనీలో మాత్రమే వాడబడుతుంది.';

  @override
  String get useOwnName => 'వారి స్వంత పేరు వాడు';

  @override
  String get scanQrCode => 'QR కోడ్ స్కాన్ చేయి';

  @override
  String get scanQrHint =>
      'వారి యాప్‌లో చూపిన QR కోడ్ వైపు కెమెరా పెట్టండి (ఖాతా మెనూ, “నా QR కోడ్”).';

  @override
  String get orEnterCode => 'లేదా వారి 6 అంకెల కోడ్ నమోదు చేయండి';

  @override
  String get qrInvalid => 'ఇది Staff Flow QR కోడ్ కాదు.';

  @override
  String cameraUnavailable(String error) {
    return 'కెమెరా అందుబాటులో లేదు ($error).';
  }

  @override
  String get notificationsTitle => 'నోటిఫికేషన్‌లు';

  @override
  String get notifChooseHint =>
      'ఏ విషయాలకు నోటిఫికేషన్‌లు రావాలో ఎంచుకోండి. అన్నీ గంటలో కనిపిస్తూనే ఉంటాయి.';

  @override
  String get notifPlanning => 'షెడ్యూల్ ప్రచురించబడింది లేదా మార్చబడింది';

  @override
  String get notifRequests => 'అభ్యర్థనలు: మార్పిడి, సెలవు, ఆహ్వానాలు';

  @override
  String get notifMessages => 'కొత్త సందేశాలు';

  @override
  String get notifOverlap => 'కంపెనీల మధ్య ఒకదానిపై ఒకటి వచ్చే షిఫ్టులు';

  @override
  String get notifConflicts => 'మరో మేనేజర్ మీ మార్పును భర్తీ చేశారు';

  @override
  String get notifBilling => 'సభ్యత్వ రిమైండర్‌లు';

  @override
  String get pushEnabled => 'ఈ పరికరంలో నోటిఫికేషన్‌లు ఆన్‌లో ఉన్నాయి.';

  @override
  String get pushOff => 'ఈ పరికరంలో నోటిఫికేషన్‌లు ఆఫ్‌లో ఉన్నాయి.';

  @override
  String get pushBlocked =>
      'నోటిఫికేషన్‌లు బ్లాక్ చేయబడ్డాయి: ఫోన్ లేదా బ్రౌజర్ సెట్టింగ్‌లలో అనుమతించండి.';

  @override
  String get pushUnavailable => 'ఈ పరికరంలో నోటిఫికేషన్‌లు అందుబాటులో లేవు.';

  @override
  String get enablePush => 'ఆన్ చేయి';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: మీ షెడ్యూల్ ప్రచురించబడింది లేదా మార్చబడింది.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company మిమ్మల్ని తమ టీమ్‌లో చేర్చాలనుకుంటోంది.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name మిమ్మల్ని $company యజమానిగా చేయాలని ప్రతిపాదిస్తున్నారు.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name $companyలో చేరారు.';
  }

  @override
  String get messagesTab => 'సందేశాలు';

  @override
  String get wholeTeam => 'మొత్తం టీమ్';

  @override
  String get newConversation => 'కొత్త సంభాషణ';

  @override
  String get noMessages => 'ఇంకా సందేశాలు లేవు.';

  @override
  String get messageHint => 'సందేశం రాయండి';

  @override
  String get earlierMessages => 'మునుపటి సందేశాలు';

  @override
  String get personLeftCompany => 'ఈ వ్యక్తి ఇక కంపెనీలో భాగం కాదు.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'కొత్త గ్రూప్';

  @override
  String get editGroup => 'గ్రూప్‌ను సవరించు';

  @override
  String get groupName => 'గ్రూప్ పేరు';

  @override
  String get groupMembersHint =>
      'ఈ గ్రూప్‌లోని వ్యక్తులను ఎంచుకోండి. వారు మాత్రమే దాని సందేశాలను చూస్తారు.';

  @override
  String get chooseAtLeastOne => 'కనీసం ఒకరిని ఎంచుకోండి.';

  @override
  String get replyAction => 'జవాబు';

  @override
  String get translateAction => 'అనువదించు';

  @override
  String replyingTo(String name) {
    return '$nameకు జవాబు';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name ఇటీవలి సందేశాలు';
  }

  @override
  String get deleteAllNotices => 'అన్నీ తొలగించు';

  @override
  String get deleteAllNoticesConfirm => 'అన్ని నోటిఫికేషన్‌లను తొలగించాలా?';

  @override
  String get noticeRetention => 'చదివిన నోటిఫికేషన్‌లను తొలగించే వ్యవధి';

  @override
  String get retentionDay => '1 రోజు';

  @override
  String get retentionWeek => '1 వారం';

  @override
  String get retentionMonth => '1 నెల';

  @override
  String get billingOwnersOnly => 'మీకు కంపెనీ ఉంటేనే సక్రియం.';

  @override
  String get readOnlyPastDays => 'ఒక నెల కంటే పాత రోజులు చదవడానికి మాత్రమే.';

  @override
  String get wholeCompany => 'మొత్తం కంపెనీ';

  @override
  String get sitesLabel => 'సైట్‌లు';

  @override
  String get actionSites => 'సైట్‌లు…';

  @override
  String managerOf(String name) {
    return '$name బాధ్యతలో';
  }

  @override
  String teamSitesOf(String name) {
    return '$name టీమ్';
  }

  @override
  String get notYourSite => 'ఈ సైట్ మీ బాధ్యతలో లేదు.';

  @override
  String get chooseYourSite => 'కనీసం ఒక సైట్‌ను ఎంచుకోండి.';

  @override
  String get viewRequests => 'అభ్యర్థనలు';

  @override
  String get newRequest => 'కొత్త అభ్యర్థన';

  @override
  String get requestLeave => 'సెలవు';

  @override
  String get requestUnavailability => 'అందుబాటులో లేకపోవడం';

  @override
  String get requestSwap => 'షిఫ్ట్ మార్పిడి';

  @override
  String get swapHint =>
      'మార్పిడిని ప్రతిపాదించడానికి, షెడ్యూల్‌లో మీ రాబోయే షిఫ్టుల్లో ఒకదాన్ని నొక్కండి.';

  @override
  String get noRequests => 'ఇంకా అభ్యర్థనలు లేవు.';

  @override
  String get requestsToHandle => 'చూడాల్సినవి';

  @override
  String get myRequests => 'నా అభ్యర్థనలు';

  @override
  String get otherRequests => 'బృందం అభ్యర్థనలు';

  @override
  String get statusPendingPeer => 'సహోద్యోగి కోసం వేచి ఉంది';

  @override
  String get statusPendingManager => 'మేనేజర్ కోసం వేచి ఉంది';

  @override
  String get statusApproved => 'ఆమోదించబడింది';

  @override
  String get statusRefused => 'తిరస్కరించబడింది';

  @override
  String get statusCancelled => 'రద్దు చేయబడింది';

  @override
  String get cancelRequest => 'అభ్యర్థనను రద్దు చేయి';

  @override
  String get acceptSwap => 'ఈ షిఫ్ట్ తీసుకో';

  @override
  String get approve => 'ఆమోదించు';

  @override
  String periodLabel(String from, String to) {
    return '$from నుండి $to వరకు';
  }

  @override
  String swapToPeer(String name) {
    return '$nameకి ప్రతిపాదించబడింది';
  }

  @override
  String get swapToTeam => 'మొత్తం బృందం';

  @override
  String everyWeekdays(String days) {
    return 'ప్రతి వారం: $days';
  }

  @override
  String get unavailableEveryWeek => 'మీరు ఎప్పుడూ అందుబాటులో లేని రోజులు:';

  @override
  String get choosePeriod => 'తేదీలను ఎంచుకోండి';

  @override
  String get choosePeriodOptional => 'ఒక వ్యవధికి పరిమితం చేయి (ఐచ్ఛికం)';

  @override
  String get clearPeriod => 'వ్యవధి లేదు';

  @override
  String get sendRequest => 'అభ్యర్థన పంపు';

  @override
  String get proposeSwap => 'మార్పిడిని ప్రతిపాదించు';

  @override
  String get swapWith => 'ప్రతిపాదించు';

  @override
  String get swapSteps =>
      'సహోద్యోగి అంగీకరిస్తారు, తర్వాత మేనేజర్ ఆమోదిస్తారు. ఆ తర్వాతే షెడ్యూల్ మారుతుంది.';

  @override
  String get absentThatDay => 'ఆ రోజు ఆమోదించిన గైర్హాజరు';

  @override
  String get requestSent => 'అభ్యర్థన పంపబడింది.';

  @override
  String noticeSwapOffer(String name) {
    return '$name తమ షిఫ్టుల్లో ఒకదాన్ని మీకు ఇవ్వాలనుకుంటున్నారు.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name మీ మార్పిడి ప్రతిపాదనను తిరస్కరించారు.';
  }

  @override
  String get noticeSwapToApprove =>
      'ఒక షిఫ్ట్ మార్పిడి మీ ఆమోదం కోసం వేచి ఉంది.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name సెలవు అడుగుతున్నారు.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name అందుబాటులో లేనని తెలిపారు.';
  }

  @override
  String get noticeRequestApproved => 'మీ అభ్యర్థన ఆమోదించబడింది.';

  @override
  String get noticeRequestRefused => 'మీ అభ్యర్థన తిరస్కరించబడింది.';

  @override
  String get choosePeer => 'ఈ షిఫ్ట్‌ను ఎవరు తీసుకుంటారు?';

  @override
  String get discardAll => 'అన్నీ రద్దు చేయి';

  @override
  String get notifySitesHint =>
      'అభ్యర్థన నోటిఫికేషన్లు రావాల్సిన స్థలాలను ఎంచుకోండి. అన్ని అభ్యర్థనలు జాబితాలో కనిపిస్తాయి.';

  @override
  String get notifySitesTitle => 'స్థలం వారీగా నోటిఫికేషన్లు';

  @override
  String get pendingRequestTooltip => 'పెండింగ్ అభ్యర్థన: తెరవడానికి నొక్కండి';

  @override
  String get requestsHistory => 'అన్ని అభ్యర్థనలు';

  @override
  String get revertChange => 'ఈ మార్పును రద్దు చేయి';

  @override
  String get statusExpired => 'ఇక వర్తించదు';

  @override
  String get swapWithHint => 'నిర్దిష్ట సహోద్యోగిని ఎంచుకోవడానికి నొక్కండి';

  @override
  String changesDiscarded(String count) {
    return 'రద్దు చేసిన మార్పులు: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'ప్రచురించని $count మార్పులను రద్దు చేయాలా?';
  }

  @override
  String get allSchedules => 'నా అన్ని షెడ్యూళ్లు';

  @override
  String get busyElsewhere => 'ఈ సమయంలో ఇప్పటికే వేరే కంపెనీలో పనిలో ఉన్నారు';

  @override
  String get overlapTooltip => 'వేరే కంపెనీ షిఫ్ట్‌తో ఢీకొంటుంది';

  @override
  String get overlapWarning =>
      'రెండు కంపెనీల్లో మీ కొన్ని షిఫ్టులు ఒకదానిపై ఒకటి పడుతున్నాయి.';

  @override
  String noticeOverlap(String date) {
    return '$dateన వేర్వేరు కంపెనీల్లో మీ రెండు షిఫ్టులు ఒకదానిపై ఒకటి పడుతున్నాయి.';
  }

  @override
  String get allMyCompanies => 'నా అన్ని కంపెనీలు';

  @override
  String get deleteGroup => 'సమూహాన్ని తొలగించు';

  @override
  String get openRequest => 'అభ్యర్థనను చూడు';

  @override
  String get thisCompany => 'ఈ కంపెనీ';

  @override
  String get withExtras => 'తాత్కాలిక సిబ్బందితో';

  @override
  String deleteGroupConfirm(String name) {
    return 'అందరికీ “$name” మరియు దాని అన్ని సందేశాలను తొలగించాలా?';
  }

  @override
  String reinforcementHint(String company) {
    return '$company నుండి: సహాయ సిబ్బందిగా చేర్చబడి తెలియజేయబడతారు.';
  }

  @override
  String get addToGoogle => 'Google Calendarకి జోడించు';

  @override
  String get calendarEnabled => 'నా షిఫ్టులను సింక్ చేయి';

  @override
  String get calendarHint =>
      'మీ అన్ని కంపెనీల షిఫ్టులను Google Calendarకి జోడించండి. అవి తామే అప్‌డేట్ అవుతాయి, ఎప్పుడైనా ఆపివేయవచ్చు.';

  @override
  String get changeSettings => 'మార్చు';

  @override
  String get copyCalendarLink => 'క్యాలెండర్ లింక్‌ను కాపీ చేయి';

  @override
  String get countryBelgium => 'బెల్జియం';

  @override
  String get countryCanada => 'కెనడా';

  @override
  String get countryFrance => 'ఫ్రాన్స్';

  @override
  String get countrySwitzerland => 'స్విట్జర్లాండ్';

  @override
  String get employeesSection => 'ఉద్యోగులు';

  @override
  String get emptyNoAlert => 'ఖాళీ: హెచ్చరిక లేదు';

  @override
  String get extrasSection => 'తాత్కాలిక సిబ్బంది';

  @override
  String get googleCalendar => 'Google Calendar';

  @override
  String get hoursTotals => 'గంటల మొత్తం';

  @override
  String get legalAlerts => 'చట్టపరమైన హెచ్చరికలు';

  @override
  String get legalAlertsHint =>
      'హెచ్చరికలు మాత్రమే, ఎప్పుడూ అడ్డుకోవు. మీకు వర్తించే నియమాలను ఎంచుకోండి, లేదా ఏదీ వద్దు.';

  @override
  String get legalPreset => 'దేశ నమూనా';

  @override
  String get linkCopied => 'లింక్ కాపీ అయింది.';

  @override
  String get maxConsecutiveLabel => 'వరుసగా గరిష్ఠ పని రోజులు';

  @override
  String get maxDayLabel => 'రోజుకు గరిష్ఠ వ్యవధి (గంటలు)';

  @override
  String get maxWeekLabel => 'వారానికి గరిష్ఠ వ్యవధి (గంటలు)';

  @override
  String get minRestLabel => 'రెండు షిఫ్టుల మధ్య కనీస విశ్రాంతి (గంటలు)';

  @override
  String get noLegalRules => 'ఏ హెచ్చరికనూ ఎంచుకోలేదు.';

  @override
  String get presetNone => 'ఏదీ లేదు';

  @override
  String get presetsCheck =>
      'నమూనాలు ప్రారంభ బిందువు మాత్రమే: మీ దేశ నియమాలు, సమష్టి ఒప్పందం ప్రకారం సరిచూసుకోండి.';

  @override
  String get printMine => 'నా షెడ్యూల్';

  @override
  String get printOwn => 'తమ స్వంత షెడ్యూల్ మాత్రమే';

  @override
  String get printPdf => 'ముద్రించు / PDF';

  @override
  String get printRights => 'ఉద్యోగులు ఏమి ముద్రించవచ్చు';

  @override
  String get printTeam => 'మొత్తం బృందం షెడ్యూల్';

  @override
  String get printTeamOption => 'బృందం షెడ్యూల్';

  @override
  String get totalsHint =>
      'డ్రాఫ్ట్‌లతో సహా. Excel, CSV ఎగుమతులు ప్రచురించిన షెడ్యూల్‌ను వాడతాయి.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: వరుసగా $value రోజులు (గరిష్ఠం $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: రోజులో $value (గరిష్ఠం $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: కేవలం $value విశ్రాంతి (కనీసం $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: వారంలో $value (గరిష్ఠం $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'చట్టపరమైన హెచ్చరికలు: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'షిఫ్టులు: $count';
  }
}
