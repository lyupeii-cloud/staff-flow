import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'tools_widgets.dart';

/// Montant en euros, dans la langue de l'application.
String euroAmount(BuildContext context, int cents) =>
    NumberFormat.simpleCurrency(locale: context.localeName, name: 'EUR').format(cents / 100);

/// État de l'abonnement d'une entreprise, en une phrase.
String? billingStatusText(BuildContext context, Company company) {
  final t = context.l10n;
  final loc = context.localeName;
  String day(DateTime? d) => d == null ? '' : longDate(d.toLocal(), loc);
  return switch (company.billingStatus) {
    'trial' => t.billingStatusTrial(day(company.trialEndsAt)),
    'active' => t.billingStatusActive(day(company.paidUntil)),
    'grace' => t.billingStatusGrace(day(company.graceEndsAt)),
    'comped' => t.billingStatusComped,
    _ => null,
  };
}

/// Espace « Abonnement » du propriétaire : état, prix selon l'effectif,
/// paiement (fictif pour l'instant) et factures.
class BillingPage extends StatefulWidget {
  final Session session;
  final Company company;

  const BillingPage({super.key, required this.session, required this.company});

  static Future<void> open(BuildContext context, Session session, Company company) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => BillingPage(session: session, company: company)));

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  Map<String, dynamic>? _data;
  Object? _error;
  bool _cascade = false;
  bool _busy = false;

  String get _base => '/companies/${widget.company.id}/billing';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final d = (await widget.session.api.send('GET', _base) as Map).cast<String, dynamic>();
      if (!mounted) return;
      setState(() {
        _data = d;
        _error = null;
        _cascade = d['cascadeOption'] == true;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  Future<void> _run(Future<void> Function() action, {String? done}) async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);
    try {
      await action();
      if (done != null) messenger.showSnackBar(SnackBar(content: Text(done)));
    } on OfflineException {
      messenger.showSnackBar(SnackBar(content: Text(t.offlineUnavailable)));
    } on ApiException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.describe(t))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pay(String period) => _run(() async {
        await widget.session.api.send('POST', '$_base/checkout', body: {'period': period, 'cascade': _cascade});
        await widget.session.refresh();
        await _load();
      }, done: context.l10n.billingPaidOk);

  Future<void> _openInvoice(int id) => _run(() async {
        final r = await widget.session.api
            .send('GET', '/companies/${widget.company.id}/invoices/$id/link?lang=${context.localeName}');
        await launchUrl(Uri.parse(serverUrl(r['path'] as String)),
            mode: LaunchMode.externalApplication, webOnlyWindowName: '_blank');
      });

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final theme = Theme.of(context);
    final d = _data;
    return Scaffold(
      appBar: AppBar(title: Text('${t.billingTitle} · ${widget.company.name}')),
      body: d == null
          ? Center(
              child: _error == null
                  ? const CircularProgressIndicator()
                  : TextButton.icon(
                      onPressed: _load,
                      icon: const Icon(Icons.refresh),
                      label: Text(_error is OfflineException ? t.offlineUnavailable : t.retry),
                    ),
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: ListView(padding: const EdgeInsets.all(16), children: _content(context, t, theme, d)),
              ),
            ),
    );
  }

  List<Widget> _content(BuildContext context, L10n t, ThemeData theme, Map<String, dynamic> d) {
    final loc = context.localeName;
    final status = d['status'] as String;
    String day(String? iso) => iso == null ? '' : longDate(DateTime.parse(iso).toLocal(), loc);
    final statusText = switch (status) {
      'trial' => t.billingStatusTrial(day(d['trialEndsAt'])),
      'active' => t.billingStatusActive(day(d['paidUntil'])),
      'grace' => t.billingStatusGrace(day(d['graceEndsAt'])),
      _ => t.billingStatusComped,
    };
    final prices = (d['prices'] as Map).cast<String, dynamic>();
    final staff = d['staff'] as int;
    final included = staff >= (d['cascadeIncludedFrom'] as int);
    final cascade = _cascade && !included;
    final month = prices[cascade ? 'monthCascade' : 'month'] as int;
    final year = prices[cascade ? 'yearCascade' : 'year'] as int;
    final due = (d['dueNow'] as Map).cast<String, dynamic>();
    final dueMonth = due[cascade ? 'monthCascade' : 'month'] as int;
    final dueYear = due[cascade ? 'yearCascade' : 'year'] as int;
    final prorata = (d['prorataDays'] as int? ?? 0) > 0 && status != 'active';
    return [
      Card(
        color: status == 'grace' ? theme.colorScheme.errorContainer : theme.colorScheme.primaryContainer,
        child: ListTile(
          leading: Icon(status == 'grace' ? Icons.lock_clock : Icons.verified_outlined),
          title: Text(statusText),
          subtitle: Text('${t.billingStaff('$staff')}\n${t.billingCompanyId('${d['publicId']}')}'),
          isThreeLine: true,
        ),
      ),
      if (status != 'comped') ...[
        const SizedBox(height: 16),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: included || _cascade,
          onChanged: included || _busy ? null : (v) => setState(() => _cascade = v ?? false),
          title: Text(t.billingCascade),
          subtitle: Text(included ? t.billingCascadeIncluded('${d['cascadeIncludedFrom']}') : t.billingPerMonth(euroAmount(context, prices['monthCascade'] - prices['month']))),
        ),
        const SizedBox(height: 8),
        _PriceCard(
          title: t.billingMonthly,
          price: t.billingPerMonth(euroAmount(context, month)),
          due: dueMonth == month ? null : t.billingDueToday(euroAmount(context, dueMonth)),
          button: t.billingPay(euroAmount(context, dueMonth)),
          onPressed: d['canPay'] == true && !_busy ? () => _pay('month') : null,
        ),
        _PriceCard(
          title: t.billingYearly('${d['annualMonths']}'),
          price: t.billingPerYear(euroAmount(context, year)),
          due: dueYear == year ? null : t.billingDueToday(euroAmount(context, dueYear)),
          button: t.billingPay(euroAmount(context, dueYear)),
          onPressed: d['canPay'] == true && !_busy ? () => _pay('year') : null,
        ),
        if (prorata)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(t.billingProrataNote('${d['prorataDays']}'), style: theme.textTheme.bodySmall),
          ),
        const SizedBox(height: 4),
        Text(d['canPay'] == true ? t.billingTestNotice : t.billingSoon,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.tertiary)),
      ],
      const SizedBox(height: 24),
      Text(t.billingInvoices, style: theme.textTheme.titleMedium),
      _Invoices(
        invoices: [for (final i in d['invoices'] as List) (i as Map).cast<String, dynamic>()],
        busy: _busy,
        onOpen: _openInvoice,
      ),
    ];
  }
}

/// Factures, une année à la fois : on passe d'une année à l'autre en
/// touchant les années (les plus récentes d'abord) ou en glissant.
class _Invoices extends StatefulWidget {
  final List<Map<String, dynamic>> invoices;
  final bool busy;
  final ValueChanged<int> onOpen;

  const _Invoices({required this.invoices, required this.busy, required this.onOpen});

  @override
  State<_Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<_Invoices> {
  late final List<int> _years = {for (final i in widget.invoices) DateTime.parse(i['issuedAt']).toLocal().year}.toList()
    ..sort((a, b) => b.compareTo(a));
  late int? _year = _years.firstOrNull;

  void _shift(int delta) {
    final i = _years.indexOf(_year!) + delta;
    if (i >= 0 && i < _years.length) setState(() => _year = _years[i]);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    if (_year == null) return Padding(padding: const EdgeInsets.only(top: 8), child: Text(t.billingNoInvoices));
    String day(String iso) => longDate(DateTime.parse(iso).toLocal(), loc);
    final shown = [for (final i in widget.invoices) if (DateTime.parse(i['issuedAt']).toLocal().year == _year) i];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 8),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          for (final y in _years)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text('$y'),
                selected: y == _year,
                onSelected: (_) => setState(() => _year = y),
              ),
            ),
        ]),
      ),
      // Glisser vers la gauche : année précédente ; vers la droite : suivante.
      GestureDetector(
        onHorizontalDragEnd: (e) {
          final v = e.primaryVelocity ?? 0;
          if (v < -200) _shift(1);
          if (v > 200) _shift(-1);
        },
        child: Column(children: [
          for (final i in shown)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.receipt_long_outlined),
              title: Text('${i['number']}'),
              subtitle: Text('${day(i['from'])} – ${day(DateTime.parse(i['to']).subtract(const Duration(days: 1)).toIso8601String())}'
                  ' · ${euroAmount(context, i['amountCents'] as int)}'),
              trailing: const Icon(Icons.download_outlined),
              onTap: widget.busy ? null : () => widget.onOpen(i['id'] as int),
            ),
        ]),
      ),
    ]);
  }
}

class _PriceCard extends StatelessWidget {
  final String title, price, button;
  final String? due;
  final VoidCallback? onPressed;

  const _PriceCard({required this.title, required this.price, this.due, required this.button, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: theme.textTheme.titleSmall),
              Text(price, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              if (due != null) Text(due!, style: theme.textTheme.bodySmall),
            ]),
          ),
          FilledButton(onPressed: onPressed, child: Text(button)),
        ]),
      ),
    );
  }
}
