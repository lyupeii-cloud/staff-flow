// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class L10nSw extends L10n {
  L10nSw([String locale = 'sw']) : super(locale);

  @override
  String get cancel => 'Ghairi';

  @override
  String get save => 'Hifadhi';

  @override
  String get confirm => 'Thibitisha';

  @override
  String get validate => 'Thibitisha';

  @override
  String get add => 'Ongeza';

  @override
  String get rename => 'Badilisha jina';

  @override
  String get delete => 'Futa';

  @override
  String get accept => 'Kubali';

  @override
  String get decline => 'Kataa';

  @override
  String get close => 'Funga';

  @override
  String get retry => 'Jaribu tena';

  @override
  String get name => 'Jina';

  @override
  String get serverUnreachable => 'Haiwezekani kufikia seva.';

  @override
  String errorStatus(int status) {
    return 'Hitilafu $status';
  }

  @override
  String get roleOwner => 'Mmiliki';

  @override
  String get roleManager => 'Msimamizi';

  @override
  String get roleEmployee => 'Mfanyakazi';

  @override
  String get roleExtra => 'Mfanyakazi wa muda';

  @override
  String get taglineStart => 'Ratiba za timu yako, ';

  @override
  String get taglineEnd => 'popote.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Ingia kwa Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Kuingia kwa Google hakupatikani: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Imeshindikana kuingia kwa Google: $detail';
  }

  @override
  String get newCompany => 'Kampuni mpya';

  @override
  String get timezone => 'Saa za eneo';

  @override
  String get create => 'Unda';

  @override
  String get noCompanyTitle => 'Bado hujajiunga na kampuni yoyote.';

  @override
  String get noCompanyHint =>
      'Ili kujiunga na kampuni ya mwajiri wako, tengeneza msimbo na umpe msimamizi wako.';

  @override
  String get joinCompany => 'Jiunge na kampuni';

  @override
  String get createCompany => 'Unda kampuni';

  @override
  String transferOffer(String company) {
    return 'Umeombwa kuwa mmiliki wa “$company”.';
  }

  @override
  String get someCompany => 'kampuni';

  @override
  String get becameOwner => 'Sasa wewe ndiye mmiliki.';

  @override
  String get myAccount => 'Akaunti yangu';

  @override
  String get idCopied => 'Kitambulisho kimenakiliwa.';

  @override
  String myId(String id) {
    return 'Kitambulisho changu: $id';
  }

  @override
  String get signOut => 'Ondoka';

  @override
  String joinInvite(String company, String role) {
    return '“$company” inakualika kama $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Umejiunga na $company.';
  }

  @override
  String get viewPlanning => 'Ratiba';

  @override
  String get viewTeam => 'Timu';

  @override
  String get viewPositions => 'Nafasi';

  @override
  String get readOnlyCompany => 'Kampuni hii ni ya kusoma tu.';

  @override
  String get team => 'Timu';

  @override
  String get leaveCompany => 'Ondoka kwenye kampuni hii';

  @override
  String meSuffix(String name) {
    return '$name (wewe)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Kuhamisha kampuni kwa $name?';
  }

  @override
  String get transferConfirmBody =>
      'Akikubali, atakuwa mmiliki (usajili, ankara, wasimamizi) na wewe utakuwa msimamizi.';

  @override
  String transferSent(String name) {
    return 'Ombi limetumwa kwa $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Kumwondoa $name?';
  }

  @override
  String get removeConfirmBody => 'Historia yake itahifadhiwa.';

  @override
  String get addPersonTitle => 'Ongeza mtu';

  @override
  String get addPersonHint =>
      'Mwombe afungue Staff Flow, menyu ya akaunti, “Jiunge na kampuni”, kisha uweke msimbo unaoonyeshwa.';

  @override
  String get sixDigitCode => 'Msimbo wa tarakimu 6';

  @override
  String invitationSent(String name) {
    return 'Mwaliko umetumwa kwa $name: lazima aukubali.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Kuondoka $company?';
  }

  @override
  String get leaveConfirmBody => 'Hutaona ratiba yake tena.';

  @override
  String get renameCompany => 'Badilisha jina la kampuni';

  @override
  String get actionMakeManager => 'Fanya msimamizi';

  @override
  String get actionMakeEmployee => 'Rudisha kuwa mfanyakazi';

  @override
  String get actionToEmployee => 'Fanya mfanyakazi';

  @override
  String get actionToExtra => 'Fanya mfanyakazi wa muda';

  @override
  String get actionTransfer => 'Hamisha umiliki';

  @override
  String get actionRemove => 'Ondoa kwenye kampuni';

  @override
  String get positions => 'Nafasi';

  @override
  String get sites => 'Maeneo';

  @override
  String get positionsHint => 'Kazi anayofanya: keshia, jikoni, mapokezi…';

  @override
  String get sitesHint =>
      'Mahali zamu inafanyika, ikiwa kampuni ina maeneo kadhaa.';

  @override
  String get archived => 'Imehifadhiwa kwenye kumbukumbu';

  @override
  String get archive => 'Hifadhi kwenye kumbukumbu';

  @override
  String get reactivate => 'Washa tena';

  @override
  String weekOf(String date) {
    return 'Wiki ya $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mabadiliko $count yamechapishwa.',
      one: 'Badiliko 1 limechapishwa.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Zamu';

  @override
  String get display => 'Mwonekano';

  @override
  String get week => 'Wiki';

  @override
  String get month => 'Mwezi';

  @override
  String get today => 'Leo';

  @override
  String get onlyMine => 'Zamu zangu tu';

  @override
  String get replacePersonMenu => 'Badilisha mtu…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mabadiliko $count hayajachapishwa',
      one: 'Badiliko 1 halijachapishwa',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Wafanyakazi bado hawayaoni.';

  @override
  String get publish => 'Chapisha';

  @override
  String yourHours(String duration) {
    return 'Saa zako katika kipindi hiki: $duration';
  }

  @override
  String get addShiftThisDay => 'Ongeza zamu siku hii';

  @override
  String get noShift => 'Hakuna zamu';

  @override
  String get unassigned => 'Haijapangiwa';

  @override
  String get formerMember => 'Mwanachama wa zamani';

  @override
  String get statusDraft => 'Rasimu';

  @override
  String get statusModified => 'Imebadilishwa';

  @override
  String get statusDeleted => 'Imefutwa';

  @override
  String durationHours(int hours) {
    return 'Saa $hours';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return 'Saa $hours dak $minutes';
  }

  @override
  String get editShift => 'Hariri zamu';

  @override
  String get newShift => 'Zamu mpya';

  @override
  String get thisShift => 'Zamu hii tu';

  @override
  String get thisAndFollowing => 'Hii na zinazofuata';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Siku',
      one: 'Siku',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Siku nyingine';

  @override
  String get start => 'Mwanzo';

  @override
  String get end => 'Mwisho';

  @override
  String get endsNextDay => 'Inaisha siku inayofuata.';

  @override
  String get person => 'Mtu';

  @override
  String get position => 'Nafasi';

  @override
  String get site => 'Eneo';

  @override
  String get noteOptional => 'Dokezo (si lazima)';

  @override
  String get repetition => 'Kurudia';

  @override
  String get repeatNone => 'Hakuna';

  @override
  String get repeatDaily => 'Kila siku';

  @override
  String get repeatWeekly => 'Kila wiki';

  @override
  String get repeatForPrefix => 'Kwa ';

  @override
  String get repeatDaysSuffix => ' siku';

  @override
  String get repeatWeeksSuffix => ' wiki';

  @override
  String get repeatUntilPrefix => 'Hadi ';

  @override
  String get replacePersonTitle => 'Badilisha mtu';

  @override
  String get replaceFrom => 'Badilisha';

  @override
  String get replaceBy => 'Kwa';

  @override
  String dateRange(String from, String to) {
    return 'Kuanzia $from hadi $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zamu $count zimebadilishwa.',
      one: 'Zamu 1 imebadilishwa.',
      zero: 'Hakuna zamu iliyobadilishwa.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Badilisha';

  @override
  String get joinHint =>
      'Mpe msimamizi wako msimbo huu. Akiuweka kwenye programu yake, utapokea mwaliko wa kukubali.';

  @override
  String get codeExpired => 'Msimbo umeisha muda.';

  @override
  String codeValidFor(String time) {
    return 'Halali kwa $time zaidi';
  }

  @override
  String get newCode => 'Msimbo mpya';

  @override
  String get language => 'Lugha';

  @override
  String get languageAuto => 'Otomatiki (lugha ya kifaa)';
}
