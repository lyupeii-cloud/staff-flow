// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class L10nBn extends L10n {
  L10nBn([String locale = 'bn']) : super(locale);

  @override
  String get cancel => 'বাতিল';

  @override
  String get save => 'সংরক্ষণ';

  @override
  String get confirm => 'নিশ্চিত করুন';

  @override
  String get validate => 'নিশ্চিত করুন';

  @override
  String get add => 'যোগ করুন';

  @override
  String get rename => 'নাম বদলান';

  @override
  String get delete => 'মুছুন';

  @override
  String get accept => 'গ্রহণ করুন';

  @override
  String get decline => 'প্রত্যাখ্যান করুন';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get name => 'নাম';

  @override
  String get serverUnreachable => 'সার্ভারের সঙ্গে যোগাযোগ করা যাচ্ছে না।';

  @override
  String errorStatus(int status) {
    return 'ত্রুটি $status';
  }

  @override
  String get roleOwner => 'মালিক';

  @override
  String get roleManager => 'ব্যবস্থাপক';

  @override
  String get roleEmployee => 'কর্মী';

  @override
  String get roleExtra => 'অস্থায়ী কর্মী';

  @override
  String get taglineStart => 'আপনার দলের শিফট, ';

  @override
  String get taglineEnd => 'সব জায়গায়।';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Google দিয়ে সাইন ইন করুন';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google সাইন-ইন পাওয়া যাচ্ছে না: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google দিয়ে সাইন ইন করা গেল না: $detail';
  }

  @override
  String get newCompany => 'নতুন প্রতিষ্ঠান';

  @override
  String get timezone => 'সময় অঞ্চল';

  @override
  String get create => 'তৈরি করুন';

  @override
  String get noCompanyTitle => 'আপনি এখনো কোনো প্রতিষ্ঠানের সদস্য নন।';

  @override
  String get noCompanyHint =>
      'আপনার নিয়োগকর্তার প্রতিষ্ঠানে যোগ দিতে একটি কোড তৈরি করে আপনার ব্যবস্থাপককে দিন।';

  @override
  String get joinCompany => 'প্রতিষ্ঠানে যোগ দিন';

  @override
  String get createCompany => 'প্রতিষ্ঠান তৈরি করুন';

  @override
  String transferOffer(String company) {
    return 'আপনাকে “$company”-এর মালিক হওয়ার প্রস্তাব দেওয়া হয়েছে।';
  }

  @override
  String get someCompany => 'একটি প্রতিষ্ঠান';

  @override
  String get becameOwner => 'আপনি এখন মালিক।';

  @override
  String get myAccount => 'আমার অ্যাকাউন্ট';

  @override
  String get idCopied => 'আইডি কপি হয়েছে।';

  @override
  String myId(String id) {
    return 'আমার আইডি: $id';
  }

  @override
  String get signOut => 'সাইন আউট';

  @override
  String joinInvite(String company, String role) {
    return '“$company” আপনাকে $role হিসেবে আমন্ত্রণ জানিয়েছে।';
  }

  @override
  String joinedCompany(String company) {
    return 'আপনি $company-এ যোগ দিয়েছেন।';
  }

  @override
  String get viewPlanning => 'সময়সূচি';

  @override
  String get viewTeam => 'ব্যবস্থাপনা';

  @override
  String get viewPositions => 'পদ';

  @override
  String get readOnlyCompany => 'এই প্রতিষ্ঠান শুধু দেখার জন্য।';

  @override
  String get team => 'দল';

  @override
  String get leaveCompany => 'এই প্রতিষ্ঠান ছাড়ুন';

  @override
  String meSuffix(String name) {
    return '$name (আপনি)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'প্রতিষ্ঠানটি $name-কে হস্তান্তর করবেন?';
  }

  @override
  String get transferConfirmBody =>
      'তিনি গ্রহণ করলে মালিক হবেন (সাবস্ক্রিপশন, বিল, ব্যবস্থাপক), আর আপনি ব্যবস্থাপক হবেন।';

  @override
  String transferSent(String name) {
    return '$name-কে প্রস্তাব পাঠানো হয়েছে।';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$name-কে সরাবেন?';
  }

  @override
  String get removeConfirmBody => 'ইতিহাস সংরক্ষিত থাকবে।';

  @override
  String get addPersonTitle => 'একজনকে যোগ করুন';

  @override
  String get addPersonHint =>
      'তাঁকে Staff Flow খুলে অ্যাকাউন্ট মেনুতে “প্রতিষ্ঠানে যোগ দিন” বেছে নিতে বলুন, তারপর দেখানো কোডটি লিখুন।';

  @override
  String get sixDigitCode => '৬ অঙ্কের কোড';

  @override
  String invitationSent(String name) {
    return '$name-কে আমন্ত্রণ পাঠানো হয়েছে: তাঁকে গ্রহণ করতে হবে।';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company ছাড়বেন?';
  }

  @override
  String get leaveConfirmBody => 'আপনি আর এর সময়সূচি দেখতে পাবেন না।';

  @override
  String get renameCompany => 'প্রতিষ্ঠানের নাম বদলান';

  @override
  String get actionMakeManager => 'ব্যবস্থাপক করুন';

  @override
  String get actionMakeEmployee => 'আবার কর্মী করুন';

  @override
  String get actionToEmployee => 'কর্মী করুন';

  @override
  String get actionToExtra => 'অস্থায়ী কর্মী করুন';

  @override
  String get actionTransfer => 'মালিকানা হস্তান্তর করুন';

  @override
  String get actionRemove => 'প্রতিষ্ঠান থেকে সরান';

  @override
  String get positions => 'পদ';

  @override
  String get sites => 'স্থান';

  @override
  String get positionsHint =>
      'ব্যক্তি কী কাজ করেন: ক্যাশ, রান্নাঘর, অভ্যর্থনা…';

  @override
  String get sitesHint => 'প্রতিষ্ঠানের একাধিক স্থান থাকলে শিফট কোথায় হবে।';

  @override
  String get archived => 'আর্কাইভ করা';

  @override
  String get archive => 'আর্কাইভ করুন';

  @override
  String get reactivate => 'আবার চালু করুন';

  @override
  String weekOf(String date) {
    return '$date সপ্তাহ';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি পরিবর্তন প্রকাশিত হয়েছে।',
      one: '১টি পরিবর্তন প্রকাশিত হয়েছে।',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'শিফট';

  @override
  String get display => 'দেখার ধরন';

  @override
  String get week => 'সপ্তাহ';

  @override
  String get month => 'মাস';

  @override
  String get today => 'আজ';

  @override
  String get onlyMine => 'শুধু আমার শিফট';

  @override
  String get replacePersonMenu => 'একজনকে বদলান…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি পরিবর্তন অপ্রকাশিত',
      one: '১টি পরিবর্তন অপ্রকাশিত',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'কর্মীরা এখনো এগুলো দেখতে পান না।';

  @override
  String get publish => 'প্রকাশ করুন';

  @override
  String yourHours(String duration) {
    return 'এই সময়ে আপনার ঘণ্টা: $duration';
  }

  @override
  String get addShiftThisDay => 'এই দিনে শিফট যোগ করুন';

  @override
  String get noShift => 'কোনো শিফট নেই';

  @override
  String get unassigned => 'কাউকে দেওয়া হয়নি';

  @override
  String get formerMember => 'প্রাক্তন সদস্য';

  @override
  String get statusDraft => 'খসড়া';

  @override
  String get statusModified => 'পরিবর্তিত';

  @override
  String get statusDeleted => 'মুছে ফেলা';

  @override
  String durationHours(int hours) {
    return '$hours ঘ.';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ঘ. $minutes মি.';
  }

  @override
  String get editShift => 'শিফট সম্পাদনা';

  @override
  String get newShift => 'নতুন শিফট';

  @override
  String get thisShift => 'শুধু এই শিফট';

  @override
  String get thisAndFollowing => 'এটি ও পরেরগুলো';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'দিন',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'অন্য দিন';

  @override
  String get start => 'শুরু';

  @override
  String get end => 'শেষ';

  @override
  String get endsNextDay => 'পরের দিন শেষ হয়।';

  @override
  String get person => 'ব্যক্তি';

  @override
  String get position => 'পদ';

  @override
  String get site => 'স্থান';

  @override
  String get noteOptional => 'নোট (ঐচ্ছিক)';

  @override
  String get repetition => 'পুনরাবৃত্তি';

  @override
  String get repeatNone => 'নেই';

  @override
  String get repeatDaily => 'প্রতিদিন';

  @override
  String get repeatWeekly => 'প্রতি সপ্তাহে';

  @override
  String get repeatForPrefix => 'মেয়াদ ';

  @override
  String get repeatDaysSuffix => ' দিন';

  @override
  String get repeatWeeksSuffix => ' সপ্তাহ';

  @override
  String get repeatUntilPrefix => 'পর্যন্ত ';

  @override
  String get replacePersonTitle => 'একজনকে বদলান';

  @override
  String get replaceFrom => 'যাঁকে বদলাবেন';

  @override
  String get replaceBy => 'যাঁর দ্বারা';

  @override
  String dateRange(String from, String to) {
    return '$from থেকে $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি শিফট বদলানো হয়েছে।',
      zero: 'কোনো শিফট বদলায়নি।',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'বদলান';

  @override
  String get joinHint =>
      'এই কোডটি আপনার ব্যবস্থাপককে দিন। তিনি অ্যাপে লিখলে আপনি গ্রহণ করার জন্য একটি আমন্ত্রণ পাবেন।';

  @override
  String get codeExpired => 'কোডের মেয়াদ শেষ।';

  @override
  String codeValidFor(String time) {
    return 'আরও $time বৈধ';
  }

  @override
  String get newCode => 'নতুন কোড';

  @override
  String get language => 'ভাষা';

  @override
  String get languageAuto => 'স্বয়ংক্রিয় (ডিভাইসের ভাষা)';

  @override
  String get syncUpToDate => 'হালনাগাদ';

  @override
  String get syncOffline => 'অফলাইন';

  @override
  String syncPending(int count) {
    return 'অপেক্ষমাণ পরিবর্তন: $count';
  }

  @override
  String get syncNow => 'এখনই সিঙ্ক করুন';

  @override
  String syncRejected(String reason) {
    return 'সার্ভার পরিবর্তন প্রত্যাখ্যান করেছে: $reason';
  }

  @override
  String get pendingBadge => 'অপেক্ষমাণ';

  @override
  String get offlineUnavailable => 'অফলাইনে পাওয়া যায় না।';

  @override
  String get offlineCached => 'অফলাইন: সর্বশেষ সংরক্ষিত তথ্য।';

  @override
  String get savedOffline => 'ডিভাইসে সংরক্ষিত, নেটওয়ার্ক ফিরলে পাঠানো হবে।';

  @override
  String get notices => 'বিজ্ঞপ্তি';

  @override
  String get noNotices => 'কোনো বিজ্ঞপ্তি নেই।';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name $date তারিখের শিফটে আপনার পরিবর্তন বদলে দিয়েছেন।';
  }

  @override
  String get history => 'ইতিহাস';

  @override
  String get recentChanges => 'সাম্প্রতিক পরিবর্তন';

  @override
  String get undoChange => 'এই পরিবর্তন বাতিল করুন';

  @override
  String get undoDone => 'পরিবর্তন বাতিল হয়েছে।';

  @override
  String get historyCreate => 'তৈরি';

  @override
  String get historyUpdate => 'পরিবর্তন';

  @override
  String get historyDelete => 'মুছে ফেলা';

  @override
  String get historyUndo => 'বাতিল';

  @override
  String get noHistory => 'কোনো পরিবর্তন নেই।';

  @override
  String get pendingNotEditable =>
      'এই শিফট এখনো সিঙ্ক হয়নি: অনলাইনে আবার চেষ্টা করুন।';

  @override
  String get myQrCode => 'আমার QR কোড';

  @override
  String get myQrCodeHint =>
      'ম্যানেজার এই কোড স্ক্যান করে আপনাকে তাঁর কোম্পানিতে যুক্ত করেন; তারপর আপনি নিশ্চিত করেন। এটি কখনও বদলায় না।';

  @override
  String get changeMyName => 'আমার নাম পরিবর্তন করুন';

  @override
  String get nameShownToTeam =>
      'আপনার সহকর্মীরা আপনার Google নামের বদলে এই নাম দেখবেন।';

  @override
  String googleName(String name) {
    return 'Google নাম: $name';
  }

  @override
  String get useGoogleName => 'আমার Google নাম ব্যবহার করুন';

  @override
  String renameMemberTitle(String name) {
    return '$name-এর নাম পরিবর্তন';
  }

  @override
  String get renameMemberHint => 'এই নাম শুধু এই কোম্পানিতে ব্যবহৃত হয়।';

  @override
  String get useOwnName => 'তাঁর নিজের নাম ব্যবহার করুন';

  @override
  String get scanQrCode => 'QR কোড স্ক্যান করুন';

  @override
  String get scanQrHint =>
      'তাঁর অ্যাপে দেখানো QR কোডের দিকে ক্যামেরা ধরুন (অ্যাকাউন্ট মেনু, “আমার QR কোড”)।';

  @override
  String get orEnterCode => 'অথবা তাঁর ৬ অঙ্কের কোড লিখুন';

  @override
  String get qrInvalid => 'এটি Staff Flow QR কোড নয়।';

  @override
  String cameraUnavailable(String error) {
    return 'ক্যামেরা পাওয়া যাচ্ছে না ($error)।';
  }

  @override
  String get notificationsTitle => 'বিজ্ঞপ্তি';

  @override
  String get notifChooseHint =>
      'কোন বিষয়ে বিজ্ঞপ্তি পাবেন তা বেছে নিন। সবকিছু ঘণ্টায় দেখা যাবে।';

  @override
  String get notifPlanning => 'সময়সূচি প্রকাশিত বা পরিবর্তিত';

  @override
  String get notifRequests => 'অনুরোধ: অদলবদল, ছুটি, আমন্ত্রণ';

  @override
  String get notifMessages => 'নতুন বার্তা';

  @override
  String get notifOverlap => 'কোম্পানিগুলোর মধ্যে ওভারল্যাপ করা শিফট';

  @override
  String get notifConflicts =>
      'অন্য ম্যানেজার আপনার পরিবর্তন প্রতিস্থাপন করেছেন';

  @override
  String get notifBilling => 'সাবস্ক্রিপশন রিমাইন্ডার';

  @override
  String get pushEnabled => 'এই ডিভাইসে বিজ্ঞপ্তি চালু আছে।';

  @override
  String get pushOff => 'এই ডিভাইসে বিজ্ঞপ্তি বন্ধ আছে।';

  @override
  String get pushBlocked =>
      'বিজ্ঞপ্তি ব্লক করা আছে: ফোন বা ব্রাউজারের সেটিংসে অনুমতি দিন।';

  @override
  String get pushUnavailable => 'এই ডিভাইসে বিজ্ঞপ্তি পাওয়া যায় না।';

  @override
  String get enablePush => 'চালু করুন';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: আপনার সময়সূচি প্রকাশিত বা পরিবর্তিত হয়েছে।';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company আপনাকে তাদের দলে যুক্ত করতে চায়।';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name আপনাকে $company-এর মালিক হওয়ার প্রস্তাব দিচ্ছেন।';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name $company-এ যোগ দিয়েছেন।';
  }

  @override
  String get messagesTab => 'বার্তা';

  @override
  String get wholeTeam => 'পুরো দল';

  @override
  String get newConversation => 'নতুন কথোপকথন';

  @override
  String get noMessages => 'এখনও কোনো বার্তা নেই।';

  @override
  String get messageHint => 'একটি বার্তা লিখুন';

  @override
  String get earlierMessages => 'আগের বার্তা';

  @override
  String get personLeftCompany => 'এই ব্যক্তি আর কোম্পানির অংশ নন।';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'নতুন গ্রুপ';

  @override
  String get editGroup => 'গ্রুপ সম্পাদনা';

  @override
  String get groupName => 'গ্রুপের নাম';

  @override
  String get groupMembersHint =>
      'এই গ্রুপের মানুষ বেছে নিন। শুধু তাঁরাই এর বার্তা দেখবেন।';

  @override
  String get chooseAtLeastOne => 'অন্তত একজনকে বেছে নিন।';

  @override
  String get replyAction => 'উত্তর দিন';

  @override
  String get translateAction => 'অনুবাদ করুন';

  @override
  String replyingTo(String name) {
    return '$name-কে উত্তর';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name-এর সাম্প্রতিক বার্তা';
  }

  @override
  String get deleteAllNotices => 'সব মুছুন';

  @override
  String get deleteAllNoticesConfirm => 'সব বিজ্ঞপ্তি মুছবেন?';

  @override
  String get noticeRetention => 'পড়া বিজ্ঞপ্তি মুছুন এর পরে';

  @override
  String get retentionDay => '১ দিন';

  @override
  String get retentionWeek => '১ সপ্তাহ';

  @override
  String get retentionMonth => '১ মাস';

  @override
  String get billingOwnersOnly => 'শুধু আপনি কোনো কোম্পানির মালিক হলে সক্রিয়।';

  @override
  String get readOnlyPastDays => 'এক মাসের বেশি পুরোনো দিন শুধু দেখা যাবে।';

  @override
  String get wholeCompany => 'পুরো কোম্পানি';

  @override
  String get sitesLabel => 'সাইট';

  @override
  String get actionSites => 'সাইট…';

  @override
  String managerOf(String name) {
    return '$name-এর দায়িত্বে';
  }

  @override
  String teamSitesOf(String name) {
    return '$name-এর দল';
  }

  @override
  String get notYourSite => 'এই সাইটটি আপনার দায়িত্বে নেই।';

  @override
  String get chooseYourSite => 'অন্তত একটি সাইট বেছে নিন।';

  @override
  String get viewRequests => 'অনুরোধ';

  @override
  String get newRequest => 'নতুন অনুরোধ';

  @override
  String get requestLeave => 'ছুটি';

  @override
  String get requestUnavailability => 'অনুপলব্ধতা';

  @override
  String get requestSwap => 'শিফট অদলবদল';

  @override
  String get swapHint =>
      'অদলবদলের প্রস্তাব দিতে সময়সূচিতে আপনার আসন্ন কোনো শিফটে ট্যাপ করুন।';

  @override
  String get noRequests => 'এখনও কোনো অনুরোধ নেই।';

  @override
  String get requestsToHandle => 'করণীয়';

  @override
  String get myRequests => 'আমার অনুরোধ';

  @override
  String get otherRequests => 'দলের অনুরোধ';

  @override
  String get statusPendingPeer => 'সহকর্মীর অপেক্ষায়';

  @override
  String get statusPendingManager => 'ব্যবস্থাপকের অপেক্ষায়';

  @override
  String get statusApproved => 'গৃহীত';

  @override
  String get statusRefused => 'প্রত্যাখ্যাত';

  @override
  String get statusCancelled => 'বাতিল';

  @override
  String get cancelRequest => 'অনুরোধ বাতিল করুন';

  @override
  String get acceptSwap => 'এই শিফট নিন';

  @override
  String get approve => 'অনুমোদন';

  @override
  String periodLabel(String from, String to) {
    return '$from থেকে $to';
  }

  @override
  String swapToPeer(String name) {
    return '$name-কে প্রস্তাবিত';
  }

  @override
  String get swapToTeam => 'পুরো দল';

  @override
  String everyWeekdays(String days) {
    return 'প্রতি সপ্তাহে: $days';
  }

  @override
  String get unavailableEveryWeek => 'যেসব দিনে আপনি কখনও উপলব্ধ নন:';

  @override
  String get choosePeriod => 'তারিখ বাছুন';

  @override
  String get choosePeriodOptional => 'একটি সময়কালে সীমিত করুন (ঐচ্ছিক)';

  @override
  String get clearPeriod => 'কোনো সময়কাল নেই';

  @override
  String get sendRequest => 'অনুরোধ পাঠান';

  @override
  String get proposeSwap => 'অদলবদলের প্রস্তাব দিন';

  @override
  String get swapWith => 'প্রস্তাব দিন';

  @override
  String get swapSteps =>
      'সহকর্মী গ্রহণ করেন, তারপর ব্যবস্থাপক অনুমোদন দেন। এরপরই সময়সূচি বদলায়।';

  @override
  String get absentThatDay => 'সেদিন অনুমোদিত অনুপস্থিতি';

  @override
  String get requestSent => 'অনুরোধ পাঠানো হয়েছে।';

  @override
  String noticeSwapOffer(String name) {
    return '$name আপনাকে তাঁর একটি শিফট দিতে চান।';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name আপনার অদলবদলের প্রস্তাব প্রত্যাখ্যান করেছেন।';
  }

  @override
  String get noticeSwapToApprove =>
      'একটি শিফট অদলবদল আপনার অনুমোদনের অপেক্ষায়।';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name ছুটি চাইছেন।';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name অনুপলব্ধতা জানিয়েছেন।';
  }

  @override
  String get noticeRequestApproved => 'আপনার অনুরোধ গৃহীত হয়েছে।';

  @override
  String get noticeRequestRefused => 'আপনার অনুরোধ প্রত্যাখ্যাত হয়েছে।';

  @override
  String get choosePeer => 'এই শিফট কে নেবেন?';

  @override
  String get discardAll => 'সব বাতিল করুন';

  @override
  String get notifySitesHint =>
      'যেসব স্থানের অনুরোধের বিজ্ঞপ্তি পেতে চান সেগুলো বেছে নিন। সব অনুরোধ তালিকায় দেখা যাবে।';

  @override
  String get notifySitesTitle => 'স্থান অনুযায়ী বিজ্ঞপ্তি';

  @override
  String get pendingRequestTooltip => 'অপেক্ষমাণ অনুরোধ: খুলতে ট্যাপ করুন';

  @override
  String get requestsHistory => 'সব অনুরোধ';

  @override
  String get revertChange => 'এই পরিবর্তন বাতিল করুন';

  @override
  String get statusExpired => 'আর প্রযোজ্য নয়';

  @override
  String get swapWithHint => 'নির্দিষ্ট সহকর্মী বাছতে ট্যাপ করুন';

  @override
  String changesDiscarded(String count) {
    return 'বাতিল পরিবর্তন: $count';
  }

  @override
  String discardConfirm(String count) {
    return '$countটি অপ্রকাশিত পরিবর্তন বাতিল করবেন?';
  }

  @override
  String get allSchedules => 'আমার সব সময়সূচি';

  @override
  String get busyElsewhere => 'এই সময়ে ইতিমধ্যে অন্য কোম্পানিতে কাজে আছেন';

  @override
  String get overlapTooltip => 'অন্য কোম্পানির শিফটের সঙ্গে মিলে যায়';

  @override
  String get overlapWarning =>
      'দুটি কোম্পানিতে আপনার কিছু শিফট একে অপরের সঙ্গে মিলে যাচ্ছে।';

  @override
  String noticeOverlap(String date) {
    return '$date তারিখে ভিন্ন কোম্পানিতে আপনার দুটি শিফট একে অপরের সঙ্গে মিলে যাচ্ছে।';
  }

  @override
  String get allMyCompanies => 'আমার সব কোম্পানি';

  @override
  String get deleteGroup => 'গ্রুপ মুছুন';

  @override
  String get openRequest => 'অনুরোধ দেখুন';

  @override
  String get thisCompany => 'এই কোম্পানি';

  @override
  String get withExtras => 'অস্থায়ী কর্মীসহ';

  @override
  String deleteGroupConfirm(String name) {
    return 'সবার জন্য “$name” ও এর সব বার্তা মুছবেন?';
  }

  @override
  String reinforcementHint(String company) {
    return '$company থেকে: সহায়ক কর্মী হিসেবে যোগ করা হবে ও জানানো হবে।';
  }

  @override
  String get addToGoogle => 'Google ক্যালেন্ডারে যোগ করুন';

  @override
  String get calendarEnabled => 'আমার শিফট সিঙ্ক করুন';

  @override
  String get calendarHint =>
      'আপনার সব কোম্পানির শিফট Google ক্যালেন্ডারে যোগ করুন। এগুলো নিজে থেকেই হালনাগাদ হয়, আর যেকোনো সময় বন্ধ করা যায়।';

  @override
  String get changeSettings => 'পরিবর্তন';

  @override
  String get copyCalendarLink => 'ক্যালেন্ডারের লিংক কপি করুন';

  @override
  String get countryBelgium => 'বেলজিয়াম';

  @override
  String get countryCanada => 'কানাডা';

  @override
  String get countryFrance => 'ফ্রান্স';

  @override
  String get countrySwitzerland => 'সুইজারল্যান্ড';

  @override
  String get employeesSection => 'কর্মী';

  @override
  String get emptyNoAlert => 'খালি: কোনো সতর্কতা নেই';

  @override
  String get extrasSection => 'অস্থায়ী কর্মী';

  @override
  String get googleCalendar => 'Google ক্যালেন্ডার';

  @override
  String get hoursTotals => 'মোট ঘণ্টা';

  @override
  String get legalAlerts => 'আইনি সতর্কতা';

  @override
  String get legalAlertsHint =>
      'শুধু সতর্কতা, কখনো বাধা নয়। আপনার জন্য প্রযোজ্য নিয়ম বেছে নিন, বা কোনোটিই নয়।';

  @override
  String get legalPreset => 'দেশভিত্তিক টেমপ্লেট';

  @override
  String get linkCopied => 'লিংক কপি হয়েছে।';

  @override
  String get maxConsecutiveLabel => 'সর্বোচ্চ টানা কর্মদিবস';

  @override
  String get maxDayLabel => 'দিনে সর্বোচ্চ সময় (ঘণ্টা)';

  @override
  String get maxWeekLabel => 'সপ্তাহে সর্বোচ্চ সময় (ঘণ্টা)';

  @override
  String get minRestLabel => 'দুই শিফটের মাঝে ন্যূনতম বিশ্রাম (ঘণ্টা)';

  @override
  String get noLegalRules => 'কোনো সতর্কতা বেছে নেওয়া হয়নি।';

  @override
  String get presetNone => 'কোনোটি নয়';

  @override
  String get presetsCheck =>
      'টেমপ্লেট শুধু শুরু: আপনার দেশের নিয়ম ও যৌথ চুক্তি অনুযায়ী যাচাই করুন।';

  @override
  String get printMine => 'আমার সময়সূচি';

  @override
  String get printOwn => 'শুধু নিজেদের সময়সূচি';

  @override
  String get printPdf => 'প্রিন্ট / PDF';

  @override
  String get printRights => 'কর্মীরা যা প্রিন্ট করতে পারেন';

  @override
  String get printTeam => 'পুরো দলের সময়সূচি';

  @override
  String get printTeamOption => 'দলের সময়সূচি';

  @override
  String get totalsHint =>
      'খসড়া সহ। Excel ও CSV রপ্তানি প্রকাশিত সময়সূচি ব্যবহার করে।';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: টানা $value দিন (সর্বোচ্চ $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: দিনে $value (সর্বোচ্চ $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: মাত্র $value বিশ্রাম (ন্যূনতম $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: সপ্তাহে $value (সর্বোচ্চ $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'আইনি সতর্কতা: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'শিফট: $count';
  }

  @override
  String get actionMakeDeputy => 'উপ-ব্যবস্থাপক নিযুক্ত করুন';

  @override
  String get actionRemoveDeputy => 'উপ-ব্যবস্থাপকের ভূমিকা সরান';

  @override
  String get busyHere => 'এই সময়ে ইতিমধ্যে এই কোম্পানিতে কাজে আছেন';

  @override
  String get calendarByLink => 'লিংকের মাধ্যমে (কম্পিউটারে Google ক্যালেন্ডার)';

  @override
  String get calendarDenied =>
      'ক্যালেন্ডারের অনুমতি দেওয়া হয়নি। ফোনের সেটিংসে অনুমতি দিন।';

  @override
  String get calendarLinkHint =>
      'কম্পিউটারে Google ক্যালেন্ডার থেকে যোগ করুন; Google কয়েক ঘণ্টায় হালনাগাদ করে।';

  @override
  String get calendarNone => 'এই ফোনে সম্পাদনযোগ্য কোনো ক্যালেন্ডার নেই।';

  @override
  String get calendarOnPhone => 'আমার শিফট ফোনের ক্যালেন্ডারে যোগ করুন';

  @override
  String get calendarOnPhoneHint =>
      'আপনার Google ক্যালেন্ডারে: ফোন ও Google ক্যালেন্ডারে সঙ্গে সঙ্গে দেখা যাবে।';

  @override
  String get chooseCalendar => 'ক্যালেন্ডার বাছুন';

  @override
  String get otherSiteHint =>
      'অন্য স্থানের কর্মী: তাঁর ব্যবস্থাপকদের জানানো হবে।';

  @override
  String get subManager => 'উপ-ব্যবস্থাপক';

  @override
  String calendarSynced(String count) {
    return 'ক্যালেন্ডারে শিফট: $count';
  }

  @override
  String deputyOf(String name) {
    return 'উপ-ব্যবস্থাপক: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by $date তারিখে $name-কে $site-এ রেখেছেন।';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company আপনাকে সহায়ক কর্মী হিসেবে যোগ করেছে।';
  }

  @override
  String get companyNotificationsHint =>
      'বন্ধ: এই ফোনে কিছু বাজবে না, তবে সব ঘণ্টায় থেকে যাবে।';

  @override
  String get companyNotificationsOn => 'এই কোম্পানির বিজ্ঞপ্তি পান';

  @override
  String get companyTimezone => 'কোম্পানির সময় অঞ্চল';

  @override
  String get companyTimezoneHint =>
      'এই কোম্পানির সব সময় এই সময় অঞ্চলে (দিবালোক সংরক্ষণ সহ)। ক্যালেন্ডার নিজে থেকে রূপান্তর করে।';

  @override
  String get iosInstallHint =>
      'iPhone-এ: শেয়ার ট্যাপ করুন, তারপর “হোম স্ক্রিনে যোগ করুন” দিয়ে Staff Flow ইনস্টল করুন।';

  @override
  String get searchCity => 'শহর খুঁজুন';

  @override
  String get thisPhone => 'এই ডিভাইস';

  @override
  String companyNotifications(String name) {
    return 'বিজ্ঞপ্তি: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'সময় $zone-এর সময় অনুযায়ী ($company)। আপনার ডিভাইস: $here।';
  }

  @override
  String get addPreset => 'প্রিসেট যোগ করুন';

  @override
  String get addPresets => 'প্রিসেট তৈরি করুন';

  @override
  String get appearance => 'চেহারা';

  @override
  String get chooseLogo => 'PNG ছবি বাছুন';

  @override
  String get conversationMuted => 'এই কথোপকথনের বিজ্ঞপ্তি বন্ধ করা হয়েছে।';

  @override
  String get conversationUnmuted => 'এই কথোপকথনের বিজ্ঞপ্তি আবার চালু হয়েছে।';

  @override
  String get customization => 'নিজের মতো সাজানো';

  @override
  String get disableGroup => 'গ্রুপ বন্ধ করুন';

  @override
  String get disableGroupConfirm =>
      'পুরো কোম্পানির গ্রুপ সবার কাছ থেকে লুকানো হবে। বার্তা থেকে আবার চালু করতে পারবেন।';

  @override
  String get editPresets => 'প্রিসেট';

  @override
  String get enable => 'আবার চালু করুন';

  @override
  String get groupDisabled => 'গ্রুপ বন্ধ (শুধু আপনি দেখছেন)';

  @override
  String get logoHint =>
      'কোম্পানির ট্যাবে দেখানো ছোট PNG ছবি (আপনার লোগো), সব সদস্যের জন্য।';

  @override
  String get logoPngOnly => '১ MB পর্যন্ত PNG ছবি বাছুন।';

  @override
  String get muteConversation => 'এই কথোপকথন নীরব করুন';

  @override
  String get myIdentifier => 'আমার শনাক্তকারী';

  @override
  String get myProfile => 'আমার প্রোফাইল';

  @override
  String get presetName => 'নাম (যেমন সকাল)';

  @override
  String get removeLogo => 'ছবি সরান';

  @override
  String get resetGroup => 'গ্রুপ রিসেট করুন';

  @override
  String get resetGroupConfirm =>
      'কোম্পানির গ্রুপের সব বার্তা সবার জন্য মুছে যাবে।';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get shiftPresets => 'শিফটের সময় প্রিসেট';

  @override
  String get shiftPresetsHint =>
      'তৈরি সময় (সকাল, সন্ধ্যা, রাত…): শিফটে এক ট্যাপে শুরু ও শেষ পূরণ হয়।';

  @override
  String get themeDark => 'গাঢ়';

  @override
  String get themeLight => 'হালকা';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get unmuteConversation => 'এই কথোপকথনের বিজ্ঞপ্তি চালু করুন';

  @override
  String get awaitingApproval => 'অনুমোদন বাকি';

  @override
  String get placementNeedsApproval =>
      '! এই ব্যক্তি আপনার সাইটের নন: প্রকাশের আগে শিফটটি আপনার ঊর্ধ্বতন বা মালিকের অনুমোদনের অপেক্ষায় থাকবে। নইলে অন্য কাউকে বেছে নিন।';

  @override
  String get placementAwaiting => 'ঊর্ধ্বতন বা মালিকের অনুমোদনের অপেক্ষায়।';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by অন্য সাইটের $name-কে $date তারিখে রাখতে চান: অনুমোদন দরকার।';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by $date তারিখে $name-এর নিয়োগ অনুমোদন করেছেন।';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by $date তারিখে $name-এর নিয়োগ প্রত্যাখ্যান করেছেন।';
  }

  @override
  String get addSubSite => 'উপ-সাইট যোগ করুন';

  @override
  String get moveSite => 'সরান';

  @override
  String get topLevel => 'প্রথম স্তর';

  @override
  String moveSiteTitle(String name) {
    return '“$name” কে এর নিচে সরান…';
  }

  @override
  String subSiteOf(String name) {
    return '$name-এর উপ-সাইট';
  }

  @override
  String get siteTreeHint =>
      'সর্বোচ্চ ৩ স্তর, যেমন অঞ্চল › শহর › দোকান। কোনো সাইটের ম্যানেজার তার নিচের সবকিছুও পরিচালনা করেন।';

  @override
  String get subSitesOnlyHint =>
      'এখানে আপনি নিজের সাইটের নিচে উপ-সাইট যোগ করেন।';

  @override
  String get messagingSetting => 'প্রতিষ্ঠানের বার্তা';

  @override
  String get messagingSettingHint =>
      'চালু: দলের একটি বার্তা ট্যাব থাকে। বন্ধ: কেউ এটি দেখে না বা লিখতে পারে না (পুরনো বার্তা রাখা হয়)।';
}
