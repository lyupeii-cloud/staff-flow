import 'dart:convert';
import 'dart:io';

import 'errors.dart';
import 'models.dart';
import 'store.dart';

/// Nature d'un réglage : un montant en centimes d'euro, un nombre entier ou
/// un pourcentage entier.
enum SettingKind { cents, count, percent }

/// Un réglage de la plateforme, avec ses limites.
class SettingDef {
  final String key;
  final String group;
  final SettingKind kind;
  final int value;
  final int min;
  final int max;

  const SettingDef(this.key, this.group, this.kind, this.value, this.min, this.max);
}

/// Réglages de la plateforme (section 10 du cahier des charges) : tout ce
/// qui influe sur les prix se règle sans toucher au code.
///
/// Les valeurs par défaut sont celles ci-dessous, éventuellement remplacées
/// au démarrage par le fichier `PLATFORM_CONFIG` (JSON `{clé: valeur}`).
/// L'administration les modifie ensuite en direct (table `platform_settings`),
/// en priorité sur le fichier ; « revenir à la valeur du fichier » efface la
/// modification. Chaque changement est inscrit au journal.
class PlatformService {
  final Store store;
  final Map<String, int> fileValues;

  PlatformService(this.store, {Map<String, int>? fileValues})
      : fileValues = {for (final d in defs) d.key: d.value, ...?fileValues};

  /// Grille adoptée le 11 octobre 2026.
  static const defs = [
    SettingDef('basePrice', 'pricing', SettingKind.cents, 300, 0, 100000),
    SettingDef('includedStaff', 'pricing', SettingKind.count, 10, 1, 10000),
    SettingDef('tierSize', 'pricing', SettingKind.count, 10, 1, 1000),
    SettingDef('tier1Price', 'pricing', SettingKind.cents, 100, 0, 100000),
    SettingDef('tier1End', 'pricing', SettingKind.count, 50, 1, 100000),
    SettingDef('tier2Price', 'pricing', SettingKind.cents, 80, 0, 100000),
    SettingDef('tier2End', 'pricing', SettingKind.count, 100, 1, 100000),
    SettingDef('tier3Price', 'pricing', SettingKind.cents, 50, 0, 100000),
    SettingDef('annualMonths', 'pricing', SettingKind.count, 10, 1, 12),
    SettingDef('cascadeOptionPrice', 'options', SettingKind.cents, 200, 0, 100000),
    SettingDef('cascadeIncludedFrom', 'options', SettingKind.count, 101, 1, 100000),
    SettingDef('adRemovalPrice', 'options', SettingKind.cents, 120, 0, 100000),
    SettingDef('extrasIncluded', 'extras', SettingKind.count, 1, 0, 1000),
    SettingDef('extrasPercent', 'extras', SettingKind.percent, 20, 0, 100),
    SettingDef('extraMinDays', 'extras', SettingKind.count, 30, 0, 365),
    SettingDef('trialDays', 'durations', SettingKind.count, 2, 0, 90),
    SettingDef('graceDays', 'durations', SettingKind.count, 15, 0, 90),
    SettingDef('priceNoticeDays', 'durations', SettingKind.count, 30, 0, 365),
  ];

  static SettingDef? def(String key) => defs.where((d) => d.key == key).firstOrNull;

  /// Fichier de valeurs par défaut (facultatif) ; une clé inconnue ou une
  /// valeur hors limites arrête le démarrage, pour ne pas facturer faux.
  static Map<String, int> readFile(String path) {
    final raw = jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
    final out = <String, int>{};
    for (final e in raw.entries) {
      final d = def(e.key);
      final v = e.value;
      if (d == null || v is! int || v < d.min || v > d.max) {
        throw FormatException('PLATFORM_CONFIG : réglage invalide « ${e.key} ».');
      }
      out[e.key] = v;
    }
    return out;
  }

  Map<String, int>? _overrides;

  Future<Map<String, int>> _loadOverrides() async {
    final rows = await store.query(store.db, 'SELECT key, value FROM platform_settings');
    return _overrides = {
      for (final r in rows)
        if (def(r[0] as String) != null) r[0] as String: r[1] as int,
    };
  }

  /// Valeurs en vigueur.
  Future<Map<String, int>> values() async {
    final over = _overrides ?? await _loadOverrides();
    return {...fileValues, ...over};
  }

  Future<int> value(String key) async => (await values())[key]!;

  /// Pour la page d'administration : chaque réglage, sa valeur, celle du
  /// fichier, et s'il a été modifié.
  Future<List<Map<String, Object?>>> list() async {
    final over = _overrides ?? await _loadOverrides();
    return [
      for (final d in defs)
        {
          'key': d.key,
          'group': d.group,
          'kind': d.kind.name,
          'value': over[d.key] ?? fileValues[d.key],
          'fileValue': fileValues[d.key],
          'overridden': over.containsKey(d.key),
          'min': d.min,
          'max': d.max,
        },
    ];
  }

  /// Modifie un réglage (ou revient à la valeur du fichier avec `null`).
  Future<void> set(User admin, String key, int? value) async {
    final d = def(key);
    if (d == null) throw const ApiError.notFound();
    if (value != null && (value < d.min || value > d.max)) {
      throw ApiError.badRequest('Valeur hors limites : de {min} à {max}.', {'min': '${d.min}', 'max': '${d.max}'});
    }
    final before = await values();
    final after = {...before, key: value ?? fileValues[key]!};
    final staff = after['includedStaff']!, end1 = after['tier1End']!, end2 = after['tier2End']!;
    if (!(staff < end1 && end1 < end2)) {
      throw const ApiError.badRequest('Les paliers doivent se suivre : salariés inclus < fin du palier 1 < fin du palier 2.');
    }
    await store.db.runTx((tx) async {
      if (value == null) {
        await store.query(tx, 'DELETE FROM platform_settings WHERE key = @k', {'k': key});
      } else {
        await store.query(tx, '''
          INSERT INTO platform_settings (key, value, updated_by) VALUES (@k, @v, @u::uuid)
          ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value, updated_by = EXCLUDED.updated_by, updated_at = now()''',
            {'k': key, 'v': value, 'u': admin.id});
      }
      await store.audit(
          actorId: admin.id,
          action: 'platform.setting',
          details: {'key': key, 'old': before[key], 'new': after[key], 'reset': value == null},
          tx: tx);
    });
    _overrides = null;
  }

  /// Prix mensuel en centimes, calcul cumulatif : chaque tranche de
  /// [tierSize] salariés au-delà de [includedStaff] ajoute le prix de son palier.
  static int monthlyCents(Map<String, int> v, int staff, {bool cascade = false}) {
    final included = v['includedStaff']!, size = v['tierSize']!;
    int tranches(int upTo) => upTo <= included ? 0 : ((upTo - included) + size - 1) ~/ size;
    final t = tranches(staff);
    final t1 = tranches(v['tier1End']!);
    final t2 = tranches(v['tier2End']!) - t1;
    var cents = v['basePrice']! +
        (t < t1 ? t : t1) * v['tier1Price']! +
        (t - t1).clamp(0, t2) * v['tier2Price']! +
        (t - t1 - t2 < 0 ? 0 : t - t1 - t2) * v['tier3Price']!;
    if (cascade && staff < v['cascadeIncludedFrom']!) cents += v['cascadeOptionPrice']!;
    return cents;
  }

  /// Prix d'une année payée en une fois : l'abonnement au prix de
  /// [annualMonths] mois, les options sans remise.
  static int annualCents(Map<String, int> v, int staff, {bool cascade = false}) {
    final base = monthlyCents(v, staff);
    final option = monthlyCents(v, staff, cascade: cascade) - base;
    return base * v['annualMonths']! + option * 12;
  }

  Future<Map<String, Object?>> quote(int staff, {bool cascade = false}) async {
    final v = await values();
    return {
      'staff': staff,
      'monthlyCents': monthlyCents(v, staff, cascade: cascade),
      'annualCents': annualCents(v, staff, cascade: cascade),
    };
  }

  /// Tableau de bord : l'activité de la plateforme et, en attendant le
  /// paiement, le revenu théorique si chaque entreprise active payait.
  Future<Map<String, Object?>> overview() async {
    int one(List rows) => (rows.first[0] as num?)?.toInt() ?? 0;
    Future<int> count(String sql) async => one(await store.query(store.db, sql));
    final v = await values();
    final sizes = await store.query(store.db, '''
      SELECT c.id, count(m.user_id) FILTER (WHERE m.role <> 'extra')
      FROM companies c LEFT JOIN memberships m ON m.company_id = c.id AND m.left_at IS NULL
      WHERE c.status = 'active' GROUP BY c.id''');
    var monthly = 0;
    final bands = <String, int>{};
    for (final r in sizes) {
      final staff = (r[1] as num).toInt();
      monthly += monthlyCents(v, staff);
      final band = staff <= v['includedStaff']!
          ? '1-${v['includedStaff']}'
          : staff <= v['tier1End']!
              ? '${v['includedStaff']! + 1}-${v['tier1End']}'
              : staff <= v['tier2End']!
                  ? '${v['tier1End']! + 1}-${v['tier2End']}'
                  : '${v['tier2End']! + 1}+';
      bands[band] = (bands[band] ?? 0) + 1;
    }
    return {
      'users': await count('SELECT count(*) FROM users'),
      'usersLast30Days': await count("SELECT count(*) FROM users WHERE created_at > now() - interval '30 days'"),
      'companies': await count('SELECT count(*) FROM companies'),
      'activeCompanies': sizes.length,
      'readOnlyCompanies': await count("SELECT count(*) FROM companies WHERE status = 'readOnly'"),
      'companiesLast30Days': await count("SELECT count(*) FROM companies WHERE created_at > now() - interval '30 days'"),
      'memberships': await count('SELECT count(*) FROM memberships WHERE left_at IS NULL'),
      'shiftsLast30Days': await count("SELECT count(*) FROM shifts WHERE day > current_date - 30 AND NOT deleted"),
      'messagesLast30Days': await count("SELECT count(*) FROM messages WHERE created_at > now() - interval '30 days'"),
      'theoreticalMonthlyCents': monthly,
      'companiesBySize': bands,
    };
  }

  /// Journal des modifications des réglages, les plus récentes d'abord.
  Future<List<Map<String, Object?>>> log({int limit = 100}) async {
    final rows = await store.query(store.db, '''
      SELECT a.at, u.email, a.details FROM audit_log a LEFT JOIN users u ON u.id = a.actor_id
      WHERE a.action = 'platform.setting' ORDER BY a.id DESC LIMIT @l''', {'l': limit});
    return [
      for (final r in rows)
        {'at': (r[0] as DateTime).toIso8601String(), 'by': r[1], ...(r[2] as Map).cast<String, Object?>()},
    ];
  }
}
