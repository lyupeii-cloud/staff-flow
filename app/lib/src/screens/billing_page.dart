import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api.dart';
import '../dates.dart';
import '../i18n.dart';
import '../models.dart';
import '../session.dart';
import 'account_tools.dart';
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
  bool _api = false;
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
        _cascade = d['cascadeOption'] == true && d['cascadeUntil'] == null;
        _api = d['apiOption'] == true && d['apiUntil'] == null;
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

  /// Détail ligne par ligne de ce qui sera payé, puis paiement.
  /// Offre du serveur : période, option cascade, option API.
  static Map<String, dynamic> _offer(Map<String, dynamic> d, String period, bool cascade, bool api) =>
      ((d['offers'] as Map)['$period-${cascade ? 1 : 0}-${api ? 1 : 0}'] as Map).cast<String, dynamic>();

  Future<void> _confirm(Map<String, dynamic> d, String period, bool cascade) =>
      _showQuote(_offer(d, period, cascade, _api), () => _pay(period));

  /// Option active : la renouveler ou non (elle reste jusqu'à la fin de la période payée).
  Future<void> _setRenewal(String option, bool renew) => _run(() async {
        await widget.session.api.send('PUT', '$_base/renewal', body: {'option': option, 'renew': renew});
        await _load();
      }, done: renew ? context.l10n.billingOptionRenewed : context.l10n.billingOptionStopped);

  /// Case d'une option : pendant un abonnement, une option active se
  /// renouvelle ou non ; sinon, la case choisit ce qui sera payé.
  Widget _optionTile(Map<String, dynamic> d, String option, String title, String price,
      {required bool value, required ValueChanged<bool> onLocal}) {
    final t = context.l10n;
    final loc = context.localeName;
    final active = d['status'] == 'active' && d['${option}Option'] == true;
    final until = d['${option}Until'] as String?;
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: value,
      onChanged: _busy ? null : (v) => active ? _setRenewal(option, v ?? false) : onLocal(v ?? false),
      title: Text(title),
      subtitle: Text([
        price,
        if (active && until != null)
          t.billingOptionEnds(longDate(DateTime.parse(until).subtract(const Duration(days: 1)), loc))
        else if (active)
          t.billingOptionActive,
      ].join('\n')),
    );
  }

  /// Option seule ([option] : `api` ou `cascade`), payée jusqu'à la fin de la période.
  Future<void> _buyAddon(String option) => _run(() async {
        await widget.session.api.send('POST', '$_base/addon', body: {'option': option});
        await widget.session.refresh();
        await _load();
      }, done: context.l10n.billingPaidOk);

  /// Détail ligne par ligne d'un paiement, puis [pay] si la personne confirme.
  Future<void> _showQuote(Map<String, dynamic> quote, Future<void> Function() pay) async {
    final t = context.l10n;
    final loc = context.localeName;
    String date(Object? iso) => longDate(DateTime.parse(iso as String).toLocal(), loc);
    String line(Map l) => switch (l['label']) {
          'apiAddon' => t.billingLineApiAddon(
              date(l['from']), longDate(DateTime.parse(l['to']).subtract(const Duration(days: 1)), loc), '${l['months']}'),
          'cascadeAddon' => t.billingLineCascadeAddon(
              date(l['from']), longDate(DateTime.parse(l['to']).subtract(const Duration(days: 1)), loc), '${l['months']}'),
          'api' => t.billingLineApi('${l['months']}'),
          'apiProrata' => t.billingLineApiProrata('${l['days']}', '${l['monthDays']}'),
          'prorata' => t.billingLineProrata('${l['days']}', '${l['monthDays']}'),
          'cascadeProrata' => t.billingLineCascadeProrata('${l['days']}', '${l['monthDays']}'),
          'cascade' => t.billingLineCascade('${l['months']}'),
          _ => l['period'] == 'year'
              ? t.billingLineYear('${l['staff']}', '${l['paidMonths']}')
              : t.billingLineMonth('${l['staff']}'),
        };
    final total = quote['total'] as int;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: Text(t.billingDetailTitle),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              for (final l in quote['lines'] as List)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: Text(line(l as Map))),
                    const SizedBox(width: 12),
                    Text(euroAmount(context, l['cents'] as int)),
                  ]),
                ),
              const Divider(),
              Row(children: [
                Expanded(child: Text(t.billingTotal, style: const TextStyle(fontWeight: FontWeight.w800))),
                Text(euroAmount(context, total), style: const TextStyle(fontWeight: FontWeight.w800)),
              ]),
              const SizedBox(height: 8),
              Text(
                t.billingCovers(longDate(DateTime.parse(quote['from']).toLocal(), loc),
                    longDate(DateTime.parse(quote['to']).subtract(const Duration(days: 1)), loc)),
                style: theme.textTheme.bodySmall,
              ),
            ]),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(t.cancel)),
            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(t.billingPay(euroAmount(context, total)))),
          ],
        );
      },
    );
    if (ok == true && mounted) await pay();
  }

  Future<void> _pay(String period) => _run(() async {
        await widget.session.api.send('POST', '$_base/checkout', body: {'period': period, 'cascade': _cascade, 'api': _api});
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
    final monthOffer = _offer(d, 'month', cascade, _api), yearOffer = _offer(d, 'year', cascade, _api);
    final month = monthOffer['price'] as int;
    final year = yearOffer['price'] as int;
    final dueMonth = monthOffer['total'] as int;
    final dueYear = yearOffer['total'] as int;
    final prorata = (d['prorataDays'] as int? ?? 0) > 0 && status != 'active';
    final invoices = d['invoices'] as List;
    Future<void> downloadAll() =>
        downloadFromServer(context, widget.session, '/companies/${widget.company.id}/invoices-zip/link');
    return [
      // Pas renouvelée : on propose de récupérer toutes les factures tant que c'est simple.
      if (status == 'grace' && invoices.isNotEmpty)
        Card(
          color: theme.colorScheme.tertiaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text(t.billingGraceInvoices),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: downloadAll,
                icon: const Icon(Icons.folder_zip_outlined),
                label: Text(t.downloadAllInvoices),
              ),
            ]),
          ),
        ),
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
        if (included)
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: true,
            onChanged: null,
            title: Text(t.billingCascade),
            subtitle: Text(t.billingCascadeIncluded('${d['cascadeIncludedFrom']}')),
          )
        else
          _optionTile(d, 'cascade', t.billingCascade,
              t.billingPerMonth(euroAmount(context, prices['monthCascade'] - prices['month'])),
              value: _cascade, onLocal: (v) => setState(() => _cascade = v)),
        _optionTile(d, 'api', t.billingApi, t.billingPerMonth(euroAmount(context, d['apiOptionPrice'] as int)),
            value: _api, onLocal: (v) => setState(() => _api = v)),
        // Abonnement en cours : une option s'ajoute seule, jusqu'à la fin de la période payée.
        if (status == 'active') ...[
          Text(t.billingRenewalOptions, style: theme.textTheme.bodySmall),
          for (final (key, title) in [('api', t.billingApi), ('cascade', t.billingCascade)])
            if ((d['addons'] as Map?)?[key] case final Map addon)
              Card(
                color: theme.colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Text(t.billingAddonTitle(title), style: theme.textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(t.billingAddonHint(
                        longDate(DateTime.parse(addon['to'] as String).subtract(const Duration(days: 1)), context.localeName))),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton(
                        onPressed: d['canPay'] == true && !_busy
                            ? () => _showQuote(addon.cast<String, dynamic>(), () => _buyAddon(key))
                            : null,
                        child: Text(t.billingPay(euroAmount(context, addon['total'] as int))),
                      ),
                    ),
                  ]),
                ),
              ),
        ],
        const SizedBox(height: 8),
        _PriceCard(
          title: t.billingMonthly,
          price: t.billingPerMonth(euroAmount(context, month)),
          due: dueMonth == month ? null : t.billingDueToday(euroAmount(context, dueMonth)),
          button: t.billingPay(euroAmount(context, dueMonth)),
          onPressed: d['canPay'] == true && !_busy ? () => _confirm(d, 'month', cascade) : null,
        ),
        _PriceCard(
          title: t.billingYearly('${d['annualMonths']}'),
          price: t.billingPerYear(euroAmount(context, year)),
          due: dueYear == year ? null : t.billingDueToday(euroAmount(context, dueYear)),
          button: t.billingPay(euroAmount(context, dueYear)),
          onPressed: d['canPay'] == true && !_busy ? () => _confirm(d, 'year', cascade) : null,
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
        invoices: [for (final i in invoices) (i as Map).cast<String, dynamic>()],
        busy: _busy,
        onOpen: _openInvoice,
      ),
      if (invoices.length > 1)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: OutlinedButton.icon(
            onPressed: downloadAll,
            icon: const Icon(Icons.folder_zip_outlined),
            label: Text(t.downloadAllInvoices),
          ),
        ),
    ];
  }
}

/// Factures, une année à la fois, choisie dans un menu déroulant (la plus
/// récente d'abord).
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

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final loc = context.localeName;
    if (_year == null) return Padding(padding: const EdgeInsets.only(top: 8), child: Text(t.billingNoInvoices));
    String day(String iso) => longDate(DateTime.parse(iso).toLocal(), loc);
    final shown = [for (final i in widget.invoices) if (DateTime.parse(i['issuedAt']).toLocal().year == _year) i];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 8),
      Align(
        alignment: Alignment.centerLeft,
        child: DropdownButton<int>(
          value: _year,
          items: [for (final y in _years) DropdownMenuItem(value: y, child: Text('${t.billingYearLabel} $y'))],
          onChanged: (y) => setState(() => _year = y),
        ),
      ),
      Column(children: [
          for (final i in shown)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.receipt_long_outlined),
              title: Text(i['period'] == 'addon' ? '${i['number']} · ${t.billingAddonInvoice}' : '${i['number']}'),
              subtitle: Text('${day(i['from'])} – ${day(DateTime.parse(i['to']).subtract(const Duration(days: 1)).toIso8601String())}'
                  ' · ${euroAmount(context, i['amountCents'] as int)}'),
              trailing: const Icon(Icons.download_outlined),
              onTap: widget.busy ? null : () => widget.onOpen(i['id'] as int),
            ),
      ]),
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
