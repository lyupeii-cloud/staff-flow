// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class L10nFil extends L10n {
  L10nFil([String locale = 'fil']) : super(locale);

  @override
  String get cancel => 'Kanselahin';

  @override
  String get save => 'I-save';

  @override
  String get confirm => 'Kumpirmahin';

  @override
  String get validate => 'Kumpirmahin';

  @override
  String get add => 'Magdagdag';

  @override
  String get rename => 'Palitan ang pangalan';

  @override
  String get delete => 'Burahin';

  @override
  String get accept => 'Tanggapin';

  @override
  String get decline => 'Tanggihan';

  @override
  String get close => 'Isara';

  @override
  String get retry => 'Subukan ulit';

  @override
  String get name => 'Pangalan';

  @override
  String get serverUnreachable => 'Hindi maabot ang server.';

  @override
  String errorStatus(int status) {
    return 'Error $status';
  }

  @override
  String get roleOwner => 'May-ari';

  @override
  String get roleManager => 'Tagapamahala';

  @override
  String get roleEmployee => 'Empleyado';

  @override
  String get roleExtra => 'Pansamantalang manggagawa';

  @override
  String get taglineStart => 'Ang iskedyul ng iyong team, ';

  @override
  String get taglineEnd => 'kahit saan.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Mag-sign in gamit ang Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Hindi available ang pag-sign in gamit ang Google: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Hindi nakapag-sign in gamit ang Google: $detail';
  }

  @override
  String get newCompany => 'Bagong kumpanya';

  @override
  String get timezone => 'Time zone';

  @override
  String get create => 'Gumawa';

  @override
  String get noCompanyTitle => 'Wala ka pang kinabibilangang kumpanya.';

  @override
  String get noCompanyHint =>
      'Para sumali sa kumpanya ng employer mo, gumawa ng code at ibigay ito sa tagapamahala mo.';

  @override
  String get joinCompany => 'Sumali sa kumpanya';

  @override
  String get createCompany => 'Gumawa ng kumpanya';

  @override
  String transferOffer(String company) {
    return 'Inaalok ka na maging may-ari ng “$company”.';
  }

  @override
  String get someCompany => 'isang kumpanya';

  @override
  String get becameOwner => 'Ikaw na ang may-ari.';

  @override
  String get myAccount => 'Aking account';

  @override
  String get idCopied => 'Nakopya ang ID.';

  @override
  String myId(String id) {
    return 'Aking ID: $id';
  }

  @override
  String get signOut => 'Mag-sign out';

  @override
  String joinInvite(String company, String role) {
    return 'Iniimbitahan ka ng “$company” bilang $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Sumali ka sa $company.';
  }

  @override
  String get viewPlanning => 'Iskedyul';

  @override
  String get viewTeam => 'Team';

  @override
  String get viewPositions => 'Posisyon';

  @override
  String get readOnlyCompany => 'Read-only ang kumpanyang ito.';

  @override
  String get team => 'Team';

  @override
  String get leaveCompany => 'Umalis sa kumpanyang ito';

  @override
  String meSuffix(String name) {
    return '$name (ikaw)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Ilipat ang kumpanya kay $name?';
  }

  @override
  String get transferConfirmBody =>
      'Kapag tinanggap niya, siya ang magiging may-ari (subscription, invoice, tagapamahala) at ikaw ay magiging tagapamahala.';

  @override
  String transferSent(String name) {
    return 'Naipadala ang alok kay $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Alisin si $name?';
  }

  @override
  String get removeConfirmBody => 'Mananatili ang kanyang history.';

  @override
  String get addPersonTitle => 'Magdagdag ng tao';

  @override
  String get addPersonHint =>
      'Hilingin sa kanya na buksan ang Staff Flow, ang menu ng account, “Sumali sa kumpanya”, at ilagay ang ipinapakitang code.';

  @override
  String get sixDigitCode => '6-digit na code';

  @override
  String invitationSent(String name) {
    return 'Naipadala ang imbitasyon kay $name: kailangan niya itong tanggapin.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Umalis sa $company?';
  }

  @override
  String get leaveConfirmBody => 'Hindi mo na makikita ang iskedyul nito.';

  @override
  String get renameCompany => 'Palitan ang pangalan ng kumpanya';

  @override
  String get actionMakeManager => 'Gawing tagapamahala';

  @override
  String get actionMakeEmployee => 'Ibalik bilang empleyado';

  @override
  String get actionToEmployee => 'Gawing empleyado';

  @override
  String get actionToExtra => 'Gawing pansamantala';

  @override
  String get actionTransfer => 'Ilipat ang pagmamay-ari';

  @override
  String get actionRemove => 'Alisin sa kumpanya';

  @override
  String get positions => 'Mga posisyon';

  @override
  String get sites => 'Mga lokasyon';

  @override
  String get positionsHint => 'Ginagawa ng tao: kahera, kusina, reception…';

  @override
  String get sitesHint =>
      'Kung saan ang shift, kung maraming lokasyon ang kumpanya.';

  @override
  String get archived => 'Naka-archive';

  @override
  String get archive => 'I-archive';

  @override
  String get reactivate => 'Muling i-activate';

  @override
  String weekOf(String date) {
    return 'Linggo ng $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pagbabago ang nai-publish.',
      one: '1 pagbabago ang nai-publish.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Shift';

  @override
  String get display => 'View';

  @override
  String get week => 'Linggo';

  @override
  String get month => 'Buwan';

  @override
  String get today => 'Ngayon';

  @override
  String get onlyMine => 'Mga shift ko lang';

  @override
  String get replacePersonMenu => 'Palitan ang tao…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pagbabagong hindi pa nai-publish',
      one: '1 pagbabagong hindi pa nai-publish',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Hindi pa ito nakikita ng mga empleyado.';

  @override
  String get publish => 'I-publish';

  @override
  String yourHours(String duration) {
    return 'Iyong oras sa panahong ito: $duration';
  }

  @override
  String get addShiftThisDay => 'Magdagdag ng shift sa araw na ito';

  @override
  String get noShift => 'Walang shift';

  @override
  String get unassigned => 'Hindi naka-assign';

  @override
  String get formerMember => 'Dating miyembro';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusModified => 'Binago';

  @override
  String get statusDeleted => 'Binura';

  @override
  String durationHours(int hours) {
    return '$hours oras';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours oras $minutes min';
  }

  @override
  String get editShift => 'I-edit ang shift';

  @override
  String get newShift => 'Bagong shift';

  @override
  String get thisShift => 'Ang shift na ito lang';

  @override
  String get thisAndFollowing => 'Ito at ang mga susunod';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mga araw',
      one: 'Araw',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Ibang araw';

  @override
  String get start => 'Simula';

  @override
  String get end => 'Tapos';

  @override
  String get endsNextDay => 'Natatapos kinabukasan.';

  @override
  String get person => 'Tao';

  @override
  String get position => 'Posisyon';

  @override
  String get site => 'Lokasyon';

  @override
  String get noteOptional => 'Tala (opsyonal)';

  @override
  String get repetition => 'Pag-uulit';

  @override
  String get repeatNone => 'Wala';

  @override
  String get repeatDaily => 'Araw-araw';

  @override
  String get repeatWeekly => 'Linggo-linggo';

  @override
  String get repeatForPrefix => 'Sa loob ng ';

  @override
  String get repeatDaysSuffix => ' araw';

  @override
  String get repeatWeeksSuffix => ' linggo';

  @override
  String get repeatUntilPrefix => 'Hanggang ';

  @override
  String get replacePersonTitle => 'Palitan ang tao';

  @override
  String get replaceFrom => 'Palitan si';

  @override
  String get replaceBy => 'Ng';

  @override
  String dateRange(String from, String to) {
    return 'Mula $from hanggang $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count shift ang binago.',
      one: '1 shift ang binago.',
      zero: 'Walang shift na binago.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Palitan';

  @override
  String get joinHint =>
      'Ibigay ang code na ito sa iyong tagapamahala. Kapag inilagay niya ito sa app, makakatanggap ka ng imbitasyon.';

  @override
  String get codeExpired => 'Expired na ang code.';

  @override
  String codeValidFor(String time) {
    return 'May bisa pa nang $time';
  }

  @override
  String get newCode => 'Bagong code';

  @override
  String get language => 'Wika';

  @override
  String get languageAuto => 'Awtomatiko (wika ng device)';
}
