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

  @override
  String get viewRequests => 'Maombi';

  @override
  String get newRequest => 'Ombi jipya';

  @override
  String get requestLeave => 'Likizo';

  @override
  String get requestUnavailability => 'Kutopatikana';

  @override
  String get requestSwap => 'Kubadilishana zamu';

  @override
  String get swapHint =>
      'Ili kupendekeza kubadilishana, gusa mojawapo ya zamu zako zijazo kwenye ratiba.';

  @override
  String get noRequests => 'Bado hakuna maombi.';

  @override
  String get requestsToHandle => 'Ya kushughulikia';

  @override
  String get myRequests => 'Maombi yangu';

  @override
  String get otherRequests => 'Maombi ya timu';

  @override
  String get statusPendingPeer => 'Inamsubiri mwenzako';

  @override
  String get statusPendingManager => 'Inamsubiri msimamizi';

  @override
  String get statusApproved => 'Imekubaliwa';

  @override
  String get statusRefused => 'Imekataliwa';

  @override
  String get statusCancelled => 'Imeghairiwa';

  @override
  String get cancelRequest => 'Ghairi ombi';

  @override
  String get acceptSwap => 'Chukua zamu hii';

  @override
  String get approve => 'Idhinisha';

  @override
  String periodLabel(String from, String to) {
    return 'Kuanzia $from hadi $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Imependekezwa kwa $name';
  }

  @override
  String get swapToTeam => 'Timu nzima';

  @override
  String everyWeekdays(String days) {
    return 'Kila wiki: $days';
  }

  @override
  String get unavailableEveryWeek => 'Siku ambazo hupatikani kamwe:';

  @override
  String get choosePeriod => 'Chagua tarehe';

  @override
  String get choosePeriodOptional => 'Weka kikomo cha kipindi (hiari)';

  @override
  String get clearPeriod => 'Bila kipindi';

  @override
  String get sendRequest => 'Tuma ombi';

  @override
  String get proposeSwap => 'Pendekeza kubadilishana';

  @override
  String get swapWith => 'Pendekeza kwa';

  @override
  String get swapSteps =>
      'Mwenzako anakubali, kisha msimamizi anaidhinisha. Ratiba hubadilika baada ya hapo tu.';

  @override
  String get absentThatDay => 'Kutokuwepo kulikoidhinishwa siku hiyo';

  @override
  String get requestSent => 'Ombi limetumwa.';

  @override
  String noticeSwapOffer(String name) {
    return '$name anakupa moja ya zamu zake.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name amekataa pendekezo lako la kubadilishana.';
  }

  @override
  String get noticeSwapToApprove =>
      'Ubadilishanaji wa zamu unasubiri idhini yako.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name anaomba likizo.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name ametangaza kutopatikana.';
  }

  @override
  String get noticeRequestApproved => 'Ombi lako limekubaliwa.';

  @override
  String get noticeRequestRefused => 'Ombi lako limekataliwa.';

  @override
  String get choosePeer => 'Nani atachukua zamu hii?';

  @override
  String get discardAll => 'Ghairi zote';

  @override
  String get notifySitesHint =>
      'Chagua maeneo unayopokea arifa za maombi. Maombi yote yanabaki kuonekana kwenye orodha.';

  @override
  String get notifySitesTitle => 'Arifa kwa eneo';

  @override
  String get pendingRequestTooltip => 'Ombi linalosubiri: gusa ili kulifungua';

  @override
  String get requestsHistory => 'Maombi yote';

  @override
  String get revertChange => 'Tendua badiliko hili';

  @override
  String get statusExpired => 'Halitumiki tena';

  @override
  String get swapWithHint => 'Gusa ili kuchagua mwenzako fulani';

  @override
  String changesDiscarded(String count) {
    return 'Mabadiliko yaliyoghairiwa: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Ghairi mabadiliko $count ambayo hayajachapishwa?';
  }

  @override
  String get allSchedules => 'Ratiba zangu zote';

  @override
  String get busyElsewhere =>
      'Tayari yuko kazini katika kampuni nyingine wakati huu';

  @override
  String get overlapTooltip => 'Inaingiliana na zamu ya kampuni nyingine';

  @override
  String get overlapWarning =>
      'Baadhi ya zamu zako katika kampuni mbili zinaingiliana.';

  @override
  String noticeOverlap(String date) {
    return 'Zamu zako mbili katika kampuni tofauti zinaingiliana tarehe $date.';
  }

  @override
  String get allMyCompanies => 'Kampuni zangu zote';

  @override
  String get deleteGroup => 'Futa kikundi';

  @override
  String get openRequest => 'Tazama ombi';

  @override
  String get thisCompany => 'Kampuni hii';

  @override
  String get withExtras => 'Pamoja na vibarua';

  @override
  String deleteGroupConfirm(String name) {
    return 'Futa “$name” na jumbe zake zote kwa kila mtu?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Kutoka $company: ataongezwa kama msaidizi na kuarifiwa.';
  }

  @override
  String get addToGoogle => 'Ongeza kwenye Kalenda ya Google';

  @override
  String get calendarEnabled => 'Sawazisha zamu zangu';

  @override
  String get calendarHint =>
      'Ongeza zamu zako kutoka kampuni zako zote kwenye Kalenda ya Google. Zinajisasisha zenyewe, na unaweza kuzima wakati wowote.';

  @override
  String get changeSettings => 'Badilisha';

  @override
  String get copyCalendarLink => 'Nakili kiungo cha kalenda';

  @override
  String get countryBelgium => 'Ubelgiji';

  @override
  String get countryCanada => 'Kanada';

  @override
  String get countryFrance => 'Ufaransa';

  @override
  String get countrySwitzerland => 'Uswisi';

  @override
  String get employeesSection => 'Wafanyakazi';

  @override
  String get emptyNoAlert => 'Tupu: hakuna tahadhari';

  @override
  String get extrasSection => 'Vibarua';

  @override
  String get googleCalendar => 'Kalenda ya Google';

  @override
  String get hoursTotals => 'Jumla ya saa';

  @override
  String get legalAlerts => 'Tahadhari za kisheria';

  @override
  String get legalAlertsHint =>
      'Tahadhari tu, kamwe si kuzuia. Chagua kanuni zinazokuhusu, au hakuna.';

  @override
  String get legalPreset => 'Kiolezo cha nchi';

  @override
  String get linkCopied => 'Kiungo kimenakiliwa.';

  @override
  String get maxConsecutiveLabel => 'Siku nyingi zaidi za kazi mfululizo';

  @override
  String get maxDayLabel => 'Muda mrefu zaidi kwa siku (saa)';

  @override
  String get maxWeekLabel => 'Muda mrefu zaidi kwa wiki (saa)';

  @override
  String get minRestLabel => 'Mapumziko mafupi zaidi kati ya zamu (saa)';

  @override
  String get noLegalRules => 'Hakuna tahadhari iliyochaguliwa.';

  @override
  String get presetNone => 'Hakuna';

  @override
  String get presetsCheck =>
      'Violezo ni mwanzo tu: vihakiki kulingana na sheria za nchi yako na makubaliano ya pamoja.';

  @override
  String get printMine => 'Ratiba yangu';

  @override
  String get printOwn => 'Ratiba yao wenyewe tu';

  @override
  String get printPdf => 'Chapisha / PDF';

  @override
  String get printRights => 'Kile wafanyakazi wanaweza kuchapisha';

  @override
  String get printTeam => 'Ratiba ya timu nzima';

  @override
  String get printTeamOption => 'Ratiba ya timu';

  @override
  String get totalsHint =>
      'Pamoja na rasimu. Usafirishaji wa Excel na CSV hutumia ratiba iliyochapishwa.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: siku $value mfululizo (kiwango cha juu $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value kwa siku (kiwango cha juu $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: mapumziko ya $value tu (kiwango cha chini $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value kwa wiki (kiwango cha juu $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Tahadhari za kisheria: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Zamu: $count';
  }

  @override
  String get actionMakeDeputy => 'Teua kuwa naibu msimamizi';

  @override
  String get actionRemoveDeputy => 'Ondoa jukumu la naibu';

  @override
  String get busyHere => 'Tayari yuko kazini katika kampuni hii wakati huu';

  @override
  String get calendarByLink => 'Kwa kiungo (Kalenda ya Google kwenye kompyuta)';

  @override
  String get calendarDenied =>
      'Ufikiaji wa kalenda umekataliwa. Uruhusu katika mipangilio ya simu.';

  @override
  String get calendarLinkHint =>
      'Ongeza kutoka Kalenda ya Google kwenye kompyuta; Google huisasisha ndani ya saa chache.';

  @override
  String get calendarNone =>
      'Hakuna kalenda inayoweza kuhaririwa kwenye simu hii.';

  @override
  String get calendarOnPhone => 'Ongeza zamu zangu kwenye kalenda ya simu';

  @override
  String get calendarOnPhoneHint =>
      'Kwenye kalenda yako ya Google: inaonekana mara moja, kwenye simu na Kalenda ya Google.';

  @override
  String get chooseCalendar => 'Chagua kalenda';

  @override
  String get otherSiteHint =>
      'Mfanyakazi wa eneo lingine: wasimamizi wake wataarifiwa.';

  @override
  String get subManager => 'Naibu msimamizi';

  @override
  String calendarSynced(String count) {
    return 'Zamu kwenye kalenda: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Naibu msimamizi: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by amempanga $name katika $site tarehe $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company imekuongeza kama msaidizi.';
  }

  @override
  String get companyNotificationsHint =>
      'Zimezimwa: hakuna kitakacholia kwenye simu hii, lakini kila kitu kinabaki kwenye kengele.';

  @override
  String get companyNotificationsOn => 'Pokea arifa za kampuni hii';

  @override
  String get companyTimezone => 'Saa za eneo za kampuni';

  @override
  String get companyTimezoneHint =>
      'Saa zote za kampuni hii ziko kwenye saa hizi za eneo (pamoja na saa za majira ya joto). Kalenda huzibadilisha zenyewe.';

  @override
  String get iosInstallHint =>
      'Kwenye iPhone: gusa Shiriki, kisha “Ongeza kwenye Skrini ya Kwanza” ili kusakinisha Staff Flow.';

  @override
  String get searchCity => 'Tafuta jiji';

  @override
  String get thisPhone => 'Kifaa hiki';

  @override
  String companyNotifications(String name) {
    return 'Arifa: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Saa kulingana na saa za $zone ($company). Kifaa chako: $here.';
  }
}
