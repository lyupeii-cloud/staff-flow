// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class L10nZh extends L10n {
  L10nZh([String locale = 'zh']) : super(locale);

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get confirm => '确认';

  @override
  String get validate => '确认';

  @override
  String get add => '添加';

  @override
  String get rename => '重命名';

  @override
  String get delete => '删除';

  @override
  String get accept => '接受';

  @override
  String get decline => '拒绝';

  @override
  String get close => '关闭';

  @override
  String get retry => '重试';

  @override
  String get name => '名称';

  @override
  String get serverUnreachable => '无法连接服务器。';

  @override
  String errorStatus(int status) {
    return '错误 $status';
  }

  @override
  String get roleOwner => '所有者';

  @override
  String get roleManager => '负责人';

  @override
  String get roleEmployee => '员工';

  @override
  String get roleExtra => '临时工';

  @override
  String get taglineStart => '团队排班，';

  @override
  String get taglineEnd => '随时随地。';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => '使用 Google 登录';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google 登录不可用：$detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google 登录失败：$detail';
  }

  @override
  String get newCompany => '新公司';

  @override
  String get timezone => '时区';

  @override
  String get create => '创建';

  @override
  String get noCompanyTitle => '您还没有加入任何公司。';

  @override
  String get noCompanyHint => '要加入雇主的公司，请生成一个代码并交给您的负责人。';

  @override
  String get joinCompany => '加入公司';

  @override
  String get createCompany => '创建公司';

  @override
  String transferOffer(String company) {
    return '有人邀请您成为“$company”的所有者。';
  }

  @override
  String get someCompany => '一家公司';

  @override
  String get becameOwner => '您现在是所有者。';

  @override
  String get myAccount => '我的账户';

  @override
  String get idCopied => '编号已复制。';

  @override
  String myId(String id) {
    return '我的编号：$id';
  }

  @override
  String get signOut => '退出登录';

  @override
  String joinInvite(String company, String role) {
    return '“$company”邀请您担任$role。';
  }

  @override
  String joinedCompany(String company) {
    return '您已加入 $company。';
  }

  @override
  String get viewPlanning => '排班';

  @override
  String get viewTeam => '团队';

  @override
  String get viewPositions => '岗位';

  @override
  String get readOnlyCompany => '该公司为只读状态。';

  @override
  String get team => '团队';

  @override
  String get leaveCompany => '退出该公司';

  @override
  String meSuffix(String name) {
    return '$name（您）';
  }

  @override
  String transferConfirmTitle(String name) {
    return '将公司转让给 $name？';
  }

  @override
  String get transferConfirmBody => '对方接受后将成为所有者（订阅、账单、负责人），您将成为负责人。';

  @override
  String transferSent(String name) {
    return '已向 $name 发送转让邀请。';
  }

  @override
  String removeConfirmTitle(String name) {
    return '移除 $name？';
  }

  @override
  String get removeConfirmBody => '其历史记录会被保留。';

  @override
  String get addPersonTitle => '添加人员';

  @override
  String get addPersonHint => '请对方打开 Staff Flow，在账户菜单中选择“加入公司”，然后输入显示的代码。';

  @override
  String get sixDigitCode => '6 位代码';

  @override
  String invitationSent(String name) {
    return '已向 $name 发送邀请，需要对方接受。';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '退出 $company？';
  }

  @override
  String get leaveConfirmBody => '您将无法再查看其排班。';

  @override
  String get renameCompany => '重命名公司';

  @override
  String get actionMakeManager => '设为负责人';

  @override
  String get actionMakeEmployee => '改回员工';

  @override
  String get actionToEmployee => '设为员工';

  @override
  String get actionToExtra => '设为临时工';

  @override
  String get actionTransfer => '转让所有权';

  @override
  String get actionRemove => '从公司移除';

  @override
  String get positions => '岗位';

  @override
  String get sites => '地点';

  @override
  String get positionsHint => '人员的工作内容：收银、厨房、前台……';

  @override
  String get sitesHint => '如果公司有多个地点，班次在哪里进行。';

  @override
  String get archived => '已归档';

  @override
  String get archive => '归档';

  @override
  String get reactivate => '重新启用';

  @override
  String weekOf(String date) {
    return '$date 这一周';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已发布 $count 项更改。',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => '班次';

  @override
  String get display => '视图';

  @override
  String get week => '周';

  @override
  String get month => '月';

  @override
  String get today => '今天';

  @override
  String get onlyMine => '仅显示我的班次';

  @override
  String get replacePersonMenu => '替换人员…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 项更改未发布',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => '员工暂时看不到这些更改。';

  @override
  String get publish => '发布';

  @override
  String yourHours(String duration) {
    return '您本期的工时：$duration';
  }

  @override
  String get addShiftThisDay => '在这一天添加班次';

  @override
  String get noShift => '没有班次';

  @override
  String get unassigned => '未分配';

  @override
  String get formerMember => '前成员';

  @override
  String get statusDraft => '草稿';

  @override
  String get statusModified => '已修改';

  @override
  String get statusDeleted => '已删除';

  @override
  String durationHours(int hours) {
    return '$hours 小时';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours 小时 $minutes 分';
  }

  @override
  String get editShift => '编辑班次';

  @override
  String get newShift => '新班次';

  @override
  String get thisShift => '仅此班次';

  @override
  String get thisAndFollowing => '此班次及之后';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '日期',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => '其他日期';

  @override
  String get start => '开始';

  @override
  String get end => '结束';

  @override
  String get endsNextDay => '次日结束。';

  @override
  String get person => '人员';

  @override
  String get position => '岗位';

  @override
  String get site => '地点';

  @override
  String get noteOptional => '备注（可选）';

  @override
  String get repetition => '重复';

  @override
  String get repeatNone => '不重复';

  @override
  String get repeatDaily => '每天';

  @override
  String get repeatWeekly => '每周';

  @override
  String get repeatForPrefix => '持续 ';

  @override
  String get repeatDaysSuffix => ' 天';

  @override
  String get repeatWeeksSuffix => ' 周';

  @override
  String get repeatUntilPrefix => '直到 ';

  @override
  String get replacePersonTitle => '替换人员';

  @override
  String get replaceFrom => '替换';

  @override
  String get replaceBy => '替换为';

  @override
  String dateRange(String from, String to) {
    return '从 $from 到 $to';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已修改 $count 个班次。',
      zero: '没有班次被修改。',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => '替换';

  @override
  String get joinHint => '把这个代码交给您的负责人。对方在应用中输入后，您会收到一个邀请。';

  @override
  String get codeExpired => '代码已过期。';

  @override
  String codeValidFor(String time) {
    return '剩余有效时间 $time';
  }

  @override
  String get newCode => '新代码';

  @override
  String get language => '语言';

  @override
  String get languageAuto => '自动（设备语言）';

  @override
  String get syncUpToDate => '已同步';

  @override
  String get syncOffline => '离线';

  @override
  String syncPending(int count) {
    return '待同步的更改：$count';
  }

  @override
  String get syncNow => '立即同步';

  @override
  String syncRejected(String reason) {
    return '服务器拒绝了更改：$reason';
  }

  @override
  String get pendingBadge => '待同步';

  @override
  String get offlineUnavailable => '离线时不可用。';

  @override
  String get offlineCached => '离线：显示最近保存的数据。';

  @override
  String get savedOffline => '已保存在本设备，联网后发送。';

  @override
  String get notices => '通知';

  @override
  String get noNotices => '没有通知。';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name 替换了您对 $date 班次的修改。';
  }

  @override
  String get history => '历史记录';

  @override
  String get recentChanges => '最近的更改';

  @override
  String get undoChange => '撤销此更改';

  @override
  String get undoDone => '已撤销更改。';

  @override
  String get historyCreate => '创建';

  @override
  String get historyUpdate => '修改';

  @override
  String get historyDelete => '删除';

  @override
  String get historyUndo => '撤销';

  @override
  String get noHistory => '没有更改。';

  @override
  String get pendingNotEditable => '此班次尚未同步：请联网后重试。';

  @override
  String get myQrCode => '我的二维码';

  @override
  String get myQrCodeHint => '负责人扫描此二维码即可将你加入其公司，随后由你确认。二维码永久不变。';

  @override
  String get changeMyName => '修改我的名字';

  @override
  String get nameShownToTeam => '同事看到的将是这个名字，而不是你的 Google 名字。';

  @override
  String googleName(String name) {
    return 'Google 名字：$name';
  }

  @override
  String get useGoogleName => '使用我的 Google 名字';

  @override
  String renameMemberTitle(String name) {
    return '重命名 $name';
  }

  @override
  String get renameMemberHint => '此名字仅在本公司使用。';

  @override
  String get useOwnName => '使用其本人名字';

  @override
  String get scanQrCode => '扫描二维码';

  @override
  String get scanQrHint => '将摄像头对准对方应用中显示的二维码（账户菜单“我的二维码”）。';

  @override
  String get orEnterCode => '或输入对方的 6 位数字代码';

  @override
  String get qrInvalid => '这不是 Staff Flow 二维码。';

  @override
  String cameraUnavailable(String error) {
    return '摄像头不可用（$error）。';
  }

  @override
  String get notificationsTitle => '通知';

  @override
  String get notifChooseHint => '选择要接收哪些通知。所有内容仍会显示在铃铛中。';

  @override
  String get notifPlanning => '排班发布或更改';

  @override
  String get notifRequests => '申请：换班、休假、邀请';

  @override
  String get notifMessages => '新消息';

  @override
  String get notifOverlap => '不同公司之间的排班重叠';

  @override
  String get notifConflicts => '你的修改被其他负责人替换';

  @override
  String get notifBilling => '订阅提醒';

  @override
  String get pushEnabled => '此设备已开启通知。';

  @override
  String get pushOff => '此设备已关闭通知。';

  @override
  String get pushBlocked => '通知已被阻止：请在手机或浏览器设置中允许。';

  @override
  String get pushUnavailable => '此设备无法使用通知。';

  @override
  String get enablePush => '开启';

  @override
  String noticeSchedulePublished(String company) {
    return '$company：你的排班已发布或更改。';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company 想把你加入团队。';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name 提议由你成为 $company 的所有者。';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name 已加入 $company。';
  }
}
