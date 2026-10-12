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
    // Le 5 octobre : prorata de 27 jours sur 31, arrondi au centime supérieur.
    expect([b['prorataDays'], b['dueNow']['month'], b['dueNow']['yearCascade']], [27, 436 + 500, 436 + 175 + 5000 + 2400]);
    expect(b['publicId'], matches(RegExp(r'^[A-Z2-9]{6}$')));
    expect((await other('POST', '/companies/$mine/billing/checkout', {'period': 'month', 'cascade': false})).$1, 409);
    expect((await other('GET', '/companies/$company/billing')).$1, 404, reason: 'pas membre');
    // Année avec l'option : l'option n'a pas de remise.
    final paid = await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'year', 'cascade': true});
    expect(paid['amountCents'], 436 + 175 + 5000 + 200 * 12);
    expect(paid['number'], 'SF-${b['publicId']}-2026-0001');
    final after = await billing(boss, company);
    expect([after['status'], after['period'], after['cascadeOption']], ['active', 'year', true]);
    expect(DateTime.parse(after['paidUntil']), DateTime.utc(2027, 11, 1), reason: 'mois civils pleins');
    // Un mois de plus s'ajoute à la période déjà payée.
    final renewal = await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false});
    expect([renewal['amountCents'], renewal['number']], [500, 'SF-${b['publicId']}-2026-0002'], reason: 'pas de prorata');
    expect(DateTime.parse((await billing(boss, company))['paidUntil']), DateTime.utc(2027, 12, 1));
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
    env.clock.advance(const Duration(days: 60)); // prorata d'octobre + novembre : payé jusqu'au 1er décembre
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

  test('payée sans l\'option : trois niveaux de sites ; au-delà, l\'option achetée seule', () async {
    final boss = await env.login('boss');
    final company = await env.createCompany(boss);
    Future<String> site(String name, [String? parent]) async =>
        (await boss.ok('POST', '/companies/$company/sites', {'name': name, 'parentId': ?parent}))['id'];
    final ville = await site('Ville', await site('Lille', await site('Nord')));
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false});
    expect((await boss('POST', '/companies/$company/sites', {'name': 'Quai', 'parentId': ville})).$1, 402);
    // Payé le 5 octobre jusqu'au 1er décembre : octobre en entier et novembre, sans prorata.
    final quote = (await billing(boss, company))['addons']['cascade'] as Map;
    expect(quote['lines'].single['months'], 2);
    expect(quote['total'], 2 * 200);
    final r = await boss.ok('POST', '/companies/$company/billing/addon', {'option': 'cascade'});
    expect(r['amountCents'], 400);
    await site('Quai', ville);
    final after = await billing(boss, company);
    expect(after['addons']['cascade'], isNull, reason: 'déjà prise');
    expect(after['cascadeOption'], true);
    expect(after['invoices'].first['period'], 'addon');
    expect((await boss('POST', '/companies/$company/billing/addon', {'option': 'cascade'})).$1, 409);
  });

  test('option API seule sur un abonnement annuel : mois offerts compris ; coupée pendant la grâce', () async {
    final boss = await env.login('boss');
    final company = await env.createCompany(boss);
    // En essai : rien à ajouter seul (tout est ouvert).
    expect((await billing(boss, company))['addons']['api'], isNull);
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'year', 'cascade': false, 'api': false});
    expect((await boss('POST', '/companies/$company/api-keys', {'name': 'Paie'})).$1, 402);
    // Payé jusqu'au 1er novembre 2027 : octobre 2026 à octobre 2027, 13 mois à 3 €.
    final quote = (await billing(boss, company))['addons']['api'] as Map;
    expect([quote['lines'].single['months'], quote['total']], [13, 13 * 300]);
    await boss.ok('POST', '/companies/$company/billing/addon', {'option': 'api'});
    final key = await boss.ok('POST', '/companies/$company/api-keys', {'name': 'Paie'});
    Future<int> read() async => (await env.handler(Request('GET', Uri.parse('http://localhost/api/v1/ext/company'),
            headers: {'authorization': 'Bearer ${key['key']}'})))
        .statusCode;
    expect(await read(), 200);
    // Renouvellement suivant : l'option est reprise.
    expect((await billing(boss, company))['apiOption'], true);
    // Non renouvelé : période de grâce, la clé ne répond plus.
    env.clock.advance(const Duration(days: 400));
    await env.api.billing.tick();
    expect((await billing(boss, company))['status'], 'grace');
    expect(await read(), 402);
  });

  test('option non renouvelée : active jusqu\'à la fin de la période, puis retirée ; reprise possible', () async {
    final boss = await env.login('boss');
    final company = await env.createCompany(boss);
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false, 'api': true});
    expect((await boss('PUT', '/companies/$company/billing/renewal', {'option': 'cascade', 'renew': false})).$1, 409);
    await boss.ok('PUT', '/companies/$company/billing/renewal', {'option': 'api', 'renew': false});
    var b = await billing(boss, company);
    expect([b['apiOption'], b['apiUntil']], [true, b['paidUntil']]);
    // On se ravise, puis on renouvelle sans l'option : elle court jusqu'à l'ancienne fin.
    await boss.ok('PUT', '/companies/$company/billing/renewal', {'option': 'api', 'renew': true});
    expect((await billing(boss, company))['apiUntil'], isNull);
    final oldEnd = b['paidUntil'];
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false, 'api': false});
    b = await billing(boss, company);
    expect([b['apiOption'], b['apiUntil']], [true, oldEnd]);
    expect(b['quotes']['month']['lines'].any((l) => l['label'] == 'api'), isFalse);
    // Fin de la période : l'option est retirée, la clé ne répond plus.
    env.clock.now = DateTime.parse(oldEnd as String).add(const Duration(hours: 1));
    await env.api.billing.tick();
    b = await billing(boss, company);
    expect([b['apiOption'], b['apiUntil'], b['status']], [false, null, 'active']);
    expect((await boss('POST', '/companies/$company/api-keys', {'name': 'Paie'})).$1, 402);
  });

  test('le patron confie l\'abonnement et les factures à un comptable', () async {
    final boss = await env.login('boss');
    final compta = await env.login('compta');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, compta.id, Role.employee);
    expect((await compta('GET', '/companies/$company/billing')).$1, 403);
    expect((await compta('PUT', '/companies/$company/members/${compta.id}/billing', {'enabled': true})).$1, 403);
    await boss.ok('PUT', '/companies/$company/members/${compta.id}/billing', {'enabled': true});
    final me = (await compta.ok('GET', '/me'))['companies'].single;
    expect(me['billingAccess'], true);
    expect((await billing(compta, company))['isOwner'], false);
    // Le paiement de test est réservé à l'administration (ici le patron) ; le comptable voit les factures.
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false});
    final invoice = (await billing(compta, company))['invoices'].first['id'];
    final link = (await compta.ok('GET', '/companies/$company/invoices/$invoice/link'))['path'] as String;
    final pdf = await env.handler(Request('GET', Uri.parse('http://localhost$link')));
    expect(pdf.statusCode, 200);
    // Rappels de facturation : au patron et au comptable.
    await boss.ok('PUT', '/companies/$company/members/${compta.id}/billing', {'enabled': false});
    expect((await compta('GET', '/companies/$company/billing')).$1, 403);
    expect((await compta.ok('GET', '/me'))['companies'].single['billingAccess'], false);
  });
}
