// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class L10nVi extends L10n {
  L10nVi([String locale = 'vi']) : super(locale);

  @override
  String get cancel => 'Hủy';

  @override
  String get save => 'Lưu';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get validate => 'Xác nhận';

  @override
  String get add => 'Thêm';

  @override
  String get rename => 'Đổi tên';

  @override
  String get delete => 'Xóa';

  @override
  String get accept => 'Chấp nhận';

  @override
  String get decline => 'Từ chối';

  @override
  String get close => 'Đóng';

  @override
  String get retry => 'Thử lại';

  @override
  String get name => 'Tên';

  @override
  String get serverUnreachable => 'Không thể kết nối với máy chủ.';

  @override
  String errorStatus(int status) {
    return 'Lỗi $status';
  }

  @override
  String get roleOwner => 'Chủ sở hữu';

  @override
  String get roleManager => 'Quản lý';

  @override
  String get roleEmployee => 'Nhân viên';

  @override
  String get roleExtra => 'Nhân viên thời vụ';

  @override
  String get taglineStart => 'Lịch làm việc của đội bạn, ';

  @override
  String get taglineEnd => 'ở mọi nơi.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Đăng nhập bằng Google';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Không thể đăng nhập bằng Google: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Đăng nhập bằng Google thất bại: $detail';
  }

  @override
  String get newCompany => 'Công ty mới';

  @override
  String get timezone => 'Múi giờ';

  @override
  String get create => 'Tạo';

  @override
  String get noCompanyTitle => 'Bạn chưa thuộc công ty nào.';

  @override
  String get noCompanyHint =>
      'Để tham gia công ty của chủ lao động, hãy tạo mã và đưa cho người quản lý của bạn.';

  @override
  String get joinCompany => 'Tham gia công ty';

  @override
  String get createCompany => 'Tạo công ty';

  @override
  String transferOffer(String company) {
    return 'Bạn được đề nghị trở thành chủ sở hữu của “$company”.';
  }

  @override
  String get someCompany => 'một công ty';

  @override
  String get becameOwner => 'Giờ bạn là chủ sở hữu.';

  @override
  String get myAccount => 'Tài khoản của tôi';

  @override
  String get idCopied => 'Đã sao chép mã định danh.';

  @override
  String myId(String id) {
    return 'Mã định danh của tôi: $id';
  }

  @override
  String get signOut => 'Đăng xuất';

  @override
  String joinInvite(String company, String role) {
    return '“$company” mời bạn làm $role.';
  }

  @override
  String joinedCompany(String company) {
    return 'Bạn đã tham gia $company.';
  }

  @override
  String get viewPlanning => 'Lịch';

  @override
  String get viewTeam => 'Đội';

  @override
  String get viewPositions => 'Vị trí';

  @override
  String get readOnlyCompany => 'Công ty chỉ ở chế độ xem.';

  @override
  String get team => 'Đội';

  @override
  String get leaveCompany => 'Rời công ty này';

  @override
  String meSuffix(String name) {
    return '$name (bạn)';
  }

  @override
  String transferConfirmTitle(String name) {
    return 'Chuyển công ty cho $name?';
  }

  @override
  String get transferConfirmBody =>
      'Khi người đó chấp nhận, họ sẽ là chủ sở hữu (gói đăng ký, hóa đơn, quản lý) và bạn sẽ là quản lý.';

  @override
  String transferSent(String name) {
    return 'Đã gửi đề nghị cho $name.';
  }

  @override
  String removeConfirmTitle(String name) {
    return 'Xóa $name khỏi danh sách?';
  }

  @override
  String get removeConfirmBody => 'Lịch sử vẫn được giữ lại.';

  @override
  String get addPersonTitle => 'Thêm người';

  @override
  String get addPersonHint =>
      'Hãy nhờ người đó mở Staff Flow, vào menu tài khoản, chọn “Tham gia công ty”, rồi nhập mã hiển thị.';

  @override
  String get sixDigitCode => 'Mã 6 chữ số';

  @override
  String invitationSent(String name) {
    return 'Đã gửi lời mời cho $name: người đó cần chấp nhận.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return 'Rời $company?';
  }

  @override
  String get leaveConfirmBody => 'Bạn sẽ không còn thấy lịch của công ty này.';

  @override
  String get renameCompany => 'Đổi tên công ty';

  @override
  String get actionMakeManager => 'Đặt làm quản lý';

  @override
  String get actionMakeEmployee => 'Trở lại nhân viên';

  @override
  String get actionToEmployee => 'Chuyển thành nhân viên';

  @override
  String get actionToExtra => 'Chuyển thành thời vụ';

  @override
  String get actionTransfer => 'Chuyển quyền sở hữu';

  @override
  String get actionRemove => 'Xóa khỏi công ty';

  @override
  String get positions => 'Vị trí';

  @override
  String get sites => 'Địa điểm';

  @override
  String get positionsHint => 'Công việc của người đó: thu ngân, bếp, lễ tân…';

  @override
  String get sitesHint => 'Nơi diễn ra ca làm, nếu công ty có nhiều địa điểm.';

  @override
  String get archived => 'Đã lưu trữ';

  @override
  String get archive => 'Lưu trữ';

  @override
  String get reactivate => 'Kích hoạt lại';

  @override
  String weekOf(String date) {
    return 'Tuần $date';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã đăng $count thay đổi.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'Ca làm';

  @override
  String get display => 'Hiển thị';

  @override
  String get week => 'Tuần';

  @override
  String get month => 'Tháng';

  @override
  String get today => 'Hôm nay';

  @override
  String get onlyMine => 'Chỉ ca của tôi';

  @override
  String get replacePersonMenu => 'Thay người…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count thay đổi chưa đăng',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => 'Nhân viên chưa nhìn thấy.';

  @override
  String get publish => 'Đăng';

  @override
  String yourHours(String duration) {
    return 'Số giờ của bạn trong kỳ: $duration';
  }

  @override
  String get addShiftThisDay => 'Thêm ca vào ngày này';

  @override
  String get noShift => 'Không có ca';

  @override
  String get unassigned => 'Chưa phân công';

  @override
  String get formerMember => 'Thành viên cũ';

  @override
  String get statusDraft => 'Bản nháp';

  @override
  String get statusModified => 'Đã sửa';

  @override
  String get statusDeleted => 'Đã xóa';

  @override
  String durationHours(int hours) {
    return '$hours giờ';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours giờ $minutes phút';
  }

  @override
  String get editShift => 'Sửa ca làm';

  @override
  String get newShift => 'Ca làm mới';

  @override
  String get thisShift => 'Chỉ ca này';

  @override
  String get thisAndFollowing => 'Ca này và các ca sau';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ngày',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => 'Ngày khác';

  @override
  String get start => 'Bắt đầu';

  @override
  String get end => 'Kết thúc';

  @override
  String get endsNextDay => 'Kết thúc vào ngày hôm sau.';

  @override
  String get person => 'Người';

  @override
  String get position => 'Vị trí';

  @override
  String get site => 'Địa điểm';

  @override
  String get noteOptional => 'Ghi chú (không bắt buộc)';

  @override
  String get repetition => 'Lặp lại';

  @override
  String get repeatNone => 'Không';

  @override
  String get repeatDaily => 'Hằng ngày';

  @override
  String get repeatWeekly => 'Hằng tuần';

  @override
  String get repeatForPrefix => 'Trong ';

  @override
  String get repeatDaysSuffix => ' ngày';

  @override
  String get repeatWeeksSuffix => ' tuần';

  @override
  String get repeatUntilPrefix => 'Đến ';

  @override
  String get replacePersonTitle => 'Thay người';

  @override
  String get replaceFrom => 'Thay';

  @override
  String get replaceBy => 'Bằng';

  @override
  String dateRange(String from, String to) {
    return 'Từ $from đến $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã thay đổi $count ca.',
      zero: 'Không có ca nào thay đổi.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => 'Thay';

  @override
  String get joinHint =>
      'Đưa mã này cho người quản lý. Họ nhập mã vào ứng dụng, sau đó bạn sẽ nhận được lời mời.';

  @override
  String get codeExpired => 'Mã đã hết hạn.';

  @override
  String codeValidFor(String time) {
    return 'Còn hiệu lực $time';
  }

  @override
  String get newCode => 'Mã mới';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get languageAuto => 'Tự động (ngôn ngữ thiết bị)';
}
