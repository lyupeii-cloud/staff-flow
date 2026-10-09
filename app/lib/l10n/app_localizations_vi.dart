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

  @override
  String get syncUpToDate => 'Đã cập nhật';

  @override
  String get syncOffline => 'Ngoại tuyến';

  @override
  String syncPending(int count) {
    return 'Thay đổi đang chờ: $count';
  }

  @override
  String get syncNow => 'Đồng bộ ngay';

  @override
  String syncRejected(String reason) {
    return 'Máy chủ từ chối thay đổi: $reason';
  }

  @override
  String get pendingBadge => 'Đang chờ';

  @override
  String get offlineUnavailable => 'Không khả dụng khi ngoại tuyến.';

  @override
  String get offlineCached => 'Ngoại tuyến: dữ liệu đã lưu gần nhất.';

  @override
  String get savedOffline => 'Đã lưu trên thiết bị, sẽ gửi khi có mạng.';

  @override
  String get notices => 'Thông báo';

  @override
  String get noNotices => 'Không có thông báo.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name đã thay thế thay đổi của bạn cho ca ngày $date.';
  }

  @override
  String get history => 'Lịch sử';

  @override
  String get recentChanges => 'Thay đổi gần đây';

  @override
  String get undoChange => 'Hoàn tác thay đổi này';

  @override
  String get undoDone => 'Đã hoàn tác.';

  @override
  String get historyCreate => 'Tạo';

  @override
  String get historyUpdate => 'Sửa';

  @override
  String get historyDelete => 'Xóa';

  @override
  String get historyUndo => 'Hoàn tác';

  @override
  String get noHistory => 'Không có thay đổi.';

  @override
  String get pendingNotEditable =>
      'Ca này chưa được đồng bộ: hãy thử lại khi có mạng.';

  @override
  String get myQrCode => 'Mã QR của tôi';

  @override
  String get myQrCodeHint =>
      'Quản lý quét mã này để thêm bạn vào công ty; sau đó bạn xác nhận. Mã không bao giờ thay đổi.';

  @override
  String get changeMyName => 'Đổi tên của tôi';

  @override
  String get nameShownToTeam =>
      'Đồng nghiệp sẽ thấy tên này thay cho tên Google của bạn.';

  @override
  String googleName(String name) {
    return 'Tên Google: $name';
  }

  @override
  String get useGoogleName => 'Dùng tên Google của tôi';

  @override
  String renameMemberTitle(String name) {
    return 'Đổi tên $name';
  }

  @override
  String get renameMemberHint => 'Tên này chỉ dùng trong công ty này.';

  @override
  String get useOwnName => 'Dùng tên của chính họ';

  @override
  String get scanQrCode => 'Quét mã QR';

  @override
  String get scanQrHint =>
      'Hướng camera vào mã QR trong ứng dụng của họ (menu tài khoản, “Mã QR của tôi”).';

  @override
  String get orEnterCode => 'Hoặc nhập mã 6 chữ số của họ';

  @override
  String get qrInvalid => 'Đây không phải mã QR Staff Flow.';

  @override
  String cameraUnavailable(String error) {
    return 'Không dùng được camera ($error).';
  }

  @override
  String get notificationsTitle => 'Thông báo';

  @override
  String get notifChooseHint =>
      'Chọn những gì bạn muốn nhận thông báo. Mọi thứ vẫn hiển thị ở chuông.';

  @override
  String get notifPlanning => 'Lịch được công bố hoặc thay đổi';

  @override
  String get notifRequests => 'Yêu cầu: đổi ca, nghỉ phép, lời mời';

  @override
  String get notifMessages => 'Tin nhắn mới';

  @override
  String get notifOverlap => 'Ca làm trùng giữa các công ty';

  @override
  String get notifConflicts => 'Thay đổi của bạn bị quản lý khác thay thế';

  @override
  String get notifBilling => 'Nhắc nhở gói đăng ký';

  @override
  String get pushEnabled => 'Thông báo đang bật trên thiết bị này.';

  @override
  String get pushOff => 'Thông báo đang tắt trên thiết bị này.';

  @override
  String get pushBlocked =>
      'Thông báo bị chặn: hãy cho phép trong cài đặt điện thoại hoặc trình duyệt.';

  @override
  String get pushUnavailable => 'Thông báo không khả dụng trên thiết bị này.';

  @override
  String get enablePush => 'Bật';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: lịch làm việc của bạn đã được công bố hoặc thay đổi.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company muốn thêm bạn vào nhóm.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name đề nghị bạn trở thành chủ sở hữu $company.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name đã tham gia $company.';
  }

  @override
  String get messagesTab => 'Tin nhắn';

  @override
  String get wholeTeam => 'Cả nhóm';

  @override
  String get newConversation => 'Cuộc trò chuyện mới';

  @override
  String get noMessages => 'Chưa có tin nhắn.';

  @override
  String get messageHint => 'Viết tin nhắn';

  @override
  String get earlierMessages => 'Tin nhắn trước';

  @override
  String get personLeftCompany => 'Người này không còn thuộc công ty.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => 'Nhóm mới';

  @override
  String get editGroup => 'Sửa nhóm';

  @override
  String get groupName => 'Tên nhóm';

  @override
  String get groupMembersHint =>
      'Chọn những người trong nhóm này. Chỉ họ mới thấy tin nhắn của nhóm.';

  @override
  String get chooseAtLeastOne => 'Chọn ít nhất một người.';

  @override
  String get replyAction => 'Trả lời';

  @override
  String get translateAction => 'Dịch';

  @override
  String replyingTo(String name) {
    return 'Trả lời $name';
  }

  @override
  String lastMessagesOf(String name) {
    return 'Tin nhắn gần đây của $name';
  }

  @override
  String get deleteAllNotices => 'Xóa tất cả';

  @override
  String get deleteAllNoticesConfirm => 'Xóa tất cả thông báo?';

  @override
  String get noticeRetention => 'Xóa thông báo đã đọc sau';

  @override
  String get retentionDay => '1 ngày';

  @override
  String get retentionWeek => '1 tuần';

  @override
  String get retentionMonth => '1 tháng';

  @override
  String get billingOwnersOnly => 'Chỉ bật khi bạn sở hữu một công ty.';

  @override
  String get readOnlyPastDays =>
      'Các ngày đã qua hơn một tháng chỉ có thể xem.';

  @override
  String get wholeCompany => 'Toàn công ty';

  @override
  String get sitesLabel => 'Địa điểm';

  @override
  String get actionSites => 'Địa điểm…';

  @override
  String managerOf(String name) {
    return '$name phụ trách';
  }

  @override
  String teamSitesOf(String name) {
    return 'Nhóm của $name';
  }

  @override
  String get notYourSite => 'Địa điểm này không thuộc trách nhiệm của bạn.';

  @override
  String get chooseYourSite => 'Chọn ít nhất một địa điểm.';

  @override
  String get viewRequests => 'Yêu cầu';

  @override
  String get newRequest => 'Yêu cầu mới';

  @override
  String get requestLeave => 'Nghỉ phép';

  @override
  String get requestUnavailability => 'Không thể làm';

  @override
  String get requestSwap => 'Đổi ca';

  @override
  String get swapHint =>
      'Để đề xuất đổi ca, hãy chạm vào một ca sắp tới của bạn trong lịch.';

  @override
  String get noRequests => 'Chưa có yêu cầu nào.';

  @override
  String get requestsToHandle => 'Cần xử lý';

  @override
  String get myRequests => 'Yêu cầu của tôi';

  @override
  String get otherRequests => 'Yêu cầu của nhóm';

  @override
  String get statusPendingPeer => 'Chờ đồng nghiệp';

  @override
  String get statusPendingManager => 'Chờ quản lý';

  @override
  String get statusApproved => 'Đã chấp nhận';

  @override
  String get statusRefused => 'Đã từ chối';

  @override
  String get statusCancelled => 'Đã hủy';

  @override
  String get cancelRequest => 'Hủy yêu cầu';

  @override
  String get acceptSwap => 'Nhận ca này';

  @override
  String get approve => 'Duyệt';

  @override
  String periodLabel(String from, String to) {
    return 'Từ $from đến $to';
  }

  @override
  String swapToPeer(String name) {
    return 'Đề xuất cho $name';
  }

  @override
  String get swapToTeam => 'Cả nhóm';

  @override
  String everyWeekdays(String days) {
    return 'Hằng tuần: $days';
  }

  @override
  String get unavailableEveryWeek => 'Những ngày bạn không bao giờ làm được:';

  @override
  String get choosePeriod => 'Chọn ngày';

  @override
  String get choosePeriodOptional =>
      'Giới hạn trong một khoảng thời gian (tùy chọn)';

  @override
  String get clearPeriod => 'Không giới hạn';

  @override
  String get sendRequest => 'Gửi yêu cầu';

  @override
  String get proposeSwap => 'Đề xuất đổi ca';

  @override
  String get swapWith => 'Đề xuất cho';

  @override
  String get swapSteps =>
      'Đồng nghiệp chấp nhận, sau đó quản lý duyệt. Lịch chỉ thay đổi sau đó.';

  @override
  String get absentThatDay => 'Vắng mặt đã duyệt vào ngày này';

  @override
  String get requestSent => 'Đã gửi yêu cầu.';

  @override
  String noticeSwapOffer(String name) {
    return '$name đề nghị bạn nhận một ca của họ.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name đã từ chối đề nghị đổi ca của bạn.';
  }

  @override
  String get noticeSwapToApprove => 'Một yêu cầu đổi ca đang chờ bạn duyệt.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name xin nghỉ phép.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name báo không thể làm việc.';
  }

  @override
  String get noticeRequestApproved => 'Yêu cầu của bạn đã được chấp nhận.';

  @override
  String get noticeRequestRefused => 'Yêu cầu của bạn đã bị từ chối.';

  @override
  String get choosePeer => 'Ai nhận ca này?';

  @override
  String get discardAll => 'Hủy tất cả';

  @override
  String get notifySitesHint =>
      'Chọn các địa điểm bạn muốn nhận thông báo về yêu cầu. Mọi yêu cầu vẫn hiển thị trong danh sách.';

  @override
  String get notifySitesTitle => 'Thông báo theo địa điểm';

  @override
  String get pendingRequestTooltip => 'Yêu cầu đang chờ: chạm để mở';

  @override
  String get requestsHistory => 'Tất cả yêu cầu';

  @override
  String get revertChange => 'Hủy thay đổi này';

  @override
  String get statusExpired => 'Không còn hiệu lực';

  @override
  String get swapWithHint => 'Chạm để chọn một đồng nghiệp cụ thể';

  @override
  String changesDiscarded(String count) {
    return 'Đã hủy thay đổi: $count';
  }

  @override
  String discardConfirm(String count) {
    return 'Hủy $count thay đổi chưa công bố?';
  }

  @override
  String get allSchedules => 'Tất cả lịch của tôi';

  @override
  String get busyElsewhere => 'Đã làm ở công ty khác vào khung giờ này';

  @override
  String get overlapTooltip => 'Trùng với một ca ở công ty khác';

  @override
  String get overlapWarning => 'Một số ca của bạn ở hai công ty bị trùng nhau.';

  @override
  String noticeOverlap(String date) {
    return 'Hai ca làm của bạn ở hai công ty khác nhau bị trùng vào ngày $date.';
  }

  @override
  String get allMyCompanies => 'Tất cả công ty của tôi';

  @override
  String get deleteGroup => 'Xóa nhóm';

  @override
  String get openRequest => 'Xem yêu cầu';

  @override
  String get thisCompany => 'Công ty này';

  @override
  String get withExtras => 'Gồm cả nhân viên thời vụ';

  @override
  String deleteGroupConfirm(String name) {
    return 'Xóa “$name” và mọi tin nhắn với tất cả mọi người?';
  }

  @override
  String reinforcementHint(String company) {
    return 'Từ $company: sẽ được thêm làm nhân sự hỗ trợ và được thông báo.';
  }

  @override
  String get addToGoogle => 'Thêm vào Google Lịch';

  @override
  String get calendarEnabled => 'Đồng bộ ca làm của tôi';

  @override
  String get calendarHint =>
      'Thêm ca làm ở tất cả các công ty của bạn vào Google Lịch. Chúng tự cập nhật và bạn có thể tắt bất cứ lúc nào.';

  @override
  String get changeSettings => 'Sửa';

  @override
  String get copyCalendarLink => 'Sao chép liên kết lịch';

  @override
  String get countryBelgium => 'Bỉ';

  @override
  String get countryCanada => 'Canada';

  @override
  String get countryFrance => 'Pháp';

  @override
  String get countrySwitzerland => 'Thụy Sĩ';

  @override
  String get employeesSection => 'Nhân viên';

  @override
  String get emptyNoAlert => 'Để trống: không cảnh báo';

  @override
  String get extrasSection => 'Nhân viên thời vụ';

  @override
  String get googleCalendar => 'Google Lịch';

  @override
  String get hoursTotals => 'Tổng giờ';

  @override
  String get legalAlerts => 'Cảnh báo theo luật';

  @override
  String get legalAlertsHint =>
      'Chỉ cảnh báo, không bao giờ chặn. Chọn các quy định áp dụng cho bạn, hoặc không chọn.';

  @override
  String get legalPreset => 'Mẫu theo quốc gia';

  @override
  String get linkCopied => 'Đã sao chép liên kết.';

  @override
  String get maxConsecutiveLabel => 'Số ngày làm liên tiếp tối đa';

  @override
  String get maxDayLabel => 'Thời lượng tối đa mỗi ngày (giờ)';

  @override
  String get maxWeekLabel => 'Thời lượng tối đa mỗi tuần (giờ)';

  @override
  String get minRestLabel => 'Nghỉ tối thiểu giữa hai ca (giờ)';

  @override
  String get noLegalRules => 'Chưa chọn cảnh báo nào.';

  @override
  String get presetNone => 'Không';

  @override
  String get presetsCheck =>
      'Các mẫu chỉ là điểm khởi đầu: hãy kiểm tra theo luật nước bạn và thỏa ước tập thể.';

  @override
  String get printMine => 'Lịch của tôi';

  @override
  String get printOwn => 'Chỉ lịch của chính họ';

  @override
  String get printPdf => 'In / PDF';

  @override
  String get printRights => 'Nhân viên được in gì';

  @override
  String get printTeam => 'Lịch của cả nhóm';

  @override
  String get printTeamOption => 'Lịch của nhóm';

  @override
  String get totalsHint =>
      'Gồm cả bản nháp. Xuất Excel và CSV dùng lịch đã công bố.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value ngày liên tiếp (tối đa $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: $value trong ngày (tối đa $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: chỉ nghỉ $value (tối thiểu $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: $value trong tuần (tối đa $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return 'Cảnh báo theo luật: $count';
  }

  @override
  String shiftsCount(String count) {
    return 'Ca làm: $count';
  }

  @override
  String get actionMakeDeputy => 'Bổ nhiệm phó quản lý';

  @override
  String get actionRemoveDeputy => 'Gỡ vai trò phó quản lý';

  @override
  String get busyHere => 'Đã làm ở công ty này vào khung giờ này';

  @override
  String get calendarByLink => 'Qua liên kết (Google Lịch trên máy tính)';

  @override
  String get calendarDenied =>
      'Quyền truy cập lịch bị từ chối. Hãy cho phép trong cài đặt điện thoại.';

  @override
  String get calendarLinkHint =>
      'Thêm từ Google Lịch trên máy tính; Google cập nhật trong vài giờ.';

  @override
  String get calendarNone =>
      'Không có lịch nào chỉnh sửa được trên điện thoại này.';

  @override
  String get calendarOnPhone => 'Thêm ca làm của tôi vào lịch điện thoại';

  @override
  String get calendarOnPhoneHint =>
      'Trong lịch Google của bạn: thấy ngay, trên điện thoại và trên Google Lịch.';

  @override
  String get chooseCalendar => 'Chọn lịch';

  @override
  String get otherSiteHint =>
      'Nhân viên của địa điểm khác: quản lý của họ sẽ được báo.';

  @override
  String get subManager => 'Phó quản lý';

  @override
  String calendarSynced(String count) {
    return 'Ca trong lịch: $count';
  }

  @override
  String deputyOf(String name) {
    return 'Phó quản lý: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by đã xếp $name vào địa điểm $site ngày $date.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company đã thêm bạn làm nhân sự hỗ trợ.';
  }

  @override
  String get companyNotificationsHint =>
      'Đã tắt: điện thoại này không đổ chuông, nhưng mọi thứ vẫn ở trong chuông thông báo.';

  @override
  String get companyNotificationsOn => 'Nhận thông báo của công ty này';

  @override
  String get companyTimezone => 'Múi giờ của công ty';

  @override
  String get companyTimezoneHint =>
      'Mọi giờ của công ty này theo múi giờ này (đã tính giờ mùa hè). Lịch sẽ tự quy đổi.';

  @override
  String get iosInstallHint =>
      'Trên iPhone: chạm Chia sẻ, rồi “Thêm vào MH chính” để cài Staff Flow.';

  @override
  String get searchCity => 'Tìm thành phố';

  @override
  String get thisPhone => 'Thiết bị này';

  @override
  String companyNotifications(String name) {
    return 'Thông báo: $name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return 'Giờ theo giờ $zone ($company). Thiết bị của bạn: $here.';
  }

  @override
  String get addPreset => 'Thêm mẫu giờ';

  @override
  String get addPresets => 'Tạo mẫu giờ';

  @override
  String get appearance => 'Giao diện';

  @override
  String get chooseLogo => 'Chọn ảnh PNG';

  @override
  String get conversationMuted => 'Đã tắt thông báo của cuộc trò chuyện này.';

  @override
  String get conversationUnmuted =>
      'Đã bật lại thông báo của cuộc trò chuyện này.';

  @override
  String get customization => 'Tùy chỉnh';

  @override
  String get disableGroup => 'Tắt nhóm';

  @override
  String get disableGroupConfirm =>
      'Nhóm của toàn công ty sẽ bị ẩn với mọi người. Bạn có thể bật lại trong Tin nhắn.';

  @override
  String get editPresets => 'Mẫu giờ';

  @override
  String get enable => 'Bật lại';

  @override
  String get groupDisabled => 'Nhóm đã tắt (chỉ bạn thấy)';

  @override
  String get logoHint =>
      'Một ảnh PNG nhỏ (logo của bạn) hiện trên tab công ty cho mọi thành viên.';

  @override
  String get logoPngOnly => 'Hãy chọn ảnh PNG tối đa 1 MB.';

  @override
  String get muteConversation => 'Tắt thông báo cuộc trò chuyện này';

  @override
  String get myIdentifier => 'Mã định danh của tôi';

  @override
  String get myProfile => 'Hồ sơ của tôi';

  @override
  String get presetName => 'Tên (vd. Sáng)';

  @override
  String get removeLogo => 'Gỡ ảnh';

  @override
  String get resetGroup => 'Đặt lại nhóm';

  @override
  String get resetGroupConfirm =>
      'Mọi tin nhắn trong nhóm công ty sẽ bị xóa với mọi người.';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get shiftPresets => 'Mẫu giờ làm';

  @override
  String get shiftPresetsHint =>
      'Giờ có sẵn (sáng, tối, đêm…): một chạm trong ca sẽ điền giờ bắt đầu và kết thúc.';

  @override
  String get themeDark => 'Tối';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeSystem => 'Theo hệ thống';

  @override
  String get unmuteConversation => 'Bật lại thông báo cuộc trò chuyện này';

  @override
  String get awaitingApproval => 'Chờ duyệt';

  @override
  String get placementNeedsApproval =>
      '! Người này không thuộc địa điểm của bạn: ca sẽ chờ cấp trên hoặc chủ sở hữu phê duyệt trước khi có thể công bố. Nếu không, hãy chọn người khác.';

  @override
  String get placementAwaiting =>
      'Đang chờ cấp trên hoặc chủ sở hữu phê duyệt.';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by muốn xếp $name từ địa điểm khác vào $date: cần phê duyệt.';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by đã duyệt việc xếp $name vào $date.';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by đã từ chối việc xếp $name vào $date.';
  }

  @override
  String get addSubSite => 'Thêm địa điểm con';

  @override
  String get moveSite => 'Di chuyển';

  @override
  String get topLevel => 'Cấp cao nhất';

  @override
  String moveSiteTitle(String name) {
    return 'Di chuyển “$name” vào dưới…';
  }

  @override
  String subSiteOf(String name) {
    return 'Địa điểm con của $name';
  }

  @override
  String get siteTreeHint =>
      'Tối đa 3 cấp, ví dụ Vùng › Thành phố › Cửa hàng. Người quản lý một địa điểm cũng quản lý mọi thứ bên dưới.';

  @override
  String get subSitesOnlyHint =>
      'Tại đây bạn thêm địa điểm con dưới các địa điểm của mình.';
}
