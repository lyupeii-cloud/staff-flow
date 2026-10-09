import 'package:flutter/material.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';

/// Indicateur de synchronisation : « À jour », « Hors connexion » ou le
/// nombre de modifications en attente. Un appui synchronise tout de suite.
class SyncIndicator extends StatelessWidget {
  final Session session;

  const SyncIndicator({super.key, required this.session});

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: session.sync,
        builder: (context, _) {
          final t = context.l10n;
          final sync = session.sync;
          final pending = sync.queue.length;
          final (icon, label) = !sync.online
              ? (Icons.cloud_off, pending > 0 ? '${t.syncOffline} · ${t.syncPending(pending)}' : t.syncOffline)
              : pending > 0
                  ? (Icons.cloud_upload, t.syncPending(pending))
                  : (Icons.cloud_done, t.syncUpToDate);
          return IconButton(
            tooltip: '$label — ${t.syncNow}',
            onPressed: sync.syncNow,
            icon: Badge(
              isLabelVisible: pending > 0,
              label: Text('$pending'),
              child: Icon(icon, color: sync.online ? null : Colors.orangeAccent),
            ),
          );
        },
      );
}

/// Cloche des avis (par exemple : modification remplacée par un autre responsable).
class NoticesButton extends StatelessWidget {
  final Session session;

  const NoticesButton({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final unread = session.me?.unreadNotices ?? 0;
    return IconButton(
      tooltip: context.l10n.notices,
      onPressed: () => _open(context),
      icon: Badge(isLabelVisible: unread > 0, label: Text('$unread'), child: const Icon(Icons.notifications)),
    );
  }

  Future<void> _open(BuildContext context) async {
    final t = context.l10n;
    final loc = context.localeName;
    List<dynamic> notices;
    try {
      notices = (await session.api.send('GET', '/notices'))['notices'];
    } on OfflineException {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
      }
      return;
    }
    if (!context.mounted) return;
    var cleared = false;
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          Row(
            children: [
              Expanded(child: Text(t.notices, style: Theme.of(context).textTheme.titleLarge)),
              if (notices.isNotEmpty)
                TextButton.icon(
                  icon: const Icon(Icons.delete_sweep),
                  label: Text(t.deleteAllNotices),
                  onPressed: () async {
                    final sure = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(t.deleteAllNoticesConfirm),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
                          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.confirm)),
                        ],
                      ),
                    );
                    if (sure != true || !context.mounted) return;
                    final messenger = ScaffoldMessenger.of(context);
                    try {
                      await session.api.send('DELETE', '/notices');
                      cleared = true;
                      if (context.mounted) Navigator.pop(context);
                    } on OfflineException {
                      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
                    }
                  },
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (notices.isEmpty) Text(t.noNotices),
          for (final n in notices)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(_noticeIcon(n['kind']),
                  color: n['read'] == true ? Theme.of(context).disabledColor : Theme.of(context).colorScheme.primary),
              title: Text(_noticeText(t, loc, n)),
              subtitle: Text(_when(loc, DateTime.parse(n['createdAt']).toLocal())),
              // Avis d'une demande : le toucher ouvre la demande.
              trailing: n['data']?['requestId'] != null && n['companyId'] != null ? const Icon(Icons.chevron_right) : null,
              onTap: n['data']?['requestId'] != null && n['companyId'] != null
                  ? () {
                      Navigator.pop(context);
                      session.openRequest.value =
                          (companyId: n['companyId'] as String, requestId: n['data']['requestId'] as String);
                    }
                  : null,
            ),
        ],
      ),
    );
    try {
      if (!cleared) await session.api.send('POST', '/notices/read');
      await session.refresh();
    } catch (_) {}
  }

  static String _noticeText(L10n t, String loc, dynamic n) {
    final data = n['data'] as Map<String, dynamic>;
    final company = (n['companyName'] as String?) ?? t.someCompany;
    return switch (n['kind']) {
      'shift_overwritten' => t.noticeOverwritten(
          data['byName'] ?? '?', longDate(parseDay(data['shift']['day']), loc)),
      'schedule_published' => t.noticeSchedulePublished(company),
      'join_invite' => t.noticeJoinInvite(company),
      'transfer_offer' => t.noticeTransferOffer(data['byName'] ?? '?', company),
      'member_joined' => t.noticeMemberJoined(data['name'] ?? '?', company),
      'swap_offer' => t.noticeSwapOffer(data['byName'] ?? '?'),
      'swap_declined' => t.noticeSwapDeclined(data['byName'] ?? '?'),
      'swap_to_approve' => t.noticeSwapToApprove,
      'leave_to_approve' => t.noticeLeaveToApprove(data['requesterName'] ?? '?'),
      'unavailability_to_approve' => t.noticeUnavailabilityToApprove(data['requesterName'] ?? '?'),
      'request_approved' => t.noticeRequestApproved,
      'request_refused' => t.noticeRequestRefused,
      'shift_overlap' => t.noticeOverlap(longDate(parseDay(data['day']), loc)),
      _ => n['kind'] as String,
    };
  }

  static IconData _noticeIcon(String? kind) => switch (kind) {
        'schedule_published' => Icons.calendar_month,
        'join_invite' => Icons.group_add,
        'transfer_offer' => Icons.key,
        'member_joined' => Icons.person_add,
        'swap_offer' || 'swap_declined' || 'swap_to_approve' => Icons.swap_horiz,
        'leave_to_approve' => Icons.beach_access,
        'unavailability_to_approve' => Icons.event_busy,
        'request_approved' => Icons.check_circle,
        'request_refused' => Icons.cancel,
        'shift_overlap' => Icons.warning_amber,
        _ => Icons.edit_note,
      };
}

String _when(String loc, DateTime at) => '${dayLabel(at, loc)} ${timeLabel(at.hour * 60 + at.minute)}';

/// Historique d'un service ([shiftId]) ou des dernières modifications de
/// l'entreprise, avec un bouton pour annuler chaque changement.
Future<void> showHistorySheet(BuildContext context,
    {required Session session, required Company company, required CompanyData data, String? shiftId}) async {
  final t = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  Future<List<dynamic>> load() async => (await session.api
      .send('GET', '/companies/${company.id}/history${shiftId == null ? '' : '?shiftId=$shiftId'}'))['entries'];
  List<dynamic> entries;
  try {
    entries = await load();
  } on OfflineException {
    messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    return;
  }
  if (!context.mounted) return;
  var changed = false;
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        final loc = context.localeName;
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          builder: (context, scroll) => ListView(
            controller: scroll,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            children: [
              Text(shiftId == null ? t.recentChanges : t.history, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              if (entries.isEmpty) Text(t.noHistory),
              for (final e in entries)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${_actionLabel(t, e['action'])} · ${_describe(t, loc, data, e)}'),
                  subtitle: Text('${e['actor']?['name'] ?? '?'} · ${_when(loc, DateTime.parse(e['at']).toLocal())}'),
                  trailing: company.readOnly
                      ? null
                      : IconButton(
                          tooltip: t.undoChange,
                          icon: const Icon(Icons.undo),
                          onPressed: () async {
                            try {
                              await session.api.send('POST', '/companies/${company.id}/history/${e['id']}/undo');
                              changed = true;
                              messenger.showSnackBar(SnackBar(content: Text(t.undoDone)));
                              final fresh = await load();
                              setState(() => entries = fresh);
                            } on OfflineException {
                              messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
                            } on ApiException catch (err) {
                              messenger.showSnackBar(SnackBar(content: Text(err.describe(t))));
                            }
                          },
                        ),
                ),
            ],
          ),
        );
      },
    ),
  );
  if (changed) session.sync.markChanged();
}

String _actionLabel(L10n t, String action) => switch (action) {
      'create' => t.historyCreate,
      'update' => t.historyUpdate,
      'delete' => t.historyDelete,
      _ => t.historyUndo,
    };

/// « lun. 5 oct. 08:00–17:00 · Bob », et « avant → après » pour une modification.
String _describe(L10n t, String loc, CompanyData data, dynamic e) {
  String summary(Map<String, dynamic>? s) {
    if (s == null) return '—';
    final who = s['userId'] == null ? t.unassigned : (data.memberName(s['userId']) ?? t.formerMember);
    return '${dayLabel(parseDay(s['day']), loc)} ${timeLabel(s['start'])}–${timeLabel(s['end'])} · $who';
  }

  final before = e['before'] as Map<String, dynamic>?, after = e['after'] as Map<String, dynamic>?;
  if (e['action'] == 'create') return summary(after);
  if (e['action'] == 'delete') return summary(before);
  final a = summary(before), b = summary(after);
  return a == b ? b : '$a → $b';
}
