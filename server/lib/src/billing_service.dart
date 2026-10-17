import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'company_service.dart';
import 'api_access.dart';
import 'errors.dart';
import 'messages.dart';
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

  /// Le patron, ou la personne à qui il a confié l'abonnement (comptable…).
  Future<Company> _owned(User actor, String companyId) async {
    final (company, role) = await companies.open(actor, companyId);
    if (role != Role.owner && !await _billingAccess(companyId, actor.id)) throw const ApiError.forbidden();
    return company;
  }

  Future<bool> _billingAccess(String companyId, String userId) async {
    final rows = await store.query(store.db, '''
      SELECT 1 FROM memberships WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL
        AND (role = 'owner' OR billing_access)''', {'c': companyId, 'u': userId});
    return rows.isNotEmpty;
  }

  /// Le patron confie (ou retire) la gestion de l'abonnement et des factures.
  Future<void> setBillingAccess(User actor, String companyId, String userId, bool enabled) async {
    final (_, role) = await companies.open(actor, companyId);
    if (role != Role.owner) throw const ApiError.forbidden();
    final target = await store.roleOf(companyId, userId);
    if (target == null) throw const ApiError.notFound('Membre introuvable.');
    if (target == Role.owner) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    await store.query(store.db, '''
      UPDATE memberships SET billing_access = @e
      WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''', {'c': companyId, 'u': userId, 'e': enabled});
    await store.audit(
        companyId: companyId, actorId: actor.id, action: 'billing.access', details: {'userId': userId, 'enabled': enabled});
  }

  /// Option ajoutée en cours d'abonnement : le mois en cours en entier, puis
  /// chaque mois jusqu'à la fin de la période payée (mois offerts de
  /// l'année compris), sans remise. `null` : rien à acheter.
  Map<String, Object?>? _addon(Company c, Map<String, int> v, int staff, String option, {int? slots}) {
    final t = now();
    final until = c.paidUntil;
    if (c.billingStatus != 'active' || until == null || !until.isAfter(t)) return null;
    // Lecture comprise dans « API Pro ».
    if (option == 'api' && (c.apiOption || c.apiProOption)) return null;
    if (option == 'pro' && c.apiProOption) return null;
    if (option == 'pro10' && c.apiProOption && c.apiProKeys >= 10) return null;
    if (option == 'cascade' && (c.cascadeOption || c.slots >= v['cascadeIncludedFrom']!)) return null;
    if (option == 'slots' && (slots == null || slots <= c.slots)) return null;
    final from = DateTime.utc(t.year, t.month);
    var months = (until.year - from.year) * 12 + until.month - from.month;
    if (until.isAfter(DateTime.utc(until.year, until.month))) months++;
    if (months < 1) months = 1;
    // Places en plus : la différence de prix par mois entre les deux nombres de places.
    final unit = switch (option) {
      'api' => v['apiOptionPrice']!,
      'pro' => proUnit(v, 1),
      // Déjà en « API Pro » 1 clé : seulement la différence.
      'pro10' => c.apiProOption ? proUnit(v, 10) - proUnit(v, 1) : proUnit(v, 10),
      'cascade' => v['cascadeOptionPrice']!,
      _ => PlatformService.monthlyCents(v, slots!) - PlatformService.monthlyCents(v, c.slots),
    };
    final line = {
      'label': switch (option) {
        'api' => 'apiAddon',
        'pro' => 'proAddon',
        'pro10' => c.apiProOption ? 'pro10Upgrade' : 'pro10Addon',
        'cascade' => 'cascadeAddon',
        _ => 'slotsAddon'
      },
      if (option == 'slots') ...{'slotsFrom': c.slots, 'slots': slots},
      'unitCents': unit,
      'months': months,
      'from': from.toIso8601String(),
      'to': until.toIso8601String(),
      'cents': unit * months,
    };
    return {'lines': [line], 'total': unit * months, 'from': from.toIso8601String(), 'to': until.toIso8601String()};
  }

  /// Prix mensuel de « API Pro » : 1 clé, ou 10 clés.
  static int proUnit(Map<String, int> v, int keys) => keys >= 10 ? v['apiPro10Price']! : v['apiProPrice']!;

  /// « API Pro » : nombre de clés du prochain renouvellement (1 ou 5). Le
  /// passage à 10 clés se paie tout de suite (option « pro10 ») ; la baisse
  /// à 1 clé prend effet au renouvellement (clés en trop désactivées).
  Future<void> setProKeys(User actor, String companyId, int keys) async {
    final company = await _owned(actor, companyId);
    if (keys != 1 && keys != 10) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    if (company.billingStatus != 'active' || !company.apiProOption) {
      throw const ApiError.conflict('Cette option n\'est pas active.');
    }
    if (keys > company.apiProKeys) throw const ApiError.conflict('Cette option ne peut pas être ajoutée maintenant.');
    await store.query(store.db, 'UPDATE companies SET api_pro_next_keys = @n WHERE id = @c::uuid',
        {'c': companyId, 'n': keys == company.apiProKeys ? null : keys});
    await store.audit(companyId: companyId, actorId: actor.id, action: 'billing.renewal', details: {'option': 'proKeys', 'keys': keys});
  }

  /// Clés au-delà de la formule : désactivées (les plus récentes).
  Future<void> _enforceKeys(String companyId) async {
    final c = await store.findCompany(companyId);
    // Accès coupé (limite 0) : rien à désactiver, les clés reprennent avec l'option.
    if (c == null || ApiAccessService.keyLimit(c) == 0) return;
    await store.query(store.db, '''
      UPDATE api_keys SET disabled_at = @t WHERE id IN (
        SELECT id FROM api_keys WHERE company_id = @c::uuid AND revoked_at IS NULL AND disabled_at IS NULL
        ORDER BY created_at OFFSET @n)''', {'c': companyId, 'n': ApiAccessService.keyLimit(c), 't': now()});
  }

  /// Accès API arrêté (essai fini, option non renouvelée, période de grâce) :
  /// les clés ne marchent plus ; le patron est prévenu 7 jours avant leur
  /// suppression, 30 jours après l'arrêt. Accès revenu : tout reprend.
  Future<void> _apiKeysTick(DateTime t) async {
    final rows = await store.query(store.db, '''
      SELECT DISTINCT k.company_id::text, c.api_off_since, c.api_off_warned FROM api_keys k
      JOIN companies c ON c.id = k.company_id WHERE k.revoked_at IS NULL''');
    for (final r in rows) {
      final companyId = r[0] as String;
      final c = await store.findCompany(companyId);
      if (c == null) continue;
      final since = r[1] as DateTime?;
      if (ApiAccessService.keyLimit(c) > 0) {
        if (since != null) {
          await store.query(store.db, 'UPDATE companies SET api_off_since = NULL, api_off_warned = false WHERE id = @c::uuid',
              {'c': companyId});
        }
        await _enforceKeys(companyId);
        continue;
      }
      if (since == null) {
        await store.query(store.db, 'UPDATE companies SET api_off_since = @t, api_off_warned = false WHERE id = @c::uuid',
            {'c': companyId, 't': t});
        continue;
      }
      final end = since.add(const Duration(days: 30));
      if (!t.isBefore(end)) {
        await store.query(store.db, 'DELETE FROM api_keys WHERE company_id = @c::uuid AND revoked_at IS NULL', {'c': companyId});
        await store.query(store.db, 'UPDATE companies SET api_off_since = NULL, api_off_warned = false WHERE id = @c::uuid',
            {'c': companyId});
        final owner = await _ownerId(companyId);
        if (owner != null) await store.audit(companyId: companyId, actorId: owner, action: 'api.keys_deleted');
      } else if (r[2] != true && !t.isBefore(end.subtract(const Duration(days: 7)))) {
        await store.query(store.db, 'UPDATE companies SET api_off_warned = true WHERE id = @c::uuid', {'c': companyId});
        final managers = await store.query(store.db, '''
          SELECT user_id::text FROM memberships WHERE company_id = @c::uuid AND left_at IS NULL
            AND (role = 'owner' OR (role = 'manager' AND billing_access))''', {'c': companyId});
        await notifications.notify([for (final m in managers) m[0] as String],
            companyId: companyId, kind: 'api_keys_deletion', data: {'day': _iso(end)});
      }
    }
  }

  Future<String?> _ownerId(String companyId) async {
    final r = await store.query(store.db, '''
      SELECT user_id::text FROM memberships WHERE company_id = @c::uuid AND role = 'owner' AND left_at IS NULL''',
        {'c': companyId});
    return r.isEmpty ? null : r.first[0] as String;
  }

  Future<bool> _renews(String companyId, String column) async =>
      (await store.query(store.db, 'SELECT $column IS NULL FROM companies WHERE id = @c::uuid', {'c': companyId})).first[0] == true;

  /// Fin d'une option non renouvelée (`null` : renouvelée).
  Future<Map<String, Object?>> _renewals(String companyId) async {
    final rows = await store.query(store.db, 'SELECT api_until, cascade_until, api_pro_until FROM companies WHERE id = @c::uuid',
        {'c': companyId});
    return {
      'apiUntil': (rows.first[0] as DateTime?)?.toIso8601String(),
      'cascadeUntil': (rows.first[1] as DateTime?)?.toIso8601String(),
      'proUntil': (rows.first[2] as DateTime?)?.toIso8601String(),
    };
  }

  /// Une option active n'est plus renouvelée ([renew] faux) : elle reste
  /// jusqu'à la fin de la période payée, puis elle est retirée ; [renew]
  /// vrai annule cette décision.
  Future<void> setRenewal(User actor, String companyId, String option, bool renew) async {
    final company = await _owned(actor, companyId);
    if (option != 'api' && option != 'cascade' && option != 'pro') {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    final active = switch (option) { 'api' => company.apiOption, 'pro' => company.apiProOption, _ => company.cascadeOption };
    if (company.billingStatus != 'active' || !active) {
      throw const ApiError.conflict('Cette option n\'est pas active.');
    }
    final column = switch (option) { 'api' => 'api_until', 'pro' => 'api_pro_until', _ => 'cascade_until' };
    await store.query(store.db, 'UPDATE companies SET $column = @u::timestamptz WHERE id = @c::uuid',
        {'c': companyId, 'u': renew ? null : company.paidUntil});
    await store.audit(
        companyId: companyId, actorId: actor.id, action: 'billing.renewal', details: {'option': option, 'renew': renew});
  }

  /// Paiement d'une option seule ([option] : `api` ou `cascade`) ; elle est
  /// active aussitôt et reprise dans les renouvellements suivants.
  Future<Map<String, Object?>> buyAddon(User actor, String companyId, String option, {int? slots}) async {
    final company = await _owned(actor, companyId);
    if (!canPay(actor)) throw const ApiError.conflict('Le paiement en ligne arrive bientôt.');
    if (option != 'api' && option != 'cascade' && option != 'slots' && option != 'pro' && option != 'pro10') {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    if (option == 'slots') checkSlots(slots, 0);
    final v = await platform.values();
    final quote = _addon(company, v, await staffCount(companyId), option, slots: slots);
    if (quote == null) throw const ApiError.conflict('Cette option ne peut pas être ajoutée maintenant.');
    final t = now();
    final owner = await store.findUser(actor.id);
    final seller = await platform.texts();
    return store.db.runTx((tx) async {
      await store.query(tx, 'SELECT 1 FROM companies WHERE id = @c::uuid FOR UPDATE', {'c': companyId});
      final count = await store.query(tx, '''
        SELECT count(*) FROM invoices WHERE company_code = @k AND extract(year FROM issued_at) = @y''',
          {'k': company.publicId, 'y': t.year});
      final number = 'SF-${company.publicId}-${t.year}-${((count.first[0] as num).toInt() + 1).toString().padLeft(4, '0')}';
      final rows = await store.query(tx, '''
        INSERT INTO invoices (number, company_id, company_code, company_name, owner_id, owner_name, issued_at,
          period, period_start, period_end, staff, lines, amount_cents, provider, paid_at, seller)
        VALUES (@n, @c::uuid, @k, @cn, @o::uuid, @on, @t, 'addon', @f, @to, @s, @l::jsonb, @a, 'test', @t, @sel::jsonb)
        RETURNING id''', {
        'n': number,
        'c': companyId,
        'k': company.publicId,
        'cn': company.name,
        'o': actor.id,
        'on': owner?.name,
        't': t,
        'f': DateTime.parse(quote['from'] as String),
        'to': DateTime.parse(quote['to'] as String),
        's': await staffCount(companyId),
        'l': jsonEncode(quote['lines']),
        'a': quote['total'],
        'sel': jsonEncode(seller),
      });
      await store.query(
          tx,
          switch (option) {
            'api' => 'UPDATE companies SET api_option = true, api_until = NULL WHERE id = @c::uuid',
            // « API Pro » comprend la lecture : l'option lecture s'arrête, la clé est gardée.
            'pro' || 'pro10' => '''UPDATE companies SET api_pro_option = true, api_pro_until = NULL, api_pro_next_keys = NULL,
                api_pro_keys = ${option == 'pro10' ? 10 : 1}, api_option = false, api_until = NULL WHERE id = @c::uuid''',
            'cascade' => 'UPDATE companies SET cascade_option = true, cascade_until = NULL WHERE id = @c::uuid',
            _ => 'UPDATE companies SET slots = @n WHERE id = @c::uuid',
          },
          {'c': companyId, 'n': slots});
      await store.audit(
          companyId: companyId,
          actorId: actor.id,
          action: 'billing.addon',
          details: {'invoice': number, 'option': option, 'amountCents': quote['total'], 'provider': 'test'},
          tx: tx);
      return {'id': rows.first[0], 'number': number, 'amountCents': quote['total']};
    });
  }

  bool canPay(User actor) => testPaymentsForAll || isAdmin(actor);

  /// Ce qui sera payé aujourd'hui : on paie des mois civils pleins. Au premier
  /// paiement (ou après une interruption), le reste du mois en cours est payé
  /// au prorata (jour du paiement compris, arrondi au centime supérieur), puis
  /// la période choisie commence le 1er du mois suivant ; payé le 1er, la
  /// période commence le jour même. Un renouvellement prolonge simplement la
  /// période déjà payée.
  ({int prorataDays, int monthDays, DateTime periodStart, DateTime periodEnd, DateTime coverFrom}) _plan(
      Company company, String period) {
    final t = now();
    final months = period == 'year' ? 12 : 1;
    if (company.paidUntil != null && company.paidUntil!.isAfter(t)) {
      final start = company.paidUntil!;
      return (prorataDays: 0, monthDays: 0, periodStart: start, periodEnd: _addMonths(start, months), coverFrom: start);
    }
    final monthStart = DateTime.utc(t.year, t.month);
    final next = DateTime.utc(t.year, t.month + 1);
    final monthDays = next.difference(monthStart).inDays;
    if (t.day == 1) {
      return (prorataDays: 0, monthDays: monthDays, periodStart: monthStart, periodEnd: _addMonths(monthStart, months), coverFrom: t);
    }
    return (
      prorataDays: monthDays - t.day + 1,
      monthDays: monthDays,
      periodStart: next,
      periodEnd: _addMonths(next, months),
      coverFrom: t,
    );
  }

  static int _prorata(int monthlyCents, int days, int monthDays) =>
      days == 0 ? 0 : (monthlyCents * days + monthDays - 1) ~/ monthDays;

  /// Montants et lignes de facture d'un paiement.
  ({int amount, List<Map<String, Object?>> lines, int base, bool withOption, int recurring}) _price(
      Map<String, int> v, int staff, String period, bool cascade, ({int prorataDays, int monthDays, DateTime periodStart, DateTime periodEnd, DateTime coverFrom}) p,
      {bool api = false, int proKeys = 0}) {
    final withOption = cascade && staff < v['cascadeIncludedFrom']!;
    final pro = proKeys > 0;
    final proPrice = pro ? proUnit(v, proKeys) : 0;
    final base = PlatformService.monthlyCents(v, staff);
    final option = withOption ? v['cascadeOptionPrice']! : 0;
    final apiPrice = api ? v['apiOptionPrice']! : 0;
    final prorataApi = _prorata(apiPrice, p.prorataDays, p.monthDays);
    final months = period == 'year' ? 12 : 1;
    final baseAmount = period == 'year' ? base * v['annualMonths']! : base;
    final prorataBase = _prorata(base, p.prorataDays, p.monthDays);
    final prorataOption = _prorata(option, p.prorataDays, p.monthDays);
    final lines = <Map<String, Object?>>[
      if (prorataBase > 0)
        {'label': 'prorata', 'staff': staff, 'slots': staff, 'days': p.prorataDays, 'monthDays': p.monthDays, 'cents': prorataBase},
      if (prorataOption > 0)
        {'label': 'cascadeProrata', 'days': p.prorataDays, 'monthDays': p.monthDays, 'cents': prorataOption},
      {
        'label': 'subscription',
        'staff': staff,
        'slots': staff,
        'period': period,
        'unitCents': base,
        'months': months,
        'paidMonths': period == 'year' ? v['annualMonths'] : 1,
        'cents': baseAmount,
      },
      if (withOption) {'label': 'cascade', 'unitCents': option, 'months': months, 'cents': option * months},
      if (prorataApi > 0) {'label': 'apiProrata', 'days': p.prorataDays, 'monthDays': p.monthDays, 'cents': prorataApi},
      if (api) {'label': 'api', 'unitCents': apiPrice, 'months': months, 'cents': apiPrice * months},
      if (pro) {'label': 'pro', 'keys': proKeys, 'unitCents': proPrice, 'months': months, 'cents': proPrice * months},
    ];
    return (
      amount: lines.fold(0, (s, l) => s + (l['cents'] as int)),
      lines: lines,
      base: base,
      withOption: withOption,
      recurring: baseAmount + (option + apiPrice + proPrice) * months,
    );
  }

  /// Nombre de places valable : par tranches de 10, de 10 à 5000, et au
  /// moins l'effectif actuel ([staff]).
  static int checkSlots(int? slots, int staff) {
    if (slots == null || slots < 10 || slots > 5000 || slots % 10 != 0) {
      throw const ApiError.badRequest('Places : de 10 à 5000, par tranches de 10.');
    }
    if (slots < staff) {
      throw ApiError.badRequest('Places : au moins {count}, l\'effectif actuel.', {'count': '${minSlots(staff)}'});
    }
    return slots;
  }

  /// Le plus petit nombre de places qui couvre [staff] personnes.
  static int minSlots(int staff) => staff <= 10 ? 10 : (staff + 9) ~/ 10 * 10;

  Future<Map<String, Object?>> summary(User actor, String companyId, {int? slots}) async {
    final company = await _owned(actor, companyId);
    final v = await platform.values();
    final realStaff = await staffCount(companyId);
    // Prix sur les places (choisies, sinon celles de l'entreprise).
    final staff = slots == null ? max(company.slots, minSlots(realStaff)) : checkSlots(slots, realStaff);
    final invoices = await store.query(store.db, '''
      SELECT id, number, issued_at, period, period_start, period_end, amount_cents
      FROM invoices WHERE company_id = @c::uuid ORDER BY id DESC''', {'c': companyId});
    final month = _plan(company, 'month');
    int due(String period, bool cascade) => _price(v, staff, period, cascade, _plan(company, period)).amount;
    // Détail de chaque formule, montré avant le paiement.
    Map<String, Object?> quote(String period, bool cascade, [bool api = false]) {
      final plan = _plan(company, period);
      final price = _price(v, staff, period, cascade, plan, api: api);
      return {
        'lines': price.lines,
        'total': price.amount,
        'price': price.recurring,
        'from': plan.coverFrom.toIso8601String(),
        'to': plan.periodEnd.toIso8601String(),
      };
    }
    return {
      ...company.billingJson(),
      'publicId': company.publicId,
      'staff': realStaff,
      'slotsChosen': staff,
      'minSlots': minSlots(realStaff),
      'seatLimit': company.billingStatus == 'comped' ? null : CompanyService.seatLimit(company.slots),
      'cascadeIncludedFrom': v['cascadeIncludedFrom'],
      'annualMonths': v['annualMonths'],
      'prices': {
        'month': PlatformService.monthlyCents(v, staff),
        'year': PlatformService.annualCents(v, staff),
        'monthCascade': PlatformService.monthlyCents(v, staff, cascade: true),
        'yearCascade': PlatformService.annualCents(v, staff, cascade: true),
      },
      // À payer aujourd'hui (prorata du mois en cours compris).
      'dueNow': {
        'month': due('month', false),
        'year': due('year', false),
        'monthCascade': due('month', true),
        'yearCascade': due('year', true),
      },
      'quotes': {
        'month': quote('month', false),
        'year': quote('year', false),
        'monthCascade': quote('month', true),
        'yearCascade': quote('year', true),
      },
      // Toutes les combinaisons : « période-cascade-api », par exemple « year-1-0 ».
      'offers': {
        for (final p in ['month', 'year'])
          for (final c in [false, true])
            for (final x in [false, true]) '$p-${c ? 1 : 0}-${x ? 1 : 0}': quote(p, c, x),
      },
      'apiOption': company.apiOption,
      'apiOptionPrice': v['apiOptionPrice'],
      'apiProOption': company.apiProOption,
      'apiProPrice': v['apiProPrice'],
      'apiPro10Price': v['apiPro10Price'],
      'apiProKeys': company.apiProKeys,
      'apiProNextKeys': (await store.query(store.db, 'SELECT api_pro_next_keys FROM companies WHERE id = @c::uuid',
              {'c': companyId}))
          .first[0],
      'apiKeyCount': (await store.query(store.db, '''
          SELECT count(*) FROM api_keys WHERE company_id = @c::uuid AND revoked_at IS NULL AND disabled_at IS NULL''',
              {'c': companyId}))
          .first[0],
      'apiKeyLimit': ApiAccessService.keyLimit(company),
      'cascadeOptionPrice': v['cascadeOptionPrice'],
      ...await _renewals(companyId),
      // Options à ajouter seules, en cours d'abonnement.
      'addons': {
        for (final o in ['api', 'pro', 'pro10', 'cascade']) o: _addon(company, v, staff, o),
        'slots': _addon(company, v, staff, 'slots', slots: staff),
      },
      'isOwner': (await companies.open(actor, companyId)).$2 == Role.owner,
      'prorataDays': month.prorataDays,
      'canPay': canPay(actor),
      'testPayments': true,
      'invoices': [for (final r in invoices) _invoiceJson(r)],
    };
  }

  static Map<String, Object?> _invoiceJson(List<Object?> r) => {
        'id': r[0],
        'number': r[1],
        'issuedAt': (r[2] as DateTime).toIso8601String(),
        'period': r[3],
        'from': (r[4] as DateTime).toIso8601String(),
        'to': (r[5] as DateTime).toIso8601String(),
        'amountCents': r[6],
      };

  static DateTime _addMonths(DateTime d, int months) {
    final m = d.month - 1 + months;
    final y = d.year + m ~/ 12;
    final month = m % 12 + 1;
    final last = DateTime.utc(y, month + 1, 0).day;
    return DateTime.utc(y, month, d.day > last ? last : d.day, d.hour, d.minute, d.second);
  }

  /// Paiement (fictif pour l'instant) d'un mois ou d'une année civile, avec
  /// le prorata du mois en cours (voir [_plan]) ; le prix est calculé avec
  /// les tarifs et l'effectif du moment ; l'entreprise redevient modifiable ;
  /// une facture est créée, numérotée par entreprise et par année.
  Future<Map<String, Object?>> checkout(User actor, String companyId,
      {required String period, required bool cascade, bool? api, int? slots}) async {
    final company = await _owned(actor, companyId);
    if (!canPay(actor)) throw const ApiError.conflict('Le paiement en ligne arrive bientôt.');
    if (period != 'month' && period != 'year') throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    if (company.billingStatus == 'comped') throw const ApiError.conflict('Cette entreprise est offerte : rien à payer.');
    final v = await platform.values();
    // Places payées : choisies, sinon celles de l'entreprise (au moins l'effectif).
    final realStaff = await staffCount(companyId);
    final staff = checkSlots(slots ?? (company.slots < realStaff ? minSlots(realStaff) : company.slots), realStaff);
    final plan = _plan(company, period);
    // Sans précision (anciennes versions de l'application) : l'option API reste comme elle est.
    final withPro = company.apiProOption && await _renews(companyId, 'api_pro_until') && company.billingStatus == 'active';
    final next = (await store.query(store.db, 'SELECT api_pro_next_keys FROM companies WHERE id = @c::uuid', {'c': companyId}))
        .first[0] as int?;
    final proKeys = withPro ? (next ?? company.apiProKeys) : 0;
    // La lecture est comprise dans « API Pro ».
    final withApi = (api ?? company.apiOption) && !withPro;
    final price = _price(v, staff, period, cascade, plan, api: withApi, proKeys: proKeys);
    final t = now();
    final owner = await store.findUser(actor.id);
    final seller = await platform.texts();
    return store.db.runTx((tx) async {
      // Numéro : SF-<identifiant de l'entreprise>-<année>-<n° dans l'année>.
      await store.query(tx, 'SELECT 1 FROM companies WHERE id = @c::uuid FOR UPDATE', {'c': companyId});
      final count = await store.query(tx, '''
        SELECT count(*) FROM invoices WHERE company_code = @k AND extract(year FROM issued_at) = @y''',
          {'k': company.publicId, 'y': t.year});
      final number = 'SF-${company.publicId}-${t.year}-${((count.first[0] as num).toInt() + 1).toString().padLeft(4, '0')}';
      final rows = await store.query(tx, '''
        INSERT INTO invoices (number, company_id, company_code, company_name, owner_id, owner_name, issued_at,
          period, period_start, period_end, staff, lines, amount_cents, provider, paid_at, seller)
        VALUES (@n, @c::uuid, @k, @cn, @o::uuid, @on, @t, @p, @f, @to, @s, @l::jsonb, @a, 'test', @t, @sel::jsonb)
        RETURNING id''', {
        'n': number,
        'c': companyId,
        'k': company.publicId,
        'cn': company.name,
        'o': actor.id,
        'on': owner?.name,
        't': t,
        'p': period,
        'f': plan.coverFrom,
        'to': plan.periodEnd,
        's': staff,
        'l': jsonEncode(price.lines),
        'a': price.amount,
        'sel': jsonEncode(seller),
      });
      // Option prise : active et renouvelée. Option laissée pendant un
      // renouvellement : elle reste jusqu'à la fin de la période déjà payée.
      final renewal = company.paidUntil != null && company.paidUntil!.isAfter(t) && company.billingStatus == 'active';
      await store.query(tx, '''
        UPDATE companies SET billing_status = 'active', paid_until = @to, grace_ends_at = NULL, status = 'active',
          billing_period = @p, billing_reminders = '{}', slots = @slots,
          cascade_option = @co OR (@renewal AND cascade_option),
          cascade_until = CASE WHEN @co THEN NULL WHEN @renewal AND cascade_option THEN coalesce(cascade_until, @old::timestamptz) END,
          api_option = @ao OR (@renewal AND api_option),
          api_until = CASE WHEN @ao THEN NULL WHEN @renewal AND api_option THEN coalesce(api_until, @old::timestamptz) END,
          api_pro_keys = CASE WHEN @pk > 0 THEN @pk ELSE api_pro_keys END,
          api_pro_next_keys = CASE WHEN @pk > 0 THEN NULL ELSE api_pro_next_keys END
        WHERE id = @c::uuid''', {
        'pk': proKeys,
        'c': companyId,
        'to': plan.periodEnd,
        'p': period,
        'co': price.withOption,
        'ao': withApi,
        'renewal': renewal,
        'old': company.paidUntil,
        'slots': staff,
      });
      await store.audit(
          companyId: companyId,
          actorId: actor.id,
          action: 'billing.paid',
          details: {'invoice': number, 'amountCents': price.amount, 'period': period, 'provider': 'test'},
          tx: tx);
      return {
        'id': rows.first[0],
        'number': number,
        'amountCents': price.amount,
        'paidUntil': plan.periodEnd.toIso8601String(),
      };
    }).then((r) async {
      // Formule réduite au renouvellement : clés en trop désactivées.
      await _enforceKeys(companyId);
      return r;
    });
  }

  /// L'option « sites en cascade » est-elle ouverte ? (Essai et entreprise
  /// offerte : tout est ouvert.)
  Future<bool> cascadeAllowed(String companyId) async {
    final c = await store.findCompany(companyId);
    if (c == null) return false;
    if (c.billingStatus == 'trial' || c.billingStatus == 'comped' || c.cascadeOption) return true;
    return c.slots >= await platform.value('cascadeIncludedFrom');
  }

  // --- Factures -------------------------------------------------------------

  /// Lien de téléchargement (10 minutes) d'une facture de l'entreprise, pour
  /// son propriétaire actuel : un nouveau propriétaire retrouve tout
  /// l'historique. [lang] : langue de l'application (la facture est aussi en anglais).
  Future<String> invoiceLink(User actor, String companyId, int invoiceId, String lang) async {
    await _owned(actor, companyId);
    final rows = await store.query(store.db,
        'SELECT 1 FROM invoices WHERE id = @i AND company_id = @c::uuid', {'i': invoiceId, 'c': companyId});
    if (rows.isEmpty) throw const ApiError.notFound();
    return _sign({'i': invoiceId, 'l': lang}, actor);
  }

  /// Facture d'une entreprise fermée, pour son dernier propriétaire.
  Future<String> archivedInvoiceLink(User actor, int invoiceId, String lang) async {
    final rows = await store.query(store.db,
        'SELECT 1 FROM invoices WHERE id = @i AND company_id IS NULL AND holder_id = @u::uuid',
        {'i': invoiceId, 'u': actor.id});
    if (rows.isEmpty) throw const ApiError.notFound();
    return _sign({'i': invoiceId, 'l': lang}, actor);
  }

  /// Administration : n'importe quelle facture (par exemple pour un ancien
  /// patron qui a supprimé son compte et prouve qu'il était propriétaire).
  String adminInvoiceLink(User admin, int invoiceId, String lang) => _sign({'i': invoiceId, 'l': lang, 'a': true}, admin);

  /// Toutes les factures d'une entreprise ([companyId]), ou celles des
  /// entreprises fermées de la personne (`null`), dans un fichier ZIP.
  Future<String> zipLink(User actor, String? companyId, String lang) async {
    if (companyId != null) await _owned(actor, companyId);
    return _sign({'z': companyId ?? '', 'l': lang}, actor);
  }

  String _sign(Map<String, Object?> claims, User actor) =>
      JWT(claims, subject: actor.id, issuer: 'staff-flow-invoice').sign(_key, expiresIn: const Duration(minutes: 10));

  static const _columns = '''number, company_name, owner_name, company_code, issued_at, period, period_start,
    period_end, staff, lines, amount_cents, provider, seller, company_id::text, holder_id::text''';

  Future<(Map, User)> _verify(String token) async {
    final JWT jwt;
    try {
      jwt = JWT.verify(token, _key, issuer: 'staff-flow-invoice');
    } on JWTException {
      throw const ApiError.notFound('Lien expiré.');
    }
    final user = await store.findActiveUser(jwt.subject!);
    if (user == null) throw const ApiError.notFound('Lien expiré.');
    return (jwt.payload as Map, user);
  }

  /// Les droits sont revérifiés à chaque téléchargement : propriétaire
  /// actuel de l'entreprise ; une fois l'entreprise fermée, son dernier
  /// propriétaire ; ou l'administration.
  Future<bool> _canRead(User user, List<Object?> r, {bool admin = false}) async {
    if (admin) return isAdmin(user);
    final companyId = r[13] as String?;
    if (companyId != null) return _billingAccess(companyId, user.id);
    return r[14] == user.id;
  }

  Future<Uint8List> _render(List<Object?> r, String lang) async =>
      renderInvoice([...r.sublist(0, 12), r[12] ?? await platform.texts()], lang);

  Future<(String, Uint8List)> invoicePdf(String token) async {
    final (claims, user) = await _verify(token);
    if (claims['i'] == null) throw const ApiError.notFound('Lien expiré.');
    final rows = await store.query(store.db, 'SELECT $_columns FROM invoices WHERE id = @i', {'i': claims['i']});
    if (rows.isEmpty || !await _canRead(user, rows.first, admin: claims['a'] == true)) {
      throw const ApiError.notFound('Lien expiré.');
    }
    final r = rows.first;
    return ('${r[0]}.pdf', await _render(r, claims['l'] as String? ?? 'en'));
  }

  Future<(String, Uint8List)> invoiceZip(String token) async {
    final (claims, user) = await _verify(token);
    final companyId = claims['z'] as String?;
    if (companyId == null) throw const ApiError.notFound('Lien expiré.');
    final rows = companyId.isEmpty
        ? await store.query(store.db,
            'SELECT $_columns FROM invoices WHERE company_id IS NULL AND holder_id = @u::uuid ORDER BY id', {'u': user.id})
        : await store.query(store.db,
            'SELECT $_columns FROM invoices WHERE company_id = @c::uuid ORDER BY id', {'c': companyId});
    final archive = Archive();
    for (final r in rows) {
      if (!await _canRead(user, r)) throw const ApiError.notFound('Lien expiré.');
      final pdf = await _render(r, claims['l'] as String? ?? 'en');
      archive.addFile(ArchiveFile('${r[0]}.pdf', pdf.length, pdf));
    }
    final name = companyId.isEmpty || rows.isEmpty ? 'staff-flow-invoices.zip' : 'SF-${rows.first[3]}-invoices.zip';
    return (name, Uint8List.fromList(ZipEncoder().encode(archive)!));
  }

  /// Factures des entreprises fermées dont la personne était le dernier propriétaire.
  Future<List<Map<String, Object?>>> archivedInvoices(User user) async {
    final rows = await store.query(store.db, '''
      SELECT id, number, issued_at, period, period_start, period_end, amount_cents, company_name, company_code
      FROM invoices WHERE company_id IS NULL AND holder_id = @u::uuid ORDER BY id DESC''', {'u': user.id});
    return [
      for (final r in rows) {..._invoiceJson(r), 'companyName': r[7], 'companyCode': r[8]},
    ];
  }

  /// Administration : factures d'une entreprise (ouverte ou fermée), par son identifiant.
  Future<List<Map<String, Object?>>> adminInvoices(String code) async {
    final rows = await store.query(store.db, '''
      SELECT i.id, i.number, i.issued_at, i.period, i.period_start, i.period_end, i.amount_cents, i.company_name,
        i.company_code, i.owner_name, i.company_id IS NULL, i.provider
      FROM invoices i WHERE i.company_code = @k ORDER BY i.id DESC''', {'k': code.trim().toUpperCase()});
    return [
      for (final r in rows)
        {..._invoiceJson(r), 'companyName': r[7], 'companyCode': r[8], 'ownerName': r[9], 'closed': r[10], 'provider': r[11]},
    ];
  }

  static pw.Font? _regular, _bold;
  static pw.MemoryImage? _logo;

  static String _assets() => Directory('/app/assets').existsSync() ? '/app/assets' : 'assets';

  /// Polices DejaVu Sans (libres, cyrillique compris), livrées avec le serveur.
  static pw.Font _loadFont(String file) =>
      pw.Font.ttf(ByteData.sublistView(File('${_assets()}/$file').readAsBytesSync()));

  static String _eur(int cents) => '${(cents / 100).toStringAsFixed(2).replaceAll('.', ',')} €';
  static String _day(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  /// Contact public de l'éditeur (redirection : l'adresse personnelle n'apparaît jamais).
  static const contactEmail = 'contact@staff-flow.cloud';

  /// Facture dans la langue de l'application du propriétaire, doublée en
  /// anglais. [r] : number, company_name, owner_name, company_code, issued_at,
  /// period, period_start, period_end, staff, lines, amount_cents, provider,
  /// seller (textes de l'éditeur, voir [PlatformService.textKeys]).
  static Future<Uint8List> renderInvoice(List<Object?> r, String lang) async {
    // Chaque texte : dans la langue choisie, puis en anglais.
    String t(String fr, [Map<String, String> args = const {}]) {
      final en = translate(fr, 'en', args);
      final mine = translate(fr, lang, args);
      return lang == 'en' || mine == en ? en : '$mine / $en';
    }

    final font = _regular ??= _loadFont('DejaVuSans.ttf');
    final logo = _logo ??= pw.MemoryImage(File('${_assets()}/logo.png').readAsBytesSync());
    final bold = _bold ??= _loadFont('DejaVuSans-Bold.ttf');
    final navy = PdfColor.fromHex('#061440');
    final blue = PdfColor.fromHex('#1A8CFC');
    final grey = PdfColor.fromHex('#55607A');
    final lines = (r[9] as List).cast<Map>();
    final test = r[11] == 'test';
    final seller = (r[12] as Map? ?? const {}).cast<String, Object?>();
    String sel(String k) => (seller[k] as String? ?? '').trim();
    final small = pw.TextStyle(fontSize: 8.5, color: grey);
    final doc = pw.Document(theme: pw.ThemeData.withFont(base: font, bold: bold));
    pw.Widget cell(String s, {bool strong = false, pw.TextAlign align = pw.TextAlign.left, PdfColor? color}) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: pw.Text(s,
            textAlign: align,
            style: pw.TextStyle(fontSize: 9.5, fontWeight: strong ? pw.FontWeight.bold : null, color: color)));
    String label(Map l) => switch (l['label']) {
          'prorata' when l['slots'] != null => t('Prorata du mois en cours ({days} jours sur {total}) : abonnement, {slots} places',
              {'days': '${l['days']}', 'total': '${l['monthDays']}', 'slots': '${l['slots']}'}),
          'prorata' => t('Prorata du mois en cours ({days} jours sur {total}) : abonnement, {staff} salariés',
              {'days': '${l['days']}', 'total': '${l['monthDays']}', 'staff': '${l['staff']}'}),
          'slotsAddon' => t('Places ajoutées en cours d\'abonnement, de {from} à {to} places, du {start} au {end} : {months} mois', {
              'from': '${l['slotsFrom']}',
              'to': '${l['slots']}',
              'start': _day(DateTime.parse(l['from'] as String)),
              'end': _day(DateTime.parse(l['to'] as String).subtract(const Duration(days: 1))),
              'months': '${l['months']}',
            }),
          'cascadeProrata' => t('Prorata du mois en cours ({days} jours sur {total}) : option « sites en cascade »',
              {'days': '${l['days']}', 'total': '${l['monthDays']}'}),
          'cascade' => t('Option « sites en cascade » : {months} mois', {'months': '${l['months']}'}),
          'apiProrata' => t('Prorata du mois en cours ({days} jours sur {total}) : option « accès API »',
              {'days': '${l['days']}', 'total': '${l['monthDays']}'}),
          'api' => t('Option « accès API » : {months} mois', {'months': '${l['months']}'}),
          'pro' => t('Option « API Pro » : {months} mois', {'months': '${l['months']}'}),
          'pro10Addon' => t('Option « API Pro » : 10 clés, ajoutée en cours d\'abonnement, du {from} au {to} : {months} mois, sans remise', {
              'from': _day(DateTime.parse(l['from'] as String)),
              'to': _day(DateTime.parse(l['to'] as String).subtract(const Duration(days: 1))),
              'months': '${l['months']}',
            }),
          'pro10Upgrade' => t('Passage de « API Pro » à 10 clés, du {from} au {to} : {months} mois (différence de prix), sans remise', {
              'from': _day(DateTime.parse(l['from'] as String)),
              'to': _day(DateTime.parse(l['to'] as String).subtract(const Duration(days: 1))),
              'months': '${l['months']}',
            }),
          'proAddon' => t('Option « API Pro », ajoutée en cours d\'abonnement, du {from} au {to} : {months} mois', {
              'from': _day(DateTime.parse(l['from'] as String)),
              'to': _day(DateTime.parse(l['to'] as String).subtract(const Duration(days: 1))),
              'months': '${l['months']}',
            }),
          'apiAddon' => t('Option « accès API », ajoutée en cours d\'abonnement, du {from} au {to} : {months} mois',
              {'from': _day(DateTime.parse(l['from'] as String)), 'to': _day(DateTime.parse(l['to'] as String).subtract(const Duration(days: 1))), 'months': '${l['months']}'}),
          'cascadeAddon' => t('Option « sites en cascade », ajoutée en cours d\'abonnement, du {from} au {to} : {months} mois',
              {'from': _day(DateTime.parse(l['from'] as String)), 'to': _day(DateTime.parse(l['to'] as String).subtract(const Duration(days: 1))), 'months': '${l['months']}'}),
          _ when l['slots'] != null => l['period'] == 'year'
              ? t('Abonnement Staff Flow, {slots} places : 12 mois, {paid} facturés',
                  {'slots': '${l['slots']}', 'paid': '${l['paidMonths']}'})
              : t('Abonnement Staff Flow, {slots} places : 1 mois', {'slots': '${l['slots']}'}),
          _ => l['period'] == 'year'
              ? t('Abonnement Staff Flow, {staff} salariés : 12 mois, {paid} facturés',
                  {'staff': '${l['staff']}', 'paid': '${l['paidMonths']}'})
              : t('Abonnement Staff Flow, {staff} salariés : 1 mois', {'staff': '${l['staff']}'}),
        };
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (_) => pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Row(children: [
            pw.ClipRRect(horizontalRadius: 9, verticalRadius: 9, child: pw.Image(logo, width: 46, height: 46)),
            pw.SizedBox(width: 10),
            pw.RichText(
                text: pw.TextSpan(style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold), children: [
              pw.TextSpan(text: 'Staff', style: pw.TextStyle(color: navy)),
              pw.TextSpan(text: 'Flow', style: pw.TextStyle(color: blue)),
            ])),
          ]),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            pw.Text(t('FACTURE'), style: pw.TextStyle(fontSize: 14, color: blue)),
            pw.Text('${r[0]}', style: const pw.TextStyle(fontSize: 12)),
            pw.Text(t('Date : {date}', {'date': _day(r[4] as DateTime)}), style: pw.TextStyle(fontSize: 9, color: grey)),
          ]),
        ]),
        if (test) ...[
          pw.SizedBox(height: 12),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(8),
            color: PdfColor.fromHex('#FFF3CD'),
            child: pw.Text(t('EXEMPLE : paiement de test, aucun montant prélevé.'), style: const pw.TextStyle(fontSize: 9.5)),
          ),
        ],
        pw.SizedBox(height: 24),
        pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Expanded(
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Text(t('Émetteur'), style: pw.TextStyle(fontSize: 8.5, color: grey)),
              pw.Text(sel('sellerName').isEmpty ? 'Vercane' : sel('sellerName'), style: const pw.TextStyle(fontSize: 11)),
              for (final k in ['sellerAddressLatin', 'sellerAddressLocal'])
                if (sel(k).isNotEmpty) pw.Text(sel(k), style: small),
              if (sel('sellerRegistration').isNotEmpty)
                pw.Text(t('N° d\'enregistrement : {id}', {'id': sel('sellerRegistration')}), style: small),
              pw.Text('$contactEmail · https://staff-flow.cloud', style: small),
            ]),
          ),
          pw.SizedBox(width: 16),
          pw.Expanded(
            child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Text(t('Client'), style: pw.TextStyle(fontSize: 8.5, color: grey)),
              pw.Text('${r[1]}', style: const pw.TextStyle(fontSize: 11)),
              pw.Text(t('Entreprise n° {id}', {'id': '${r[3]}'}), style: pw.TextStyle(fontSize: 8.5, color: grey)),
              if (r[2] != null) pw.Text('${r[2]}', style: pw.TextStyle(fontSize: 8.5, color: grey)),
            ]),
          ),
        ]),
        pw.SizedBox(height: 16),
        pw.Text(t('Période : {from} – {to}', {'from': _day(r[6] as DateTime), 'to': _day((r[7] as DateTime).subtract(const Duration(days: 1)))}),
            style: const pw.TextStyle(fontSize: 9.5)),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder(horizontalInside: pw.BorderSide(color: PdfColor.fromHex('#E3E8F2'))),
          columnWidths: {0: const pw.FlexColumnWidth(3), 1: const pw.FlexColumnWidth(1)},
          children: [
            pw.TableRow(decoration: pw.BoxDecoration(color: navy), children: [
              cell(t('Désignation'), strong: true, color: PdfColors.white),
              cell(t('Montant'), strong: true, align: pw.TextAlign.right, color: PdfColors.white),
            ]),
            for (final l in lines)
              pw.TableRow(children: [cell(label(l)), cell(_eur(l['cents'] as int), align: pw.TextAlign.right)]),
            pw.TableRow(children: [
              cell(t('Total TTC'), strong: true),
              cell(_eur(r[10] as int), strong: true, align: pw.TextAlign.right),
            ]),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Text(t('Payé.'), style: small),
        if (sel('sellerTax').isNotEmpty) pw.Text(sel('sellerTax'), style: small),
        pw.Spacer(),
        pw.Text(t('Aucun remboursement d\'une période payée.'), style: pw.TextStyle(fontSize: 8, color: grey)),
      ]),
    ));
    return doc.save();
  }

  // --- Échéances (toutes les quelques minutes) ------------------------------

  /// Essai ou période payée terminée : lecture seule et compte à rebours ;
  /// rappels au propriétaire ; suppression à la fin de la période de grâce.
  Future<void> tick() async {
    final t = now();
    // Options non renouvelées : retirées à la fin de leur période.
    await store.query(store.db, '''
      UPDATE companies SET api_option = false, api_until = NULL WHERE api_until <= @t''', {'t': t});
    await store.query(store.db, '''
      UPDATE companies SET api_pro_option = false, api_pro_until = NULL, api_pro_next_keys = NULL
      WHERE api_pro_until <= @t''', {'t': t});
    await store.query(store.db, '''
      UPDATE companies SET cascade_option = false, cascade_until = NULL WHERE cascade_until <= @t''', {'t': t});
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
      final paid = (await store.query(store.db, 'SELECT 1 FROM invoices WHERE company_id = @c::uuid LIMIT 1', {'c': r[0]}))
          .isNotEmpty;
      if (!paid) {
        // Jamais payée (essai seulement) : tout disparaît, journal compris.
        await store.db.runTx((tx) async {
          await store.query(tx, 'DELETE FROM audit_log WHERE company_id = @c::uuid', {'c': r[0]});
          await store.query(tx, "DELETE FROM audit_log WHERE details->>'companyId' = @c", {'c': r[0]});
          await store.query(tx, 'DELETE FROM companies WHERE id = @c::uuid', {'c': r[0]});
        });
        if (r[2] != null) await notifications.notify([r[2] as String], kind: 'billing_deleted', data: {'companyName': r[1]});
        continue;
      }
      await store.query(store.db, 'UPDATE invoices SET holder_id = @u::uuid WHERE company_id = @c::uuid',
          {'c': r[0], 'u': r[2]});
      await store.query(store.db, 'DELETE FROM companies WHERE id = @c::uuid', {'c': r[0]});
      if (r[2] != null) {
        await store.audit(actorId: r[2] as String, action: 'billing.deleted', details: {'companyId': r[0], 'name': r[1]});
        await notifications.notify([r[2] as String], kind: 'billing_deleted', data: {'companyName': r[1]});
      }
    }
    await _apiKeysTick(t);
    // Factures des entreprises fermées : gardées la durée légale, puis effacées.
    await store.query(store.db, '''
      DELETE FROM invoices WHERE company_id IS NULL AND issued_at < @t::timestamptz - make_interval(years => @y)''',
        {'t': t, 'y': v['invoiceRetentionYears']});
  }

  static String _iso(DateTime d) => d.toIso8601String().substring(0, 10);

  Future<void> _toOwner(String companyId, String kind, Map<String, Object?> data) async {
    final rows = await store.query(store.db, '''
      SELECT user_id::text FROM memberships
      WHERE company_id = @c::uuid AND (role = 'owner' OR billing_access) AND left_at IS NULL''',
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

  /// Suppression d'une entreprise par l'administration (essais, tests) :
  /// [confirm] doit reprendre son nom exact. Les factures déjà émises sont
  /// gardées au nom du patron (durée légale), comme à la fin d'une période
  /// de grâce ; une entreprise jamais payée disparaît entièrement.
  Future<void> adminDelete(User admin, String companyId, String confirm) async {
    final rows = await store.query(store.db, '''
      SELECT c.name, m.user_id::text FROM companies c
      LEFT JOIN memberships m ON m.company_id = c.id AND m.role = 'owner' AND m.left_at IS NULL
      WHERE c.id::text = @c''', {'c': companyId});
    if (rows.isEmpty) throw const ApiError.notFound();
    final name = rows.first[0] as String, owner = rows.first[1] as String?;
    if (confirm.trim() != name) throw const ApiError.badRequest('Le nom tapé ne correspond pas.');
    final paid = (await store.query(store.db, 'SELECT 1 FROM invoices WHERE company_id = @c::uuid LIMIT 1', {'c': companyId}))
        .isNotEmpty;
    await store.db.runTx((tx) async {
      if (paid) {
        await store.query(tx, 'UPDATE invoices SET holder_id = @u::uuid WHERE company_id = @c::uuid', {'c': companyId, 'u': owner});
      } else {
        await store.query(tx, 'DELETE FROM audit_log WHERE company_id = @c::uuid', {'c': companyId});
        await store.query(tx, "DELETE FROM audit_log WHERE details->>'companyId' = @c", {'c': companyId});
      }
      await store.query(tx, 'DELETE FROM companies WHERE id = @c::uuid', {'c': companyId});
      await store.audit(actorId: admin.id, action: 'admin.company_deleted', details: {'name': name}, tx: tx);
    });
  }

  Future<List<Map<String, Object?>>> adminCompanies() async {
    final rows = await store.query(store.db, '''
      SELECT c.id::text, c.name, c.billing_status, c.trial_ends_at, c.paid_until, c.grace_ends_at, u.email, c.public_id,
        (SELECT count(*) FROM memberships m2 WHERE m2.company_id = c.id AND m2.left_at IS NULL
           AND m2.role IN ('manager', 'employee')) AS staff
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
          'publicId': r[7],
          'staff': (r[8] as num).toInt(),
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
