// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get cancel => 'キャンセル';

  @override
  String get save => '保存';

  @override
  String get confirm => '確認';

  @override
  String get validate => '確定';

  @override
  String get add => '追加';

  @override
  String get rename => '名前を変更';

  @override
  String get delete => '削除';

  @override
  String get accept => '承認';

  @override
  String get decline => '辞退';

  @override
  String get close => '閉じる';

  @override
  String get retry => '再試行';

  @override
  String get name => '名前';

  @override
  String get serverUnreachable => 'サーバーに接続できません。';

  @override
  String errorStatus(int status) {
    return 'エラー $status';
  }

  @override
  String get roleOwner => 'オーナー';

  @override
  String get roleManager => '責任者';

  @override
  String get roleEmployee => '従業員';

  @override
  String get roleExtra => '臨時スタッフ';

  @override
  String get taglineStart => 'チームのシフトを、';

  @override
  String get taglineEnd => 'どこでも。';

  @override
  String get googleNotConfigured =>
      'Google sign-in is not configured (GOOGLE_WEB_CLIENT_ID).';

  @override
  String get signInWithGoogle => 'Google でログイン';

  @override
  String get devSection => 'Development';

  @override
  String get emailLabel => 'Email address';

  @override
  String get devSignIn => 'Test sign-in';

  @override
  String googleUnavailable(String detail) {
    return 'Google ログインを利用できません: $detail';
  }

  @override
  String googleFailed(String detail) {
    return 'Google でログインできませんでした: $detail';
  }

  @override
  String get newCompany => '新しい会社';

  @override
  String get timezone => 'タイムゾーン';

  @override
  String get create => '作成';

  @override
  String get noCompanyTitle => 'まだどの会社にも所属していません。';

  @override
  String get noCompanyHint => '勤務先の会社に参加するには、コードを生成して責任者に伝えてください。';

  @override
  String get joinCompany => '会社に参加';

  @override
  String get createCompany => '会社を作成';

  @override
  String transferOffer(String company) {
    return '「$company」のオーナーになるよう依頼されています。';
  }

  @override
  String get someCompany => 'ある会社';

  @override
  String get becameOwner => 'あなたがオーナーになりました。';

  @override
  String get myAccount => 'アカウント';

  @override
  String get idCopied => 'ID をコピーしました。';

  @override
  String myId(String id) {
    return '自分の ID: $id';
  }

  @override
  String get signOut => 'ログアウト';

  @override
  String joinInvite(String company, String role) {
    return '「$company」から$roleとして招待されています。';
  }

  @override
  String joinedCompany(String company) {
    return '$company に参加しました。';
  }

  @override
  String get viewPlanning => 'シフト';

  @override
  String get viewTeam => '管理';

  @override
  String get viewPositions => 'ポジション';

  @override
  String get readOnlyCompany => 'この会社は閲覧のみです。';

  @override
  String get team => 'チーム';

  @override
  String get leaveCompany => 'この会社を退出';

  @override
  String meSuffix(String name) {
    return '$name（あなた）';
  }

  @override
  String transferConfirmTitle(String name) {
    return '会社を $name に譲渡しますか？';
  }

  @override
  String get transferConfirmBody =>
      '相手が承認すると、相手がオーナー（契約、請求書、責任者）になり、あなたは責任者になります。';

  @override
  String transferSent(String name) {
    return '$name に依頼を送りました。';
  }

  @override
  String removeConfirmTitle(String name) {
    return '$name を外しますか？';
  }

  @override
  String get removeConfirmBody => '履歴は保持されます。';

  @override
  String get addPersonTitle => 'メンバーを追加';

  @override
  String get addPersonHint =>
      '相手に Staff Flow を開いてもらい、アカウントメニューの「会社に参加」を選んでもらい、表示されたコードを入力してください。';

  @override
  String get sixDigitCode => '6 桁のコード';

  @override
  String invitationSent(String name) {
    return '$name に招待を送りました。承認が必要です。';
  }

  @override
  String leaveConfirmTitle(String company) {
    return '$company を退出しますか？';
  }

  @override
  String get leaveConfirmBody => 'この会社のシフトは見られなくなります。';

  @override
  String get renameCompany => '会社名を変更';

  @override
  String get actionMakeManager => '責任者にする';

  @override
  String get actionMakeEmployee => '従業員に戻す';

  @override
  String get actionToEmployee => '従業員にする';

  @override
  String get actionToExtra => '臨時スタッフにする';

  @override
  String get actionTransfer => 'オーナー権を譲渡';

  @override
  String get actionRemove => '会社から外す';

  @override
  String get positions => 'ポジション';

  @override
  String get sites => '拠点';

  @override
  String get positionsHint => '担当業務：レジ、キッチン、受付など';

  @override
  String get sitesHint => '会社に複数の拠点がある場合の勤務場所。';

  @override
  String get archived => 'アーカイブ済み';

  @override
  String get archive => 'アーカイブ';

  @override
  String get reactivate => '再開';

  @override
  String weekOf(String date) {
    return '$date の週';
  }

  @override
  String changesPublished(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件の変更を公開しました。',
    );
    return '$_temp0';
  }

  @override
  String get shiftButton => 'シフト';

  @override
  String get display => '表示';

  @override
  String get week => '週';

  @override
  String get month => '月';

  @override
  String get today => '今日';

  @override
  String get onlyMine => '自分のシフトのみ';

  @override
  String get replacePersonMenu => '担当者を交代…';

  @override
  String pendingChanges(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '未公開の変更 $count 件',
    );
    return '$_temp0';
  }

  @override
  String get pendingHint => '従業員にはまだ表示されません。';

  @override
  String get publish => '公開';

  @override
  String yourHours(String duration) {
    return '期間中の勤務時間: $duration';
  }

  @override
  String get addShiftThisDay => 'この日にシフトを追加';

  @override
  String get noShift => 'シフトなし';

  @override
  String get unassigned => '未割り当て';

  @override
  String get formerMember => '元メンバー';

  @override
  String get statusDraft => '下書き';

  @override
  String get statusModified => '変更あり';

  @override
  String get statusDeleted => '削除済み';

  @override
  String durationHours(int hours) {
    return '$hours 時間';
  }

  @override
  String durationHoursMinutes(int hours, String minutes) {
    return '$hours 時間 $minutes 分';
  }

  @override
  String get editShift => 'シフトを編集';

  @override
  String get newShift => '新しいシフト';

  @override
  String get thisShift => 'このシフトのみ';

  @override
  String get thisAndFollowing => 'これ以降すべて';

  @override
  String daysLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '日付',
    );
    return '$_temp0';
  }

  @override
  String get otherDay => '別の日';

  @override
  String get start => '開始';

  @override
  String get end => '終了';

  @override
  String get endsNextDay => '翌日に終了します。';

  @override
  String get person => '担当者';

  @override
  String get position => 'ポジション';

  @override
  String get site => '拠点';

  @override
  String get noteOptional => 'メモ（任意）';

  @override
  String get repetition => '繰り返し';

  @override
  String get repeatNone => 'なし';

  @override
  String get repeatDaily => '毎日';

  @override
  String get repeatWeekly => '毎週';

  @override
  String get repeatForPrefix => '期間 ';

  @override
  String get repeatDaysSuffix => ' 日間';

  @override
  String get repeatWeeksSuffix => ' 週間';

  @override
  String get repeatUntilPrefix => '終了日 ';

  @override
  String get replacePersonTitle => '担当者を交代';

  @override
  String get replaceFrom => '交代する人';

  @override
  String get replaceBy => '交代先';

  @override
  String dateRange(String from, String to) {
    return '$from から $to まで';
  }

  @override
  String shiftsChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件のシフトを変更しました。',
      zero: '変更されたシフトはありません。',
    );
    return '$_temp0';
  }

  @override
  String get replaceButton => '交代';

  @override
  String get joinHint => 'このコードを責任者に伝えてください。責任者がアプリに入力すると、招待が届きます。';

  @override
  String get codeExpired => 'コードの有効期限が切れました。';

  @override
  String codeValidFor(String time) {
    return '残り $time';
  }

  @override
  String get newCode => '新しいコード';

  @override
  String get language => '言語';

  @override
  String get languageAuto => '自動（端末の言語）';

  @override
  String get syncUpToDate => '最新の状態';

  @override
  String get syncOffline => 'オフライン';

  @override
  String syncPending(int count) {
    return '未送信の変更: $count';
  }

  @override
  String get syncNow => '今すぐ同期';

  @override
  String syncRejected(String reason) {
    return 'サーバーが変更を拒否しました: $reason';
  }

  @override
  String get pendingBadge => '未送信';

  @override
  String get offlineUnavailable => 'オフラインでは利用できません。';

  @override
  String get offlineCached => 'オフライン: 最後に保存したデータを表示しています。';

  @override
  String get savedOffline => 'この端末に保存しました。ネットワーク復帰後に送信します。';

  @override
  String get notices => 'お知らせ';

  @override
  String get noNotices => 'お知らせはありません。';

  @override
  String noticeOverwritten(String name, String date) {
    return '$name が $date のシフトに対するあなたの変更を上書きしました。';
  }

  @override
  String get history => '履歴';

  @override
  String get recentChanges => '最近の変更';

  @override
  String get undoChange => 'この変更を元に戻す';

  @override
  String get undoDone => '変更を元に戻しました。';

  @override
  String get historyCreate => '作成';

  @override
  String get historyUpdate => '変更';

  @override
  String get historyDelete => '削除';

  @override
  String get historyUndo => '取り消し';

  @override
  String get noHistory => '変更はありません。';

  @override
  String get pendingNotEditable => 'このシフトはまだ同期されていません。オンラインで再度お試しください。';

  @override
  String get myQrCode => '自分のQRコード';

  @override
  String get myQrCodeHint =>
      '管理者がこのコードを読み取ると、会社に追加されます。その後あなたが承認します。コードは変わりません。';

  @override
  String get changeMyName => '名前を変更';

  @override
  String get nameShownToTeam => '同僚にはGoogleの名前の代わりにこの名前が表示されます。';

  @override
  String googleName(String name) {
    return 'Googleの名前：$name';
  }

  @override
  String get useGoogleName => 'Googleの名前を使う';

  @override
  String renameMemberTitle(String name) {
    return '$name の名前を変更';
  }

  @override
  String get renameMemberHint => 'この名前はこの会社でのみ使われます。';

  @override
  String get useOwnName => '本人の名前を使う';

  @override
  String get scanQrCode => 'QRコードを読み取る';

  @override
  String get scanQrHint =>
      '相手のアプリに表示されたQRコードにカメラを向けてください（アカウントメニュー「自分のQRコード」）。';

  @override
  String get orEnterCode => 'または6桁のコードを入力';

  @override
  String get qrInvalid => 'Staff FlowのQRコードではありません。';

  @override
  String cameraUnavailable(String error) {
    return 'カメラを使用できません（$error）。';
  }

  @override
  String get notificationsTitle => '通知';

  @override
  String get notifChooseHint => '通知を受け取る内容を選んでください。すべてベルにはそのまま表示されます。';

  @override
  String get notifPlanning => 'シフトの公開・変更';

  @override
  String get notifRequests => '申請：交代、休暇、招待';

  @override
  String get notifMessages => '新着メッセージ';

  @override
  String get notifOverlap => '会社間のシフトの重複';

  @override
  String get notifConflicts => '自分の変更が別の管理者に置き換えられたとき';

  @override
  String get notifBilling => 'サブスクリプションのお知らせ';

  @override
  String get pushEnabled => 'この端末で通知はオンです。';

  @override
  String get pushOff => 'この端末で通知はオフです。';

  @override
  String get pushBlocked => '通知がブロックされています。スマートフォンまたはブラウザの設定で許可してください。';

  @override
  String get pushUnavailable => 'この端末では通知を利用できません。';

  @override
  String get enablePush => 'オンにする';

  @override
  String noticeSchedulePublished(String company) {
    return '$company：シフトが公開または変更されました。';
  }

  @override
  String noticeJoinInvite(String company) {
    return '$company があなたをチームに追加しようとしています。';
  }

  @override
  String noticeTransferOffer(String name, String company) {
    return '$name さんがあなたを $company のオーナーにすることを提案しています。';
  }

  @override
  String noticeMemberJoined(String name, String company) {
    return '$name さんが $company に参加しました。';
  }

  @override
  String get messagesTab => 'メッセージ';

  @override
  String get wholeTeam => 'チーム全員';

  @override
  String get newConversation => '新しい会話';

  @override
  String get noMessages => 'まだメッセージはありません。';

  @override
  String get messageHint => 'メッセージを入力';

  @override
  String get earlierMessages => '以前のメッセージ';

  @override
  String get personLeftCompany => 'この人はもう会社のメンバーではありません。';

  @override
  String messagePreview(String name, String text) {
    return '$name：$text';
  }

  @override
  String get newGroup => '新しいグループ';

  @override
  String get editGroup => 'グループを編集';

  @override
  String get groupName => 'グループ名';

  @override
  String get groupMembersHint => 'このグループのメンバーを選んでください。メッセージはメンバーだけに表示されます。';

  @override
  String get chooseAtLeastOne => '少なくとも1人選んでください。';

  @override
  String get replyAction => '返信';

  @override
  String get translateAction => '翻訳';

  @override
  String replyingTo(String name) {
    return '$name さんへの返信';
  }

  @override
  String lastMessagesOf(String name) {
    return '$name さんの最近のメッセージ';
  }

  @override
  String get deleteAllNotices => 'すべて削除';

  @override
  String get deleteAllNoticesConfirm => 'すべてのお知らせを削除しますか？';

  @override
  String get noticeRetention => '既読のお知らせを削除するまで';

  @override
  String get retentionDay => '1日';

  @override
  String get retentionWeek => '1週間';

  @override
  String get retentionMonth => '1か月';

  @override
  String get billingOwnersOnly => '会社のオーナーの場合のみ有効です。';

  @override
  String get readOnlyPastDays => '1か月以上前の日は閲覧のみです。';

  @override
  String get wholeCompany => '会社全体';

  @override
  String get sitesLabel => '拠点';

  @override
  String get actionSites => '拠点…';

  @override
  String managerOf(String name) {
    return '$name さんの担当';
  }

  @override
  String teamSitesOf(String name) {
    return '$name さんのチーム';
  }

  @override
  String get notYourSite => 'この拠点はあなたの担当ではありません。';

  @override
  String get chooseYourSite => '拠点を少なくとも1つ選んでください。';

  @override
  String get viewRequests => '申請';

  @override
  String get newRequest => '新しい申請';

  @override
  String get requestLeave => '休暇';

  @override
  String get requestUnavailability => '勤務不可';

  @override
  String get requestSwap => 'シフト交代';

  @override
  String get swapHint => '交代を提案するには、勤務表で今後の自分のシフトをタップしてください。';

  @override
  String get noRequests => 'まだ申請はありません。';

  @override
  String get requestsToHandle => '対応待ち';

  @override
  String get myRequests => '自分の申請';

  @override
  String get otherRequests => 'チームの申請';

  @override
  String get statusPendingPeer => '同僚の返答待ち';

  @override
  String get statusPendingManager => '責任者の承認待ち';

  @override
  String get statusApproved => '承認済み';

  @override
  String get statusRefused => '却下';

  @override
  String get statusCancelled => '取り消し済み';

  @override
  String get cancelRequest => '申請を取り消す';

  @override
  String get acceptSwap => 'このシフトを引き受ける';

  @override
  String get approve => '承認';

  @override
  String periodLabel(String from, String to) {
    return '$from〜$to';
  }

  @override
  String swapToPeer(String name) {
    return '$name さんに提案';
  }

  @override
  String get swapToTeam => 'チーム全員';

  @override
  String everyWeekdays(String days) {
    return '毎週：$days';
  }

  @override
  String get unavailableEveryWeek => 'いつも勤務できない曜日：';

  @override
  String get choosePeriod => '日付を選ぶ';

  @override
  String get choosePeriodOptional => '期間を限定する（任意）';

  @override
  String get clearPeriod => '期間なし';

  @override
  String get sendRequest => '申請を送信';

  @override
  String get proposeSwap => '交代を提案';

  @override
  String get swapWith => '提案先';

  @override
  String get swapSteps => '同僚が承諾し、その後責任者が承認します。勤務表はその後に変わります。';

  @override
  String get absentThatDay => 'この日は承認済みの不在';

  @override
  String get requestSent => '申請を送信しました。';

  @override
  String noticeSwapOffer(String name) {
    return '$name さんがシフトを1つ譲ろうとしています。';
  }

  @override
  String noticeSwapDeclined(String name) {
    return '$name さんが交代の提案を断りました。';
  }

  @override
  String get noticeSwapToApprove => 'シフト交代があなたの承認を待っています。';

  @override
  String noticeLeaveToApprove(String name) {
    return '$name さんが休暇を申請しています。';
  }

  @override
  String noticeUnavailabilityToApprove(String name) {
    return '$name さんが勤務不可を申告しました。';
  }

  @override
  String get noticeRequestApproved => '申請が承認されました。';

  @override
  String get noticeRequestRefused => '申請が却下されました。';

  @override
  String get choosePeer => 'このシフトを誰が引き受けますか？';

  @override
  String get discardAll => 'すべて取り消す';

  @override
  String get notifySitesHint => '申請の通知を受け取る店舗を選んでください。すべての申請は一覧に表示されたままです。';

  @override
  String get notifySitesTitle => '店舗ごとの通知';

  @override
  String get pendingRequestTooltip => '保留中の申請：タップして開く';

  @override
  String get requestsHistory => 'すべての申請';

  @override
  String get revertChange => 'この変更を取り消す';

  @override
  String get statusExpired => '対象外';

  @override
  String get swapWithHint => 'タップして同僚を指定';

  @override
  String changesDiscarded(String count) {
    return '取り消した変更：$count';
  }

  @override
  String discardConfirm(String count) {
    return '未公開の変更 $count 件を取り消しますか？';
  }

  @override
  String get allSchedules => 'すべての勤務表';

  @override
  String get busyElsewhere => 'この時間帯は別の会社で勤務中です';

  @override
  String get overlapTooltip => '別の会社のシフトと重なっています';

  @override
  String get overlapWarning => '2つの会社のシフトの一部が重なっています。';

  @override
  String noticeOverlap(String date) {
    return '$date に、別々の会社の2つのシフトが重なっています。';
  }

  @override
  String get allMyCompanies => 'すべての会社';

  @override
  String get deleteGroup => 'グループを削除';

  @override
  String get openRequest => '申請を見る';

  @override
  String get thisCompany => 'この会社';

  @override
  String get withExtras => '臨時スタッフを含める';

  @override
  String deleteGroupConfirm(String name) {
    return '「$name」とすべてのメッセージを全員から削除しますか？';
  }

  @override
  String reinforcementHint(String company) {
    return '$company から：応援スタッフとして追加され、通知されます。';
  }

  @override
  String get addToGoogle => 'Google カレンダーに追加';

  @override
  String get calendarEnabled => 'シフトを同期';

  @override
  String get calendarHint =>
      'すべての会社のシフトを Google カレンダーに追加します。自動で更新され、いつでもオフにできます。';

  @override
  String get changeSettings => '変更';

  @override
  String get copyCalendarLink => 'カレンダーのリンクをコピー';

  @override
  String get countryBelgium => 'ベルギー';

  @override
  String get countryCanada => 'カナダ';

  @override
  String get countryFrance => 'フランス';

  @override
  String get countrySwitzerland => 'スイス';

  @override
  String get employeesSection => '従業員';

  @override
  String get emptyNoAlert => '空欄：警告なし';

  @override
  String get extrasSection => '臨時スタッフ';

  @override
  String get googleCalendar => 'Google カレンダー';

  @override
  String get hoursTotals => '勤務時間の合計';

  @override
  String get legalAlerts => '法定アラート';

  @override
  String get legalAlertsHint => '警告のみで、ブロックはしません。適用されるルールを選ぶか、何も選ばないでください。';

  @override
  String get legalPreset => '国別テンプレート';

  @override
  String get linkCopied => 'リンクをコピーしました。';

  @override
  String get maxConsecutiveLabel => '連続勤務日数の上限';

  @override
  String get maxDayLabel => '1日の最長時間（時間）';

  @override
  String get maxWeekLabel => '1週間の最長時間（時間）';

  @override
  String get minRestLabel => 'シフト間の最短休息（時間）';

  @override
  String get noLegalRules => 'アラートは選択されていません。';

  @override
  String get presetNone => 'なし';

  @override
  String get presetsCheck => 'テンプレートは出発点です。国の法律と労働協約に合わせて確認してください。';

  @override
  String get printMine => '自分の勤務表';

  @override
  String get printOwn => '自分の勤務表のみ';

  @override
  String get printPdf => '印刷 / PDF';

  @override
  String get printRights => '従業員が印刷できる範囲';

  @override
  String get printTeam => 'チーム全員の勤務表';

  @override
  String get printTeamOption => 'チームの勤務表';

  @override
  String get totalsHint => '下書きを含みます。Excel と CSV の書き出しは公開済みの勤務表を使います。';

  @override
  String alertConsecutive(String name, String value, String limit) {
    return '$name：$value 日連続（上限 $limit）';
  }

  @override
  String alertDay(String name, String value, String limit) {
    return '$name：1日 $value（上限 $limit）';
  }

  @override
  String alertRest(String name, String value, String limit) {
    return '$name：休息が $value のみ（最低 $limit）';
  }

  @override
  String alertWeek(String name, String value, String limit) {
    return '$name：1週間 $value（上限 $limit）';
  }

  @override
  String legalAlertsCount(String count) {
    return '法定アラート：$count';
  }

  @override
  String shiftsCount(String count) {
    return 'シフト：$count';
  }

  @override
  String get actionMakeDeputy => '副責任者に任命';

  @override
  String get actionRemoveDeputy => '副責任者の役割を外す';

  @override
  String get busyHere => 'この時間帯はすでにこの会社で勤務中です';

  @override
  String get calendarByLink => 'リンクで追加（パソコンの Google カレンダー）';

  @override
  String get calendarDenied => 'カレンダーへのアクセスが拒否されました。電話の設定で許可してください。';

  @override
  String get calendarLinkHint =>
      'パソコンの Google カレンダーから追加してください。Google が数時間以内に更新します。';

  @override
  String get calendarNone => 'この電話には編集できるカレンダーがありません。';

  @override
  String get calendarOnPhone => 'シフトを電話のカレンダーに追加';

  @override
  String get calendarOnPhoneHint =>
      'Google カレンダーにすぐ表示されます（電話と Google カレンダーの両方）。';

  @override
  String get chooseCalendar => 'カレンダーを選択';

  @override
  String get otherSiteHint => '別の店舗の従業員です。その責任者に通知されます。';

  @override
  String get subManager => '副責任者';

  @override
  String calendarSynced(String count) {
    return 'カレンダーのシフト：$count';
  }

  @override
  String deputyOf(String name) {
    return '副責任者：$name';
  }

  @override
  String noticeBorrowed(String by, String name, String site, String date) {
    return '$by さんが $date に $name さんを $site に配置しました。';
  }

  @override
  String noticeReinforcement(String company) {
    return '$company があなたを応援スタッフとして追加しました。';
  }

  @override
  String get companyNotificationsHint => 'オフ：この電話では鳴りませんが、すべてベルに残ります。';

  @override
  String get companyNotificationsOn => 'この会社の通知を受け取る';

  @override
  String get companyTimezone => '会社のタイムゾーン';

  @override
  String get companyTimezoneHint =>
      'この会社の時刻はすべてこのタイムゾーンです（夏時間を含む）。カレンダーが自動で変換します。';

  @override
  String get iosInstallHint =>
      'iPhone では「共有」をタップし、「ホーム画面に追加」で Staff Flow をインストールできます。';

  @override
  String get searchCity => '都市を検索';

  @override
  String get thisPhone => 'このデバイス';

  @override
  String companyNotifications(String name) {
    return '通知：$name';
  }

  @override
  String timezoneDiffers(String zone, String company, String here) {
    return '時刻は $zone 時間（$company）です。お使いのデバイス：$here。';
  }

  @override
  String get addPreset => 'プリセットを追加';

  @override
  String get addPresets => 'プリセットを作成';

  @override
  String get appearance => '表示';

  @override
  String get chooseLogo => 'PNG 画像を選択';

  @override
  String get conversationMuted => 'この会話の通知をミュートしました。';

  @override
  String get conversationUnmuted => 'この会話の通知を再開しました。';

  @override
  String get customization => 'カスタマイズ';

  @override
  String get disableGroup => 'グループをオフにする';

  @override
  String get disableGroupConfirm =>
      '会社全体のグループが全員に対して非表示になります。メッセージから再びオンにできます。';

  @override
  String get editPresets => 'プリセット';

  @override
  String get enable => '再びオンにする';

  @override
  String get groupDisabled => 'グループはオフです（あなたにだけ表示）';

  @override
  String get logoHint => '会社のタブに表示される小さな PNG 画像（ロゴ）。全メンバーに表示されます。';

  @override
  String get logoPngOnly => '1 MB 以下の PNG 画像を選んでください。';

  @override
  String get muteConversation => 'この会話をミュート';

  @override
  String get myIdentifier => 'マイ ID';

  @override
  String get myProfile => 'マイプロフィール';

  @override
  String get presetName => '名前（例：朝）';

  @override
  String get removeLogo => '画像を削除';

  @override
  String get resetGroup => 'グループをリセット';

  @override
  String get resetGroupConfirm => '会社グループのすべてのメッセージが全員に対して削除されます。';

  @override
  String get settingsTitle => '設定';

  @override
  String get shiftPresets => '勤務時間のプリセット';

  @override
  String get shiftPresetsHint => '決まった時間（朝・夕方・夜…）：シフトでタップすると開始と終了が入ります。';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeSystem => 'システム';

  @override
  String get unmuteConversation => 'この会話のミュートを解除';

  @override
  String get awaitingApproval => '承認待ち';

  @override
  String get placementNeedsApproval =>
      '! この人はあなたの拠点の所属ではありません：公開する前に、上司またはオーナーの承認を待ちます。承認を待たない場合は、別の人を選んでください。';

  @override
  String get placementAwaiting => '上司またはオーナーの承認待ちです。';

  @override
  String noticePlacementToApprove(String by, String name, String date) {
    return '$byさんが別の拠点の$nameさんを$dateに配置しようとしています：承認が必要です。';
  }

  @override
  String noticePlacementApproved(String by, String name, String date) {
    return '$byさんが$dateの$nameさんの配置を承認しました。';
  }

  @override
  String noticePlacementRefused(String by, String name, String date) {
    return '$byさんが$dateの$nameさんの配置を却下しました。';
  }

  @override
  String get addSubSite => '下位拠点を追加';

  @override
  String get moveSite => '移動';

  @override
  String get topLevel => '最上位';

  @override
  String moveSiteTitle(String name) {
    return '「$name」を次の下へ移動…';
  }

  @override
  String subSiteOf(String name) {
    return '$nameの下位拠点';
  }

  @override
  String get siteTreeHint => '最大3階層（例：地域 › 都市 › 店舗）。拠点の責任者は、その下のすべても管理します。';

  @override
  String get subSitesOnlyHint => 'ここでは、自分の拠点の下に下位拠点を追加できます。';

  @override
  String get messagingSetting => '会社のメッセージ';

  @override
  String get messagingSettingHint =>
      'オン：チームに「メッセージ」タブが表示されます。オフ：誰にも表示されず、書き込みもできません（過去のメッセージは残ります）。';

  @override
  String get billingTitle => 'サブスクリプション';

  @override
  String billingStatusTrial(String date) {
    return '$dateまで無料体験';
  }

  @override
  String billingStatusActive(String date) {
    return '$dateまで支払い済み';
  }

  @override
  String billingStatusGrace(String date) {
    return '読み取り専用：支払いがない場合、会社は$dateに削除されます。';
  }

  @override
  String get billingStatusComped => '無償';

  @override
  String billingStaff(String count) {
    return '$count人の従業員を計上（オーナーと臨時スタッフを除く）';
  }

  @override
  String get billingMonthly => '月払い';

  @override
  String billingYearly(String months) {
    return '年払い（$monthsか月分を請求）';
  }

  @override
  String get billingCascade => '「階層拠点」オプション';

  @override
  String billingCascadeIncluded(String count) {
    return '従業員$count人以上で込み';
  }

  @override
  String billingPay(String amount) {
    return '$amountを支払う';
  }

  @override
  String get billingTestNotice => 'テスト決済：請求は発生しません。';

  @override
  String get billingSoon => 'オンライン決済はまもなく利用可能になります。';

  @override
  String get billingPaidOk => '支払いを記録しました。';

  @override
  String get billingInvoices => '請求書';

  @override
  String get billingNoInvoices => '請求書はまだありません。';

  @override
  String get billingManage => 'サブスクリプションを管理';

  @override
  String get billingReadOnlyStaff => 'オーナーがサブスクリプションを更新するまで、この会社は読み取り専用です。';

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
    return '$company：無料体験は24時間以内に終了します。';
  }

  @override
  String noticeBillingGrace(String company, String date) {
    return '$companyは未払いのため読み取り専用です。$dateに削除されます。';
  }

  @override
  String noticeBillingGraceReminder(String company, String date) {
    return 'リマインダー：支払いがない場合、$companyは$dateに削除されます。';
  }

  @override
  String noticeBillingDeleted(String company) {
    return '$companyは未払いのため削除されました。';
  }

  @override
  String billingCompanyId(String id) {
    return '会社ID：$id';
  }

  @override
  String billingDueToday(String amount) {
    return '本日：$amount';
  }

  @override
  String billingProrataNote(String days) {
    return '今月の残り（$days日分、日割り）と、翌月1日からの月単位の料金を含みます。';
  }

  @override
  String get telegramTitle => 'Telegram';

  @override
  String get telegramNotLinked => 'まだ連携されていません。Google アカウントの変更時など、本人確認に使います。';

  @override
  String telegramLinked(String name) {
    return '連携済み：$name';
  }

  @override
  String get telegramNoUsername => 'ユーザー名なし';

  @override
  String get telegramLink => 'Telegram を連携';

  @override
  String get telegramLinkHint => 'Telegram が開きます。「開始」をタップしてから、ここに戻ってください。';

  @override
  String get telegramUnlink => '連携解除';

  @override
  String get telegramUnavailable => 'Telegram はまだ利用できません。';

  @override
  String get telegramShowIn => 'Telegram を表示する会社：';

  @override
  String get newQrCode => 'QR コードを変更';

  @override
  String get newQrCodeConfirm =>
      '古い QR コードと古い ID は使えなくなります。各会社でのあなたの立場は変わりません。';

  @override
  String get newQrCodeDone => '新しい QR コードを作成しました。';

  @override
  String get changeGoogle => 'Google アカウントを変更';

  @override
  String get changeGoogleSub => '同じアカウント・同じ番号・同じ会社のまま';

  @override
  String changeGoogleSteps(String id) {
    return '1. このプロフィールで Telegram を連携します（必須）。\n2. ログアウトし、新しい Google アカウントでログインします。\n3. 「Staff Flow のアカウントを持っています」を選び、ID $id を入力します。\n4. Telegram で受け取ったコードを入力します。\nアカウント、番号、会社はそのまま引き継がれます。';
  }

  @override
  String get recoverAccount => 'Staff Flow のアカウントを持っています';

  @override
  String get recoverHint =>
      '以前のアカウントの ID（SF-…）を入力してください。そのアカウントに連携された Telegram にコードを送ります。';

  @override
  String get recoverIdLabel => 'ID（SF-…）';

  @override
  String get recoverSend => 'コードを送信';

  @override
  String get recoverCodeSent => 'Telegram にコードを送信しました。';

  @override
  String get recoverCodeLabel => '受け取ったコード（6 桁）';

  @override
  String get recoverConfirm => 'アカウントを復元';

  @override
  String get recoverDone => '完了：アカウントに戻りました。';

  @override
  String get exportData => 'データをエクスポート';

  @override
  String get exportDataSub => 'あなたの個人データをすべて含むファイル';

  @override
  String get deleteAccount => 'アカウントを削除';

  @override
  String get deleteGhost => 'ゴーストを残して削除';

  @override
  String get deleteGhostHint =>
      'すべての会社から退出します。後で同じ Google アカウントでログインすると、アカウントと番号が戻ります。';

  @override
  String get deleteErase => 'すべて完全に消去';

  @override
  String get deleteEraseHint => '名前、メール、写真、Telegram、メッセージ、通知が消去されます。元に戻せません。';

  @override
  String get deleteGhostNote =>
      'どちらの場合も、会社の履歴にはあなたの代わりに匿名の「Ghost」が残ります（休暇申請、過去のシフトなど）。オーナーや責任者が経緯をたどれるようにするためです。';

  @override
  String get deleteOwnerNote => '会社のオーナーですか？先に会社を譲渡するか、サブスクリプションの終了をお待ちください。';

  @override
  String get deleteConfirmButton => '削除';

  @override
  String get accountRestored => 'おかえりなさい！アカウントが再開されました。';

  @override
  String get closedInvoices => '閉鎖した会社の請求書';

  @override
  String get downloadAllInvoices => 'すべての請求書をダウンロード（ZIP）';

  @override
  String get legalTerms => '利用規約・販売条件';

  @override
  String get legalPrivacy => 'プライバシーポリシー';

  @override
  String get billingDetailTitle => 'お支払いの内訳';

  @override
  String billingLineProrata(String days, String total) {
    return '今月の残り（$total 日中 $days 日）：サブスクリプション';
  }

  @override
  String billingLineCascadeProrata(String days, String total) {
    return '今月の残り（$total 日中 $days 日）：「階層拠点」オプション';
  }

  @override
  String billingLineMonth(String staff) {
    return 'サブスクリプション、従業員 $staff 人：1 か月';
  }

  @override
  String billingLineYear(String staff, String paid) {
    return 'サブスクリプション、従業員 $staff 人：12 か月を $paid か月分の料金で';
  }

  @override
  String billingLineCascade(String months) {
    return '「階層拠点」オプション：$months か月、割引なし';
  }

  @override
  String get billingTotal => '合計';

  @override
  String billingCovers(String from, String to) {
    return '対象期間：$from〜$to';
  }

  @override
  String get billingGraceInvoices => 'この会社は更新されません。今すぐすべての請求書をダウンロードしてください。';

  @override
  String get billingYearLabel => '年';

  @override
  String get sitesNoneChosen => '拠点が選ばれていません';

  @override
  String get avatarTitle => 'マイアバター';

  @override
  String get avatarSub => '写真の代わりに表示する画像';

  @override
  String get avatarUseGoogle => 'Google の写真を使う';

  @override
  String get avatarColor => '色';

  @override
  String get hidePhotosTitle => 'Google の写真を隠す';

  @override
  String get hidePhotosSub => 'この会社では、全員がアバターまたはイニシャルで表示されます。';

  @override
  String get billingApi => '「API アクセス」オプション';

  @override
  String billingLineApi(String months) {
    return '「API アクセス」オプション：$months か月、割引なし';
  }

  @override
  String billingLineApiProrata(String days, String total) {
    return '今月の残り（$total 日中 $days 日）：「API アクセス」オプション';
  }

  @override
  String get apiTitle => 'API アクセス（会計・CRM）';

  @override
  String get apiSub => '会計・給与・CRM ソフトが、公開されたシフト、勤務時間、不在を読み取ります。';

  @override
  String get apiNeedsOption => '有料オプション：「サブスクリプションを管理」で「API アクセス」を追加してください。';

  @override
  String get apiNewKey => '新しいキー';

  @override
  String get apiKeyName => 'キーの名前（例：給与ソフト）';

  @override
  String get apiKeyCreated => 'このキーを今すぐコピーして安全に保管してください。再表示されません。';

  @override
  String get apiKeyCopy => 'コピー';

  @override
  String get apiKeyCopied => 'キーをコピーしました。';

  @override
  String apiKeyLastUsed(String date) {
    return '最終使用：$date';
  }

  @override
  String get apiKeyNeverUsed => '未使用';

  @override
  String get apiRevoke => '無効にする';

  @override
  String get apiRevokeConfirm => 'このキーを使うソフトはアクセスできなくなります。';

  @override
  String get apiDocs => 'API ドキュメント';

  @override
  String get memberGoogleLink => '従業員の Google 再ログイン';

  @override
  String googleLinkHint(String name) {
    return 'このリンクを $name に送ってください。ブラウザーで開きます（Android アプリでは開きません）。1 回限り、24 時間有効です。$name が新しい Google アカウントでログインすると、自分のアカウントに戻れます。ほかのすべての端末はログアウトされます。';
  }

  @override
  String get googleLinkCopied => 'リンクをコピーしました。';

  @override
  String get switchBanner =>
      'Google アカウント変更用リンク：新しい Google アカウントでログインすると、Staff Flow のアカウントに戻れます。';

  @override
  String get switchSignOutFirst =>
      'このリンクは Staff Flow のアカウントを新しい Google アカウントに連携するためのものです。いったんログアウトしてから、新しい Google アカウントでログインしてください。';

  @override
  String get switchDone =>
      '完了：Staff Flow のアカウントがこの Google アカウントに連携されました。ほかの端末はログアウトされました。';

  @override
  String changeGoogleBot(String bot) {
    return 'いちばん簡単な方法：Telegram でボット $bot に /changegoogle を送り、案内に従ってください。その後 10 分以内に新しい Google アカウントでログインします。';
  }

  @override
  String get changeGoogleNoTelegram =>
      'Telegram がない場合：オーナーまたは責任者に Google アカウント変更用リンクを依頼してください。';

  @override
  String noticeGoogleSwitchLink(String name) {
    return '$name が、あなたのアカウントを新しい Google アカウントに連携するリンクを作成しました。心当たりがない場合は、責任者に知らせてください。';
  }

  @override
  String get sessionRevoked => 'ログアウトされました。アカウントは別の Google アカウントに連携されています。';

  @override
  String telegramLoginHint(String bot) {
    return 'ヒント：ボット $bot に /connexion を送るとリンクが届き、アプリや Google アカウントなしでブラウザーから Staff Flow を開けます。';
  }
}
