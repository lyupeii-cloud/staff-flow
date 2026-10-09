// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class L10nGu extends L10n {
  L10nGu([String locale = 'gu']) : super(locale);

  @override
  String get cancel => 'રદ કરો';

  @override
  String get save => 'સાચવો';

  @override
  String get confirm => 'પુષ્ટિ કરો';

  @override
  String get validate => 'પુષ્ટિ કરો';

  @override
  String get add => 'ઉમેરો';

  @override
  String get rename => 'નામ બદલો';

  @override
  String get delete => 'કાઢી નાખો';

  @override
  String get accept => 'સ્વીકારો';

  @override
  String get decline => 'નકારો';

  @override
  String get close => 'બંધ કરો';

  @override
  String get retry => 'ફરી પ્રયાસ કરો';

  @override
  String get name => 'નામ';

  @override
  String get serverUnreachable => 'સર્વર સુધી પહોંચી શકાતું નથી.';

  @override
  String errorStatus(int status) {
    return 'ભૂલ $status';
  }

  @override
  String get roleOwner => 'માલિક';

  @override
  String get roleManager => 'મેનેજર';

  @override
  String get roleEmployee => 'કર્મચારી';

  @override
  String get roleExtra => 'હંગામી કર્મચારી';

  @override
  String get taglineStart => 'તમારી ટીમનું શેડ્યૂલ, ';

  @override
  String get taglineEnd => 'દરેક જગ્યાએ.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Google વડે સાઇન ઇન કરો';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google સાઇન-ઇન ઉપલબ્ધ નથી: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google વડે સાઇન ઇન થઈ શક્યું નહીં: $detail';
  }

  @override
  String get newCompany => 'નવી કંપની';

  @override
  String get timezone => 'સમય ઝોન';

  @override
  String get create => 'બનાવો';

  @override
  String get noCompanyTitle => 'તમે હજી કોઈ કંપનીમાં નથી.';

  @override
  String get noCompanyHint =>
      'તમારા નોકરીદાતાની કંપનીમાં જોડાવા માટે કોડ બનાવો અને તમારા મેનેજરને આપો.';

  @override
  String get joinCompany => 'કંપનીમાં જોડાઓ';

  @override
  String get createCompany => 'કંપની બનાવો';

  @override
  String transferOffer(String company) {
    return 'તમને “$company” ના માલિક બનવાની ઓફર મળી છે.';
  }

  @override
  String get someCompany => 'એક કંપની';

  @override
  String get becameOwner => 'હવે તમે માલિક છો.';

  @override
  String get myAccount => 'મારું ખાતું';

  @override
  String get idCopied => 'ઓળખ નકલ થઈ.';

  @override
  String myId(String id) {
    return 'મારી ઓળખ: $id';
  }

  @override
  String get signOut => 'સાઇન આઉટ';

  @override
  String joinInvite(String company, String role) {
    return '“$company” તમને $role તરીકે આમંત્રણ આપે છે.';
  }

  @override
  String joinedCompany(String company) {
    return 'તમે $companyમાં જોડાયા.';
  }

  @override
  String get viewPlanning => 'શેડ્યૂલ';

  @override
  String get viewTeam => 'ટીમ';

  @override
  String get viewPositions => 'હોદ્દા';

  @override
  String get readOnlyCompany => 'આ કંપની ફક્ત જોવા માટે છે.';

  @override
  String get team => 'ટીમ';

  @override
  String get leaveCompany => 'આ કંપની છોડો';

  @override
  String meSuffix(String name) {
    return '$name (તમે)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'કંપની $nameને સોંપવી છે?';
  }

  @override
  String get transferConfirmBody =>
      'સ્વીકાર્યા પછી તે માલિક બનશે (સબ્સ્ક્રિપ્શન, બિલ, મેનેજર) અને તમે મેનેજર બનશો.';

  @override
  String transferSent(String name) {
    return '$nameને ઓફર મોકલી.';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$nameને દૂર કરવા છે?';
  }

  @override
  String get removeConfirmBody => 'ઇતિહાસ સચવાઈ રહેશે.';

  @override
  String get addPersonTitle => 'વ્યક્તિ ઉમેરો';

  @override
  String get addPersonHint =>
      'તેમને Staff Flow ખોલીને ખાતા મેનૂમાં “કંપનીમાં જોડાઓ” પસંદ કરવા કહો, પછી દેખાતો કોડ દાખલ કરો.';

  @override
  String get sixDigitCode => '6 અંકનો કોડ';

  @override
  String invitationSent(String name) {
    return '$nameને આમંત્રણ મોકલ્યું: તેમણે સ્વીકારવું પડશે.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company છોડવી છે?';
  }

  @override
  String get leaveConfirmBody => 'તમે તેનું શેડ્યૂલ હવે જોઈ શકશો નહીં.';

  @override
  String get renameCompany => 'કંપનીનું નામ બદલો';

  @override
  String get actionMakeManager => 'મેનેજર બનાવો';

  @override
  String get actionMakeEmployee => 'ફરી કર્મચારી બનાવો';

  @override
  String get actionToEmployee => 'કર્મચારી બનાવો';

  @override
  String get actionToExtra => 'હંગામી બનાવો';

  @override
  String get actionTransfer => 'માલિકી સોંપો';

  @override
  String get actionRemove => 'કંપનીમાંથી દૂર કરો';

  @override
  String get positions => 'હોદ્દા';

  @override
  String get sites => 'સ્થળો';

  @override
  String get positionsHint => 'વ્યક્તિ શું કરે છે: કેશ, રસોડું, રિસેપ્શન…';

  @override
  String get sitesHint => 'કંપનીના અનેક સ્થળો હોય તો શિફ્ટ ક્યાં છે.';

  @override
  String get archived => 'આર્કાઇવ કરેલું';

  @override
  String get archive => 'આર્કાઇવ કરો';

  @override
  String get reactivate => 'ફરી સક્રિય કરો';

  @override
  String weekOf(String date) {
    return '$dateનું અઠવાડિયું';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ફેરફારો પ્રકાશિત થયા.',
      one: '1 ફેરફાર પ્રકાશિત થયો.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'શિફ્ટ';

  @override
  String get display => 'દૃશ્ય';

  @override
  String get week => 'અઠવાડિયું';

  @override
  String get month => 'મહિનો';

  @override
  String get today => 'આજે';

  @override
  String get onlyMine => 'ફક્ત મારી શિફ્ટ';

  @override
  String get replacePersonMenu => 'વ્યક્તિ બદલો…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count અપ્રકાશિત ફેરફારો',
      one: '1 અપ્રકાશિત ફેરફાર',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'કર્મચારીઓ હજી આ જોઈ શકતા નથી.';

  @override
  String get publish => 'પ્રકાશિત કરો';

  @override
  String yourHours(String duration) {
    return 'આ સમયગાળામાં તમારા કલાક: $duration';
  }

  @override
  String get addShiftThisDay => 'આ દિવસે શિફ્ટ ઉમેરો';

  @override
  String get noShift => 'કોઈ શિફ્ટ નથી';

  @override
  String get unassigned => 'કોઈને સોંપાયેલ નથી';

  @override
  String get formerMember => 'ભૂતપૂર્વ સભ્ય';

  @override
  String get statusDraft => 'ડ્રાફ્ટ';

  @override
  String get statusModified => 'બદલાયેલ';

  @override
  String get statusDeleted => 'કાઢી નાખેલ';

  @override
  String durationHours(int hours) {
    return '$hours કલાક';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours કલાક $minutes મિ.';
  }

  @override
  String get editShift => 'શિફ્ટમાં ફેરફાર કરો';

  @override
  String get newShift => 'નવી શિફ્ટ';

  @override
  String get thisShift => 'ફક્ત આ શિફ્ટ';

  @override
  String get thisAndFollowing => 'આ અને પછીની';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'દિવસો',
      one: 'દિવસ',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'બીજો દિવસ';

  @override
  String get start => 'શરૂઆત';

  @override
  String get end => 'અંત';

  @override
  String get endsNextDay => 'બીજા દિવસે પૂરી થાય છે.';

  @override
  String get person => 'વ્યક્તિ';

  @override
  String get position => 'હોદ્દો';

  @override
  String get site => 'સ્થળ';

  @override
  String get noteOptional => 'નોંધ (વૈકલ્પિક)';

  @override
  String get repetition => 'પુનરાવર્તન';

  @override
  String get repeatNone => 'કોઈ નહીં';

  @override
  String get repeatDaily => 'દરરોજ';

  @override
  String get repeatWeekly => 'દર અઠવાડિયે';

  @override
  String get repeatForPrefix => 'સમયગાળો ';

  @override
  String get repeatDaysSuffix => ' દિવસ';

  @override
  String get repeatWeeksSuffix => ' અઠવાડિયા';

  @override
  String get repeatUntilPrefix => 'સુધી ';

  @override
  String get replacePersonTitle => 'વ્યક્તિ બદલો';

  @override
  String get replaceFrom => 'કોને બદલવા';

  @override
  String get replaceBy => 'કોનાથી';

  @override
  String dateRange(String from, String to) {
    return '$from થી $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count શિફ્ટ બદલાઈ.',
      one: '1 શિફ્ટ બદલાઈ.',
      zero: 'કોઈ શિફ્ટ બદલાઈ નથી.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'બદલો';

  @override
  String get joinHint =>
      'આ કોડ તમારા મેનેજરને આપો. તેઓ એપમાં દાખલ કરશે, પછી તમને આમંત્રણ મળશે.';

  @override
  String get codeExpired => 'કોડની મુદત પૂરી થઈ.';

  @override
  String codeValidFor(String time) {
    return 'હજી $time માન્ય';
  }

  @override
  String get newCode => 'નવો કોડ';

  @override
  String get language => 'ભાષા';

  @override
  String get languageAuto => 'આપમેળે (ઉપકરણની ભાષા)';

  @override
  String get syncUpToDate => 'અપડેટ છે';

  @override
  String get syncOffline => 'ઑફલાઇન';

  @override
  String syncPending(int count) {
    return 'બાકી ફેરફારો: $count';
  }

  @override
  String get syncNow => 'હમણાં સિંક કરો';

  @override
  String syncRejected(String reason) {
    return 'સર્વરે ફેરફાર નકાર્યો: $reason';
  }

  @override
  String get pendingBadge => 'બાકી';

  @override
  String get offlineUnavailable => 'ઑફલાઇન ઉપલબ્ધ નથી.';

  @override
  String get offlineCached => 'ઑફલાઇન: છેલ્લો સાચવેલો ડેટા.';

  @override
  String get savedOffline => 'ઉપકરણ પર સાચવ્યું, નેટવર્ક આવ્યે મોકલાશે.';

  @override
  String get notices => 'સૂચનાઓ';

  @override
  String get noNotices => 'કોઈ સૂચના નથી.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$nameએ $dateની શિફ્ટમાં તમારો ફેરફાર બદલી નાખ્યો.';
  }

  @override
  String get history => 'ઇતિહાસ';

  @override
  String get recentChanges => 'તાજેતરના ફેરફારો';

  @override
  String get undoChange => 'આ ફેરફાર પાછો લો';

  @override
  String get undoDone => 'ફેરફાર પાછો લીધો.';

  @override
  String get historyCreate => 'બનાવ્યું';

  @override
  String get historyUpdate => 'બદલ્યું';

  @override
  String get historyDelete => 'કાઢી નાખ્યું';

  @override
  String get historyUndo => 'પાછું લીધું';

  @override
  String get noHistory => 'કોઈ ફેરફાર નથી.';

  @override
  String get pendingNotEditable =>
      'આ શિફ્ટ હજી સિંક થઈ નથી: ઑનલાઇન હો ત્યારે ફરી પ્રયાસ કરો.';

  @override
  String get myQrCode => 'મારો QR કોડ';

  @override
  String get myQrCodeHint =>
      'મેનેજર આ કોડ સ્કેન કરીને તમને તેમની કંપનીમાં ઉમેરે છે; પછી તમે પુષ્ટિ કરો છો. તે ક્યારેય બદલાતો નથી.';

  @override
  String get changeMyName => 'મારું નામ બદલો';

  @override
  String get nameShownToTeam =>
      'તમારા સહકર્મીઓને તમારા Google નામને બદલે આ નામ દેખાશે.';

  @override
  String googleName(String name) {
    return 'Google નામ: $name';
  }

  @override
  String get useGoogleName => 'મારું Google નામ વાપરો';

  @override
  String renameMemberTitle(String name) {
    return '$name નું નામ બદલો';
  }

  @override
  String get renameMemberHint => 'આ નામ ફક્ત આ કંપનીમાં વપરાય છે.';

  @override
  String get useOwnName => 'તેમનું પોતાનું નામ વાપરો';

  @override
  String get scanQrCode => 'QR કોડ સ્કેન કરો';

  @override
  String get scanQrHint =>
      'તેમની એપમાં દેખાતા QR કોડ તરફ કેમેરા રાખો (એકાઉન્ટ મેનૂ, “મારો QR કોડ”).';

  @override
  String get orEnterCode => 'અથવા તેમનો 6 અંકનો કોડ દાખલ કરો';

  @override
  String get qrInvalid => 'આ Staff Flow QR કોડ નથી.';

  @override
  String cameraUnavailable(String error) {
    return 'કેમેરા ઉપલબ્ધ નથી ($error).';
  }

  @override
  String get notificationsTitle => 'સૂચનાઓ';

  @override
  String get notifChooseHint =>
      'કઈ બાબતની સૂચના મળે તે પસંદ કરો. બધું ઘંટડીમાં દેખાતું રહેશે.';

  @override
  String get notifPlanning => 'સમયપત્રક પ્રકાશિત અથવા બદલાયું';

  @override
  String get notifRequests => 'વિનંતીઓ: અદલાબદલી, રજા, આમંત્રણો';

  @override
  String get notifMessages => 'નવા સંદેશા';

  @override
  String get notifOverlap => 'કંપનીઓ વચ્ચે એકબીજા પર આવતી શિફ્ટ';

  @override
  String get notifConflicts => 'બીજા મેનેજરે તમારો ફેરફાર બદલ્યો';

  @override
  String get notifBilling => 'સબ્સ્ક્રિપ્શન રિમાઇન્ડર';

  @override
  String get pushEnabled => 'આ ઉપકરણ પર સૂચનાઓ ચાલુ છે.';

  @override
  String get pushOff => 'આ ઉપકરણ પર સૂચનાઓ બંધ છે.';

  @override
  String get pushBlocked =>
      'સૂચનાઓ અવરોધિત છે: ફોન અથવા બ્રાઉઝરના સેટિંગ્સમાં મંજૂરી આપો.';

  @override
  String get pushUnavailable => 'આ ઉપકરણ પર સૂચનાઓ ઉપલબ્ધ નથી.';

  @override
  String get enablePush => 'ચાલુ કરો';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: તમારું સમયપત્રક પ્રકાશિત થયું છે અથવા બદલાયું છે.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company તમને તેની ટીમમાં ઉમેરવા માંગે છે.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name તમને $company ના માલિક બનવાનો પ્રસ્તાવ આપે છે.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name $company માં જોડાયા.';
  }

  @override
  String get messagesTab => 'સંદેશા';

  @override
  String get wholeTeam => 'આખી ટીમ';

  @override
  String get newConversation => 'નવી વાતચીત';

  @override
  String get noMessages => 'હજુ કોઈ સંદેશો નથી.';

  @override
  String get messageHint => 'સંદેશો લખો';

  @override
  String get earlierMessages => 'અગાઉના સંદેશા';

  @override
  String get personLeftCompany => 'આ વ્યક્તિ હવે કંપનીનો ભાગ નથી.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'નવું જૂથ';

  @override
  String get editGroup => 'જૂથ સંપાદિત કરો';

  @override
  String get groupName => 'જૂથનું નામ';

  @override
  String get groupMembersHint =>
      'આ જૂથના લોકો પસંદ કરો. ફક્ત તેઓ જ તેના સંદેશા જોશે.';

  @override
  String get chooseAtLeastOne => 'ઓછામાં ઓછી એક વ્યક્તિ પસંદ કરો.';

  @override
  String get replyAction => 'જવાબ આપો';

  @override
  String get translateAction => 'અનુવાદ કરો';

  @override
  String replyingTo(String name) {
    return '$name ને જવાબ';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name ના તાજેતરના સંદેશા';
  }

  @override
  String get deleteAllNotices => 'બધું કાઢી નાખો';

  @override
  String get deleteAllNoticesConfirm => 'બધી સૂચનાઓ કાઢી નાખવી?';

  @override
  String get noticeRetention => 'વાંચેલી સૂચનાઓ આટલા સમય પછી કાઢો';

  @override
  String get retentionDay => '1 દિવસ';

  @override
  String get retentionWeek => '1 અઠવાડિયું';

  @override
  String get retentionMonth => '1 મહિનો';

  @override
  String get billingOwnersOnly =>
      'ફક્ત તમારી માલિકીની કંપની હોય ત્યારે જ સક્રિય.';

  @override
  String get readOnlyPastDays => 'એક મહિનાથી જૂના દિવસો ફક્ત જોઈ શકાય છે.';

  @override
  String get wholeCompany => 'આખી કંપની';

  @override
  String get sitesLabel => 'સાઇટ્સ';

  @override
  String get actionSites => 'સાઇટ્સ…';

  @override
  String managerOf(String name) {
    return '$name ની જવાબદારી';
  }

  @override
  String teamSitesOf(String name) {
    return '$name ની ટીમ';
  }

  @override
  String get notYourSite => 'આ સાઇટ તમારી જવાબદારીમાં નથી.';

  @override
  String get chooseYourSite => 'ઓછામાં ઓછી એક સાઇટ પસંદ કરો.';

  @override
  String get viewRequests => 'વિનંતીઓ';

  @override
  String get newRequest => 'નવી વિનંતી';

  @override
  String get requestLeave => 'રજા';

  @override
  String get requestUnavailability => 'અનુપલબ્ધતા';

  @override
  String get requestSwap => 'શિફ્ટ અદલાબદલી';

  @override
  String get swapHint =>
      'અદલાબદલી સૂચવવા માટે, સમયપત્રકમાં તમારી આગામી શિફ્ટ પર ટૅપ કરો.';

  @override
  String get noRequests => 'હજી કોઈ વિનંતી નથી.';

  @override
  String get requestsToHandle => 'સંભાળવાની';

  @override
  String get myRequests => 'મારી વિનંતીઓ';

  @override
  String get otherRequests => 'ટીમની વિનંતીઓ';

  @override
  String get statusPendingPeer => 'સહકર્મીની રાહ';

  @override
  String get statusPendingManager => 'મેનેજરની રાહ';

  @override
  String get statusApproved => 'મંજૂર';

  @override
  String get statusRefused => 'નકારાઈ';

  @override
  String get statusCancelled => 'રદ';

  @override
  String get cancelRequest => 'વિનંતી રદ કરો';

  @override
  String get acceptSwap => 'આ શિફ્ટ લો';

  @override
  String get approve => 'મંજૂર કરો';

  @override
  String periodLabel(String from, String to) {
    return '$from થી $to';
  }

  @override
  String swapToPeer(String name) {
    return '$name ને સૂચવ્યું';
  }

  @override
  String get swapToTeam => 'આખી ટીમ';

  @override
  String everyWeekdays(String days) {
    return 'દર અઠવાડિયે: $days';
  }

  @override
  String get unavailableEveryWeek => 'જે દિવસોમાં તમે ક્યારેય ઉપલબ્ધ નથી:';

  @override
  String get choosePeriod => 'તારીખો પસંદ કરો';

  @override
  String get choosePeriodOptional => 'સમયગાળા સુધી મર્યાદિત કરો (વૈકલ્પિક)';

  @override
  String get clearPeriod => 'કોઈ સમયગાળો નહીં';

  @override
  String get sendRequest => 'વિનંતી મોકલો';

  @override
  String get proposeSwap => 'અદલાબદલી સૂચવો';

  @override
  String get swapWith => 'સૂચવો';

  @override
  String get swapSteps =>
      'સહકર્મી સ્વીકારે છે, પછી મેનેજર મંજૂર કરે છે. ત્યાર પછી જ સમયપત્રક બદલાય છે.';

  @override
  String get absentThatDay => 'તે દિવસે મંજૂર ગેરહાજરી';

  @override
  String get requestSent => 'વિનંતી મોકલાઈ.';

  @override
  String noticeSwapOffer(String name) {
    return '$name તમને તેમની એક શિફ્ટ આપવા માંગે છે.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name એ તમારો અદલાબદલીનો પ્રસ્તાવ નકાર્યો.';
  }

  @override
  String get noticeSwapToApprove =>
      'એક શિફ્ટ અદલાબદલી તમારી મંજૂરીની રાહ જુએ છે.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name રજા માંગે છે.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name એ અનુપલબ્ધતા જણાવી છે.';
  }

  @override
  String get noticeRequestApproved => 'તમારી વિનંતી મંજૂર થઈ.';

  @override
  String get noticeRequestRefused => 'તમારી વિનંતી નકારાઈ.';

  @override
  String get choosePeer => 'આ શિફ્ટ કોણ લેશે?';

  @override
  String get discardAll => 'બધું રદ કરો';

  @override
  String get notifySitesHint =>
      'જે સ્થળોની વિનંતીઓની સૂચનાઓ જોઈએ તે પસંદ કરો. બધી વિનંતીઓ યાદીમાં દેખાતી રહેશે.';

  @override
  String get notifySitesTitle => 'સ્થળ પ્રમાણે સૂચનાઓ';

  @override
  String get pendingRequestTooltip => 'બાકી વિનંતી: ખોલવા ટૅપ કરો';

  @override
  String get requestsHistory => 'બધી વિનંતીઓ';

  @override
  String get revertChange => 'આ ફેરફાર રદ કરો';

  @override
  String get statusExpired => 'હવે લાગુ નથી';

  @override
  String get swapWithHint => 'ચોક્કસ સહકર્મી પસંદ કરવા ટૅપ કરો';

  @override
  String changesDiscarded(String count) {
    return 'રદ કરેલા ફેરફારો: $count';
  }

  @override
  String discardConfirm(String count) {
    return '$count અપ્રકાશિત ફેરફારો રદ કરવા છે?';
  }

  @override
  String get allSchedules => 'મારાં બધાં સમયપત્રક';

  @override
  String get busyElsewhere => 'આ સમયે પહેલેથી બીજી કંપનીમાં ફરજ પર';

  @override
  String get overlapTooltip => 'બીજી કંપનીની શિફ્ટ સાથે ટકરાય છે';

  @override
  String get overlapWarning =>
      'બે કંપનીઓમાં તમારી કેટલીક શિફ્ટ એકબીજા પર આવે છે.';

  @override
  String noticeOverlap(String date) {
    return '$date ના રોજ અલગ કંપનીઓમાં તમારી બે શિફ્ટ એકબીજા પર આવે છે.';
  }

  @override
  String get allMyCompanies => 'મારી બધી કંપનીઓ';

  @override
  String get deleteGroup => 'જૂથ કાઢી નાખો';

  @override
  String get openRequest => 'વિનંતી જુઓ';

  @override
  String get thisCompany => 'આ કંપની';

  @override
  String get withExtras => 'હંગામી કર્મચારીઓ સહિત';

  @override
  String deleteGroupConfirm(String name) {
    return 'બધા માટે “$name” અને તેના બધા સંદેશા કાઢી નાખવા છે?';
  }

  @override
  String reinforcementHint(String company) {
    return '$company માંથી: મદદનીશ તરીકે ઉમેરાશે અને જાણ કરાશે.';
  }

  @override
  String get addToGoogle => 'Google કૅલેન્ડરમાં ઉમેરો';

  @override
  String get calendarEnabled => 'મારી શિફ્ટ સિંક કરો';

  @override
  String get calendarHint =>
      'તમારી બધી કંપનીઓની શિફ્ટ Google કૅલેન્ડરમાં ઉમેરો. તે આપમેળે અપડેટ થાય છે, અને તમે ક્યારેય પણ બંધ કરી શકો છો.';

  @override
  String get changeSettings => 'બદલો';

  @override
  String get copyCalendarLink => 'કૅલેન્ડરની લિંક કૉપિ કરો';

  @override
  String get countryBelgium => 'બેલ્જિયમ';

  @override
  String get countryCanada => 'કૅનેડા';

  @override
  String get countryFrance => 'ફ્રાન્સ';

  @override
  String get countrySwitzerland => 'સ્વિટ્ઝર્લૅન્ડ';

  @override
  String get employeesSection => 'કર્મચારીઓ';

  @override
  String get emptyNoAlert => 'ખાલી: કોઈ ચેતવણી નહીં';

  @override
  String get extrasSection => 'હંગામી કર્મચારીઓ';

  @override
  String get googleCalendar => 'Google કૅલેન્ડર';

  @override
  String get hoursTotals => 'કલાકોનો સરવાળો';

  @override
  String get legalAlerts => 'કાનૂની ચેતવણીઓ';

  @override
  String get legalAlertsHint =>
      'ફક્ત ચેતવણીઓ, ક્યારેય અવરોધ નહીં. તમને લાગુ પડતા નિયમો પસંદ કરો, અથવા કોઈ નહીં.';

  @override
  String get legalPreset => 'દેશનો નમૂનો';

  @override
  String get linkCopied => 'લિંક કૉપિ થઈ.';

  @override
  String get maxConsecutiveLabel => 'સળંગ કામના વધુમાં વધુ દિવસો';

  @override
  String get maxDayLabel => 'દિવસ દીઠ વધુમાં વધુ સમય (કલાક)';

  @override
  String get maxWeekLabel => 'અઠવાડિયા દીઠ વધુમાં વધુ સમય (કલાક)';

  @override
  String get minRestLabel => 'બે શિફ્ટ વચ્ચે ઓછામાં ઓછો આરામ (કલાક)';

  @override
  String get noLegalRules => 'કોઈ ચેતવણી પસંદ નથી.';

  @override
  String get presetNone => 'કોઈ નહીં';

  @override
  String get presetsCheck =>
      'નમૂના ફક્ત શરૂઆત છે: તમારા દેશના નિયમો અને સામૂહિક કરાર મુજબ ચકાસો.';

  @override
  String get printMine => 'મારું સમયપત્રક';

  @override
  String get printOwn => 'ફક્ત પોતાનું સમયપત્રક';

  @override
  String get printPdf => 'પ્રિન્ટ / PDF';

  @override
  String get printRights => 'કર્મચારીઓ શું પ્રિન્ટ કરી શકે';

  @override
  String get printTeam => 'આખી ટીમનું સમયપત્રક';

  @override
  String get printTeamOption => 'ટીમનું સમયપત્રક';

  @override
  String get totalsHint =>
      'ડ્રાફ્ટ સહિત. Excel અને CSV નિકાસ પ્રકાશિત સમયપત્રક વાપરે છે.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: સળંગ $value દિવસ (મહત્તમ $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: દિવસમાં $value (મહત્તમ $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: ફક્ત $value આરામ (ન્યૂનતમ $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: અઠવાડિયામાં $value (મહત્તમ $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'કાનૂની ચેતવણીઓ: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'શિફ્ટ: $count';
  }
}
