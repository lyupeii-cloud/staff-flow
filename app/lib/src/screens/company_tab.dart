import 'package:flutter/material.dart';

import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'catalog_view.dart';
import 'planning_view.dart';
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

enum _View { planning, team, catalog }

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

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  void didUpdateWidget(CompanyTab old) {
    super.didUpdateWidget(old);
    if (old.membership.role != role) _reload();
  }

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
              SegmentedButton<_View>(
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(
                      value: _View.planning,
                      icon: const Icon(Icons.calendar_month),
                      label: Text(t.viewPlanning)),
                  ButtonSegment(value: _View.team, icon: const Icon(Icons.group), label: Text(t.viewTeam)),
                  if (role.canManage)
                    ButtonSegment(
                        value: _View.catalog, icon: const Icon(Icons.store), label: Text(t.viewPositions)),
                ],
                selected: {_view},
                onSelectionChanged: (s) => setState(() => _view = s.first),
              ),
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
                _View.team => TeamView(
                    session: widget.session, membership: widget.membership, onChanged: _reload),
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
