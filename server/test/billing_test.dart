import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Abonnement : essai de 2 jours par compte Google, paiement (fictif,
/// réservé aux administrateurs), lecture seule puis suppression, factures.
void main() {
  final env = TestEnv();

  Future<Map<String, dynamic>> billing(Client c, String company) async => await c.ok('GET', '/companies/$company/billing');
  Future<List<String>> kinds(Client c) async => [for (final n in (await c.ok('GET', '/notices'))['notices']) n['kind'] as String];

  test('essai de 2 jours, puis lecture seule 15 jours, puis suppression', () async {
    final owner = await env.login('owner');
    final company = await env.createCompany(owner);
    final b = await billing(owner, company);
    expect(b['status'], 'trial');
    expect(DateTime.parse(b['trialEndsAt']), env.clock.now.add(const Duration(days: 2)));
    // La veille : rappel.
    env.clock.advance(const Duration(hours: 25));
    await env.api.billing.tick();
    await env.api.notifications.settle();
    expect(await kinds(owner), contains('billing_trial_ending'));
    // Fin de l'essai : lecture seule.
    env.clock.advance(const Duration(hours: 24));
    await env.api.billing.tick();
    await env.api.notifications.settle();
    final me = (await owner.ok('GET', '/me'))['companies'].single['company'];
    expect([me['status'], me['billing']['status']], ['readOnly', 'grace']);
    expect(await kinds(owner), contains('billing_grace'));
    expect((await owner('PATCH', '/companies/$company', {'name': 'X'})).$1, 409);
    // Rappels puis suppression au 15e jour.
    env.clock.advance(const Duration(days: 7));
    await env.api.billing.tick();
    await env.api.notifications.settle();
    expect(await kinds(owner), contains('billing_grace_reminder'));
    env.clock.advance(const Duration(days: 8));
    await env.api.billing.tick();
    await env.api.notifications.settle();
    expect(await kinds(owner), contains('billing_deleted'));
    expect((await owner.ok('GET', '/me'))['companies'], isEmpty);
  });

  test('l\'essai est une fois par compte : une entreprise créée après doit être payée', () async {
    final owner = await env.login('owner');
    final first = await env.createCompany(owner);
    final second = await env.createCompany(owner, 'Deuxième');
    expect((await billing(owner, second))['status'], 'trial', reason: 'pendant l\'essai du compte');
    env.clock.advance(const Duration(days: 3));
    final third = (await owner.ok('POST', '/companies', {'name': 'Troisième', 'timezone': 'Europe/Paris'}))['company'];
    expect([third['status'], third['billing']['status']], ['readOnly', 'grace']);
    expect(first, isNotNull);
  });

  test('paiement de test : réservé à l\'administrateur, recalcul et facture', () async {
    final boss = await env.login('boss');
    final other = await env.login('other');
    final company = await env.createCompany(boss);
    final mine = await env.createCompany(other, 'Autre');
    for (var i = 0; i < 25; i++) {
      final p = await env.login('p$i');
      await env.store.addMember(company, p.id, Role.employee);
    }
    final b = await billing(boss, company);
    expect([b['staff'], b['prices']['month'], b['prices']['year'], b['canPay']], [25, 500, 5000, true]);
    expect((await other('POST', '/companies/$mine/billing/checkout', {'period': 'month', 'cascade': false})).$1, 409);
    expect((await other('GET', '/companies/$company/billing')).$1, 404, reason: 'pas membre');
    // Année avec l'option : l'option n'a pas de remise.
    final paid = await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'year', 'cascade': true});
    expect(paid['amountCents'], 5000 + 200 * 12);
    expect(paid['number'], startsWith('SF-2026-'));
    final after = await billing(boss, company);
    expect([after['status'], after['period'], after['cascadeOption']], ['active', 'year', true]);
    expect(DateTime.parse(after['paidUntil']), DateTime.utc(2027, 10, 5, 8));
    // Un mois de plus s'ajoute à la période déjà payée.
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false});
    expect(DateTime.parse((await billing(boss, company))['paidUntil']), DateTime.utc(2027, 11, 5, 8));
    // Facture PDF par un lien temporaire.
    final invoice = (await billing(boss, company))['invoices'].last;
    final link = (await boss.ok('GET', '/companies/$company/invoices/${invoice['id']}/link'))['path'] as String;
    final res = await env.handler(Request('GET', Uri.parse('http://localhost$link')));
    expect([res.statusCode, res.headers['content-type']], [200, 'application/pdf']);
    final bytes = await res.read().expand((b) => b).toList();
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    // Un lien d'un autre propriétaire ne sert à rien.
    expect((await other('GET', '/companies/$company/invoices/${invoice['id']}/link')).$1, 404);
  });

  test('une entreprise payée qui n\'est plus payée repasse en lecture seule', () async {
    final boss = await env.login('boss');
    final company = await env.createCompany(boss);
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false});
    env.clock.advance(const Duration(days: 32));
    await env.api.billing.tick();
    expect((await billing(boss, company))['status'], 'grace');
    // Payer pendant la grâce réactive tout.
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false});
    final me = (await boss.ok('GET', '/me'))['companies'].single['company'];
    expect([me['status'], me['billing']['status']], ['active', 'active']);
  });

  test('entreprise offerte par l\'administration ; sous-sites et option', () async {
    final boss = await env.login('boss');
    final owner = await env.login('owner');
    final company = await env.createCompany(owner);
    final nord = (await owner.ok('POST', '/companies/$company/sites', {'name': 'Nord'}))['id'];
    // Essai : tout est ouvert, sous-sites compris.
    await owner.ok('POST', '/companies/$company/sites', {'name': 'Lille', 'parentId': nord});
    env.clock.advance(const Duration(days: 3));
    await env.api.billing.tick();
    expect((await boss('PUT', '/admin/companies/$company/comped', {'comped': true})).$1, 204);
    final b = await billing(owner, company);
    expect(b['status'], 'comped');
    expect((await owner('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false})).$1, 409);
    await owner.ok('POST', '/companies/$company/sites', {'name': 'Roubaix', 'parentId': nord});
    final list = (await boss.ok('GET', '/admin/companies'))['companies'] as List;
    expect(list.single['billingStatus'], 'comped');
    // Plus offerte, non payée : lecture seule.
    await boss.ok('PUT', '/admin/companies/$company/comped', {'comped': false});
    expect((await billing(owner, company))['status'], 'grace');
  });

  test('payée sans l\'option : pas de sous-site (sauf au-delà de 100 salariés)', () async {
    final boss = await env.login('boss');
    final company = await env.createCompany(boss);
    final nord = (await boss.ok('POST', '/companies/$company/sites', {'name': 'Nord'}))['id'];
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false});
    expect((await boss('POST', '/companies/$company/sites', {'name': 'Lille', 'parentId': nord})).$1, 402);
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': true});
    await boss.ok('POST', '/companies/$company/sites', {'name': 'Lille', 'parentId': nord});
  });
}
