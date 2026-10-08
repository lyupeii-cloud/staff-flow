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
}
