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
  String get viewTeam => 'ਟੀਮ';

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
}
