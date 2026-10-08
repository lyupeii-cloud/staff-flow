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
}
