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
  String get viewTeam => '管理';

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

  @override
  String get messagesTab => '消息';

  @override
  String get wholeTeam => '全体成员';

  @override
  String get newConversation => '新对话';

  @override
  String get noMessages => '还没有消息。';

  @override
  String get messageHint => '输入消息';

  @override
  String get earlierMessages => '更早的消息';

  @override
  String get personLeftCompany => '此人已不再是公司成员。';

  @override
  String messagePreview(String name, String text) {
    return '$name：$text';
  }

  @override
  String get newGroup => '新建群组';

  @override
  String get editGroup => '编辑群组';

  @override
  String get groupName => '群组名称';

  @override
  String get groupMembersHint => '选择该群组的成员。只有他们能看到群组消息。';

  @override
  String get chooseAtLeastOne => '请至少选择一人。';

  @override
  String get replyAction => '回复';

  @override
  String get translateAction => '翻译';

  @override
  String replyingTo(String name) {
    return '回复 $name';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name 的最近消息';
  }

  @override
  String get deleteAllNotices => '全部删除';

  @override
  String get deleteAllNoticesConfirm => '删除所有通知？';

  @override
  String get noticeRetention => '已读通知保留时间';

  @override
  String get retentionDay => '1 天';

  @override
  String get retentionWeek => '1 周';

  @override
  String get retentionMonth => '1 个月';

  @override
  String get billingOwnersOnly => '仅在您拥有公司时生效。';

  @override
  String get readOnlyPastDays => '超过一个月的日期为只读。';

  @override
  String get wholeCompany => '整个公司';

  @override
  String get sitesLabel => '地点';

  @override
  String get actionSites => '地点…';

  @override
  String managerOf(String name) {
    return '$name 负责';
  }

  @override
  String teamSitesOf(String name) {
    return '$name 的团队';
  }

  @override
  String get notYourSite => '该地点不归您负责。';

  @override
  String get chooseYourSite => '请至少选择一个地点。';

  @override
  String get viewRequests => '申请';

  @override
  String get newRequest => '新申请';

  @override
  String get requestLeave => '休假';

  @override
  String get requestUnavailability => '无法上班';

  @override
  String get requestSwap => '换班';

  @override
  String get swapHint => '要提出换班，请在排班表中点按您即将到来的一个班次。';

  @override
  String get noRequests => '暂无申请。';

  @override
  String get requestsToHandle => '待处理';

  @override
  String get myRequests => '我的申请';

  @override
  String get otherRequests => '团队申请';

  @override
  String get statusPendingPeer => '等待同事回应';

  @override
  String get statusPendingManager => '等待负责人审批';

  @override
  String get statusApproved => '已批准';

  @override
  String get statusRefused => '已拒绝';

  @override
  String get statusCancelled => '已取消';

  @override
  String get cancelRequest => '取消申请';

  @override
  String get acceptSwap => '接下这个班次';

  @override
  String get approve => '批准';

  @override
  String periodLabel(String from, String to) {
    return '$from 至 $to';
  }

  @override
  String swapToPeer(String name) {
    return '已提给 $name';
  }

  @override
  String get swapToTeam => '整个团队';

  @override
  String everyWeekdays(String days) {
    return '每周：$days';
  }

  @override
  String get unavailableEveryWeek => '您总是无法上班的日子：';

  @override
  String get choosePeriod => '选择日期';

  @override
  String get choosePeriodOptional => '限定在某个时段（可选）';

  @override
  String get clearPeriod => '不限时段';

  @override
  String get sendRequest => '发送申请';

  @override
  String get proposeSwap => '提出换班';

  @override
  String get swapWith => '提给';

  @override
  String get swapSteps => '同事接受后，由负责人批准。排班表随后才会更改。';

  @override
  String get absentThatDay => '当天有已批准的缺勤';

  @override
  String get requestSent => '申请已发送。';

  @override
  String noticeSwapOffer(String name) {
    return '$name 想把一个班次让给您。';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name 拒绝了您的换班提议。';
  }

  @override
  String get noticeSwapToApprove => '有一个换班申请等待您审批。';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name 申请休假。';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name 申报无法上班。';
  }

  @override
  String get noticeRequestApproved => '您的申请已获批准。';

  @override
  String get noticeRequestRefused => '您的申请已被拒绝。';

  @override
  String get choosePeer => '谁来接这个班次？';

  @override
  String get discardAll => '全部撤销';

  @override
  String get notifySitesHint => '选择您接收申请通知的门店。所有申请仍会显示在列表中。';

  @override
  String get notifySitesTitle => '按门店通知';

  @override
  String get pendingRequestTooltip => '待处理申请：点按打开';

  @override
  String get requestsHistory => '全部申请';

  @override
  String get revertChange => '撤销此更改';

  @override
  String get statusExpired => '已失效';

  @override
  String get swapWithHint => '点按选择指定同事';

  @override
  String changesDiscarded(String count) {
    return '已撤销更改：$count';
  }

  @override
  String discardConfirm(String count) {
    return '撤销 $count 项未发布的更改？';
  }

  @override
  String get allSchedules => '我的所有排班';

  @override
  String get busyElsewhere => '该时段已在另一家公司上班';

  @override
  String get overlapTooltip => '与另一家公司的班次重叠';

  @override
  String get overlapWarning => '您在两家公司的部分班次时间重叠。';

  @override
  String noticeOverlap(String date) {
    return '您在不同公司的两个班次在 $date 时间重叠。';
  }

  @override
  String get allMyCompanies => '我的所有公司';

  @override
  String get deleteGroup => '删除群组';

  @override
  String get openRequest => '查看申请';

  @override
  String get thisCompany => '本公司';

  @override
  String get withExtras => '包括临时工';

  @override
  String deleteGroupConfirm(String name) {
    return '为所有人删除“$name”及其全部消息？';
  }

  @override
  String reinforcementHint(String company) {
    return '来自 $company：将作为支援人员加入并收到通知。';
  }

  @override
  String get addToGoogle => '添加到 Google 日历';

  @override
  String get calendarEnabled => '同步我的班次';

  @override
  String get calendarHint => '将您所有公司的班次添加到 Google 日历。它们会自动更新，您可以随时关闭。';

  @override
  String get changeSettings => '修改';

  @override
  String get copyCalendarLink => '复制日历链接';

  @override
  String get countryBelgium => '比利时';

  @override
  String get countryCanada => '加拿大';

  @override
  String get countryFrance => '法国';

  @override
  String get countrySwitzerland => '瑞士';

  @override
  String get employeesSection => '员工';

  @override
  String get emptyNoAlert => '留空：不提醒';

  @override
  String get extrasSection => '临时工';

  @override
  String get googleCalendar => 'Google 日历';

  @override
  String get hoursTotals => '工时合计';

  @override
  String get legalAlerts => '法定提醒';

  @override
  String get legalAlertsHint => '只是提醒，绝不阻止。选择适用于您的规则，或不选。';

  @override
  String get legalPreset => '国家模板';

  @override
  String get linkCopied => '链接已复制。';

  @override
  String get maxConsecutiveLabel => '最多连续工作天数';

  @override
  String get maxDayLabel => '每天最长时长（小时）';

  @override
  String get maxWeekLabel => '每周最长时长（小时）';

  @override
  String get minRestLabel => '两班之间最短休息（小时）';

  @override
  String get noLegalRules => '未选择任何提醒。';

  @override
  String get presetNone => '无';

  @override
  String get presetsCheck => '模板仅作起点：请根据您所在国家的法律和集体协议进行核对。';

  @override
  String get printMine => '我的排班';

  @override
  String get printOwn => '仅限自己的排班';

  @override
  String get printPdf => '打印 / PDF';

  @override
  String get printRights => '员工可打印的内容';

  @override
  String get printTeam => '整个团队的排班';

  @override
  String get printTeamOption => '团队排班';

  @override
  String get totalsHint => '包括草稿。Excel 和 CSV 导出使用已发布的排班。';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name：连续 $value 天（上限 $limit）';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name：一天 $value（上限 $limit）';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name：仅休息 $value（至少 $limit）';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name：一周 $value（上限 $limit）';
  }

  @override
  String legalAlertsCount(String count) {
    return '法定提醒：$count';
  }

  @override
  String shiftsCount(String count) {
    return '班次：$count';
  }

  @override
  String get actionMakeDeputy => '任命为副负责人';

  @override
  String get actionRemoveDeputy => '撤销副负责人角色';

  @override
  String get busyHere => '该时段已在本公司上班';

  @override
  String get calendarByLink => '通过链接（电脑上的 Google 日历）';

  @override
  String get calendarDenied => '日历访问被拒绝。请在手机设置中允许。';

  @override
  String get calendarLinkHint => '请在电脑上的 Google 日历中添加；Google 会在几小时内更新。';

  @override
  String get calendarNone => '此手机上没有可编辑的日历。';

  @override
  String get calendarOnPhone => '将我的班次添加到手机日历';

  @override
  String get calendarOnPhoneHint => '在您的 Google 日历中：手机和 Google 日历上立即可见。';

  @override
  String get chooseCalendar => '选择日历';

  @override
  String get otherSiteHint => '其他门店的员工：将通知其负责人。';

  @override
  String get subManager => '副负责人';

  @override
  String calendarSynced(String count) {
    return '日历中的班次：$count';
  }

  @override
  String deputyOf(String name) {
    return '副负责人：$name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by 在 $date 将 $name 安排到了 $site。';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company 已将您添加为支援人员。';
  }

  @override
  String get companyNotificationsHint => '已关闭：这台手机不会响，但所有通知仍保留在铃铛中。';

  @override
  String get companyNotificationsOn => '接收这家公司的通知';

  @override
  String get companyTimezone => '公司时区';

  @override
  String get companyTimezoneHint => '这家公司的所有时间都按此时区计算（含夏令时）。日历会自动换算。';

  @override
  String get iosInstallHint => '在 iPhone 上：点按“共享”，再点“添加到主屏幕”即可安装 Staff Flow。';

  @override
  String get searchCity => '搜索城市';

  @override
  String get thisPhone => '此设备';

  @override
  String companyNotifications(String name) {
    return '通知：$name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return '时间按 $zone 时间（$company）。您的设备：$here。';
  }

  @override
  String get addPreset => '添加预设';

  @override
  String get addPresets => '创建预设';

  @override
  String get appearance => '外观';

  @override
  String get chooseLogo => '选择 PNG 图片';

  @override
  String get conversationMuted => '已将此对话静音。';

  @override
  String get conversationUnmuted => '已恢复此对话的通知。';

  @override
  String get customization => '个性化';

  @override
  String get disableGroup => '关闭群组';

  @override
  String get disableGroupConfirm => '全公司群组将对所有人隐藏。您可以在“消息”中重新开启。';

  @override
  String get editPresets => '预设';

  @override
  String get enable => '重新开启';

  @override
  String get groupDisabled => '群组已关闭（仅您可见）';

  @override
  String get logoHint => '显示在公司标签上的小 PNG 图片（您的标志），所有成员可见。';

  @override
  String get logoPngOnly => '请选择不超过 1 MB 的 PNG 图片。';

  @override
  String get muteConversation => '将此对话静音';

  @override
  String get myIdentifier => '我的标识';

  @override
  String get myProfile => '我的资料';

  @override
  String get presetName => '名称（如：早班）';

  @override
  String get removeLogo => '移除图片';

  @override
  String get resetGroup => '重置群组';

  @override
  String get resetGroupConfirm => '公司群组的所有消息将对所有人删除。';

  @override
  String get settingsTitle => '设置';

  @override
  String get shiftPresets => '班次时间预设';

  @override
  String get shiftPresetsHint => '现成的时间（早班、晚班、夜班…）：在班次中点一下即可填入开始和结束时间。';

  @override
  String get themeDark => '深色';

  @override
  String get themeLight => '浅色';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get unmuteConversation => '恢复此对话的通知';

  @override
  String get awaitingApproval => '待审批';

  @override
  String get placementNeedsApproval => '！此人不属于您的站点：班次需等您的上级或老板审批后才能发布。否则请另选他人。';

  @override
  String get placementAwaiting => '等待上级或老板审批。';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$by 想在 $date 安排其他站点的 $name：需要审批。';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$by 已批准在 $date 安排 $name。';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$by 已拒绝在 $date 安排 $name。';
  }

  @override
  String get addSubSite => '添加子站点';

  @override
  String get moveSite => '移动';

  @override
  String get topLevel => '顶级';

  @override
  String moveSiteTitle(String name) {
    return '将“$name”移到…之下';
  }

  @override
  String subSiteOf(String name) {
    return '$name 的子站点';
  }

  @override
  String get siteTreeHint => '最多 3 级，例如 区域 › 城市 › 门店。站点负责人也管理其下的所有站点。';

  @override
  String get subSitesOnlyHint => '在这里，您可以在自己的站点下添加子站点。';

  @override
  String get messagingSetting => '公司消息';

  @override
  String get messagingSettingHint => '开启：团队有“消息”标签。关闭：任何人都看不到也无法发送（旧消息会保留）。';

  @override
  String get billingTitle => '订阅';

  @override
  String billingStatusTrial(String date) {
    return '免费试用至 $date';
  }

  @override
  String billingStatusActive(String date) {
    return '已付费至 $date';
  }

  @override
  String billingStatusGrace(String date) {
    return '只读：如不付款，公司将于 $date 删除。';
  }

  @override
  String get billingStatusComped => '免费赠送';

  @override
  String billingStaff(String count) {
    return '计入员工 $count 人（不含老板和临时工）';
  }

  @override
  String get billingMonthly => '按月';

  @override
  String billingYearly(String months) {
    return '按年（收费 $months 个月）';
  }

  @override
  String get billingCascade => '“多级站点”选项';

  @override
  String billingCascadeIncluded(String count) {
    return '$count 名员工起免费包含';
  }

  @override
  String billingPay(String amount) {
    return '支付 $amount';
  }

  @override
  String get billingTestNotice => '测试付款：不会扣款。';

  @override
  String get billingSoon => '在线支付即将推出。';

  @override
  String get billingPaidOk => '付款已记录。';

  @override
  String get billingInvoices => '发票';

  @override
  String get billingNoInvoices => '暂无发票。';

  @override
  String get billingManage => '管理订阅';

  @override
  String get billingReadOnlyStaff => '在老板续订之前，此公司为只读状态。';

  @override
  String billingPerMonth(String amount) {
    return '$amount / 月';
  }

  @override
  String billingPerYear(String amount) {
    return '$amount / 年';
  }

  @override
  String noticeBillingTrialEnding(String company) {
    return '$company：免费试用将在 24 小时内结束。';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$company 因未付款处于只读状态；将于 $date 删除。';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return '提醒：如不付款，$company 将于 $date 删除。';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$company 因未付款已被删除。';
  }

  @override
  String billingCompanyId(String id) {
    return '公司编号：$id';
  }

  @override
  String billingDueToday(String amount) {
    return '今天：$amount';
  }

  @override
  String billingProrataNote(String days) {
    return '包含本月剩余天数（$days 天，按比例），之后从每月 1 日起按整月计费。';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked => '尚未关联。它用于验证您的身份，例如更换 Google 账号时。';

  @override
  String telegramLinked(String name) {
    return '已关联：$name';
  }

  @override
  String get telegramNoUsername => '无用户名';

  @override
  String get telegramLink => '关联我的 Telegram';

  @override
  String get telegramLinkHint => '将打开 Telegram：点击“开始”，然后返回这里。';

  @override
  String get telegramUnlink => '取消关联';

  @override
  String get telegramUnavailable => 'Telegram 暂不可用。';

  @override
  String get telegramShowIn => '在以下公司显示我的 Telegram：';

  @override
  String get newQrCode => '更换二维码';

  @override
  String get newQrCodeConfirm => '您的旧二维码和旧编号将失效。您在各公司中的位置不变。';

  @override
  String get newQrCodeDone => '已创建新二维码。';

  @override
  String get changeGoogle => '更换 Google 账号';

  @override
  String get changeGoogleSub => '同一账号、同一编号、同样的公司';

  @override
  String changeGoogleSteps(String id) {
    return '1. 在此资料页关联您的 Telegram（必需）。\n2. 退出登录，然后用新的 Google 账号登录。\n3. 选择“我已有 Staff Flow 账号”，输入您的编号 $id。\n4. 输入在 Telegram 收到的验证码。\n您的账号、编号和公司都保持不变。';
  }

  @override
  String get recoverAccount => '我已有 Staff Flow 账号';

  @override
  String get recoverHint => '输入旧账号的编号（SF-…）。验证码将发送到该账号关联的 Telegram。';

  @override
  String get recoverIdLabel => '编号（SF-…）';

  @override
  String get recoverSend => '发送验证码';

  @override
  String get recoverCodeSent => '验证码已通过 Telegram 发送。';

  @override
  String get recoverCodeLabel => '收到的验证码（6 位数字）';

  @override
  String get recoverConfirm => '找回我的账号';

  @override
  String get recoverDone => '完成：您已回到自己的账号。';

  @override
  String get exportData => '导出我的数据';

  @override
  String get exportDataSub => '包含您全部个人数据的文件';

  @override
  String get deleteAccount => '删除我的账号';

  @override
  String get deleteGhost => '删除但保留“幽灵”';

  @override
  String get deleteGhostHint => '您将退出所有公司。之后用同一个 Google 账号登录即可找回账号和编号。';

  @override
  String get deleteErase => '永久删除全部内容';

  @override
  String get deleteEraseHint => '姓名、邮箱、照片、Telegram、消息和通知都将被删除，且无法撤销。';

  @override
  String get deleteGhostNote =>
      '无论哪种方式，公司历史中都会以匿名的“Ghost”保留您的位置（休假申请、过去的班次等），以便老板和负责人追溯记录。';

  @override
  String get deleteOwnerNote => '您是公司所有者？请先转让公司，或等待其订阅结束。';

  @override
  String get deleteConfirmButton => '删除';

  @override
  String get accountRestored => '欢迎回来！您的账号已重新启用。';

  @override
  String get closedInvoices => '已关闭公司的发票';

  @override
  String get downloadAllInvoices => '下载全部发票（ZIP）';

  @override
  String get legalTerms => '使用与销售条款';

  @override
  String get legalPrivacy => '隐私政策';

  @override
  String get billingDetailTitle => '付款明细';

  @override
  String billingLineProrata(String days, String total) {
    return '本月剩余（$total 天中的 $days 天）：订阅';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return '本月剩余（$total 天中的 $days 天）：“多级地点”选项';
  }

  @override
  String billingLineMonth(String staff) {
    return '订阅，$staff 名员工：1 个月';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return '订阅，$staff 名员工：12 个月，按 $paid 个月计费';
  }

  @override
  String billingLineCascade(String months) {
    return '“多级地点”选项：$months 个月，无折扣';
  }

  @override
  String get billingTotal => '合计';

  @override
  String billingCovers(String from, String to) {
    return '覆盖期间：$from 至 $to';
  }

  @override
  String get billingGraceInvoices => '此公司不再续订：请立即下载其全部发票。';

  @override
  String get billingYearLabel => '年份';

  @override
  String get sitesNoneChosen => '未选择地点';

  @override
  String get avatarTitle => '我的头像';

  @override
  String get avatarSub => '用图片代替您的照片';

  @override
  String get avatarUseGoogle => '使用我的 Google 照片';

  @override
  String get avatarColor => '颜色';

  @override
  String get hidePhotosTitle => '隐藏 Google 照片';

  @override
  String get hidePhotosSub => '在此公司中，每个人都以头像或首字母显示。';

  @override
  String get billingApi => '“API 访问”选项';

  @override
  String billingLineApi(String months) {
    return '“API 访问”选项：$months 个月，无折扣';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return '本月剩余（$total 天中的 $days 天）：“API 访问”选项';
  }

  @override
  String get apiTitle => 'API 访问（会计、CRM）';

  @override
  String get apiSub => '您的会计、工资或 CRM 软件可读取已发布的排班、工时和缺勤。';

  @override
  String get apiNeedsOption => '付费选项：请在“管理订阅”中添加“API 访问”。';

  @override
  String get apiNewKey => '新密钥';

  @override
  String get apiKeyName => '密钥名称（例如：工资软件）';

  @override
  String get apiKeyCreated => '请立即复制此密钥并妥善保存：它不会再次显示。';

  @override
  String get apiKeyCopy => '复制';

  @override
  String get apiKeyCopied => '密钥已复制。';

  @override
  String apiKeyLastUsed(String date) {
    return '上次使用：$date';
  }

  @override
  String get apiKeyNeverUsed => '从未使用';

  @override
  String get apiRevoke => '撤销';

  @override
  String get apiRevokeConfirm => '使用此密钥的软件将失去访问权限。';

  @override
  String get apiDocs => 'API 文档';

  @override
  String get memberGoogleLink => '员工 Google 重新登录';

  @override
  String googleLinkHint(String name) {
    return '请将此链接发给 $name。它需在浏览器中打开（不能在 Android 应用中），仅限一次，24 小时内有效：$name 用新的 Google 账号登录即可找回账号。其他所有设备随后都会退出登录。';
  }

  @override
  String get googleLinkCopied => '链接已复制。';

  @override
  String get switchBanner =>
      '更换 Google 账号链接：请用新的 Google 账号登录，以找回您的 Staff Flow 账号。';

  @override
  String get switchSignOutFirst =>
      '此链接用于将 Staff Flow 账号关联到新的 Google 账号。请先退出登录，再用新的 Google 账号登录。';

  @override
  String get switchDone => '完成：您的 Staff Flow 账号已关联到此 Google 账号。您的其他设备已退出登录。';

  @override
  String changeGoogleBot(String bot) {
    return '最简单的方法：在 Telegram 中向机器人 $bot 发送 /changegoogle 并按提示操作，然后在 10 分钟内用新的 Google 账号登录。';
  }

  @override
  String get changeGoogleNoTelegram => '没有 Telegram：请向老板或负责人索取更换 Google 账号的链接。';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name 创建了一个链接，用于将您的账号关联到新的 Google 账号。如果您没有提出此请求，请告知您的负责人。';
  }

  @override
  String get sessionRevoked => '您已退出登录：您的账号现已关联到另一个 Google 账号。';

  @override
  String telegramLoginHint(String bot) {
    return '提示：向机器人 $bot 发送 /connexion 获取链接，即可在浏览器中打开 Staff Flow，无需应用或 Google 账号。';
  }
}
