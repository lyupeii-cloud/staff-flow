import 'package:flutter/material.dart';

import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'catalog_view.dart';
import 'messages_view.dart';
import 'planning_view.dart';
import 'requests_view.dart';
import 'team_view.dart';

/// Données partagées par les vues d'une entreprise : membres, sites, postes.
class CompanyData {
  final List<Member> members;
  final List<CatalogItem> sites;
  final List<CatalogItem> positions;

  const CompanyData(this.members, this.sites, this.positions);

  /// Depuis le serveur, ou hors connexion depuis la dernière copie gardée.
  static Future<CompanyData> load(Session session, String companyId) async {
    final sync = session.sync;
    final r = await Future.wait([
      sync.read('members:$companyId', '/companies/$companyId/members'),
      sync.read('sites:$companyId', '/companies/$companyId/sites'),
      sync.read('positions:$companyId', '/companies/$companyId/positions'),
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

  String? positionName(String? id) => positions.where((p) => p.id == id).firstOrNull?.name;
}

enum _View { planning, requests, messages, team, catalog }

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
    _reload();
    widget.session.sync.addListener(_onSync);
  }

  @override
  void dispose() {
    widget.session.sync.removeListener(_onSync);
    super.dispose();
  }

  @override
  void didUpdateWidget(CompanyTab old) {
    super.didUpdateWidget(old);
    if (old.membership.role != role) _reload();
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
        _data = CompanyData.load(widget.session, company.id);
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
              Text('${role.label(t)} · ${company.timezone}', style: theme.textTheme.bodySmall),
              const SizedBox(height: 8),
              Builder(builder: (context) {
                final unread = widget.session.me?.unreadMessages[company.id] ?? 0;
                return _ViewSwitcher(
                  selected: _view,
                  items: [
                    (_View.planning, const Icon(Icons.calendar_month), t.viewPlanning),
                    (_View.requests, const Icon(Icons.swap_horiz), t.viewRequests),
                    (
                      _View.messages,
                      Badge(isLabelVisible: unread > 0, label: Text('$unread'), child: const Icon(Icons.forum)),
                      t.messagesTab
                    ),
                    (_View.team, const Icon(Icons.group), t.viewTeam),
                    if (widget.membership.managesAll) (_View.catalog, const Icon(Icons.store), t.viewPositions),
                  ],
                  onSelected: (v) {
                    // L'équipe a pu changer : le planning repart de la liste à jour.
                    if (v == _View.planning && _view != _View.planning) _reload();
                    setState(() => _view = v);
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
                _View.planning =>
                  PlanningView(session: widget.session, membership: widget.membership, data: data),
                _View.requests =>
                  RequestsView(session: widget.session, membership: widget.membership, data: data),
                _View.messages =>
                  MessagesView(session: widget.session, membership: widget.membership, data: data),
                _View.team => TeamView(
                    session: widget.session, membership: widget.membership, data: data, onChanged: _reload),
                _View.catalog => CatalogView(
                    session: widget.session, company: company, data: data, onChanged: _reload),
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
