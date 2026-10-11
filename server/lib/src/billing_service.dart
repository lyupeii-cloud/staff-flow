import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'company_service.dart';
import 'errors.dart';
import 'models.dart';
import 'notifications.dart';
import 'platform_service.dart';
import 'store.dart';

/// Abonnement de chaque entreprise (section 9 du cahier des charges).
///
/// États : `trial` (essai gratuit, une fois par compte Google), `active`
/// (payée jusqu'à `paid_until`), `grace` (non payée : lecture seule, puis
/// suppression à `grace_ends_at`), `comped` (offerte par l'administration).
///
/// En attendant la plateforme de paiement, le paiement est fictif et réservé
/// aux administrateurs (ou à tous avec `BILLING_TEST`) : rien n'est prélevé.
class BillingService {
  final Store store;
  final CompanyService companies;
  final PlatformService platform;
  final NotificationService notifications;
  final SecretKey _key;
  final DateTime Function() now;

  /// Paiement fictif ouvert à tous les propriétaires (tests seulement).
  final bool testPaymentsForAll;
  final bool Function(User) isAdmin;

  BillingService(this.store, this.companies, this.platform, this.notifications, String secret,
      {required this.now, required this.isAdmin, this.testPaymentsForAll = false})
      : _key = SecretKey(secret);

  static const states = {'trial', 'active', 'grace', 'comped'};

  // --- Création d'une entreprise ------------------------------------------

  /// Une nouvelle entreprise : pendant la période d'essai du compte (2 jours
  /// à partir de sa première entreprise), elle est en essai ; après, un
  /// abonnement est demandé dès la création (lecture seule en attendant).
  Future<Company> start(User owner, Company company) async {
    final t = now();
    final v = await platform.values();
    final rows = await store.query(store.db,
        'UPDATE users SET trial_started_at = coalesce(trial_started_at, @t) WHERE id = @u::uuid RETURNING trial_started_at',
        {'t': t, 'u': owner.id});
    final trialEnds = (rows.first[0] as DateTime).add(Duration(days: v['trialDays']!));
    final inTrial = trialEnds.isAfter(t);
    final updated = await store.query(store.db, '''
      UPDATE companies SET billing_status = @s, trial_ends_at = @te, grace_ends_at = @ge,
        status = CASE WHEN @s = 'grace' THEN 'readOnly' ELSE 'active' END
      WHERE id = @c::uuid RETURNING *''', {
      'c': company.id,
      's': inTrial ? 'trial' : 'grace',
      'te': trialEnds,
      'ge': inTrial ? null : t.add(Duration(days: v['graceDays']!)),
    });
    return Store.companyFromRow(updated.first.toColumnMap());
  }

  // --- Espace « Facturation » du propriétaire -------------------------------

  /// Salariés comptés : responsables et salariés (ni le propriétaire, ni les extras).
  Future<int> staffCount(String companyId) async {
    final rows = await store.query(store.db, '''
      SELECT count(*) FROM memberships
      WHERE company_id = @c::uuid AND left_at IS NULL AND role IN ('manager', 'employee')''', {'c': companyId});
    return (rows.first[0] as num).toInt();
  }

  Future<Company> _owned(User actor, String companyId) async {
    final (company, role) = await companies.open(actor, companyId);
    if (role != Role.owner) throw const ApiError.forbidden();
    return company;
  }

  bool canPay(User actor) => testPaymentsForAll || isAdmin(actor);

  Future<Map<String, Object?>> summary(User actor, String companyId) async {
    final company = await _owned(actor, companyId);
    final v = await platform.values();
    final staff = await staffCount(companyId);
    final invoices = await store.query(store.db, '''
      SELECT id, number, issued_at, period, period_start, period_end, amount_cents
      FROM invoices WHERE company_id = @c::uuid ORDER BY id DESC''', {'c': companyId});
    return {
      ...company.billingJson(),
      'staff': staff,
      'cascadeIncludedFrom': v['cascadeIncludedFrom'],
      'annualMonths': v['annualMonths'],
      'prices': {
        'month': PlatformService.monthlyCents(v, staff),
        'year': PlatformService.annualCents(v, staff),
        'monthCascade': PlatformService.monthlyCents(v, staff, cascade: true),
        'yearCascade': PlatformService.annualCents(v, staff, cascade: true),
      },
      'canPay': canPay(actor),
      'testPayments': true,
      'invoices': [
        for (final r in invoices)
          {
            'id': r[0],
            'number': r[1],
            'issuedAt': (r[2] as DateTime).toIso8601String(),
            'period': r[3],
            'from': (r[4] as DateTime).toIso8601String(),
            'to': (r[5] as DateTime).toIso8601String(),
            'amountCents': r[6],
          },
      ],
    };
  }

  Future<void> setInvoiceByEmail(User actor, String companyId, bool on) async {
    await _owned(actor, companyId);
    await store.query(store.db, 'UPDATE companies SET invoice_by_email = @e WHERE id = @c::uuid', {'c': companyId, 'e': on});
  }

  static DateTime _addMonths(DateTime d, int months) {
    final m = d.month - 1 + months;
    final y = d.year + m ~/ 12;
    final month = m % 12 + 1;
    final last = DateTime.utc(y, month + 1, 0).day;
    return DateTime.utc(y, month, d.day > last ? last : d.day, d.hour, d.minute, d.second);
  }

  /// Paiement (fictif pour l'instant) d'un mois ou d'une année : le prix est
  /// calculé avec les tarifs et l'effectif du moment, la période s'ajoute à
  /// celle déjà payée, l'entreprise redevient modifiable, une facture est créée.
  Future<Map<String, Object?>> checkout(User actor, String companyId, {required String period, required bool cascade}) async {
    final company = await _owned(actor, companyId);
    if (!canPay(actor)) throw const ApiError.conflict('Le paiement en ligne arrive bientôt.');
    if (period != 'month' && period != 'year') throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    if (company.billingStatus == 'comped') throw const ApiError.conflict('Cette entreprise est offerte : rien à payer.');
    final v = await platform.values();
    final staff = await staffCount(companyId);
    final withOption = cascade && staff < v['cascadeIncludedFrom']!;
    final base = PlatformService.monthlyCents(v, staff);
    final option = withOption ? v['cascadeOptionPrice']! : 0;
    final months = period == 'year' ? 12 : 1;
    final baseAmount = period == 'year' ? base * v['annualMonths']! : base;
    final t = now();
    final from = company.paidUntil != null && company.paidUntil!.isAfter(t) ? company.paidUntil! : t;
    final to = _addMonths(from, months);
    final lines = [
      {
        'label': 'subscription',
        'staff': staff,
        'period': period,
        'unitCents': base,
        'months': months,
        'paidMonths': period == 'year' ? v['annualMonths'] : 1,
        'cents': baseAmount,
      },
      if (withOption) {'label': 'cascade', 'unitCents': option, 'months': months, 'cents': option * months},
    ];
    final amount = baseAmount + option * months;
    final owner = await store.findUser(actor.id);
    final invoice = await store.db.runTx((tx) async {
      final seq = await store.query(tx, "SELECT nextval('invoice_number_seq')");
      final number = 'SF-${t.year}-${(seq.first[0] as int).toString().padLeft(6, '0')}';
      final rows = await store.query(tx, '''
        INSERT INTO invoices (number, company_id, company_name, owner_id, owner_name, owner_email, issued_at,
          period, period_start, period_end, staff, lines, amount_cents, provider, paid_at)
        VALUES (@n, @c::uuid, @cn, @o::uuid, @on, @oe, @t, @p, @f, @to, @s, @l::jsonb, @a, 'test', @t)
        RETURNING id''', {
        'n': number,
        'c': companyId,
        'cn': company.name,
        'o': actor.id,
        'on': owner?.name,
        'oe': owner?.email,
        't': t,
        'p': period,
        'f': from,
        'to': to,
        's': staff,
        'l': jsonEncode(lines),
        'a': amount,
      });
      await store.query(tx, '''
        UPDATE companies SET billing_status = 'active', paid_until = @to, grace_ends_at = NULL, status = 'active',
          billing_period = @p, cascade_option = @co, billing_reminders = '{}'
        WHERE id = @c::uuid''', {'c': companyId, 'to': to, 'p': period, 'co': withOption});
      await store.audit(
          companyId: companyId,
          actorId: actor.id,
          action: 'billing.paid',
          details: {'invoice': number, 'amountCents': amount, 'period': period, 'provider': 'test'},
          tx: tx);
      return {'id': rows.first[0], 'number': number, 'amountCents': amount, 'paidUntil': to.toIso8601String()};
    });
    return invoice;
  }

  /// L'option « sites en cascade » est-elle ouverte ? (Essai et entreprise
  /// offerte : tout est ouvert.)
  Future<bool> cascadeAllowed(String companyId) async {
    final c = await store.findCompany(companyId);
    if (c == null) return false;
    if (c.billingStatus == 'trial' || c.billingStatus == 'comped' || c.cascadeOption) return true;
    return await staffCount(companyId) >= await platform.value('cascadeIncludedFrom');
  }

  // --- Factures -------------------------------------------------------------

  Future<String> invoiceLink(User actor, String companyId, int invoiceId) async {
    await _owned(actor, companyId);
    final rows = await store.query(store.db,
        'SELECT 1 FROM invoices WHERE id = @i AND company_id = @c::uuid', {'i': invoiceId, 'c': companyId});
    if (rows.isEmpty) throw const ApiError.notFound();
    final jwt = JWT({'i': invoiceId}, subject: actor.id, issuer: 'staff-flow-invoice');
    return jwt.sign(_key, expiresIn: const Duration(minutes: 10));
  }

  Future<(String, Uint8List)> invoicePdf(String token) async {
    final JWT jwt;
    try {
      jwt = JWT.verify(token, _key, issuer: 'staff-flow-invoice');
    } on JWTException {
      throw const ApiError.notFound('Lien expiré.');
    }
    final id = (jwt.payload as Map)['i'] as int;
    final rows = await store.query(store.db, '''
      SELECT number, company_name, owner_name, owner_email, issued_at, period, period_start, period_end,
        staff, lines, amount_cents, provider, owner_id::text
      FROM invoices WHERE id = @i''', {'i': id});
    if (rows.isEmpty || rows.first[12] != jwt.subject) throw const ApiError.notFound('Lien expiré.');
    final r = rows.first;
    return ('${r[0]}.pdf', await renderInvoice(r));
  }

  static pw.Font? _regular, _bold;

  /// Polices DejaVu Sans (libres, cyrillique compris), livrées avec le serveur.
  static pw.Font _loadFont(String file) {
    final dir = Directory('/app/assets').existsSync() ? '/app/assets' : 'assets';
    return pw.Font.ttf(ByteData.sublistView(File('$dir/$file').readAsBytesSync()));
  }

  static String _eur(int cents) => '${(cents / 100).toStringAsFixed(2).replaceAll('.', ',')} €';
  static String _day(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  /// Facture en français et en anglais. Les informations de l'éditeur sont
  /// provisoires tant que l'entreprise n'est pas enregistrée.
  static Future<Uint8List> renderInvoice(List<Object?> r) async {
    final font = _regular ??= _loadFont('DejaVuSans.ttf');
    final bold = _bold ??= _loadFont('DejaVuSans-Bold.ttf');
    final navy = PdfColor.fromHex('#061440');
    final blue = PdfColor.fromHex('#1A8CFC');
    final grey = PdfColor.fromHex('#55607A');
    final lines = (r[9] as List).cast<Map>();
    final test = r[11] == 'test';
    final doc = pw.Document(theme: pw.ThemeData.withFont(base: font, bold: bold));
    pw.Widget cell(String s, {bool bold = false, pw.TextAlign align = pw.TextAlign.left, PdfColor? color}) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: pw.Text(s,
            textAlign: align,
            style: pw.TextStyle(fontSize: 10, fontWeight: bold ? pw.FontWeight.bold : null, color: color)));
    String label(Map l) => l['label'] == 'cascade'
        ? 'Option « sites en cascade » / Nested sites option — ${l['months']} mois / months'
        : 'Abonnement Staff Flow / Subscription — ${l['staff']} salariés / employees — '
            '${l['period'] == 'year' ? '12 mois, ${l['paidMonths']} facturés / 12 months, ${l['paidMonths']} billed' : '1 mois / 1 month'}';
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (_) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text('Staff Flow', style: pw.TextStyle(fontSize: 24, color: navy, fontWeight: pw.FontWeight.bold)),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            pw.Text('FACTURE / INVOICE', style: pw.TextStyle(fontSize: 14, color: blue)),
            pw.Text('${r[0]}', style: const pw.TextStyle(fontSize: 12)),
            pw.Text('Date : ${_day(r[4] as DateTime)}', style: pw.TextStyle(fontSize: 10, color: grey)),
          ]),
        ]),
        if (test) ...[
          pw.SizedBox(height: 12),
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            color: PdfColor.fromHex('#FFF3CD'),
            child: pw.Text('EXEMPLE — paiement de test, aucun montant prélevé. / SAMPLE — test payment, nothing charged.',
                style: const pw.TextStyle(fontSize: 10)),
          ),
        ],
        pw.SizedBox(height: 24),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Text('Émetteur / Seller', style: pw.TextStyle(fontSize: 9, color: grey)),
              pw.Text('Staff Flow', style: const pw.TextStyle(fontSize: 11)),
              pw.Text('[Raison sociale, numéro d\'enregistrement et adresse à compléter]',
                  style: pw.TextStyle(fontSize: 9, color: grey)),
              pw.Text('https://staff-flow.cloud', style: pw.TextStyle(fontSize: 9, color: grey)),
            ]),
          ),
          pw.Expanded(
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Text('Client / Customer', style: pw.TextStyle(fontSize: 9, color: grey)),
              pw.Text('${r[1]}', style: const pw.TextStyle(fontSize: 11)),
              pw.Text('${r[2] ?? ''} · ${r[3] ?? ''}', style: pw.TextStyle(fontSize: 9, color: grey)),
            ]),
          ),
        ]),
        pw.SizedBox(height: 16),
        pw.Text('Période / Period : ${_day(r[6] as DateTime)} – ${_day(r[7] as DateTime)}',
            style: const pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 16),
        pw.Table(
          border: pw.TableBorder(horizontalInside: pw.BorderSide(color: PdfColor.fromHex('#E3E8F2'))),
          columnWidths: {0: const pw.FlexColumnWidth(3), 1: const pw.FlexColumnWidth(1)},
          children: [
            pw.TableRow(decoration: pw.BoxDecoration(color: navy), children: [
              cell('Désignation / Description', bold: true, color: PdfColors.white),
              cell('Montant / Amount', bold: true, align: pw.TextAlign.right, color: PdfColors.white),
            ]),
            for (final l in lines)
              pw.TableRow(children: [cell(label(l)), cell(_eur(l['cents'] as int), align: pw.TextAlign.right)]),
            pw.TableRow(children: [
              cell('Total TTC / Total incl. taxes', bold: true),
              cell(_eur(r[10] as int), bold: true, align: pw.TextAlign.right),
            ]),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Text('Payé / Paid. Taxes : régime à préciser selon le statut de l\'éditeur. / Tax regime to be confirmed.',
            style: pw.TextStyle(fontSize: 9, color: grey)),
        pw.Spacer(),
        pw.Text('Aucun remboursement d\'une période payée. / Paid periods are not refundable.',
            style: pw.TextStyle(fontSize: 8, color: grey)),
      ]),
    ));
    return doc.save();
  }

  // --- Échéances (toutes les quelques minutes) ------------------------------

  /// Essai ou période payée terminée : lecture seule et compte à rebours ;
  /// rappels au propriétaire ; suppression à la fin de la période de grâce.
  Future<void> tick() async {
    final t = now();
    final v = await platform.values();
    final grace = Duration(days: v['graceDays']!);
    // Fin de l'essai ou de la période payée.
    final ended = await store.query(store.db, '''
      UPDATE companies SET billing_status = 'grace', status = 'readOnly', grace_ends_at = @g, billing_reminders = '{}'
      WHERE (billing_status = 'trial' AND trial_ends_at <= @t) OR (billing_status = 'active' AND paid_until <= @t)
      RETURNING id::text, name''', {'t': t, 'g': t.add(grace)});
    for (final r in ended) {
      await _toOwner(r[0] as String, 'billing_grace', {'day': _iso(t.add(grace))});
    }
    // Essai : rappel la veille.
    final soon = await store.query(store.db, '''
      UPDATE companies SET billing_reminders = billing_reminders || '{trial}'
      WHERE billing_status = 'trial' AND trial_ends_at <= @s AND NOT ('trial' = ANY(billing_reminders))
      RETURNING id::text, trial_ends_at''', {'s': t.add(const Duration(hours: 24))});
    for (final r in soon) {
      await _toOwner(r[0] as String, 'billing_trial_ending', {'day': _iso(r[1] as DateTime)});
    }
    // Période de grâce : rappels au 7e, 13e et 14e jour.
    for (final day in [7, 13, 14]) {
      if (day >= v['graceDays']!) continue;
      final rows = await store.query(store.db, '''
        UPDATE companies SET billing_reminders = billing_reminders || @k::text
        WHERE billing_status = 'grace' AND grace_ends_at - @g::interval + @d::interval <= @t
          AND NOT (@k = ANY(billing_reminders))
        RETURNING id::text, grace_ends_at''',
          {'k': 'grace$day', 'g': '${v['graceDays']} days', 'd': '$day days', 't': t});
      for (final r in rows) {
        await _toOwner(r[0] as String, 'billing_grace_reminder', {'day': _iso(r[1] as DateTime)});
      }
    }
    // Fin de la période de grâce : l'entreprise est supprimée.
    final gone = await store.query(store.db, '''
      SELECT c.id::text, c.name, m.user_id::text FROM companies c
      LEFT JOIN memberships m ON m.company_id = c.id AND m.role = 'owner' AND m.left_at IS NULL
      WHERE c.billing_status = 'grace' AND c.grace_ends_at <= @t''', {'t': t});
    for (final r in gone) {
      await store.query(store.db, 'DELETE FROM companies WHERE id = @c::uuid', {'c': r[0]});
      if (r[2] != null) {
        await store.audit(actorId: r[2] as String, action: 'billing.deleted', details: {'companyId': r[0], 'name': r[1]});
        await notifications.notify([r[2] as String], kind: 'billing_deleted', data: {'companyName': r[1]});
      }
    }
  }

  static String _iso(DateTime d) => d.toIso8601String().substring(0, 10);

  Future<void> _toOwner(String companyId, String kind, Map<String, Object?> data) async {
    final rows = await store.query(store.db, '''
      SELECT user_id::text FROM memberships WHERE company_id = @c::uuid AND role = 'owner' AND left_at IS NULL''',
        {'c': companyId});
    await notifications.notify([for (final r in rows) r[0] as String], companyId: companyId, kind: kind, data: data);
  }

  // --- Administration --------------------------------------------------------

  Future<Map<String, Object?>> stats() async {
    final rows = await store.query(store.db, 'SELECT billing_status, count(*) FROM companies GROUP BY billing_status');
    final revenue = await store.query(store.db, '''
      SELECT coalesce(sum(amount_cents), 0), count(*) FROM invoices
      WHERE paid_at >= date_trunc('month', now()) AND provider <> 'test' ''');
    final test = await store.query(store.db, '''
      SELECT coalesce(sum(amount_cents), 0) FROM invoices
      WHERE paid_at >= date_trunc('month', now()) AND provider = 'test' ''');
    return {
      'byStatus': {for (final r in rows) r[0] as String: (r[1] as num).toInt()},
      'revenueMonthCents': (revenue.first[0] as num).toInt(),
      'invoicesMonth': (revenue.first[1] as num).toInt(),
      'testRevenueMonthCents': (test.first[0] as num).toInt(),
    };
  }

  Future<List<Map<String, Object?>>> adminCompanies() async {
    final rows = await store.query(store.db, '''
      SELECT c.id::text, c.name, c.billing_status, c.trial_ends_at, c.paid_until, c.grace_ends_at, u.email,
        (SELECT count(*) FROM memberships m2 WHERE m2.company_id = c.id AND m2.left_at IS NULL
           AND m2.role IN ('manager', 'employee'))
      FROM companies c
      LEFT JOIN memberships m ON m.company_id = c.id AND m.role = 'owner' AND m.left_at IS NULL
      LEFT JOIN users u ON u.id = m.user_id
      ORDER BY c.created_at DESC''');
    String? iso(Object? d) => (d as DateTime?)?.toIso8601String();
    return [
      for (final r in rows)
        {
          'id': r[0],
          'name': r[1],
          'billingStatus': r[2],
          'trialEndsAt': iso(r[3]),
          'paidUntil': iso(r[4]),
          'graceEndsAt': iso(r[5]),
          'ownerEmail': r[6],
          'staff': (r[7] as num).toInt(),
        },
    ];
  }

  /// Administration : entreprise offerte, ou de nouveau soumise au paiement.
  Future<void> setComped(User admin, String companyId, bool comped) async {
    final t = now();
    final graceDays = await platform.value('graceDays');
    final rows = await store.query(store.db, comped
        ? '''UPDATE companies SET billing_status = 'comped', status = 'active', grace_ends_at = NULL
             WHERE id = @c::uuid RETURNING id'''
        : '''UPDATE companies SET
               billing_status = CASE WHEN paid_until > @t::timestamptz THEN 'active' ELSE 'grace' END,
               status = CASE WHEN paid_until > @t::timestamptz THEN 'active' ELSE 'readOnly' END,
               grace_ends_at = CASE WHEN paid_until > @t::timestamptz THEN NULL ELSE @g::timestamptz END, billing_reminders = '{}'
             WHERE id = @c::uuid AND billing_status = 'comped' RETURNING id''',
        {'c': companyId, 't': t, 'g': t.add(Duration(days: graceDays))});
    if (rows.isEmpty) throw const ApiError.notFound();
    await store.audit(companyId: companyId, actorId: admin.id, action: 'billing.comped', details: {'comped': comped});
  }
}
