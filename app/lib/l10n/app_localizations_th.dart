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
}
