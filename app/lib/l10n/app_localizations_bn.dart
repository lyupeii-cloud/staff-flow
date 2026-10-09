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
  String get viewTeam => 'দল';

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
}
