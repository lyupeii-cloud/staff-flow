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

  @override
  String get syncUpToDate => 'Imesasishwa';

  @override
  String get syncOffline => 'Nje ya mtandao';

  @override
  String syncPending(int count) {
    return 'Mabadiliko yanayosubiri: $count';
  }

  @override
  String get syncNow => 'Sawazisha sasa';

  @override
  String syncRejected(String reason) {
    return 'Seva imekataa badiliko: $reason';
  }

  @override
  String get pendingBadge => 'Inasubiri';

  @override
  String get offlineUnavailable => 'Haipatikani nje ya mtandao.';

  @override
  String get offlineCached => 'Nje ya mtandao: data za mwisho zilizohifadhiwa.';

  @override
  String get savedOffline =>
      'Imehifadhiwa kwenye kifaa, itatumwa mtandao ukirudi.';

  @override
  String get notices => 'Arifa';

  @override
  String get noNotices => 'Hakuna arifa.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name amebadilisha marekebisho yako ya zamu ya $date.';
  }

  @override
  String get history => 'Historia';

  @override
  String get recentChanges => 'Mabadiliko ya karibuni';

  @override
  String get undoChange => 'Tendua badiliko hili';

  @override
  String get undoDone => 'Badiliko limetenduliwa.';

  @override
  String get historyCreate => 'Kuundwa';

  @override
  String get historyUpdate => 'Kubadilishwa';

  @override
  String get historyDelete => 'Kufutwa';

  @override
  String get historyUndo => 'Kutendua';

  @override
  String get noHistory => 'Hakuna mabadiliko.';

  @override
  String get pendingNotEditable =>
      'Zamu hii bado haijasawazishwa: jaribu tena ukiwa mtandaoni.';

  @override
  String get myQrCode => 'Msimbo wangu wa QR';

  @override
  String get myQrCodeHint =>
      'Msimamizi huchanganua msimbo huu ili akuongeze kwenye kampuni yake; kisha wewe unathibitisha. Haubadiliki kamwe.';

  @override
  String get changeMyName => 'Badilisha jina langu';

  @override
  String get nameShownToTeam =>
      'Jina hili linaonyeshwa kwa wenzako badala ya jina lako la Google.';

  @override
  String googleName(String name) {
    return 'Jina la Google: $name';
  }

  @override
  String get useGoogleName => 'Tumia jina langu la Google';

  @override
  String renameMemberTitle(String name) {
    return 'Badilisha jina la $name';
  }

  @override
  String get renameMemberHint =>
      'Jina hili linatumika katika kampuni hii pekee.';

  @override
  String get useOwnName => 'Tumia jina lake mwenyewe';

  @override
  String get scanQrCode => 'Changanua msimbo wa QR';

  @override
  String get scanQrHint =>
      'Elekeza kamera kwenye msimbo wa QR ulio kwenye programu yake (menyu ya akaunti, “Msimbo wangu wa QR”).';

  @override
  String get orEnterCode => 'Au weka msimbo wake wa tarakimu 6';

  @override
  String get qrInvalid => 'Huu si msimbo wa QR wa Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Kamera haipatikani ($error).';
  }

  @override
  String get notificationsTitle => 'Arifa';

  @override
  String get notifChooseHint =>
      'Chagua mambo unayotaka kuarifiwa. Kila kitu kinaendelea kuonekana kwenye kengele.';

  @override
  String get notifPlanning => 'Ratiba imechapishwa au kubadilishwa';

  @override
  String get notifRequests => 'Maombi: kubadilishana, likizo, mialiko';

  @override
  String get notifMessages => 'Ujumbe mpya';

  @override
  String get notifOverlap => 'Zamu zinazogongana kati ya kampuni';

  @override
  String get notifConflicts =>
      'Mabadiliko yako yamebadilishwa na msimamizi mwingine';

  @override
  String get notifBilling => 'Vikumbusho vya usajili';

  @override
  String get pushEnabled => 'Arifa zimewashwa kwenye kifaa hiki.';

  @override
  String get pushOff => 'Arifa zimezimwa kwenye kifaa hiki.';

  @override
  String get pushBlocked =>
      'Arifa zimezuiwa: ziruhusu kwenye mipangilio ya simu au kivinjari.';

  @override
  String get pushUnavailable => 'Arifa hazipatikani kwenye kifaa hiki.';

  @override
  String get enablePush => 'Washa';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: ratiba yako imechapishwa au kubadilishwa.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company inataka kukuongeza kwenye timu yake.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name anapendekeza uwe mmiliki wa $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name amejiunga na $company.';
  }

  @override
  String get messagesTab => 'Ujumbe';

  @override
  String get wholeTeam => 'Timu nzima';

  @override
  String get newConversation => 'Mazungumzo mapya';

  @override
  String get noMessages => 'Bado hakuna ujumbe.';

  @override
  String get messageHint => 'Andika ujumbe';

  @override
  String get earlierMessages => 'Ujumbe wa awali';

  @override
  String get personLeftCompany => 'Mtu huyu si sehemu ya kampuni tena.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Kikundi kipya';

  @override
  String get editGroup => 'Hariri kikundi';

  @override
  String get groupName => 'Jina la kikundi';

  @override
  String get groupMembersHint =>
      'Chagua watu wa kikundi hiki. Wao pekee wataona ujumbe wake.';

  @override
  String get chooseAtLeastOne => 'Chagua angalau mtu mmoja.';

  @override
  String get replyAction => 'Jibu';

  @override
  String get translateAction => 'Tafsiri';

  @override
  String replyingTo(String name) {
    return 'Jibu kwa $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Ujumbe wa hivi karibuni wa $name';
  }

  @override
  String get deleteAllNotices => 'Futa zote';

  @override
  String get deleteAllNoticesConfirm => 'Futa arifa zote?';

  @override
  String get noticeRetention => 'Futa arifa zilizosomwa baada ya';

  @override
  String get retentionDay => 'Siku 1';

  @override
  String get retentionWeek => 'Wiki 1';

  @override
  String get retentionMonth => 'Mwezi 1';

  @override
  String get billingOwnersOnly => 'Inafanya kazi tu ukimiliki kampuni.';

  @override
  String get readOnlyPastDays =>
      'Siku zilizopita zaidi ya mwezi ni za kusoma tu.';

  @override
  String get wholeCompany => 'Kampuni nzima';

  @override
  String get sitesLabel => 'Maeneo';

  @override
  String get actionSites => 'Maeneo…';

  @override
  String managerOf(String name) {
    return '$name anasimamia';
  }

  @override
  String teamSitesOf(String name) {
    return 'Timu ya $name';
  }

  @override
  String get notYourSite => 'Eneo hili haliko chini ya jukumu lako.';

  @override
  String get chooseYourSite => 'Chagua angalau eneo moja.';
}
