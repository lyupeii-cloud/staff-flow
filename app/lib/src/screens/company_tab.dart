import 'package:flutter/material.dart';

import '../api.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'catalog_view.dart';
import 'messages_view.dart';
import 'planning_view.dart';
import 'team_view.dart';
import 'tools_widgets.dart';

/// Données partagées par les vues d'une entreprise : membres, sites, postes.
class CompanyData {
  final List<Member> members;
  final List<CatalogItem> sites;
  final List<CatalogItem> positions;

  const CompanyData(this.members, this.sites, this.positions);

  /// Depuis le serveur, ou hors connexion depuis la dernière copie gardée.
  /// Sauf [fresh], une copie de moins de 10 minutes suffit : ces données
  /// changent rarement, et chaque changement connu force une relecture.
  static Future<CompanyData> load(Session session, String companyId, {bool fresh = false}) async {
    final sync = session.sync;
    final age = fresh ? null : const Duration(minutes: 10);
    final r = await Future.wait([
      sync.read('members:$companyId', '/companies/$companyId/members', maxAge: age),
      sync.read('sites:$companyId', '/companies/$companyId/sites', maxAge: age),
      sync.read('positions:$companyId', '/companies/$companyId/positions', maxAge: age),
    ]);
    return CompanyData(
      [for (final m in r[0]['members']) Member.fromJson(m)],
      [for (final i in r[1]['items']) CatalogItem.fromJson(i)],
      [for (final i in r[2]['items']) CatalogItem.fromJson(i)],
    );
  }

  String? memberName(String? userId) =>
      members.where((m) => m.user.id == userId).firstOrNull?.user.name;

  String? siteName(String? id) => sites.where((s) => s.id == id).firstOrNull?.name;

  /// Sites dans l'ordre de l'arbre (une région, puis ses villes…), avec leur
  /// niveau (0 : premier niveau).
  List<(CatalogItem, int)> get siteTree {
    final ids = {for (final s in sites) s.id};
    final out = <(CatalogItem, int)>[];
    void walk(String? parent, int depth) {
      final children = [
        for (final s in sites)
          if (parent == null ? (s.parentId == null || !ids.contains(s.parentId)) : s.parentId == parent) s,
      ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      for (final s in children) {
        out.add((s, depth));
        if (depth < 5) walk(s.id, depth + 1);
      }
    }

    walk(null, 0);
    return out;
  }

  /// [ids] et tous les sites qui sont en dessous.
  Set<String> expandSites(Iterable<String> ids) {
    final out = {...ids};
    for (var added = true; added;) {
      added = false;
      for (final s in sites) {
        if (s.parentId != null && out.contains(s.parentId) && out.add(s.id)) added = true;
      }
    }
    return out;
  }

  /// « Nord › Lille › Gare ».
  String? sitePath(String? id) {
    final names = <String>[];
    for (var s = sites.where((s) => s.id == id).firstOrNull; s != null && names.length < 5;
        s = sites.where((x) => x.id == s!.parentId).firstOrNull) {
      names.insert(0, s.name);
    }
    return names.isEmpty ? null : names.join(' › ');
  }

  String? positionName(String? id) => positions.where((p) => p.id == id).firstOrNull?.name;
}

enum _View { planning, messages, team, catalog }

/// Onglet d'une entreprise : planning, équipe, et pour les responsables,
/// sites et postes.
class CompanyTab extends StatefulWidget {
  final Session session;
  final Membership membership;

  const CompanyTab({super.key, required this.session, required this.membership});

  @override
  State<CompanyTab> createState() => _CompanyTabState();
}

class _CompanyTabState extends State<CompanyTab> with AutomaticKeepAliveClientMixin {
  var _view = _View.planning;
  late Future<CompanyData> _data;

  Company get company => widget.membership.company;
  Role get role => widget.membership.role;

  @override
  bool get wantKeepAlive => true;

  late int _synced = widget.session.sync.synced;

  @override
  void initState() {
    super.initState();
    _data = CompanyData.load(widget.session, company.id);
    widget.session.sync.addListener(_onSync);
    widget.session.openDay.addListener(_onOpenDay);
    _onOpenDay();
  }

  @override
  void dispose() {
    widget.session.sync.removeListener(_onSync);
    widget.session.openDay.removeListener(_onOpenDay);
    super.dispose();
  }

  @override
  void didUpdateWidget(CompanyTab old) {
    super.didUpdateWidget(old);
    if (old.membership.role != role) _reload();
  }

  /// Notification touchée, ou icône d'une demande dans le planning.
  /// Jour à montrer dans le planning (service touché dans « Tous mes plannings »).
  DateTime? _focusDay;

  void _onOpenDay() {
    final wanted = widget.session.openDay.value;
    if (wanted == null || wanted.companyId != company.id) return;
    widget.session.openDay.value = null;
    setState(() {
      _view = _View.planning;
      _focusDay = wanted.day;
    });
  }

  /// Responsable : sites dont il veut recevoir les notifications.
  /// Les horaires sont toujours à l'heure de l'entreprise (heure d'été
  /// comprise). Si le téléphone n'est pas à la même heure, un bandeau le dit.
  Widget? _timezoneNotice(BuildContext context) {
    final offset = widget.membership.utcOffset;
    final here = DateTime.now().timeZoneOffset.inMinutes;
    if (offset == null || offset == here) return null;
    final t = context.l10n;
    final theme = Theme.of(context);
    String utc(int m) => 'UTC${m < 0 ? '−' : '+'}${m.abs() ~/ 60}${m.abs() % 60 == 0 ? '' : ':${(m.abs() % 60).toString().padLeft(2, '0')}'}';
    return Card(
      margin: const EdgeInsets.only(top: 6),
      color: theme.colorScheme.tertiaryContainer,
      child: ListTile(
        dense: true,
        leading: const Icon(Icons.schedule),
        title: Text(t.timezoneDiffers(company.timezone.split('/').last.replaceAll('_', ' '), utc(offset), utc(here))),
        trailing: widget.membership.managesAll && !company.readOnly
            ? TextButton(
                onPressed: () => chooseTimezone(context, widget.session, company),
                child: Text(t.changeSettings),
              )
            : null,
      ),
    );
  }

  /// Notifications de cette entreprise : un interrupteur pour tous ; pour
  /// un responsable de plusieurs sites, le choix des sites en plus.
  Future<void> _chooseNotifications(CompanyData? data) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final mine = widget.membership.managedSites;
    final sites = !role.canManage || data == null
        ? const <(CatalogItem, int)>[]
        : [for (final (s, d) in data.siteTree) if (!s.archived && (mine == null || mine.contains(s.id))) (s, d)];
    final current = widget.membership.notifySites;
    final chosen = {for (final (s, _) in sites) if (current == null || current.contains(s.id)) s.id};
    var on = widget.membership.notificationsOn;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialog) => AlertDialog(
          title: Text(t.companyNotifications(company.name)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: on,
                  title: Text(t.companyNotificationsOn),
                  subtitle: Text(t.companyNotificationsHint),
                  onChanged: (v) => setDialog(() => on = v),
                ),
                if (sites.length >= 2) ...[
                  const Divider(),
                  Text(t.notifySitesHint),
                  for (final (s, d) in sites)
                    CheckboxListTile(
                      contentPadding: EdgeInsets.only(left: 16.0 * d),
                      value: on && chosen.contains(s.id),
                      title: Text(s.name),
                      onChanged: on ? (v) => setDialog(() => v == true ? chosen.add(s.id) : chosen.remove(s.id)) : null,
                    ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.save)),
          ],
        ),
      ),
    );
    if (ok != true) return;
    try {
      await widget.session.api.send('PUT', '/companies/${company.id}/notifications', body: {'enabled': on});
      if (sites.length >= 2) {
        final all = sites.every((s) => chosen.contains(s.$1.id));
        await widget.session.api.send('PUT', '/companies/${company.id}/notify-sites',
            body: {'sites': all ? null : chosen.toList()});
      }
      await widget.session.refresh();
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    }
  }

  /// Retour du réseau, retour dans l'application, quelqu'un a rejoint
  /// l'entreprise… : membres, sites et postes sont relus, pour qu'une
  /// nouvelle personne puisse tout de suite être placée au planning.
  void _onSync() {
    final synced = widget.session.sync.synced;
    if (synced == _synced || !mounted) return;
    _synced = synced;
    _reload();
  }

  // Pendant le rechargement, l'écran garde les données précédentes.
  void _reload() => setState(() {
        _data = CompanyData.load(widget.session, company.id, fresh: true);
      });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final t = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(child: Text('${role.label(t)} · ${company.timezone}', style: theme.textTheme.bodySmall)),
                  // Notifications de cette entreprise (et de ses sites pour un responsable).
                  FutureBuilder(
                    future: _data,
                    builder: (context, snap) {
                      final off = !widget.membership.notificationsOn;
                      final filtered = widget.membership.notifySites != null;
                      return IconButton(
                        visualDensity: VisualDensity.compact,
                        tooltip: t.companyNotifications(company.name),
                        onPressed: () => _chooseNotifications(snap.data),
                        icon: Icon(
                            off
                                ? Icons.notifications_off
                                : (filtered ? Icons.notifications_paused : Icons.notifications_active),
                            size: 20,
                            color: off || filtered ? theme.colorScheme.tertiary : null),
                      );
                    },
                  ),
                ],
              ),
              // L'heure de l'entreprise n'est pas celle du téléphone : on le dit.
              ?_timezoneNotice(context),
              const SizedBox(height: 8),
              Builder(builder: (context) {
                final unread = widget.session.me?.unreadMessages[company.id] ?? 0;
                // Messagerie coupée par le patron : l'onglet disparaît pour tous.
                if (!company.messagingEnabled && _view == _View.messages) _view = _View.planning;
                return _ViewSwitcher(
                  selected: _view,
                  items: [
                    (_View.planning, const Icon(Icons.calendar_month), t.viewPlanning),
                    if (company.messagingEnabled)
                    (
                      _View.messages,
                      Badge(isLabelVisible: unread > 0, label: Text('$unread'), child: const Icon(Icons.forum)),
                      t.messagesTab
                    ),
                    (_View.team, const Icon(Icons.manage_accounts), t.viewTeam),
                    if (role.canManage) (_View.catalog, const Icon(Icons.store), t.viewPositions),
                  ],
                  onSelected: (v) {
                    // L'équipe a pu changer : le planning repart de la liste à jour.
                    if (v == _View.planning && _view != _View.planning) _reload();
                    setState(() {
                      _view = v;
                    });
                  },
                );
              }),
            ],
          ),
        ),
        if (company.readOnly)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(t.readOnlyCompany, style: TextStyle(color: theme.colorScheme.error)),
          ),
        Expanded(
          child: FutureBuilder(
            future: _data,
            builder: (context, snap) {
              if (snap.hasError) {
                return Center(
                  child: TextButton.icon(
                    onPressed: _reload,
                    icon: const Icon(Icons.refresh),
                    label: Text('${snap.error}\n${t.retry}'),
                  ),
                );
              }
              if (!snap.hasData) return const Center(child: CircularProgressIndicator());
              final data = snap.data!;
              return switch (_view) {
                _View.planning => PlanningView(
                    key: ValueKey(_focusDay),
                    session: widget.session,
                    membership: widget.membership,
                    data: data,
                    initialDay: _focusDay),
                _View.messages =>
                  MessagesView(session: widget.session, membership: widget.membership, data: data),
                _View.team => TeamView(
                    session: widget.session, membership: widget.membership, data: data, onChanged: _reload),
                _View.catalog => CatalogView(
                    session: widget.session, membership: widget.membership, data: data, onChanged: _reload),
              };
            },
          ),
        ),
      ],
    );
  }
}

/// Choix de la vue. Sur un écran étroit, l'onglet choisi prend plus de place
/// pour afficher son nom en entier ; les autres gardent leur icône.
class _ViewSwitcher extends StatelessWidget {
  final _View selected;
  final List<(_View, Widget, String)> items;
  final ValueChanged<_View> onSelected;

  const _ViewSwitcher({required this.selected, required this.items, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, box) {
      final compact = box.maxWidth < 520;
      return Container(
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(color: scheme.outline),
          borderRadius: BorderRadius.circular(22),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            for (final (i, (view, icon, label)) in items.indexed)
              Expanded(
                flex: compact && view == selected ? 3 : 2,
                child: Tooltip(
                  message: label,
                  child: InkWell(
                    onTap: () => onSelected(view),
                    child: Container(
                      decoration: BoxDecoration(
                        color: view == selected ? scheme.secondaryContainer : null,
                        border: i == 0 ? null : Border(left: BorderSide(color: scheme.outline)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconTheme.merge(data: const IconThemeData(size: 20), child: icon),
                          if (!compact || view == selected) ...[
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(label,
                                  maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
