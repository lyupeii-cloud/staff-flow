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
  String get viewTeam => 'チーム';

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
}
