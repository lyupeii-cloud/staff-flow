import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Page d'administration : réservée aux adresses de la configuration ;
/// réglages modifiables en direct, journalisés, et calcul du prix.
void main() {
  final env = TestEnv();

  test('seul l\'administrateur voit l\'administration', () async {
    final boss = await env.login('boss');
    final other = await env.login('other');
    expect((await boss.ok('GET', '/me'))['isAdmin'], true);
    expect((await other.ok('GET', '/me'))['isAdmin'], isNull);
    for (final path in ['/admin/overview', '/admin/settings', '/admin/log', '/admin/quote?staff=5']) {
      expect((await other('GET', path)).$1, 404, reason: path);
      expect((await boss('GET', path)).$1, 200, reason: path);
    }
    expect((await other('PUT', '/admin/settings/basePrice', {'value': 1})).$1, 404);
  });

  test('grille du 11 octobre : calcul cumulatif, année à 10 mois, option sans remise', () async {
    final v = {for (final d in PlatformService.defs) d.key: d.value};
    int m(int staff, {bool cascade = false}) => PlatformService.monthlyCents(v, staff, cascade: cascade);
    expect([m(1), m(10), m(11), m(20), m(50), m(51), m(100), m(110), m(200), m(500)],
        [300, 300, 400, 400, 700, 780, 1100, 1150, 1600, 3100]);
    expect(m(60, cascade: true), 780 + 200);
    expect(m(150, cascade: true), m(150), reason: 'incluse à partir de 101');
    expect(PlatformService.annualCents(v, 60, cascade: true), 780 * 10 + 200 * 12);
  });

  test('un réglage modifié s\'applique tout de suite, se journalise, et revient à la valeur du fichier', () async {
    final boss = await env.login('boss');
    expect((await boss.ok('GET', '/admin/quote?staff=60'))['monthlyCents'], 780);
    await boss.ok('PUT', '/admin/settings/basePrice', {'value': 500});
    expect((await boss.ok('GET', '/admin/quote?staff=60'))['monthlyCents'], 980);
    final s = ((await boss.ok('GET', '/admin/settings'))['settings'] as List).firstWhere((s) => s['key'] == 'basePrice');
    expect([s['value'], s['fileValue'], s['overridden']], [500, 300, true]);
    final log = (await boss.ok('GET', '/admin/log'))['entries'] as List;
    expect([log.first['key'], log.first['old'], log.first['new'], log.first['by']], ['basePrice', 300, 500, 'boss@example.com']);
    await boss.ok('DELETE', '/admin/settings/basePrice');
    expect((await boss.ok('GET', '/admin/quote?staff=60'))['monthlyCents'], 780);
    // Limites et cohérence des paliers.
    expect((await boss('PUT', '/admin/settings/annualMonths', {'value': 13})).$1, 400);
    expect((await boss('PUT', '/admin/settings/tier1End', {'value': 200})).$1, 400);
    expect((await boss('PUT', '/admin/settings/nope', {'value': 1})).$1, 404);
  });

  test('tableau de bord : activité et revenu théorique', () async {
    final boss = await env.login('boss');
    final bob = await env.login('bob');
    final c = await env.createCompany(boss);
    await env.store.addMember(c, bob.id, Role.employee);
    final o = await boss.ok('GET', '/admin/overview');
    expect([o['users'], o['companies'], o['activeCompanies'], o['theoreticalMonthlyCents']], [2, 1, 1, 300]);
    expect(o['companiesBySize'], {'1-10': 1});
  });
}
