import 'package:flutter/material.dart';

import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'company_tab.dart';
import 'requests_view.dart';

/// Demandes (échanges, congés, indisponibilités), ouvertes depuis le menu du
/// compte ou une notification : un onglet par entreprise.
class RequestsPage extends StatelessWidget {
  final Session session;

  /// Entreprise à montrer d'abord, et demande à mettre en évidence.
  final String? companyId;
  final String? requestId;

  const RequestsPage({super.key, required this.session, this.companyId, this.requestId});

  static Future<void> open(BuildContext context, Session session, {String? companyId, String? requestId}) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => RequestsPage(session: session, companyId: companyId, requestId: requestId)));

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final companies = session.me?.companies ?? const <Membership>[];
    final start = companies.indexWhere((m) => m.company.id == companyId);
    if (companies.length < 2) {
      return Scaffold(
        appBar: AppBar(title: Text(t.viewRequests)),
        body: companies.isEmpty
            ? const SizedBox.shrink()
            : _CompanyRequests(session: session, membership: companies.single, focus: requestId),
      );
    }
    return DefaultTabController(
      length: companies.length,
      initialIndex: start < 0 ? 0 : start,
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.viewRequests),
          bottom: TabBar(isScrollable: true, tabs: [for (final m in companies) Tab(text: m.company.name)]),
        ),
        body: TabBarView(children: [
          for (final m in companies)
            _CompanyRequests(
                session: session, membership: m, focus: m.company.id == companyId ? requestId : null),
        ]),
      ),
    );
  }
}

class _CompanyRequests extends StatefulWidget {
  final Session session;
  final Membership membership;
  final String? focus;

  const _CompanyRequests({required this.session, required this.membership, this.focus});

  @override
  State<_CompanyRequests> createState() => _CompanyRequestsState();
}

class _CompanyRequestsState extends State<_CompanyRequests> with AutomaticKeepAliveClientMixin {
  late final Future<CompanyData> _data = CompanyData.load(widget.session, widget.membership.company.id);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _data,
      builder: (context, snap) {
        if (snap.hasError) return Center(child: Text('${snap.error}'));
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        return RequestsView(
            session: widget.session, membership: widget.membership, data: snap.data!, focus: widget.focus);
      },
    );
  }
}
