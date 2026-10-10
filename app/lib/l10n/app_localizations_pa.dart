// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class L10nPa extends L10n {
  L10nPa([String locale = 'pa']) : super(locale);

  @override
  String get cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get save => 'ਸੰਭਾਲੋ';

  @override
  String get confirm => 'ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get validate => 'ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get add => 'ਸ਼ਾਮਲ ਕਰੋ';

  @override
  String get rename => 'ਨਾਮ ਬਦਲੋ';

  @override
  String get delete => 'ਮਿਟਾਓ';

  @override
  String get accept => 'ਸਵੀਕਾਰ ਕਰੋ';

  @override
  String get decline => 'ਅਸਵੀਕਾਰ ਕਰੋ';

  @override
  String get close => 'ਬੰਦ ਕਰੋ';

  @override
  String get retry => 'ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get name => 'ਨਾਮ';

  @override
  String get serverUnreachable => 'ਸਰਵਰ ਨਾਲ ਸੰਪਰਕ ਨਹੀਂ ਹੋ ਰਿਹਾ।';

  @override
  String errorStatus(int status) {
    return 'ਗਲਤੀ $status';
  }

  @override
  String get roleOwner => 'ਮਾਲਕ';

  @override
  String get roleManager => 'ਮੈਨੇਜਰ';

  @override
  String get roleEmployee => 'ਕਰਮਚਾਰੀ';

  @override
  String get roleExtra => 'ਆਰਜ਼ੀ ਕਰਮਚਾਰੀ';

  @override
  String get taglineStart => 'ਤੁਹਾਡੀ ਟੀਮ ਦੀਆਂ ਸ਼ਿਫ਼ਟਾਂ, ';

  @override
  String get taglineEnd => 'ਹਰ ਥਾਂ।';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Google ਨਾਲ ਸਾਈਨ ਇਨ ਕਰੋ';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google ਸਾਈਨ-ਇਨ ਉਪਲਬਧ ਨਹੀਂ: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google ਨਾਲ ਸਾਈਨ ਇਨ ਨਹੀਂ ਹੋ ਸਕਿਆ: $detail';
  }

  @override
  String get newCompany => 'ਨਵੀਂ ਕੰਪਨੀ';

  @override
  String get timezone => 'ਸਮਾਂ ਖੇਤਰ';

  @override
  String get create => 'ਬਣਾਓ';

  @override
  String get noCompanyTitle => 'ਤੁਸੀਂ ਅਜੇ ਕਿਸੇ ਕੰਪਨੀ ਵਿੱਚ ਨਹੀਂ ਹੋ।';

  @override
  String get noCompanyHint =>
      'ਆਪਣੇ ਮਾਲਕ ਦੀ ਕੰਪਨੀ ਵਿੱਚ ਸ਼ਾਮਲ ਹੋਣ ਲਈ ਇੱਕ ਕੋਡ ਬਣਾਓ ਅਤੇ ਆਪਣੇ ਮੈਨੇਜਰ ਨੂੰ ਦਿਓ।';

  @override
  String get joinCompany => 'ਕੰਪਨੀ ਵਿੱਚ ਸ਼ਾਮਲ ਹੋਵੋ';

  @override
  String get createCompany => 'ਕੰਪਨੀ ਬਣਾਓ';

  @override
  String transferOffer(String company) {
    return 'ਤੁਹਾਨੂੰ “$company” ਦਾ ਮਾਲਕ ਬਣਨ ਦੀ ਪੇਸ਼ਕਸ਼ ਮਿਲੀ ਹੈ।';
  }

  @override
  String get someCompany => 'ਇੱਕ ਕੰਪਨੀ';

  @override
  String get becameOwner => 'ਹੁਣ ਤੁਸੀਂ ਮਾਲਕ ਹੋ।';

  @override
  String get myAccount => 'ਮੇਰਾ ਖਾਤਾ';

  @override
  String get idCopied => 'ਪਛਾਣ ਕਾਪੀ ਹੋ ਗਈ।';

  @override
  String myId(String id) {
    return 'ਮੇਰੀ ਪਛਾਣ: $id';
  }

  @override
  String get signOut => 'ਸਾਈਨ ਆਊਟ';

  @override
  String joinInvite(String company, String role) {
    return '“$company” ਨੇ ਤੁਹਾਨੂੰ $role ਵਜੋਂ ਸੱਦਾ ਦਿੱਤਾ ਹੈ।';
  }

  @override
  String joinedCompany(String company) {
    return 'ਤੁਸੀਂ $company ਵਿੱਚ ਸ਼ਾਮਲ ਹੋ ਗਏ।';
  }

  @override
  String get viewPlanning => 'ਸ਼ਡਿਊਲ';

  @override
  String get viewTeam => 'ਪ੍ਰਬੰਧਨ';

  @override
  String get viewPositions => 'ਅਹੁਦੇ';

  @override
  String get readOnlyCompany => 'ਇਹ ਕੰਪਨੀ ਸਿਰਫ਼ ਦੇਖਣ ਲਈ ਹੈ।';

  @override
  String get team => 'ਟੀਮ';

  @override
  String get leaveCompany => 'ਇਹ ਕੰਪਨੀ ਛੱਡੋ';

  @override
  String meSuffix(String name) {
    return '$name (ਤੁਸੀਂ)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'ਕੰਪਨੀ $name ਨੂੰ ਸੌਂਪਣੀ ਹੈ?';
  }

  @override
  String get transferConfirmBody =>
      'ਸਵੀਕਾਰ ਕਰਨ ਤੋਂ ਬਾਅਦ ਉਹ ਮਾਲਕ ਬਣ ਜਾਣਗੇ (ਗਾਹਕੀ, ਬਿੱਲ, ਮੈਨੇਜਰ) ਅਤੇ ਤੁਸੀਂ ਮੈਨੇਜਰ ਬਣ ਜਾਓਗੇ।';

  @override
  String transferSent(String name) {
    return '$name ਨੂੰ ਪੇਸ਼ਕਸ਼ ਭੇਜੀ ਗਈ।';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$name ਨੂੰ ਹਟਾਉਣਾ ਹੈ?';
  }

  @override
  String get removeConfirmBody => 'ਇਤਿਹਾਸ ਸੰਭਾਲਿਆ ਰਹੇਗਾ।';

  @override
  String get addPersonTitle => 'ਵਿਅਕਤੀ ਸ਼ਾਮਲ ਕਰੋ';

  @override
  String get addPersonHint =>
      'ਉਨ੍ਹਾਂ ਨੂੰ Staff Flow ਖੋਲ੍ਹ ਕੇ ਖਾਤਾ ਮੀਨੂ ਵਿੱਚ “ਕੰਪਨੀ ਵਿੱਚ ਸ਼ਾਮਲ ਹੋਵੋ” ਚੁਣਨ ਲਈ ਕਹੋ, ਫਿਰ ਦਿਖਾਇਆ ਕੋਡ ਦਰਜ ਕਰੋ।';

  @override
  String get sixDigitCode => '6 ਅੰਕਾਂ ਦਾ ਕੋਡ';

  @override
  String invitationSent(String name) {
    return '$name ਨੂੰ ਸੱਦਾ ਭੇਜਿਆ ਗਿਆ: ਉਨ੍ਹਾਂ ਨੂੰ ਇਸਨੂੰ ਸਵੀਕਾਰ ਕਰਨਾ ਪਵੇਗਾ।';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company ਛੱਡਣੀ ਹੈ?';
  }

  @override
  String get leaveConfirmBody => 'ਤੁਸੀਂ ਇਸਦਾ ਸ਼ਡਿਊਲ ਹੋਰ ਨਹੀਂ ਦੇਖ ਸਕੋਗੇ।';

  @override
  String get renameCompany => 'ਕੰਪਨੀ ਦਾ ਨਾਮ ਬਦਲੋ';

  @override
  String get actionMakeManager => 'ਮੈਨੇਜਰ ਬਣਾਓ';

  @override
  String get actionMakeEmployee => 'ਮੁੜ ਕਰਮਚਾਰੀ ਬਣਾਓ';

  @override
  String get actionToEmployee => 'ਕਰਮਚਾਰੀ ਬਣਾਓ';

  @override
  String get actionToExtra => 'ਆਰਜ਼ੀ ਕਰਮਚਾਰੀ ਬਣਾਓ';

  @override
  String get actionTransfer => 'ਮਾਲਕੀ ਸੌਂਪੋ';

  @override
  String get actionRemove => 'ਕੰਪਨੀ ਤੋਂ ਹਟਾਓ';

  @override
  String get positions => 'ਅਹੁਦੇ';

  @override
  String get sites => 'ਥਾਵਾਂ';

  @override
  String get positionsHint => 'ਵਿਅਕਤੀ ਕੀ ਕਰਦਾ ਹੈ: ਕੈਸ਼, ਰਸੋਈ, ਰਿਸੈਪਸ਼ਨ…';

  @override
  String get sitesHint => 'ਜੇ ਕੰਪਨੀ ਦੀਆਂ ਕਈ ਥਾਵਾਂ ਹਨ ਤਾਂ ਸ਼ਿਫ਼ਟ ਕਿੱਥੇ ਹੈ।';

  @override
  String get archived => 'ਪੁਰਾਲੇਖ ਵਿੱਚ';

  @override
  String get archive => 'ਪੁਰਾਲੇਖ ਕਰੋ';

  @override
  String get reactivate => 'ਮੁੜ ਚਾਲੂ ਕਰੋ';

  @override
  String weekOf(String date) {
    return '$date ਵਾਲਾ ਹਫ਼ਤਾ';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਤਬਦੀਲੀਆਂ ਪ੍ਰਕਾਸ਼ਿਤ ਹੋਈਆਂ।',
      one: '1 ਤਬਦੀਲੀ ਪ੍ਰਕਾਸ਼ਿਤ ਹੋਈ।',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'ਸ਼ਿਫ਼ਟ';

  @override
  String get display => 'ਦ੍ਰਿਸ਼';

  @override
  String get week => 'ਹਫ਼ਤਾ';

  @override
  String get month => 'ਮਹੀਨਾ';

  @override
  String get today => 'ਅੱਜ';

  @override
  String get onlyMine => 'ਸਿਰਫ਼ ਮੇਰੀਆਂ ਸ਼ਿਫ਼ਟਾਂ';

  @override
  String get replacePersonMenu => 'ਵਿਅਕਤੀ ਬਦਲੋ…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਅਪ੍ਰਕਾਸ਼ਿਤ ਤਬਦੀਲੀਆਂ',
      one: '1 ਅਪ੍ਰਕਾਸ਼ਿਤ ਤਬਦੀਲੀ',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'ਕਰਮਚਾਰੀ ਇਹ ਅਜੇ ਨਹੀਂ ਦੇਖ ਸਕਦੇ।';

  @override
  String get publish => 'ਪ੍ਰਕਾਸ਼ਿਤ ਕਰੋ';

  @override
  String yourHours(String duration) {
    return 'ਇਸ ਮਿਆਦ ਵਿੱਚ ਤੁਹਾਡੇ ਘੰਟੇ: $duration';
  }

  @override
  String get addShiftThisDay => 'ਇਸ ਦਿਨ ਸ਼ਿਫ਼ਟ ਸ਼ਾਮਲ ਕਰੋ';

  @override
  String get noShift => 'ਕੋਈ ਸ਼ਿਫ਼ਟ ਨਹੀਂ';

  @override
  String get unassigned => 'ਕਿਸੇ ਨੂੰ ਨਹੀਂ ਦਿੱਤੀ';

  @override
  String get formerMember => 'ਸਾਬਕਾ ਮੈਂਬਰ';

  @override
  String get statusDraft => 'ਖਰੜਾ';

  @override
  String get statusModified => 'ਬਦਲੀ ਗਈ';

  @override
  String get statusDeleted => 'ਮਿਟਾਈ ਗਈ';

  @override
  String durationHours(int hours) {
    return '$hours ਘੰ.';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ਘੰ. $minutes ਮਿੰ.';
  }

  @override
  String get editShift => 'ਸ਼ਿਫ਼ਟ ਸੋਧੋ';

  @override
  String get newShift => 'ਨਵੀਂ ਸ਼ਿਫ਼ਟ';

  @override
  String get thisShift => 'ਸਿਰਫ਼ ਇਹ ਸ਼ਿਫ਼ਟ';

  @override
  String get thisAndFollowing => 'ਇਹ ਅਤੇ ਅਗਲੀਆਂ';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ਦਿਨ',
      one: 'ਦਿਨ',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'ਹੋਰ ਦਿਨ';

  @override
  String get start => 'ਸ਼ੁਰੂ';

  @override
  String get end => 'ਅੰਤ';

  @override
  String get endsNextDay => 'ਅਗਲੇ ਦਿਨ ਖ਼ਤਮ ਹੁੰਦੀ ਹੈ।';

  @override
  String get person => 'ਵਿਅਕਤੀ';

  @override
  String get position => 'ਅਹੁਦਾ';

  @override
  String get site => 'ਥਾਂ';

  @override
  String get noteOptional => 'ਨੋਟ (ਵਿਕਲਪਿਕ)';

  @override
  String get repetition => 'ਦੁਹਰਾਓ';

  @override
  String get repeatNone => 'ਕੋਈ ਨਹੀਂ';

  @override
  String get repeatDaily => 'ਹਰ ਰੋਜ਼';

  @override
  String get repeatWeekly => 'ਹਰ ਹਫ਼ਤੇ';

  @override
  String get repeatForPrefix => 'ਮਿਆਦ ';

  @override
  String get repeatDaysSuffix => ' ਦਿਨ';

  @override
  String get repeatWeeksSuffix => ' ਹਫ਼ਤੇ';

  @override
  String get repeatUntilPrefix => 'ਤੱਕ ';

  @override
  String get replacePersonTitle => 'ਵਿਅਕਤੀ ਬਦਲੋ';

  @override
  String get replaceFrom => 'ਕਿਸਨੂੰ ਬਦਲਣਾ';

  @override
  String get replaceBy => 'ਕਿਸ ਨਾਲ';

  @override
  String dateRange(String from, String to) {
    return '$from ਤੋਂ $to ਤੱਕ';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਸ਼ਿਫ਼ਟਾਂ ਬਦਲੀਆਂ ਗਈਆਂ।',
      one: '1 ਸ਼ਿਫ਼ਟ ਬਦਲੀ ਗਈ।',
      zero: 'ਕੋਈ ਸ਼ਿਫ਼ਟ ਨਹੀਂ ਬਦਲੀ।',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'ਬਦਲੋ';

  @override
  String get joinHint =>
      'ਇਹ ਕੋਡ ਆਪਣੇ ਮੈਨੇਜਰ ਨੂੰ ਦਿਓ। ਉਹ ਐਪ ਵਿੱਚ ਦਰਜ ਕਰਨਗੇ, ਫਿਰ ਤੁਹਾਨੂੰ ਸੱਦਾ ਮਿਲੇਗਾ।';

  @override
  String get codeExpired => 'ਕੋਡ ਦੀ ਮਿਆਦ ਖ਼ਤਮ ਹੋ ਗਈ।';

  @override
  String codeValidFor(String time) {
    return 'ਹੋਰ $time ਲਈ ਵੈਧ';
  }

  @override
  String get newCode => 'ਨਵਾਂ ਕੋਡ';

  @override
  String get language => 'ਭਾਸ਼ਾ';

  @override
  String get languageAuto => 'ਆਪਣੇ-ਆਪ (ਡਿਵਾਈਸ ਦੀ ਭਾਸ਼ਾ)';

  @override
  String get syncUpToDate => 'ਅੱਪਡੇਟ ਹੈ';

  @override
  String get syncOffline => 'ਆਫ਼ਲਾਈਨ';

  @override
  String syncPending(int count) {
    return 'ਬਕਾਇਆ ਤਬਦੀਲੀਆਂ: $count';
  }

  @override
  String get syncNow => 'ਹੁਣੇ ਸਿੰਕ ਕਰੋ';

  @override
  String syncRejected(String reason) {
    return 'ਸਰਵਰ ਨੇ ਤਬਦੀਲੀ ਅਸਵੀਕਾਰ ਕੀਤੀ: $reason';
  }

  @override
  String get pendingBadge => 'ਬਕਾਇਆ';

  @override
  String get offlineUnavailable => 'ਆਫ਼ਲਾਈਨ ਉਪਲਬਧ ਨਹੀਂ।';

  @override
  String get offlineCached => 'ਆਫ਼ਲਾਈਨ: ਆਖ਼ਰੀ ਸੰਭਾਲਿਆ ਡਾਟਾ।';

  @override
  String get savedOffline =>
      'ਡਿਵਾਈਸ ਉੱਤੇ ਸੰਭਾਲਿਆ, ਨੈੱਟਵਰਕ ਆਉਣ ਤੇ ਭੇਜਿਆ ਜਾਵੇਗਾ।';

  @override
  String get notices => 'ਸੂਚਨਾਵਾਂ';

  @override
  String get noNotices => 'ਕੋਈ ਸੂਚਨਾ ਨਹੀਂ।';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name ਨੇ $date ਦੀ ਸ਼ਿਫ਼ਟ ਵਿੱਚ ਤੁਹਾਡੀ ਤਬਦੀਲੀ ਬਦਲ ਦਿੱਤੀ।';
  }

  @override
  String get history => 'ਇਤਿਹਾਸ';

  @override
  String get recentChanges => 'ਹਾਲੀਆ ਤਬਦੀਲੀਆਂ';

  @override
  String get undoChange => 'ਇਹ ਤਬਦੀਲੀ ਵਾਪਸ ਲਓ';

  @override
  String get undoDone => 'ਤਬਦੀਲੀ ਵਾਪਸ ਲਈ ਗਈ।';

  @override
  String get historyCreate => 'ਬਣਾਇਆ';

  @override
  String get historyUpdate => 'ਬਦਲਿਆ';

  @override
  String get historyDelete => 'ਮਿਟਾਇਆ';

  @override
  String get historyUndo => 'ਵਾਪਸ ਲਿਆ';

  @override
  String get noHistory => 'ਕੋਈ ਤਬਦੀਲੀ ਨਹੀਂ।';

  @override
  String get pendingNotEditable =>
      'ਇਹ ਸ਼ਿਫ਼ਟ ਅਜੇ ਸਿੰਕ ਨਹੀਂ ਹੋਈ: ਆਨਲਾਈਨ ਹੋਣ ਤੇ ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get myQrCode => 'ਮੇਰਾ QR ਕੋਡ';

  @override
  String get myQrCodeHint =>
      'ਮੈਨੇਜਰ ਇਹ ਕੋਡ ਸਕੈਨ ਕਰਕੇ ਤੁਹਾਨੂੰ ਆਪਣੀ ਕੰਪਨੀ ਵਿੱਚ ਜੋੜਦਾ ਹੈ; ਫਿਰ ਤੁਸੀਂ ਪੁਸ਼ਟੀ ਕਰਦੇ ਹੋ। ਇਹ ਕਦੇ ਨਹੀਂ ਬਦਲਦਾ।';

  @override
  String get changeMyName => 'ਮੇਰਾ ਨਾਂ ਬਦਲੋ';

  @override
  String get nameShownToTeam =>
      'ਤੁਹਾਡੇ ਸਾਥੀਆਂ ਨੂੰ ਤੁਹਾਡੇ Google ਨਾਂ ਦੀ ਥਾਂ ਇਹ ਨਾਂ ਦਿਖੇਗਾ।';

  @override
  String googleName(String name) {
    return 'Google ਨਾਂ: $name';
  }

  @override
  String get useGoogleName => 'ਮੇਰਾ Google ਨਾਂ ਵਰਤੋ';

  @override
  String renameMemberTitle(String name) {
    return '$name ਦਾ ਨਾਂ ਬਦਲੋ';
  }

  @override
  String get renameMemberHint => 'ਇਹ ਨਾਂ ਸਿਰਫ਼ ਇਸ ਕੰਪਨੀ ਵਿੱਚ ਵਰਤਿਆ ਜਾਂਦਾ ਹੈ।';

  @override
  String get useOwnName => 'ਉਹਨਾਂ ਦਾ ਆਪਣਾ ਨਾਂ ਵਰਤੋ';

  @override
  String get scanQrCode => 'QR ਕੋਡ ਸਕੈਨ ਕਰੋ';

  @override
  String get scanQrHint =>
      'ਉਹਨਾਂ ਦੀ ਐਪ ਵਿੱਚ ਦਿਖ ਰਹੇ QR ਕੋਡ ਵੱਲ ਕੈਮਰਾ ਕਰੋ (ਖਾਤਾ ਮੀਨੂ, “ਮੇਰਾ QR ਕੋਡ”)।';

  @override
  String get orEnterCode => 'ਜਾਂ ਉਹਨਾਂ ਦਾ 6 ਅੰਕਾਂ ਦਾ ਕੋਡ ਦਿਓ';

  @override
  String get qrInvalid => 'ਇਹ Staff Flow QR ਕੋਡ ਨਹੀਂ ਹੈ।';

  @override
  String cameraUnavailable(String error) {
    return 'ਕੈਮਰਾ ਉਪਲਬਧ ਨਹੀਂ ($error)।';
  }

  @override
  String get notificationsTitle => 'ਸੂਚਨਾਵਾਂ';

  @override
  String get notifChooseHint =>
      'ਚੁਣੋ ਕਿ ਤੁਹਾਨੂੰ ਕਿਹੜੀਆਂ ਸੂਚਨਾਵਾਂ ਮਿਲਣ। ਸਭ ਕੁਝ ਘੰਟੀ ਵਿੱਚ ਦਿਖਦਾ ਰਹੇਗਾ।';

  @override
  String get notifPlanning => 'ਸ਼ਡਿਊਲ ਪ੍ਰਕਾਸ਼ਿਤ ਜਾਂ ਬਦਲਿਆ';

  @override
  String get notifRequests => 'ਬੇਨਤੀਆਂ: ਅਦਲਾ-ਬਦਲੀ, ਛੁੱਟੀ, ਸੱਦੇ';

  @override
  String get notifMessages => 'ਨਵੇਂ ਸੁਨੇਹੇ';

  @override
  String get notifOverlap => 'ਕੰਪਨੀਆਂ ਵਿਚਕਾਰ ਟਕਰਾਉਂਦੀਆਂ ਸ਼ਿਫ਼ਟਾਂ';

  @override
  String get notifConflicts => 'ਕਿਸੇ ਹੋਰ ਮੈਨੇਜਰ ਨੇ ਤੁਹਾਡੀ ਤਬਦੀਲੀ ਬਦਲੀ';

  @override
  String get notifBilling => 'ਸਬਸਕ੍ਰਿਪਸ਼ਨ ਯਾਦ-ਦਹਾਨੀਆਂ';

  @override
  String get pushEnabled => 'ਇਸ ਡਿਵਾਈਸ \'ਤੇ ਸੂਚਨਾਵਾਂ ਚਾਲੂ ਹਨ।';

  @override
  String get pushOff => 'ਇਸ ਡਿਵਾਈਸ \'ਤੇ ਸੂਚਨਾਵਾਂ ਬੰਦ ਹਨ।';

  @override
  String get pushBlocked =>
      'ਸੂਚਨਾਵਾਂ ਬਲੌਕ ਹਨ: ਫ਼ੋਨ ਜਾਂ ਬ੍ਰਾਊਜ਼ਰ ਦੀਆਂ ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਇਜਾਜ਼ਤ ਦਿਓ।';

  @override
  String get pushUnavailable => 'ਇਸ ਡਿਵਾਈਸ \'ਤੇ ਸੂਚਨਾਵਾਂ ਉਪਲਬਧ ਨਹੀਂ ਹਨ।';

  @override
  String get enablePush => 'ਚਾਲੂ ਕਰੋ';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: ਤੁਹਾਡਾ ਸ਼ਡਿਊਲ ਪ੍ਰਕਾਸ਼ਿਤ ਜਾਂ ਬਦਲਿਆ ਗਿਆ ਹੈ।';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company ਤੁਹਾਨੂੰ ਆਪਣੀ ਟੀਮ ਵਿੱਚ ਜੋੜਨਾ ਚਾਹੁੰਦੀ ਹੈ।';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name ਤੁਹਾਨੂੰ $company ਦਾ ਮਾਲਕ ਬਣਨ ਦੀ ਪੇਸ਼ਕਸ਼ ਕਰ ਰਹੇ ਹਨ।';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name $company ਵਿੱਚ ਸ਼ਾਮਲ ਹੋ ਗਏ।';
  }

  @override
  String get messagesTab => 'ਸੁਨੇਹੇ';

  @override
  String get wholeTeam => 'ਪੂਰੀ ਟੀਮ';

  @override
  String get newConversation => 'ਨਵੀਂ ਗੱਲਬਾਤ';

  @override
  String get noMessages => 'ਹਾਲੇ ਕੋਈ ਸੁਨੇਹਾ ਨਹੀਂ।';

  @override
  String get messageHint => 'ਸੁਨੇਹਾ ਲਿਖੋ';

  @override
  String get earlierMessages => 'ਪਹਿਲਾਂ ਦੇ ਸੁਨੇਹੇ';

  @override
  String get personLeftCompany => 'ਇਹ ਵਿਅਕਤੀ ਹੁਣ ਕੰਪਨੀ ਦਾ ਹਿੱਸਾ ਨਹੀਂ ਹੈ।';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'ਨਵਾਂ ਗਰੁੱਪ';

  @override
  String get editGroup => 'ਗਰੁੱਪ ਸੋਧੋ';

  @override
  String get groupName => 'ਗਰੁੱਪ ਦਾ ਨਾਂ';

  @override
  String get groupMembersHint =>
      'ਇਸ ਗਰੁੱਪ ਦੇ ਲੋਕ ਚੁਣੋ। ਸਿਰਫ਼ ਉਹੀ ਇਸਦੇ ਸੁਨੇਹੇ ਦੇਖਣਗੇ।';

  @override
  String get chooseAtLeastOne => 'ਘੱਟੋ-ਘੱਟ ਇੱਕ ਵਿਅਕਤੀ ਚੁਣੋ।';

  @override
  String get replyAction => 'ਜਵਾਬ ਦਿਓ';

  @override
  String get translateAction => 'ਅਨੁਵਾਦ ਕਰੋ';

  @override
  String replyingTo(String name) {
    return '$name ਨੂੰ ਜਵਾਬ';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name ਦੇ ਹਾਲੀਆ ਸੁਨੇਹੇ';
  }

  @override
  String get deleteAllNotices => 'ਸਭ ਮਿਟਾਓ';

  @override
  String get deleteAllNoticesConfirm => 'ਸਾਰੀਆਂ ਸੂਚਨਾਵਾਂ ਮਿਟਾਉਣੀਆਂ ਹਨ?';

  @override
  String get noticeRetention => 'ਪੜ੍ਹੀਆਂ ਸੂਚਨਾਵਾਂ ਇਸ ਤੋਂ ਬਾਅਦ ਮਿਟਾਓ';

  @override
  String get retentionDay => '1 ਦਿਨ';

  @override
  String get retentionWeek => '1 ਹਫ਼ਤਾ';

  @override
  String get retentionMonth => '1 ਮਹੀਨਾ';

  @override
  String get billingOwnersOnly =>
      'ਸਿਰਫ਼ ਤਾਂ ਹੀ ਚਾਲੂ ਜੇ ਤੁਸੀਂ ਕਿਸੇ ਕੰਪਨੀ ਦੇ ਮਾਲਕ ਹੋ।';

  @override
  String get readOnlyPastDays =>
      'ਇੱਕ ਮਹੀਨੇ ਤੋਂ ਪੁਰਾਣੇ ਦਿਨ ਸਿਰਫ਼ ਦੇਖੇ ਜਾ ਸਕਦੇ ਹਨ।';

  @override
  String get wholeCompany => 'ਪੂਰੀ ਕੰਪਨੀ';

  @override
  String get sitesLabel => 'ਸਾਈਟਾਂ';

  @override
  String get actionSites => 'ਸਾਈਟਾਂ…';

  @override
  String managerOf(String name) {
    return '$name ਦੀ ਜ਼ਿੰਮੇਵਾਰੀ';
  }

  @override
  String teamSitesOf(String name) {
    return '$name ਦੀ ਟੀਮ';
  }

  @override
  String get notYourSite => 'ਇਹ ਸਾਈਟ ਤੁਹਾਡੀ ਜ਼ਿੰਮੇਵਾਰੀ ਵਿੱਚ ਨਹੀਂ ਹੈ।';

  @override
  String get chooseYourSite => 'ਘੱਟੋ-ਘੱਟ ਇੱਕ ਸਾਈਟ ਚੁਣੋ।';

  @override
  String get viewRequests => 'ਬੇਨਤੀਆਂ';

  @override
  String get newRequest => 'ਨਵੀਂ ਬੇਨਤੀ';

  @override
  String get requestLeave => 'ਛੁੱਟੀ';

  @override
  String get requestUnavailability => 'ਅਣਉਪਲਬਧਤਾ';

  @override
  String get requestSwap => 'ਸ਼ਿਫ਼ਟ ਅਦਲਾ-ਬਦਲੀ';

  @override
  String get swapHint =>
      'ਅਦਲਾ-ਬਦਲੀ ਦੀ ਪੇਸ਼ਕਸ਼ ਲਈ, ਸਮਾਂ-ਸਾਰਣੀ ਵਿੱਚ ਆਪਣੀ ਕਿਸੇ ਆਉਣ ਵਾਲੀ ਸ਼ਿਫ਼ਟ \'ਤੇ ਟੈਪ ਕਰੋ।';

  @override
  String get noRequests => 'ਅਜੇ ਕੋਈ ਬੇਨਤੀ ਨਹੀਂ।';

  @override
  String get requestsToHandle => 'ਨਿਪਟਾਉਣੀਆਂ';

  @override
  String get myRequests => 'ਮੇਰੀਆਂ ਬੇਨਤੀਆਂ';

  @override
  String get otherRequests => 'ਟੀਮ ਦੀਆਂ ਬੇਨਤੀਆਂ';

  @override
  String get statusPendingPeer => 'ਸਾਥੀ ਦੀ ਉਡੀਕ';

  @override
  String get statusPendingManager => 'ਮੈਨੇਜਰ ਦੀ ਉਡੀਕ';

  @override
  String get statusApproved => 'ਮਨਜ਼ੂਰ';

  @override
  String get statusRefused => 'ਨਾਮਨਜ਼ੂਰ';

  @override
  String get statusCancelled => 'ਰੱਦ';

  @override
  String get cancelRequest => 'ਬੇਨਤੀ ਰੱਦ ਕਰੋ';

  @override
  String get acceptSwap => 'ਇਹ ਸ਼ਿਫ਼ਟ ਲਓ';

  @override
  String get approve => 'ਮਨਜ਼ੂਰ ਕਰੋ';

  @override
  String periodLabel(String from, String to) {
    return '$from ਤੋਂ $to ਤੱਕ';
  }

  @override
  String swapToPeer(String name) {
    return '$name ਨੂੰ ਪੇਸ਼ ਕੀਤੀ';
  }

  @override
  String get swapToTeam => 'ਪੂਰੀ ਟੀਮ';

  @override
  String everyWeekdays(String days) {
    return 'ਹਰ ਹਫ਼ਤੇ: $days';
  }

  @override
  String get unavailableEveryWeek => 'ਉਹ ਦਿਨ ਜਦੋਂ ਤੁਸੀਂ ਕਦੇ ਉਪਲਬਧ ਨਹੀਂ ਹੁੰਦੇ:';

  @override
  String get choosePeriod => 'ਤਾਰੀਖਾਂ ਚੁਣੋ';

  @override
  String get choosePeriodOptional => 'ਕਿਸੇ ਸਮੇਂ ਤੱਕ ਸੀਮਤ ਕਰੋ (ਵਿਕਲਪਿਕ)';

  @override
  String get clearPeriod => 'ਕੋਈ ਸਮਾਂ ਨਹੀਂ';

  @override
  String get sendRequest => 'ਬੇਨਤੀ ਭੇਜੋ';

  @override
  String get proposeSwap => 'ਅਦਲਾ-ਬਦਲੀ ਦੀ ਪੇਸ਼ਕਸ਼';

  @override
  String get swapWith => 'ਪੇਸ਼ ਕਰੋ';

  @override
  String get swapSteps =>
      'ਸਾਥੀ ਮੰਨਦਾ ਹੈ, ਫਿਰ ਮੈਨੇਜਰ ਮਨਜ਼ੂਰ ਕਰਦਾ ਹੈ। ਸਮਾਂ-ਸਾਰਣੀ ਉਸ ਤੋਂ ਬਾਅਦ ਹੀ ਬਦਲਦੀ ਹੈ।';

  @override
  String get absentThatDay => 'ਉਸ ਦਿਨ ਮਨਜ਼ੂਰ ਗੈਰਹਾਜ਼ਰੀ';

  @override
  String get requestSent => 'ਬੇਨਤੀ ਭੇਜੀ ਗਈ।';

  @override
  String noticeSwapOffer(String name) {
    return '$name ਤੁਹਾਨੂੰ ਆਪਣੀ ਇੱਕ ਸ਼ਿਫ਼ਟ ਦੇਣਾ ਚਾਹੁੰਦੇ ਹਨ।';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name ਨੇ ਤੁਹਾਡਾ ਅਦਲਾ-ਬਦਲੀ ਦਾ ਪ੍ਰਸਤਾਵ ਠੁਕਰਾ ਦਿੱਤਾ।';
  }

  @override
  String get noticeSwapToApprove =>
      'ਇੱਕ ਸ਼ਿਫ਼ਟ ਅਦਲਾ-ਬਦਲੀ ਤੁਹਾਡੀ ਮਨਜ਼ੂਰੀ ਦੀ ਉਡੀਕ ਕਰ ਰਹੀ ਹੈ।';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name ਛੁੱਟੀ ਮੰਗ ਰਹੇ ਹਨ।';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name ਨੇ ਅਣਉਪਲਬਧਤਾ ਦੱਸੀ ਹੈ।';
  }

  @override
  String get noticeRequestApproved => 'ਤੁਹਾਡੀ ਬੇਨਤੀ ਮਨਜ਼ੂਰ ਹੋ ਗਈ।';

  @override
  String get noticeRequestRefused => 'ਤੁਹਾਡੀ ਬੇਨਤੀ ਨਾਮਨਜ਼ੂਰ ਹੋ ਗਈ।';

  @override
  String get choosePeer => 'ਇਹ ਸ਼ਿਫ਼ਟ ਕੌਣ ਲਵੇਗਾ?';

  @override
  String get discardAll => 'ਸਭ ਰੱਦ ਕਰੋ';

  @override
  String get notifySitesHint =>
      'ਉਹ ਥਾਵਾਂ ਚੁਣੋ ਜਿਨ੍ਹਾਂ ਦੀਆਂ ਬੇਨਤੀਆਂ ਦੀਆਂ ਸੂਚਨਾਵਾਂ ਤੁਹਾਨੂੰ ਮਿਲਣ। ਸਾਰੀਆਂ ਬੇਨਤੀਆਂ ਸੂਚੀ ਵਿੱਚ ਦਿਸਦੀਆਂ ਰਹਿਣਗੀਆਂ।';

  @override
  String get notifySitesTitle => 'ਥਾਂ ਮੁਤਾਬਕ ਸੂਚਨਾਵਾਂ';

  @override
  String get pendingRequestTooltip => 'ਬਕਾਇਆ ਬੇਨਤੀ: ਖੋਲ੍ਹਣ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String get requestsHistory => 'ਸਾਰੀਆਂ ਬੇਨਤੀਆਂ';

  @override
  String get revertChange => 'ਇਹ ਬਦਲਾਅ ਰੱਦ ਕਰੋ';

  @override
  String get statusExpired => 'ਹੁਣ ਲਾਗੂ ਨਹੀਂ';

  @override
  String get swapWithHint => 'ਕਿਸੇ ਖ਼ਾਸ ਸਾਥੀ ਨੂੰ ਚੁਣਨ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String changesDiscarded(String count) {
    return 'ਰੱਦ ਕੀਤੇ ਬਦਲਾਅ: $count';
  }

  @override
  String discardConfirm(String count) {
    return '$count ਅਪ੍ਰਕਾਸ਼ਿਤ ਬਦਲਾਅ ਰੱਦ ਕਰਨੇ ਹਨ?';
  }

  @override
  String get allSchedules => 'ਮੇਰੀਆਂ ਸਾਰੀਆਂ ਸਮਾਂ-ਸਾਰਣੀਆਂ';

  @override
  String get busyElsewhere =>
      'ਇਸ ਸਮੇਂ ਪਹਿਲਾਂ ਹੀ ਕਿਸੇ ਹੋਰ ਕੰਪਨੀ ਵਿੱਚ ਡਿਊਟੀ \'ਤੇ';

  @override
  String get overlapTooltip => 'ਕਿਸੇ ਹੋਰ ਕੰਪਨੀ ਦੀ ਸ਼ਿਫ਼ਟ ਨਾਲ ਟਕਰਾਉਂਦੀ ਹੈ';

  @override
  String get overlapWarning =>
      'ਦੋ ਕੰਪਨੀਆਂ ਵਿੱਚ ਤੁਹਾਡੀਆਂ ਕੁਝ ਸ਼ਿਫ਼ਟਾਂ ਆਪਸ ਵਿੱਚ ਟਕਰਾਉਂਦੀਆਂ ਹਨ।';

  @override
  String noticeOverlap(String date) {
    return '$date ਨੂੰ ਵੱਖ-ਵੱਖ ਕੰਪਨੀਆਂ ਵਿੱਚ ਤੁਹਾਡੀਆਂ ਦੋ ਸ਼ਿਫ਼ਟਾਂ ਆਪਸ ਵਿੱਚ ਟਕਰਾਉਂਦੀਆਂ ਹਨ।';
  }

  @override
  String get allMyCompanies => 'ਮੇਰੀਆਂ ਸਾਰੀਆਂ ਕੰਪਨੀਆਂ';

  @override
  String get deleteGroup => 'ਸਮੂਹ ਮਿਟਾਓ';

  @override
  String get openRequest => 'ਬੇਨਤੀ ਵੇਖੋ';

  @override
  String get thisCompany => 'ਇਹ ਕੰਪਨੀ';

  @override
  String get withExtras => 'ਆਰਜ਼ੀ ਕਰਮਚਾਰੀਆਂ ਸਮੇਤ';

  @override
  String deleteGroupConfirm(String name) {
    return 'ਸਭ ਲਈ “$name” ਅਤੇ ਇਸਦੇ ਸਾਰੇ ਸੁਨੇਹੇ ਮਿਟਾਉਣੇ ਹਨ?';
  }

  @override
  String reinforcementHint(String company) {
    return '$company ਤੋਂ: ਸਹਾਇਕ ਵਜੋਂ ਜੋੜਿਆ ਜਾਵੇਗਾ ਅਤੇ ਸੂਚਿਤ ਕੀਤਾ ਜਾਵੇਗਾ।';
  }

  @override
  String get addToGoogle => 'Google ਕੈਲੰਡਰ ਵਿੱਚ ਜੋੜੋ';

  @override
  String get calendarEnabled => 'ਮੇਰੀਆਂ ਸ਼ਿਫ਼ਟਾਂ ਸਿੰਕ ਕਰੋ';

  @override
  String get calendarHint =>
      'ਆਪਣੀਆਂ ਸਾਰੀਆਂ ਕੰਪਨੀਆਂ ਦੀਆਂ ਸ਼ਿਫ਼ਟਾਂ Google ਕੈਲੰਡਰ ਵਿੱਚ ਜੋੜੋ। ਇਹ ਆਪਣੇ-ਆਪ ਅੱਪਡੇਟ ਹੁੰਦੀਆਂ ਹਨ, ਅਤੇ ਤੁਸੀਂ ਕਦੇ ਵੀ ਬੰਦ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get changeSettings => 'ਬਦਲੋ';

  @override
  String get copyCalendarLink => 'ਕੈਲੰਡਰ ਲਿੰਕ ਕਾਪੀ ਕਰੋ';

  @override
  String get countryBelgium => 'ਬੈਲਜੀਅਮ';

  @override
  String get countryCanada => 'ਕੈਨੇਡਾ';

  @override
  String get countryFrance => 'ਫ਼ਰਾਂਸ';

  @override
  String get countrySwitzerland => 'ਸਵਿਟਜ਼ਰਲੈਂਡ';

  @override
  String get employeesSection => 'ਕਰਮਚਾਰੀ';

  @override
  String get emptyNoAlert => 'ਖਾਲੀ: ਕੋਈ ਚੇਤਾਵਨੀ ਨਹੀਂ';

  @override
  String get extrasSection => 'ਆਰਜ਼ੀ ਕਰਮਚਾਰੀ';

  @override
  String get googleCalendar => 'Google ਕੈਲੰਡਰ';

  @override
  String get hoursTotals => 'ਘੰਟਿਆਂ ਦਾ ਜੋੜ';

  @override
  String get legalAlerts => 'ਕਾਨੂੰਨੀ ਚੇਤਾਵਨੀਆਂ';

  @override
  String get legalAlertsHint =>
      'ਸਿਰਫ਼ ਚੇਤਾਵਨੀਆਂ, ਕਦੇ ਰੋਕ ਨਹੀਂ। ਆਪਣੇ ਉੱਤੇ ਲਾਗੂ ਨਿਯਮ ਚੁਣੋ, ਜਾਂ ਕੋਈ ਨਹੀਂ।';

  @override
  String get legalPreset => 'ਦੇਸ਼ ਦਾ ਨਮੂਨਾ';

  @override
  String get linkCopied => 'ਲਿੰਕ ਕਾਪੀ ਹੋ ਗਿਆ।';

  @override
  String get maxConsecutiveLabel => 'ਲਗਾਤਾਰ ਕੰਮ ਦੇ ਵੱਧ ਤੋਂ ਵੱਧ ਦਿਨ';

  @override
  String get maxDayLabel => 'ਪ੍ਰਤੀ ਦਿਨ ਵੱਧ ਤੋਂ ਵੱਧ ਸਮਾਂ (ਘੰਟੇ)';

  @override
  String get maxWeekLabel => 'ਪ੍ਰਤੀ ਹਫ਼ਤਾ ਵੱਧ ਤੋਂ ਵੱਧ ਸਮਾਂ (ਘੰਟੇ)';

  @override
  String get minRestLabel => 'ਦੋ ਸ਼ਿਫ਼ਟਾਂ ਵਿਚਕਾਰ ਘੱਟੋ-ਘੱਟ ਆਰਾਮ (ਘੰਟੇ)';

  @override
  String get noLegalRules => 'ਕੋਈ ਚੇਤਾਵਨੀ ਨਹੀਂ ਚੁਣੀ ਗਈ।';

  @override
  String get presetNone => 'ਕੋਈ ਨਹੀਂ';

  @override
  String get presetsCheck =>
      'ਨਮੂਨੇ ਸਿਰਫ਼ ਸ਼ੁਰੂਆਤ ਹਨ: ਆਪਣੇ ਦੇਸ਼ ਦੇ ਨਿਯਮਾਂ ਅਤੇ ਸਮੂਹਿਕ ਸਮਝੌਤੇ ਮੁਤਾਬਕ ਜਾਂਚੋ।';

  @override
  String get printMine => 'ਮੇਰੀ ਸਮਾਂ-ਸਾਰਣੀ';

  @override
  String get printOwn => 'ਸਿਰਫ਼ ਆਪਣੀ ਸਮਾਂ-ਸਾਰਣੀ';

  @override
  String get printPdf => 'ਪ੍ਰਿੰਟ / PDF';

  @override
  String get printRights => 'ਕਰਮਚਾਰੀ ਕੀ ਪ੍ਰਿੰਟ ਕਰ ਸਕਦੇ ਹਨ';

  @override
  String get printTeam => 'ਪੂਰੀ ਟੀਮ ਦੀ ਸਮਾਂ-ਸਾਰਣੀ';

  @override
  String get printTeamOption => 'ਟੀਮ ਦੀ ਸਮਾਂ-ਸਾਰਣੀ';

  @override
  String get totalsHint =>
      'ਡਰਾਫ਼ਟਾਂ ਸਮੇਤ। Excel ਅਤੇ CSV ਨਿਰਯਾਤ ਪ੍ਰਕਾਸ਼ਿਤ ਸਮਾਂ-ਸਾਰਣੀ ਵਰਤਦਾ ਹੈ।';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: ਲਗਾਤਾਰ $value ਦਿਨ (ਵੱਧ ਤੋਂ ਵੱਧ $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: ਦਿਨ ਵਿੱਚ $value (ਵੱਧ ਤੋਂ ਵੱਧ $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: ਸਿਰਫ਼ $value ਆਰਾਮ (ਘੱਟੋ-ਘੱਟ $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: ਹਫ਼ਤੇ ਵਿੱਚ $value (ਵੱਧ ਤੋਂ ਵੱਧ $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'ਕਾਨੂੰਨੀ ਚੇਤਾਵਨੀਆਂ: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'ਸ਼ਿਫ਼ਟਾਂ: $count';
  }

  @override
  String get actionMakeDeputy => 'ਉਪ-ਮੈਨੇਜਰ ਨਿਯੁਕਤ ਕਰੋ';

  @override
  String get actionRemoveDeputy => 'ਉਪ-ਮੈਨੇਜਰ ਦੀ ਭੂਮਿਕਾ ਹਟਾਓ';

  @override
  String get busyHere => 'ਇਸ ਸਮੇਂ ਪਹਿਲਾਂ ਹੀ ਇਸ ਕੰਪਨੀ ਵਿੱਚ ਡਿਊਟੀ \'ਤੇ';

  @override
  String get calendarByLink => 'ਲਿੰਕ ਰਾਹੀਂ (ਕੰਪਿਊਟਰ \'ਤੇ Google ਕੈਲੰਡਰ)';

  @override
  String get calendarDenied =>
      'ਕੈਲੰਡਰ ਦੀ ਇਜਾਜ਼ਤ ਨਹੀਂ ਮਿਲੀ। ਫ਼ੋਨ ਦੀਆਂ ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਇਜਾਜ਼ਤ ਦਿਓ।';

  @override
  String get calendarLinkHint =>
      'ਕੰਪਿਊਟਰ \'ਤੇ Google ਕੈਲੰਡਰ ਤੋਂ ਜੋੜੋ; Google ਕੁਝ ਘੰਟਿਆਂ ਵਿੱਚ ਅੱਪਡੇਟ ਕਰਦਾ ਹੈ।';

  @override
  String get calendarNone => 'ਇਸ ਫ਼ੋਨ \'ਤੇ ਬਦਲਣਯੋਗ ਕੋਈ ਕੈਲੰਡਰ ਨਹੀਂ।';

  @override
  String get calendarOnPhone => 'ਮੇਰੀਆਂ ਸ਼ਿਫ਼ਟਾਂ ਫ਼ੋਨ ਦੇ ਕੈਲੰਡਰ ਵਿੱਚ ਜੋੜੋ';

  @override
  String get calendarOnPhoneHint =>
      'ਤੁਹਾਡੇ Google ਕੈਲੰਡਰ ਵਿੱਚ: ਫ਼ੋਨ ਅਤੇ Google ਕੈਲੰਡਰ \'ਤੇ ਤੁਰੰਤ ਦਿਸੇਗਾ।';

  @override
  String get chooseCalendar => 'ਕੈਲੰਡਰ ਚੁਣੋ';

  @override
  String get otherSiteHint =>
      'ਕਿਸੇ ਹੋਰ ਥਾਂ ਦਾ ਕਰਮਚਾਰੀ: ਉਸਦੇ ਮੈਨੇਜਰਾਂ ਨੂੰ ਸੂਚਿਤ ਕੀਤਾ ਜਾਵੇਗਾ।';

  @override
  String get subManager => 'ਉਪ-ਮੈਨੇਜਰ';

  @override
  String calendarSynced(String count) {
    return 'ਕੈਲੰਡਰ ਵਿੱਚ ਸ਼ਿਫ਼ਟਾਂ: $count';
  }

  @override
  String deputyOf(String name) {
    return 'ਉਪ-ਮੈਨੇਜਰ: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by ਨੇ $date ਨੂੰ $name ਨੂੰ $site \'ਤੇ ਲਾਇਆ।';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company ਨੇ ਤੁਹਾਨੂੰ ਸਹਾਇਕ ਵਜੋਂ ਜੋੜਿਆ ਹੈ।';
  }

  @override
  String get companyNotificationsHint =>
      'ਬੰਦ: ਇਸ ਫ਼ੋਨ \'ਤੇ ਕੁਝ ਨਹੀਂ ਵੱਜੇਗਾ, ਪਰ ਸਭ ਕੁਝ ਘੰਟੀ ਵਿੱਚ ਰਹੇਗਾ।';

  @override
  String get companyNotificationsOn => 'ਇਸ ਕੰਪਨੀ ਦੀਆਂ ਸੂਚਨਾਵਾਂ ਲਓ';

  @override
  String get companyTimezone => 'ਕੰਪਨੀ ਦਾ ਸਮਾਂ ਖੇਤਰ';

  @override
  String get companyTimezoneHint =>
      'ਇਸ ਕੰਪਨੀ ਦੇ ਸਾਰੇ ਸਮੇਂ ਇਸ ਸਮਾਂ ਖੇਤਰ ਵਿੱਚ ਹਨ (ਗਰਮੀਆਂ ਦੇ ਸਮੇਂ ਸਮੇਤ)। ਕੈਲੰਡਰ ਇਹਨਾਂ ਨੂੰ ਆਪਣੇ-ਆਪ ਬਦਲਦੇ ਹਨ।';

  @override
  String get iosInstallHint =>
      'iPhone \'ਤੇ: ਸ਼ੇਅਰ \'ਤੇ ਟੈਪ ਕਰੋ, ਫਿਰ “ਹੋਮ ਸਕ੍ਰੀਨ \'ਤੇ ਜੋੜੋ” ਨਾਲ Staff Flow ਇੰਸਟਾਲ ਕਰੋ।';

  @override
  String get searchCity => 'ਸ਼ਹਿਰ ਲੱਭੋ';

  @override
  String get thisPhone => 'ਇਹ ਡਿਵਾਈਸ';

  @override
  String companyNotifications(String name) {
    return 'ਸੂਚਨਾਵਾਂ: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'ਸਮੇਂ $zone ਦੇ ਸਮੇਂ ਮੁਤਾਬਕ ($company)। ਤੁਹਾਡੀ ਡਿਵਾਈਸ: $here।';
  }

  @override
  String get addPreset => 'ਪ੍ਰੀਸੈੱਟ ਜੋੜੋ';

  @override
  String get addPresets => 'ਪ੍ਰੀਸੈੱਟ ਬਣਾਓ';

  @override
  String get appearance => 'ਦਿੱਖ';

  @override
  String get chooseLogo => 'PNG ਤਸਵੀਰ ਚੁਣੋ';

  @override
  String get conversationMuted => 'ਇਸ ਗੱਲਬਾਤ ਦੀਆਂ ਸੂਚਨਾਵਾਂ ਬੰਦ ਕੀਤੀਆਂ।';

  @override
  String get conversationUnmuted => 'ਇਸ ਗੱਲਬਾਤ ਦੀਆਂ ਸੂਚਨਾਵਾਂ ਮੁੜ ਚਾਲੂ ਕੀਤੀਆਂ।';

  @override
  String get customization => 'ਨਿੱਜੀਕਰਨ';

  @override
  String get disableGroup => 'ਸਮੂਹ ਬੰਦ ਕਰੋ';

  @override
  String get disableGroupConfirm =>
      'ਪੂਰੀ ਕੰਪਨੀ ਦਾ ਸਮੂਹ ਸਭ ਤੋਂ ਲੁਕ ਜਾਵੇਗਾ। ਤੁਸੀਂ ਇਸਨੂੰ ਸੁਨੇਹਿਆਂ ਵਿੱਚ ਮੁੜ ਚਾਲੂ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get editPresets => 'ਪ੍ਰੀਸੈੱਟ';

  @override
  String get enable => 'ਮੁੜ ਚਾਲੂ ਕਰੋ';

  @override
  String get groupDisabled => 'ਸਮੂਹ ਬੰਦ ਹੈ (ਸਿਰਫ਼ ਤੁਸੀਂ ਵੇਖਦੇ ਹੋ)';

  @override
  String get logoHint =>
      'ਕੰਪਨੀ ਦੀ ਟੈਬ \'ਤੇ ਦਿਸਣ ਵਾਲੀ ਛੋਟੀ PNG ਤਸਵੀਰ (ਤੁਹਾਡਾ ਲੋਗੋ), ਸਾਰੇ ਮੈਂਬਰਾਂ ਲਈ।';

  @override
  String get logoPngOnly => '1 MB ਤੱਕ ਦੀ PNG ਤਸਵੀਰ ਚੁਣੋ।';

  @override
  String get muteConversation => 'ਇਸ ਗੱਲਬਾਤ ਨੂੰ ਮਿਊਟ ਕਰੋ';

  @override
  String get myIdentifier => 'ਮੇਰੀ ਪਛਾਣ';

  @override
  String get myProfile => 'ਮੇਰੀ ਪ੍ਰੋਫ਼ਾਈਲ';

  @override
  String get presetName => 'ਨਾਮ (ਜਿਵੇਂ ਸਵੇਰ)';

  @override
  String get removeLogo => 'ਤਸਵੀਰ ਹਟਾਓ';

  @override
  String get resetGroup => 'ਸਮੂਹ ਰੀਸੈੱਟ ਕਰੋ';

  @override
  String get resetGroupConfirm => 'ਕੰਪਨੀ ਸਮੂਹ ਦੇ ਸਾਰੇ ਸੁਨੇਹੇ ਸਭ ਲਈ ਮਿਟ ਜਾਣਗੇ।';

  @override
  String get settingsTitle => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get shiftPresets => 'ਸ਼ਿਫ਼ਟ ਸਮੇਂ ਦੇ ਪ੍ਰੀਸੈੱਟ';

  @override
  String get shiftPresetsHint =>
      'ਤਿਆਰ ਸਮੇਂ (ਸਵੇਰ, ਸ਼ਾਮ, ਰਾਤ…): ਸ਼ਿਫ਼ਟ ਵਿੱਚ ਇੱਕ ਟੈਪ ਨਾਲ ਸ਼ੁਰੂ ਅਤੇ ਅੰਤ ਭਰ ਜਾਂਦੇ ਹਨ।';

  @override
  String get themeDark => 'ਗੂੜ੍ਹਾ';

  @override
  String get themeLight => 'ਹਲਕਾ';

  @override
  String get themeSystem => 'ਸਿਸਟਮ';

  @override
  String get unmuteConversation => 'ਇਸ ਗੱਲਬਾਤ ਦੀਆਂ ਸੂਚਨਾਵਾਂ ਚਾਲੂ ਕਰੋ';

  @override
  String get awaitingApproval => 'ਮਨਜ਼ੂਰੀ ਬਾਕੀ';

  @override
  String get placementNeedsApproval =>
      '! ਇਹ ਵਿਅਕਤੀ ਤੁਹਾਡੀਆਂ ਸਾਈਟਾਂ ਦਾ ਨਹੀਂ ਹੈ: ਪ੍ਰਕਾਸ਼ਿਤ ਹੋਣ ਤੋਂ ਪਹਿਲਾਂ ਸ਼ਿਫਟ ਤੁਹਾਡੇ ਸੀਨੀਅਰ ਜਾਂ ਮਾਲਕ ਦੀ ਮਨਜ਼ੂਰੀ ਦੀ ਉਡੀਕ ਕਰੇਗੀ। ਨਹੀਂ ਤਾਂ ਕਿਸੇ ਹੋਰ ਨੂੰ ਚੁਣੋ।';

  @override
  String get placementAwaiting => 'ਸੀਨੀਅਰ ਜਾਂ ਮਾਲਕ ਦੀ ਮਨਜ਼ੂਰੀ ਦੀ ਉਡੀਕ।';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by ਹੋਰ ਸਾਈਟ ਦੇ $name ਨੂੰ $date ਨੂੰ ਲਗਾਉਣਾ ਚਾਹੁੰਦੇ ਹਨ: ਮਨਜ਼ੂਰੀ ਚਾਹੀਦੀ ਹੈ।';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by ਨੇ $date ਨੂੰ $name ਦੀ ਨਿਯੁਕਤੀ ਮਨਜ਼ੂਰ ਕੀਤੀ।';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by ਨੇ $date ਨੂੰ $name ਦੀ ਨਿਯੁਕਤੀ ਰੱਦ ਕੀਤੀ।';
  }

  @override
  String get addSubSite => 'ਉਪ-ਸਾਈਟ ਜੋੜੋ';

  @override
  String get moveSite => 'ਹਿਲਾਓ';

  @override
  String get topLevel => 'ਪਹਿਲਾ ਪੱਧਰ';

  @override
  String moveSiteTitle(String name) {
    return '“$name” ਨੂੰ ਇਸਦੇ ਹੇਠਾਂ ਹਿਲਾਓ…';
  }

  @override
  String subSiteOf(String name) {
    return '$name ਦੀ ਉਪ-ਸਾਈਟ';
  }

  @override
  String get siteTreeHint =>
      'ਵੱਧ ਤੋਂ ਵੱਧ 3 ਪੱਧਰ, ਜਿਵੇਂ ਖੇਤਰ › ਸ਼ਹਿਰ › ਦੁਕਾਨ। ਕਿਸੇ ਸਾਈਟ ਦਾ ਮੈਨੇਜਰ ਉਸਦੇ ਹੇਠਾਂ ਦੀ ਹਰ ਚੀਜ਼ ਵੀ ਸੰਭਾਲਦਾ ਹੈ।';

  @override
  String get subSitesOnlyHint =>
      'ਇੱਥੇ ਤੁਸੀਂ ਆਪਣੀਆਂ ਸਾਈਟਾਂ ਹੇਠ ਉਪ-ਸਾਈਟਾਂ ਜੋੜਦੇ ਹੋ।';

  @override
  String get messagingSetting => 'ਕੰਪਨੀ ਦੇ ਸੁਨੇਹੇ';

  @override
  String get messagingSettingHint =>
      'ਚਾਲੂ: ਟੀਮ ਕੋਲ ਸੁਨੇਹੇ ਟੈਬ ਹੁੰਦੀ ਹੈ। ਬੰਦ: ਕੋਈ ਇਸਨੂੰ ਨਹੀਂ ਦੇਖਦਾ ਨਾ ਲਿਖ ਸਕਦਾ ਹੈ (ਪੁਰਾਣੇ ਸੁਨੇਹੇ ਰੱਖੇ ਜਾਂਦੇ ਹਨ)।';
}
