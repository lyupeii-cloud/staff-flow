// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class L10nTh extends L10n {
  L10nTh([String locale = 'th']) : super(locale);

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get save => 'บันทึก';

  @override
  String get confirm => 'ยืนยัน';

  @override
  String get validate => 'ยืนยัน';

  @override
  String get add => 'เพิ่ม';

  @override
  String get rename => 'เปลี่ยนชื่อ';

  @override
  String get delete => 'ลบ';

  @override
  String get accept => 'ยอมรับ';

  @override
  String get decline => 'ปฏิเสธ';

  @override
  String get close => 'ปิด';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get name => 'ชื่อ';

  @override
  String get serverUnreachable => 'ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้';

  @override
  String errorStatus(int status) {
    return 'ข้อผิดพลาด $status';
  }

  @override
  String get roleOwner => 'เจ้าของ';

  @override
  String get roleManager => 'ผู้จัดการ';

  @override
  String get roleEmployee => 'พนักงาน';

  @override
  String get roleExtra => 'พนักงานชั่วคราว';

  @override
  String get taglineStart => 'ตารางงานของทีมคุณ ';

  @override
  String get taglineEnd => 'ทุกที่';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'ลงชื่อเข้าใช้ด้วย Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'ไม่สามารถใช้การลงชื่อเข้าใช้ด้วย Google ได้: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'ลงชื่อเข้าใช้ด้วย Google ไม่สำเร็จ: $detail';
  }

  @override
  String get newCompany => 'บริษัทใหม่';

  @override
  String get timezone => 'เขตเวลา';

  @override
  String get create => 'สร้าง';

  @override
  String get noCompanyTitle => 'คุณยังไม่ได้อยู่ในบริษัทใด';

  @override
  String get noCompanyHint =>
      'หากต้องการเข้าร่วมบริษัทของนายจ้าง ให้สร้างรหัสแล้วส่งให้ผู้จัดการของคุณ';

  @override
  String get joinCompany => 'เข้าร่วมบริษัท';

  @override
  String get createCompany => 'สร้างบริษัท';

  @override
  String transferOffer(String company) {
    return 'คุณได้รับข้อเสนอให้เป็นเจ้าของ “$company”';
  }

  @override
  String get someCompany => 'บริษัทหนึ่ง';

  @override
  String get becameOwner => 'ตอนนี้คุณเป็นเจ้าของแล้ว';

  @override
  String get myAccount => 'บัญชีของฉัน';

  @override
  String get idCopied => 'คัดลอกรหัสประจำตัวแล้ว';

  @override
  String myId(String id) {
    return 'รหัสประจำตัวของฉัน: $id';
  }

  @override
  String get signOut => 'ออกจากระบบ';

  @override
  String joinInvite(String company, String role) {
    return '“$company” เชิญคุณในฐานะ$role';
  }

  @override
  String joinedCompany(String company) {
    return 'คุณเข้าร่วม $company แล้ว';
  }

  @override
  String get viewPlanning => 'ตารางงาน';

  @override
  String get viewTeam => 'ทีม';

  @override
  String get viewPositions => 'ตำแหน่ง';

  @override
  String get readOnlyCompany => 'บริษัทนี้ดูได้อย่างเดียว';

  @override
  String get team => 'ทีม';

  @override
  String get leaveCompany => 'ออกจากบริษัทนี้';

  @override
  String meSuffix(String name) {
    return '$name (คุณ)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'โอนบริษัทให้ $name หรือไม่';
  }

  @override
  String get transferConfirmBody =>
      'เมื่อยอมรับแล้ว บุคคลนี้จะเป็นเจ้าของ (การสมัครใช้งาน ใบแจ้งหนี้ ผู้จัดการ) และคุณจะเป็นผู้จัดการ';

  @override
  String transferSent(String name) {
    return 'ส่งข้อเสนอให้ $name แล้ว';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'นำ $name ออกหรือไม่';
  }

  @override
  String get removeConfirmBody => 'ประวัติจะยังถูกเก็บไว้';

  @override
  String get addPersonTitle => 'เพิ่มบุคคล';

  @override
  String get addPersonHint =>
      'ขอให้เขาเปิด Staff Flow ไปที่เมนูบัญชี เลือก “เข้าร่วมบริษัท” แล้วป้อนรหัสที่แสดง';

  @override
  String get sixDigitCode => 'รหัส 6 หลัก';

  @override
  String invitationSent(String name) {
    return 'ส่งคำเชิญให้ $name แล้ว: ต้องตอบรับก่อน';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'ออกจาก $company หรือไม่';
  }

  @override
  String get leaveConfirmBody => 'คุณจะไม่เห็นตารางงานของบริษัทนี้อีก';

  @override
  String get renameCompany => 'เปลี่ยนชื่อบริษัท';

  @override
  String get actionMakeManager => 'ตั้งเป็นผู้จัดการ';

  @override
  String get actionMakeEmployee => 'กลับเป็นพนักงาน';

  @override
  String get actionToEmployee => 'เปลี่ยนเป็นพนักงาน';

  @override
  String get actionToExtra => 'เปลี่ยนเป็นพนักงานชั่วคราว';

  @override
  String get actionTransfer => 'โอนความเป็นเจ้าของ';

  @override
  String get actionRemove => 'นำออกจากบริษัท';

  @override
  String get positions => 'ตำแหน่ง';

  @override
  String get sites => 'สาขา';

  @override
  String get positionsHint => 'งานที่ทำ: แคชเชียร์ ครัว ต้อนรับ…';

  @override
  String get sitesHint => 'สถานที่ทำกะ หากบริษัทมีหลายสาขา';

  @override
  String get archived => 'เก็บถาวรแล้ว';

  @override
  String get archive => 'เก็บถาวร';

  @override
  String get reactivate => 'เปิดใช้อีกครั้ง';

  @override
  String weekOf(String date) {
    return 'สัปดาห์ของ $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'เผยแพร่การเปลี่ยนแปลง $count รายการแล้ว',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'กะ';

  @override
  String get display => 'มุมมอง';

  @override
  String get week => 'สัปดาห์';

  @override
  String get month => 'เดือน';

  @override
  String get today => 'วันนี้';

  @override
  String get onlyMine => 'เฉพาะกะของฉัน';

  @override
  String get replacePersonMenu => 'เปลี่ยนตัวบุคคล…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'การเปลี่ยนแปลงที่ยังไม่เผยแพร่ $count รายการ',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'พนักงานยังมองไม่เห็น';

  @override
  String get publish => 'เผยแพร่';

  @override
  String yourHours(String duration) {
    return 'ชั่วโมงของคุณในช่วงนี้: $duration';
  }

  @override
  String get addShiftThisDay => 'เพิ่มกะในวันนี้';

  @override
  String get noShift => 'ไม่มีกะ';

  @override
  String get unassigned => 'ยังไม่ได้มอบหมาย';

  @override
  String get formerMember => 'อดีตสมาชิก';

  @override
  String get statusDraft => 'ฉบับร่าง';

  @override
  String get statusModified => 'แก้ไขแล้ว';

  @override
  String get statusDeleted => 'ลบแล้ว';

  @override
  String durationHours(int hours) {
    return '$hours ชม.';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours ชม. $minutes นาที';
  }

  @override
  String get editShift => 'แก้ไขกะ';

  @override
  String get newShift => 'กะใหม่';

  @override
  String get thisShift => 'เฉพาะกะนี้';

  @override
  String get thisAndFollowing => 'กะนี้และกะถัดไป';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'วัน',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'วันอื่น';

  @override
  String get start => 'เริ่ม';

  @override
  String get end => 'สิ้นสุด';

  @override
  String get endsNextDay => 'สิ้นสุดในวันถัดไป';

  @override
  String get person => 'บุคคล';

  @override
  String get position => 'ตำแหน่ง';

  @override
  String get site => 'สาขา';

  @override
  String get noteOptional => 'หมายเหตุ (ไม่บังคับ)';

  @override
  String get repetition => 'การทำซ้ำ';

  @override
  String get repeatNone => 'ไม่ทำซ้ำ';

  @override
  String get repeatDaily => 'ทุกวัน';

  @override
  String get repeatWeekly => 'ทุกสัปดาห์';

  @override
  String get repeatForPrefix => 'เป็นเวลา ';

  @override
  String get repeatDaysSuffix => ' วัน';

  @override
  String get repeatWeeksSuffix => ' สัปดาห์';

  @override
  String get repeatUntilPrefix => 'จนถึง ';

  @override
  String get replacePersonTitle => 'เปลี่ยนตัวบุคคล';

  @override
  String get replaceFrom => 'เปลี่ยน';

  @override
  String get replaceBy => 'เป็น';

  @override
  String dateRange(String from, String to) {
    return 'ตั้งแต่ $from ถึง $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'เปลี่ยนแปลง $count กะแล้ว',
      zero: 'ไม่มีกะที่เปลี่ยนแปลง',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'เปลี่ยน';

  @override
  String get joinHint =>
      'ส่งรหัสนี้ให้ผู้จัดการของคุณ เมื่อป้อนในแอปแล้ว คุณจะได้รับคำเชิญให้ตอบรับ';

  @override
  String get codeExpired => 'รหัสหมดอายุแล้ว';

  @override
  String codeValidFor(String time) {
    return 'ใช้ได้อีก $time';
  }

  @override
  String get newCode => 'รหัสใหม่';

  @override
  String get language => 'ภาษา';

  @override
  String get languageAuto => 'อัตโนมัติ (ภาษาของอุปกรณ์)';

  @override
  String get syncUpToDate => 'ล่าสุดแล้ว';

  @override
  String get syncOffline => 'ออฟไลน์';

  @override
  String syncPending(int count) {
    return 'การเปลี่ยนแปลงที่รอส่ง: $count';
  }

  @override
  String get syncNow => 'ซิงค์ตอนนี้';

  @override
  String syncRejected(String reason) {
    return 'เซิร์ฟเวอร์ปฏิเสธการเปลี่ยนแปลง: $reason';
  }

  @override
  String get pendingBadge => 'รอส่ง';

  @override
  String get offlineUnavailable => 'ใช้ไม่ได้เมื่อออฟไลน์';

  @override
  String get offlineCached => 'ออฟไลน์: แสดงข้อมูลที่บันทึกล่าสุด';

  @override
  String get savedOffline => 'บันทึกไว้ในอุปกรณ์แล้ว จะส่งเมื่อมีเครือข่าย';

  @override
  String get notices => 'การแจ้งเตือน';

  @override
  String get noNotices => 'ไม่มีการแจ้งเตือน';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name แทนที่การแก้ไขกะวันที่ $date ของคุณ';
  }

  @override
  String get history => 'ประวัติ';

  @override
  String get recentChanges => 'การเปลี่ยนแปลงล่าสุด';

  @override
  String get undoChange => 'เลิกทำการเปลี่ยนแปลงนี้';

  @override
  String get undoDone => 'เลิกทำแล้ว';

  @override
  String get historyCreate => 'สร้าง';

  @override
  String get historyUpdate => 'แก้ไข';

  @override
  String get historyDelete => 'ลบ';

  @override
  String get historyUndo => 'เลิกทำ';

  @override
  String get noHistory => 'ไม่มีการเปลี่ยนแปลง';

  @override
  String get pendingNotEditable =>
      'กะนี้ยังไม่ได้ซิงค์: ลองอีกครั้งเมื่อออนไลน์';

  @override
  String get myQrCode => 'คิวอาร์โค้ดของฉัน';

  @override
  String get myQrCodeHint =>
      'ผู้จัดการสแกนโค้ดนี้เพื่อเพิ่มคุณเข้าบริษัท จากนั้นคุณยืนยัน โค้ดนี้ไม่มีวันเปลี่ยน';

  @override
  String get changeMyName => 'เปลี่ยนชื่อของฉัน';

  @override
  String get nameShownToTeam =>
      'เพื่อนร่วมงานจะเห็นชื่อนี้แทนชื่อ Google ของคุณ';

  @override
  String googleName(String name) {
    return 'ชื่อ Google: $name';
  }

  @override
  String get useGoogleName => 'ใช้ชื่อ Google ของฉัน';

  @override
  String renameMemberTitle(String name) {
    return 'เปลี่ยนชื่อ $name';
  }

  @override
  String get renameMemberHint => 'ชื่อนี้ใช้เฉพาะในบริษัทนี้';

  @override
  String get useOwnName => 'ใช้ชื่อของเขาเอง';

  @override
  String get scanQrCode => 'สแกนคิวอาร์โค้ด';

  @override
  String get scanQrHint =>
      'หันกล้องไปที่คิวอาร์โค้ดในแอปของเขา (เมนูบัญชี “คิวอาร์โค้ดของฉัน”)';

  @override
  String get orEnterCode => 'หรือป้อนรหัส 6 หลักของเขา';

  @override
  String get qrInvalid => 'นี่ไม่ใช่คิวอาร์โค้ดของ Staff Flow';

  @override
  String cameraUnavailable(String error) {
    return 'ใช้กล้องไม่ได้ ($error)';
  }

  @override
  String get notificationsTitle => 'การแจ้งเตือน';

  @override
  String get notifChooseHint =>
      'เลือกเรื่องที่ต้องการรับการแจ้งเตือน ทุกอย่างยังดูได้ที่กระดิ่ง';

  @override
  String get notifPlanning => 'ตารางงานเผยแพร่หรือแก้ไข';

  @override
  String get notifRequests => 'คำขอ: แลกกะ ลางาน คำเชิญ';

  @override
  String get notifMessages => 'ข้อความใหม่';

  @override
  String get notifOverlap => 'กะทำงานซ้อนกันระหว่างบริษัท';

  @override
  String get notifConflicts => 'การแก้ไขของคุณถูกผู้จัดการคนอื่นแทนที่';

  @override
  String get notifBilling => 'การแจ้งเตือนการสมัครใช้งาน';

  @override
  String get pushEnabled => 'เปิดการแจ้งเตือนบนอุปกรณ์นี้แล้ว';

  @override
  String get pushOff => 'ปิดการแจ้งเตือนบนอุปกรณ์นี้อยู่';

  @override
  String get pushBlocked =>
      'การแจ้งเตือนถูกบล็อก: อนุญาตในการตั้งค่าของโทรศัพท์หรือเบราว์เซอร์';

  @override
  String get pushUnavailable => 'อุปกรณ์นี้ใช้การแจ้งเตือนไม่ได้';

  @override
  String get enablePush => 'เปิด';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: ตารางงานของคุณได้รับการเผยแพร่หรือแก้ไขแล้ว';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company ต้องการเพิ่มคุณเข้าทีม';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name เสนอให้คุณเป็นเจ้าของ $company';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name เข้าร่วม $company แล้ว';
  }

  @override
  String get messagesTab => 'ข้อความ';

  @override
  String get wholeTeam => 'ทั้งทีม';

  @override
  String get newConversation => 'การสนทนาใหม่';

  @override
  String get noMessages => 'ยังไม่มีข้อความ';

  @override
  String get messageHint => 'เขียนข้อความ';

  @override
  String get earlierMessages => 'ข้อความก่อนหน้า';

  @override
  String get personLeftCompany => 'บุคคลนี้ไม่ได้อยู่ในบริษัทแล้ว';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'กลุ่มใหม่';

  @override
  String get editGroup => 'แก้ไขกลุ่ม';

  @override
  String get groupName => 'ชื่อกลุ่ม';

  @override
  String get groupMembersHint =>
      'เลือกคนในกลุ่มนี้ เฉพาะพวกเขาเท่านั้นที่จะเห็นข้อความ';

  @override
  String get chooseAtLeastOne => 'เลือกอย่างน้อยหนึ่งคน';

  @override
  String get replyAction => 'ตอบกลับ';

  @override
  String get translateAction => 'แปล';

  @override
  String replyingTo(String name) {
    return 'ตอบกลับ $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'ข้อความล่าสุดจาก $name';
  }

  @override
  String get deleteAllNotices => 'ลบทั้งหมด';

  @override
  String get deleteAllNoticesConfirm => 'ลบการแจ้งเตือนทั้งหมดหรือไม่';

  @override
  String get noticeRetention => 'ลบการแจ้งเตือนที่อ่านแล้วหลังจาก';

  @override
  String get retentionDay => '1 วัน';

  @override
  String get retentionWeek => '1 สัปดาห์';

  @override
  String get retentionMonth => '1 เดือน';

  @override
  String get billingOwnersOnly => 'ใช้งานได้เฉพาะเมื่อคุณเป็นเจ้าของบริษัท';

  @override
  String get readOnlyPastDays => 'วันที่ผ่านมาเกินหนึ่งเดือนดูได้อย่างเดียว';

  @override
  String get wholeCompany => 'ทั้งบริษัท';

  @override
  String get sitesLabel => 'สาขา';

  @override
  String get actionSites => 'สาขา…';

  @override
  String managerOf(String name) {
    return '$name ดูแล';
  }

  @override
  String teamSitesOf(String name) {
    return 'ทีมของ $name';
  }

  @override
  String get notYourSite => 'สาขานี้ไม่อยู่ในความรับผิดชอบของคุณ';

  @override
  String get chooseYourSite => 'เลือกอย่างน้อยหนึ่งสาขา';

  @override
  String get viewRequests => 'คำขอ';

  @override
  String get newRequest => 'คำขอใหม่';

  @override
  String get requestLeave => 'ลางาน';

  @override
  String get requestUnavailability => 'ไม่สะดวกทำงาน';

  @override
  String get requestSwap => 'แลกกะ';

  @override
  String get swapHint =>
      'หากต้องการเสนอแลกกะ ให้แตะกะที่กำลังจะมาถึงของคุณในตารางงาน';

  @override
  String get noRequests => 'ยังไม่มีคำขอ';

  @override
  String get requestsToHandle => 'รอดำเนินการ';

  @override
  String get myRequests => 'คำขอของฉัน';

  @override
  String get otherRequests => 'คำขอของทีม';

  @override
  String get statusPendingPeer => 'รอเพื่อนร่วมงาน';

  @override
  String get statusPendingManager => 'รอหัวหน้า';

  @override
  String get statusApproved => 'อนุมัติแล้ว';

  @override
  String get statusRefused => 'ถูกปฏิเสธ';

  @override
  String get statusCancelled => 'ยกเลิกแล้ว';

  @override
  String get cancelRequest => 'ยกเลิกคำขอ';

  @override
  String get acceptSwap => 'รับกะนี้';

  @override
  String get approve => 'อนุมัติ';

  @override
  String periodLabel(String from, String to) {
    return 'ตั้งแต่ $from ถึง $to';
  }

  @override
  String swapToPeer(String name) {
    return 'เสนอให้ $name';
  }

  @override
  String get swapToTeam => 'ทั้งทีม';

  @override
  String everyWeekdays(String days) {
    return 'ทุกสัปดาห์: $days';
  }

  @override
  String get unavailableEveryWeek => 'วันที่คุณไม่สะดวกทำงานเลย:';

  @override
  String get choosePeriod => 'เลือกวันที่';

  @override
  String get choosePeriodOptional => 'จำกัดเป็นช่วงเวลา (ไม่บังคับ)';

  @override
  String get clearPeriod => 'ไม่มีช่วงเวลา';

  @override
  String get sendRequest => 'ส่งคำขอ';

  @override
  String get proposeSwap => 'เสนอแลกกะ';

  @override
  String get swapWith => 'เสนอให้';

  @override
  String get swapSteps =>
      'เพื่อนร่วมงานตอบรับ แล้วหัวหน้าอนุมัติ ตารางงานจะเปลี่ยนหลังจากนั้นเท่านั้น';

  @override
  String get absentThatDay => 'มีการลาที่อนุมัติแล้วในวันนั้น';

  @override
  String get requestSent => 'ส่งคำขอแล้ว';

  @override
  String noticeSwapOffer(String name) {
    return '$name เสนอกะหนึ่งของเขาให้คุณ';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name ปฏิเสธข้อเสนอแลกกะของคุณ';
  }

  @override
  String get noticeSwapToApprove => 'มีการแลกกะรอให้คุณอนุมัติ';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name ขอลางาน';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name แจ้งว่าไม่สะดวกทำงาน';
  }

  @override
  String get noticeRequestApproved => 'คำขอของคุณได้รับการอนุมัติ';

  @override
  String get noticeRequestRefused => 'คำขอของคุณถูกปฏิเสธ';

  @override
  String get choosePeer => 'ใครจะรับกะนี้';

  @override
  String get discardAll => 'ยกเลิกทั้งหมด';

  @override
  String get notifySitesHint =>
      'เลือกสาขาที่คุณต้องการรับการแจ้งเตือนคำขอ คำขอทั้งหมดยังคงแสดงในรายการ';

  @override
  String get notifySitesTitle => 'การแจ้งเตือนตามสาขา';

  @override
  String get pendingRequestTooltip => 'คำขอที่รออยู่: แตะเพื่อเปิด';

  @override
  String get requestsHistory => 'คำขอทั้งหมด';

  @override
  String get revertChange => 'ยกเลิกการเปลี่ยนแปลงนี้';

  @override
  String get statusExpired => 'ไม่มีผลแล้ว';

  @override
  String get swapWithHint => 'แตะเพื่อเลือกเพื่อนร่วมงานที่ต้องการ';

  @override
  String changesDiscarded(String count) {
    return 'ยกเลิกการเปลี่ยนแปลงแล้ว: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'ยกเลิกการเปลี่ยนแปลงที่ยังไม่เผยแพร่ $count รายการใช่ไหม';
  }

  @override
  String get allSchedules => 'ตารางงานทั้งหมดของฉัน';

  @override
  String get busyElsewhere => 'มีกะที่บริษัทอื่นในช่วงเวลานี้แล้ว';

  @override
  String get overlapTooltip => 'ทับซ้อนกับกะของบริษัทอื่น';

  @override
  String get overlapWarning => 'กะบางกะของคุณในสองบริษัททับซ้อนกัน';

  @override
  String noticeOverlap(String date) {
    return 'กะสองกะของคุณในบริษัทต่างกันทับซ้อนกันในวันที่ $date';
  }

  @override
  String get allMyCompanies => 'บริษัททั้งหมดของฉัน';

  @override
  String get deleteGroup => 'ลบกลุ่ม';

  @override
  String get openRequest => 'ดูคำขอ';

  @override
  String get thisCompany => 'บริษัทนี้';

  @override
  String get withExtras => 'รวมพนักงานชั่วคราว';

  @override
  String deleteGroupConfirm(String name) {
    return 'ลบ “$name” และข้อความทั้งหมดสำหรับทุกคนใช่ไหม';
  }

  @override
  String reinforcementHint(String company) {
    return 'จาก $company: จะถูกเพิ่มเป็นกำลังเสริมและได้รับแจ้ง';
  }

  @override
  String get addToGoogle => 'เพิ่มลงใน Google ปฏิทิน';

  @override
  String get calendarEnabled => 'ซิงค์กะของฉัน';

  @override
  String get calendarHint =>
      'เพิ่มกะจากทุกบริษัทของคุณลงใน Google ปฏิทิน กะจะอัปเดตเอง และคุณปิดได้ทุกเมื่อ';

  @override
  String get changeSettings => 'แก้ไข';

  @override
  String get copyCalendarLink => 'คัดลอกลิงก์ปฏิทิน';

  @override
  String get countryBelgium => 'เบลเยียม';

  @override
  String get countryCanada => 'แคนาดา';

  @override
  String get countryFrance => 'ฝรั่งเศส';

  @override
  String get countrySwitzerland => 'สวิตเซอร์แลนด์';

  @override
  String get employeesSection => 'พนักงาน';

  @override
  String get emptyNoAlert => 'เว้นว่าง: ไม่มีการแจ้งเตือน';

  @override
  String get extrasSection => 'พนักงานชั่วคราว';

  @override
  String get googleCalendar => 'Google ปฏิทิน';

  @override
  String get hoursTotals => 'ยอดรวมชั่วโมง';

  @override
  String get legalAlerts => 'การแจ้งเตือนตามกฎหมาย';

  @override
  String get legalAlertsHint =>
      'เป็นเพียงคำเตือน ไม่มีการบล็อก เลือกกฎที่ใช้กับคุณ หรือไม่เลือกเลย';

  @override
  String get legalPreset => 'แม่แบบตามประเทศ';

  @override
  String get linkCopied => 'คัดลอกลิงก์แล้ว';

  @override
  String get maxConsecutiveLabel => 'จำนวนวันทำงานติดต่อกันสูงสุด';

  @override
  String get maxDayLabel => 'ระยะเวลาสูงสุดต่อวัน (ชั่วโมง)';

  @override
  String get maxWeekLabel => 'ระยะเวลาสูงสุดต่อสัปดาห์ (ชั่วโมง)';

  @override
  String get minRestLabel => 'เวลาพักขั้นต่ำระหว่างกะ (ชั่วโมง)';

  @override
  String get noLegalRules => 'ยังไม่ได้เลือกการแจ้งเตือน';

  @override
  String get presetNone => 'ไม่มี';

  @override
  String get presetsCheck =>
      'แม่แบบเป็นเพียงจุดเริ่มต้น: โปรดตรวจสอบตามกฎหมายของประเทศและข้อตกลงร่วมของคุณ';

  @override
  String get printMine => 'ตารางงานของฉัน';

  @override
  String get printOwn => 'เฉพาะตารางงานของตนเอง';

  @override
  String get printPdf => 'พิมพ์ / PDF';

  @override
  String get printRights => 'สิ่งที่พนักงานพิมพ์ได้';

  @override
  String get printTeam => 'ตารางงานของทั้งทีม';

  @override
  String get printTeamOption => 'ตารางงานของทีม';

  @override
  String get totalsHint =>
      'รวมฉบับร่าง การส่งออก Excel และ CSV ใช้ตารางงานที่เผยแพร่แล้ว';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: ทำงาน $value วันติดต่อกัน (สูงสุด $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value ในหนึ่งวัน (สูงสุด $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: พักเพียง $value (ขั้นต่ำ $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value ในหนึ่งสัปดาห์ (สูงสุด $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'การแจ้งเตือนตามกฎหมาย: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'กะ: $count';
  }

  @override
  String get actionMakeDeputy => 'แต่งตั้งเป็นรองหัวหน้า';

  @override
  String get actionRemoveDeputy => 'ถอนบทบาทรองหัวหน้า';

  @override
  String get busyHere => 'มีกะในบริษัทนี้ช่วงเวลานี้แล้ว';

  @override
  String get calendarByLink => 'ผ่านลิงก์ (Google ปฏิทินบนคอมพิวเตอร์)';

  @override
  String get calendarDenied =>
      'ถูกปฏิเสธการเข้าถึงปฏิทิน อนุญาตได้ในการตั้งค่าโทรศัพท์';

  @override
  String get calendarLinkHint =>
      'เพิ่มจาก Google ปฏิทินบนคอมพิวเตอร์ Google จะอัปเดตภายในไม่กี่ชั่วโมง';

  @override
  String get calendarNone => 'ไม่มีปฏิทินที่แก้ไขได้ในโทรศัพท์นี้';

  @override
  String get calendarOnPhone => 'เพิ่มกะของฉันลงในปฏิทินของโทรศัพท์';

  @override
  String get calendarOnPhoneHint =>
      'ในปฏิทิน Google ของคุณ: เห็นได้ทันที ทั้งในโทรศัพท์และ Google ปฏิทิน';

  @override
  String get chooseCalendar => 'เลือกปฏิทิน';

  @override
  String get otherSiteHint => 'พนักงานจากสาขาอื่น: หัวหน้าของเขาจะได้รับแจ้ง';

  @override
  String get subManager => 'รองหัวหน้า';

  @override
  String calendarSynced(String count) {
    return 'กะในปฏิทิน: $count';
  }

  @override
  String deputyOf(String name) {
    return 'รองหัวหน้า: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by จัด $name ไปที่สาขา $site ในวันที่ $date';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company เพิ่มคุณเป็นกำลังเสริม';
  }
}
