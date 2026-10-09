// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class L10nKo extends L10n {
  L10nKo([String locale = 'ko']) : super(locale);

  @override
  String get cancel => '취소';

  @override
  String get save => '저장';

  @override
  String get confirm => '확인';

  @override
  String get validate => '확인';

  @override
  String get add => '추가';

  @override
  String get rename => '이름 변경';

  @override
  String get delete => '삭제';

  @override
  String get accept => '수락';

  @override
  String get decline => '거절';

  @override
  String get close => '닫기';

  @override
  String get retry => '다시 시도';

  @override
  String get name => '이름';

  @override
  String get serverUnreachable => '서버에 연결할 수 없습니다.';

  @override
  String errorStatus(int status) {
    return '오류 $status';
  }

  @override
  String get roleOwner => '소유자';

  @override
  String get roleManager => '관리자';

  @override
  String get roleEmployee => '직원';

  @override
  String get roleExtra => '임시 직원';

  @override
  String get taglineStart => '팀의 근무표를 ';

  @override
  String get taglineEnd => '어디서나.';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Google로 로그인';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google 로그인을 사용할 수 없습니다: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google 로그인에 실패했습니다: $detail';
  }

  @override
  String get newCompany => '새 회사';

  @override
  String get timezone => '시간대';

  @override
  String get create => '만들기';

  @override
  String get noCompanyTitle => '아직 소속된 회사가 없습니다.';

  @override
  String get noCompanyHint => '고용주의 회사에 가입하려면 코드를 생성해 관리자에게 알려 주세요.';

  @override
  String get joinCompany => '회사 가입';

  @override
  String get createCompany => '회사 만들기';

  @override
  String transferOffer(String company) {
    return '‘$company’의 소유자가 되어 달라는 제안이 왔습니다.';
  }

  @override
  String get someCompany => '회사';

  @override
  String get becameOwner => '이제 소유자입니다.';

  @override
  String get myAccount => '내 계정';

  @override
  String get idCopied => 'ID가 복사되었습니다.';

  @override
  String myId(String id) {
    return '내 ID: $id';
  }

  @override
  String get signOut => '로그아웃';

  @override
  String joinInvite(String company, String role) {
    return '‘$company’에서 $role(으)로 초대했습니다.';
  }

  @override
  String joinedCompany(String company) {
    return '$company에 가입했습니다.';
  }

  @override
  String get viewPlanning => '근무표';

  @override
  String get viewTeam => '팀';

  @override
  String get viewPositions => '직무';

  @override
  String get readOnlyCompany => '읽기 전용 회사입니다.';

  @override
  String get team => '팀';

  @override
  String get leaveCompany => '이 회사에서 나가기';

  @override
  String meSuffix(String name) {
    return '$name(나)';
  }

  @override
  String transferConfirmTitle(String name) {
    return '회사를 $name에게 양도할까요?';
  }

  @override
  String get transferConfirmBody =>
      '상대가 수락하면 소유자(구독, 청구서, 관리자)가 되고, 나는 관리자가 됩니다.';

  @override
  String transferSent(String name) {
    return '$name에게 제안을 보냈습니다.';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$name을(를) 내보낼까요?';
  }

  @override
  String get removeConfirmBody => '기록은 보존됩니다.';

  @override
  String get addPersonTitle => '사람 추가';

  @override
  String get addPersonHint =>
      '상대에게 Staff Flow를 열고 계정 메뉴에서 ‘회사 가입’을 누르게 한 뒤, 표시된 코드를 입력하세요.';

  @override
  String get sixDigitCode => '6자리 코드';

  @override
  String invitationSent(String name) {
    return '$name에게 초대를 보냈습니다. 수락이 필요합니다.';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company에서 나갈까요?';
  }

  @override
  String get leaveConfirmBody => '더 이상 이 회사의 근무표를 볼 수 없습니다.';

  @override
  String get renameCompany => '회사 이름 변경';

  @override
  String get actionMakeManager => '관리자로 지정';

  @override
  String get actionMakeEmployee => '다시 직원으로';

  @override
  String get actionToEmployee => '직원으로 변경';

  @override
  String get actionToExtra => '임시 직원으로 변경';

  @override
  String get actionTransfer => '소유권 양도';

  @override
  String get actionRemove => '회사에서 내보내기';

  @override
  String get positions => '직무';

  @override
  String get sites => '사업장';

  @override
  String get positionsHint => '하는 일: 계산대, 주방, 안내 등';

  @override
  String get sitesHint => '회사에 사업장이 여러 곳일 때 근무 장소.';

  @override
  String get archived => '보관됨';

  @override
  String get archive => '보관';

  @override
  String get reactivate => '다시 사용';

  @override
  String weekOf(String date) {
    return '$date 주';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '변경 사항 $count건을 게시했습니다.',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => '근무';

  @override
  String get display => '보기';

  @override
  String get week => '주';

  @override
  String get month => '월';

  @override
  String get today => '오늘';

  @override
  String get onlyMine => '내 근무만';

  @override
  String get replacePersonMenu => '사람 교체…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '게시되지 않은 변경 $count건',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => '직원에게는 아직 보이지 않습니다.';

  @override
  String get publish => '게시';

  @override
  String yourHours(String duration) {
    return '기간 내 근무 시간: $duration';
  }

  @override
  String get addShiftThisDay => '이날 근무 추가';

  @override
  String get noShift => '근무 없음';

  @override
  String get unassigned => '미배정';

  @override
  String get formerMember => '이전 멤버';

  @override
  String get statusDraft => '초안';

  @override
  String get statusModified => '변경됨';

  @override
  String get statusDeleted => '삭제됨';

  @override
  String durationHours(int hours) {
    return '$hours시간';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours시간 $minutes분';
  }

  @override
  String get editShift => '근무 수정';

  @override
  String get newShift => '새 근무';

  @override
  String get thisShift => '이 근무만';

  @override
  String get thisAndFollowing => '이 근무와 이후 근무';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '날짜',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => '다른 날';

  @override
  String get start => '시작';

  @override
  String get end => '종료';

  @override
  String get endsNextDay => '다음 날 끝납니다.';

  @override
  String get person => '사람';

  @override
  String get position => '직무';

  @override
  String get site => '사업장';

  @override
  String get noteOptional => '메모(선택)';

  @override
  String get repetition => '반복';

  @override
  String get repeatNone => '없음';

  @override
  String get repeatDaily => '매일';

  @override
  String get repeatWeekly => '매주';

  @override
  String get repeatForPrefix => '기간 ';

  @override
  String get repeatDaysSuffix => '일';

  @override
  String get repeatWeeksSuffix => '주';

  @override
  String get repeatUntilPrefix => '종료일 ';

  @override
  String get replacePersonTitle => '사람 교체';

  @override
  String get replaceFrom => '교체할 사람';

  @override
  String get replaceBy => '대신할 사람';

  @override
  String dateRange(String from, String to) {
    return '$from부터 $to까지';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '근무 $count건을 변경했습니다.',
      zero: '변경된 근무가 없습니다.',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => '교체';

  @override
  String get joinHint => '이 코드를 관리자에게 알려 주세요. 관리자가 앱에 입력하면 초대를 받게 됩니다.';

  @override
  String get codeExpired => '코드가 만료되었습니다.';

  @override
  String codeValidFor(String time) {
    return '남은 시간 $time';
  }

  @override
  String get newCode => '새 코드';

  @override
  String get language => '언어';

  @override
  String get languageAuto => '자동(기기 언어)';

  @override
  String get syncUpToDate => '최신 상태';

  @override
  String get syncOffline => '오프라인';

  @override
  String syncPending(int count) {
    return '대기 중인 변경: $count';
  }

  @override
  String get syncNow => '지금 동기화';

  @override
  String syncRejected(String reason) {
    return '서버가 변경을 거부했습니다: $reason';
  }

  @override
  String get pendingBadge => '대기 중';

  @override
  String get offlineUnavailable => '오프라인에서는 사용할 수 없습니다.';

  @override
  String get offlineCached => '오프라인: 마지막으로 저장된 데이터입니다.';

  @override
  String get savedOffline => '기기에 저장했습니다. 네트워크가 돌아오면 보냅니다.';

  @override
  String get notices => '알림';

  @override
  String get noNotices => '알림이 없습니다.';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name님이 $date 근무에 대한 내 변경을 덮어썼습니다.';
  }

  @override
  String get history => '기록';

  @override
  String get recentChanges => '최근 변경';

  @override
  String get undoChange => '이 변경 취소';

  @override
  String get undoDone => '변경을 취소했습니다.';

  @override
  String get historyCreate => '생성';

  @override
  String get historyUpdate => '수정';

  @override
  String get historyDelete => '삭제';

  @override
  String get historyUndo => '취소';

  @override
  String get noHistory => '변경 사항이 없습니다.';

  @override
  String get pendingNotEditable => '이 근무는 아직 동기화되지 않았습니다. 온라인에서 다시 시도하세요.';

  @override
  String get myQrCode => '내 QR 코드';

  @override
  String get myQrCodeHint =>
      '관리자가 이 코드를 스캔하면 회사에 추가되며, 이후 직접 확인합니다. 코드는 바뀌지 않습니다.';

  @override
  String get changeMyName => '내 이름 변경';

  @override
  String get nameShownToTeam => '동료에게는 Google 이름 대신 이 이름이 표시됩니다.';

  @override
  String googleName(String name) {
    return 'Google 이름: $name';
  }

  @override
  String get useGoogleName => 'Google 이름 사용';

  @override
  String renameMemberTitle(String name) {
    return '$name 이름 변경';
  }

  @override
  String get renameMemberHint => '이 이름은 이 회사에서만 사용됩니다.';

  @override
  String get useOwnName => '본인 이름 사용';

  @override
  String get scanQrCode => 'QR 코드 스캔';

  @override
  String get scanQrHint => '상대방 앱에 표시된 QR 코드에 카메라를 맞추세요(계정 메뉴, ‘내 QR 코드’).';

  @override
  String get orEnterCode => '또는 6자리 코드를 입력하세요';

  @override
  String get qrInvalid => 'Staff Flow QR 코드가 아닙니다.';

  @override
  String cameraUnavailable(String error) {
    return '카메라를 사용할 수 없습니다($error).';
  }

  @override
  String get notificationsTitle => '알림';

  @override
  String get notifChooseHint => '알림 받을 항목을 선택하세요. 모든 내용은 종 아이콘에서 계속 볼 수 있습니다.';

  @override
  String get notifPlanning => '근무표 게시 또는 변경';

  @override
  String get notifRequests => '요청: 교대, 휴가, 초대';

  @override
  String get notifMessages => '새 메시지';

  @override
  String get notifOverlap => '회사 간 겹치는 근무';

  @override
  String get notifConflicts => '다른 관리자가 내 변경을 대체함';

  @override
  String get notifBilling => '구독 알림';

  @override
  String get pushEnabled => '이 기기에서 알림이 켜져 있습니다.';

  @override
  String get pushOff => '이 기기에서 알림이 꺼져 있습니다.';

  @override
  String get pushBlocked => '알림이 차단되었습니다. 휴대전화나 브라우저 설정에서 허용하세요.';

  @override
  String get pushUnavailable => '이 기기에서는 알림을 사용할 수 없습니다.';

  @override
  String get enablePush => '켜기';

  @override
  String noticeSchedulePublished(String company) {
    return '$company: 근무표가 게시되었거나 변경되었습니다.';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company에서 회원님을 팀에 추가하려고 합니다.';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name님이 회원님에게 $company 소유권을 넘기려고 합니다.';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name님이 $company에 합류했습니다.';
  }

  @override
  String get messagesTab => '메시지';

  @override
  String get wholeTeam => '팀 전체';

  @override
  String get newConversation => '새 대화';

  @override
  String get noMessages => '아직 메시지가 없습니다.';

  @override
  String get messageHint => '메시지 입력';

  @override
  String get earlierMessages => '이전 메시지';

  @override
  String get personLeftCompany => '이 사람은 더 이상 회사 소속이 아닙니다.';

  @override
  String messagePreview(String name, String text) {
    return '$name: $text';
  }

  @override
  String get newGroup => '새 그룹';

  @override
  String get editGroup => '그룹 편집';

  @override
  String get groupName => '그룹 이름';

  @override
  String get groupMembersHint => '이 그룹의 사람들을 선택하세요. 이들만 메시지를 볼 수 있습니다.';

  @override
  String get chooseAtLeastOne => '한 명 이상 선택하세요.';

  @override
  String get replyAction => '답장';

  @override
  String get translateAction => '번역';

  @override
  String replyingTo(String name) {
    return '$name님에게 답장';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name님의 최근 메시지';
  }

  @override
  String get deleteAllNotices => '모두 삭제';

  @override
  String get deleteAllNoticesConfirm => '모든 알림을 삭제할까요?';

  @override
  String get noticeRetention => '읽은 알림 삭제 시점';

  @override
  String get retentionDay => '1일 후';

  @override
  String get retentionWeek => '1주 후';

  @override
  String get retentionMonth => '1개월 후';

  @override
  String get billingOwnersOnly => '회사를 소유한 경우에만 활성화됩니다.';

  @override
  String get readOnlyPastDays => '한 달이 지난 날짜는 읽기 전용입니다.';

  @override
  String get wholeCompany => '회사 전체';

  @override
  String get sitesLabel => '지점';

  @override
  String get actionSites => '지점…';

  @override
  String managerOf(String name) {
    return '$name님 담당';
  }

  @override
  String teamSitesOf(String name) {
    return '$name님의 팀';
  }

  @override
  String get notYourSite => '이 지점은 담당 지점이 아닙니다.';

  @override
  String get chooseYourSite => '지점을 하나 이상 선택하세요.';

  @override
  String get viewRequests => '요청';

  @override
  String get newRequest => '새 요청';

  @override
  String get requestLeave => '휴가';

  @override
  String get requestUnavailability => '근무 불가';

  @override
  String get requestSwap => '근무 교대';

  @override
  String get swapHint => '교대를 제안하려면 근무표에서 앞으로의 내 근무를 누르세요.';

  @override
  String get noRequests => '아직 요청이 없습니다.';

  @override
  String get requestsToHandle => '처리할 요청';

  @override
  String get myRequests => '내 요청';

  @override
  String get otherRequests => '팀 요청';

  @override
  String get statusPendingPeer => '동료 응답 대기';

  @override
  String get statusPendingManager => '관리자 승인 대기';

  @override
  String get statusApproved => '승인됨';

  @override
  String get statusRefused => '거절됨';

  @override
  String get statusCancelled => '취소됨';

  @override
  String get cancelRequest => '요청 취소';

  @override
  String get acceptSwap => '이 근무 맡기';

  @override
  String get approve => '승인';

  @override
  String periodLabel(String from, String to) {
    return '$from부터 $to까지';
  }

  @override
  String swapToPeer(String name) {
    return '$name님에게 제안';
  }

  @override
  String get swapToTeam => '팀 전체';

  @override
  String everyWeekdays(String days) {
    return '매주: $days';
  }

  @override
  String get unavailableEveryWeek => '항상 근무할 수 없는 요일:';

  @override
  String get choosePeriod => '날짜 선택';

  @override
  String get choosePeriodOptional => '기간으로 제한(선택)';

  @override
  String get clearPeriod => '기간 없음';

  @override
  String get sendRequest => '요청 보내기';

  @override
  String get proposeSwap => '교대 제안';

  @override
  String get swapWith => '제안 대상';

  @override
  String get swapSteps => '동료가 수락한 뒤 관리자가 승인합니다. 근무표는 그 후에만 바뀝니다.';

  @override
  String get absentThatDay => '이 날 승인된 부재';

  @override
  String get requestSent => '요청을 보냈습니다.';

  @override
  String noticeSwapOffer(String name) {
    return '$name님이 근무 하나를 넘기려고 합니다.';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name님이 교대 제안을 거절했습니다.';
  }

  @override
  String get noticeSwapToApprove => '근무 교대가 승인을 기다리고 있습니다.';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name님이 휴가를 요청했습니다.';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name님이 근무 불가를 알렸습니다.';
  }

  @override
  String get noticeRequestApproved => '요청이 승인되었습니다.';

  @override
  String get noticeRequestRefused => '요청이 거절되었습니다.';

  @override
  String get choosePeer => '이 근무를 누가 맡나요?';

  @override
  String get discardAll => '모두 취소';

  @override
  String get notifySitesHint => '요청 알림을 받을 지점을 선택하세요. 모든 요청은 목록에 계속 표시됩니다.';

  @override
  String get notifySitesTitle => '지점별 알림';

  @override
  String get pendingRequestTooltip => '대기 중인 요청: 눌러서 열기';

  @override
  String get requestsHistory => '모든 요청';

  @override
  String get revertChange => '이 변경 취소';

  @override
  String get statusExpired => '해당 없음';

  @override
  String get swapWithHint => '눌러서 특정 동료 선택';

  @override
  String changesDiscarded(String count) {
    return '취소된 변경: $count';
  }

  @override
  String discardConfirm(String count) {
    return '게시되지 않은 변경 $count건을 취소할까요?';
  }

  @override
  String get allSchedules => '내 모든 근무표';

  @override
  String get busyElsewhere => '이 시간에 이미 다른 회사에서 근무 중입니다';

  @override
  String get overlapTooltip => '다른 회사의 근무와 겹칩니다';

  @override
  String get overlapWarning => '두 회사의 근무 중 일부가 겹칩니다.';

  @override
  String noticeOverlap(String date) {
    return '$date에 서로 다른 회사의 근무 두 개가 겹칩니다.';
  }

  @override
  String get allMyCompanies => '내 모든 회사';

  @override
  String get deleteGroup => '그룹 삭제';

  @override
  String get openRequest => '요청 보기';

  @override
  String get thisCompany => '이 회사';

  @override
  String get withExtras => '임시 직원 포함';

  @override
  String deleteGroupConfirm(String name) {
    return '모든 사람에게서 “$name”과(와) 모든 메시지를 삭제할까요?';
  }

  @override
  String reinforcementHint(String company) {
    return '$company 소속: 지원 인력으로 추가되고 알림을 받습니다.';
  }

  @override
  String get addToGoogle => 'Google 캘린더에 추가';

  @override
  String get calendarEnabled => '내 근무 동기화';

  @override
  String get calendarHint =>
      '모든 회사의 근무를 Google 캘린더에 추가합니다. 자동으로 업데이트되며 언제든지 끌 수 있습니다.';

  @override
  String get changeSettings => '수정';

  @override
  String get copyCalendarLink => '캘린더 링크 복사';

  @override
  String get countryBelgium => '벨기에';

  @override
  String get countryCanada => '캐나다';

  @override
  String get countryFrance => '프랑스';

  @override
  String get countrySwitzerland => '스위스';

  @override
  String get employeesSection => '직원';

  @override
  String get emptyNoAlert => '비워 두면 알림 없음';

  @override
  String get extrasSection => '임시 직원';

  @override
  String get googleCalendar => 'Google 캘린더';

  @override
  String get hoursTotals => '근무 시간 합계';

  @override
  String get legalAlerts => '법정 알림';

  @override
  String get legalAlertsHint => '경고일 뿐 차단하지 않습니다. 해당되는 규칙을 선택하거나 선택하지 마세요.';

  @override
  String get legalPreset => '국가별 템플릿';

  @override
  String get linkCopied => '링크를 복사했습니다.';

  @override
  String get maxConsecutiveLabel => '최대 연속 근무일';

  @override
  String get maxDayLabel => '하루 최대 시간';

  @override
  String get maxWeekLabel => '주당 최대 시간';

  @override
  String get minRestLabel => '근무 사이 최소 휴식(시간)';

  @override
  String get noLegalRules => '선택한 알림이 없습니다.';

  @override
  String get presetNone => '없음';

  @override
  String get presetsCheck => '템플릿은 출발점일 뿐입니다. 국가 법률과 단체협약에 맞게 확인하세요.';

  @override
  String get printMine => '내 근무표';

  @override
  String get printOwn => '자신의 근무표만';

  @override
  String get printPdf => '인쇄 / PDF';

  @override
  String get printRights => '직원이 인쇄할 수 있는 범위';

  @override
  String get printTeam => '팀 전체 근무표';

  @override
  String get printTeamOption => '팀 근무표';

  @override
  String get totalsHint => '초안 포함. Excel 및 CSV 내보내기는 게시된 근무표를 사용합니다.';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name: $value일 연속(최대 $limit)';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name: 하루 $value(최대 $limit)';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name: 휴식 $value뿐(최소 $limit)';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name: 주 $value(최대 $limit)';
  }

  @override
  String legalAlertsCount(String count) {
    return '법정 알림: $count';
  }

  @override
  String shiftsCount(String count) {
    return '근무: $count';
  }

  @override
  String get actionMakeDeputy => '부관리자로 지정';

  @override
  String get actionRemoveDeputy => '부관리자 역할 해제';

  @override
  String get busyHere => '이 시간에 이미 이 회사에서 근무 중입니다';

  @override
  String get calendarByLink => '링크로 추가(컴퓨터의 Google 캘린더)';

  @override
  String get calendarDenied => '캘린더 접근이 거부되었습니다. 휴대전화 설정에서 허용하세요.';

  @override
  String get calendarLinkHint =>
      '컴퓨터의 Google 캘린더에서 추가하세요. Google이 몇 시간 안에 업데이트합니다.';

  @override
  String get calendarNone => '이 휴대전화에 편집 가능한 캘린더가 없습니다.';

  @override
  String get calendarOnPhone => '내 근무를 휴대전화 캘린더에 추가';

  @override
  String get calendarOnPhoneHint =>
      'Google 캘린더에 바로 표시됩니다(휴대전화와 Google 캘린더 모두).';

  @override
  String get chooseCalendar => '캘린더 선택';

  @override
  String get otherSiteHint => '다른 지점의 직원입니다. 해당 관리자에게 알림이 갑니다.';

  @override
  String get subManager => '부관리자';

  @override
  String calendarSynced(String count) {
    return '캘린더의 근무: $count';
  }

  @override
  String deputyOf(String name) {
    return '부관리자: $name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by님이 $date에 $name님을 $site 지점에 배치했습니다.';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company에서 귀하를 지원 인력으로 추가했습니다.';
  }
}
