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
}
