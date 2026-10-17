import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Option « API Pro » : écriture par clé API, avec des droits par clé.
void main() {
  final env = TestEnv();

  late Client boss;
  late String company;

  setUp(() async {
    boss = await env.login('boss');
    company = await env.createCompany(boss);
  });

  String p(String path) => '/companies/$company$path';

  Future<(int, dynamic)> ext(String method, String path, String key, [Object? body]) async {
    final res = await env.handler(Request(method, Uri.parse('http://localhost/api/v1$path'),
        body: body == null ? null : jsonEncode(body), headers: {'authorization': 'Bearer $key'}));
    final text = await res.readAsString();
    return (res.statusCode, text.isEmpty ? null : jsonDecode(text));
  }

  Future<void> paid({bool pro = true}) async {
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false});
    if (pro) await boss.ok('POST', p('/billing/addon'), {'option': 'pro'});
  }

  test('pas pendant l\'essai ; payée : 10 € par mois pour 1 clé, 20 € pour 5, clés avec droits choisis', () async {
    expect((await boss('POST', p('/api-keys'), {'name': 'Paie', 'scopes': ['read', 'shifts']})).$1, 402);
    // Lecture seule : possible pendant l'essai.
    await boss.ok('POST', p('/api-keys'), {'name': 'Compta', 'scopes': ['read']});
    await paid(pro: false);
    final addon = (await boss.ok('GET', p('/billing')))['addons']['pro'] as Map;
    expect([addon['lines'].single['unitCents'], addon['lines'].single['label']], [1000, 'proAddon']);
    await boss.ok('POST', p('/billing/addon'), {'option': 'pro'});
    expect((await boss.ok('GET', p('/billing')))['apiProOption'], true);
    expect((await boss('POST', p('/api-keys'), {'name': 'X', 'scopes': ['admin']})).$1, 400);
    // 1 clé : celle de lecture est déjà là. Passage à 5 clés : la différence (10 €).
    expect((await boss('POST', p('/api-keys'), {'name': 'Planif', 'scopes': ['shifts']})).$1, 409);
    final upgrade = (await boss.ok('GET', p('/billing')))['addons']['pro5'] as Map;
    expect([upgrade['lines'].single['unitCents'], upgrade['lines'].single['label']], [1000, 'pro5Upgrade']);
    await boss.ok('POST', p('/billing/addon'), {'option': 'pro5'});
    final key = await boss.ok('POST', p('/api-keys'), {'name': 'Planif', 'scopes': ['shifts']});
    expect(key['scopes'], ['shifts']);
    // Sans le droit « read » : pas de lecture ; sans « publish » : pas de publication.
    expect((await ext('GET', '/ext/company', key['key'])).$1, 403);
    expect((await ext('POST', '/ext/publish', key['key'])).$1, 403);
  });

  test('planning envoyé : brouillon par défaut (les responsables l\'adaptent), ou publié directement', () async {
    final bob = await env.login('bob');
    await env.store.addMember(company, bob.id, Role.employee);
    await boss.ok('PUT', p('/members/${bob.id}/profile'), {'employeeNumber': 'M-7'});
    await paid();
    final key = (await boss.ok('POST', p('/api-keys'), {'name': 'ERP', 'scopes': ['read', 'shifts', 'publish', 'catalog']}))['key'];
    await ext('POST', '/ext/positions', key, {'name': 'Caisse'});
    final draft = await ext('POST', '/ext/shifts', key, {
      'shifts': [
        {'day': '2026-10-07', 'start': '08:00', 'end': '16:00', 'person': 'M-7', 'position': 'caisse'},
        {'day': '2026-10-08', 'start': 480, 'end': 960, 'person': bob.user['publicId']},
      ],
    });
    expect([draft.$1, draft.$2['data']['status'], (draft.$2['data']['created'] as List).length], [201, 'draft', 2]);
    // Visibles des responsables, en brouillon (pas pour les salariés).
    final week = (await boss.ok('GET', p('/shifts?from=2026-10-05&to=2026-10-11')))['shifts'] as List;
    expect([for (final s in week) s['status']], ['draft', 'draft']);
    expect((await ext('GET', '/ext/shifts?from=2026-10-05&to=2026-10-11', key)).$2['data'], isEmpty);
    // Le responsable adapte un service, puis tout est publié d'un coup.
    final id = (draft.$2['data']['created'] as List).first;
    expect((await ext('PATCH', '/ext/shifts/$id', key, {'start': '09:00'})).$1, 200);
    final pub = await ext('POST', '/ext/shifts', key, {
      'publish': true,
      'shifts': [
        {'day': '2026-10-09', 'start': '08:00', 'end': '12:00', 'person': 'M-7'},
      ],
    });
    expect([pub.$2['data']['status'], pub.$2['data']['published']], ['published', 3]);
    expect((await ext('GET', '/ext/shifts?from=2026-10-05&to=2026-10-11', key)).$2['data'], hasLength(3));
    // Erreur : personne inconnue, rien n'est créé.
    expect((await ext('POST', '/ext/shifts', key, {
      'shifts': [
        {'day': '2026-10-10', 'start': '08:00', 'end': '12:00', 'person': 'X-404'},
      ],
    }))
        .$1, 400);
  });

  test('salariés, annonces, demandes ; coupée pendant la période de grâce', () async {
    await paid();
    final key = (await boss.ok('POST', p('/api-keys'), {'name': 'RH', 'scopes': ['members', 'news', 'requests']}))['key'];
    final imp = await ext('POST', '/ext/members/import', key, {
      'rows': [
        {'name': 'Ana Silva', 'number': 'A-1', 'position': 'Vente'},
      ],
    });
    expect([imp.$1, imp.$2['data']['created'], (imp.$2['data']['invites'] as List).single['name']], [201, 1, 'Ana Silva']);
    expect((await ext('POST', '/ext/news', key, {'body': 'Inventaire samedi'})).$1, 400, reason: 'personne dans l\'entreprise');
    expect((await ext('GET', '/ext/requests', key)).$2['data'], isEmpty);
    env.clock.advance(const Duration(days: 70));
    await env.api.billing.tick();
    expect((await boss.ok('GET', p('/billing')))['status'], 'grace');
    expect((await ext('GET', '/ext/invites', key)).$1, 402);
  });

  test('clé modifiée : mêmes caractères, droits ajoutés ou retirés', () async {
    final k = await boss.ok('POST', p('/api-keys'), {'name': 'Paie', 'scopes': ['read']});
    final id = (await boss.ok('GET', p('/api-keys')))['keys'][0]['id'];
    // Ajouter l'écriture : seulement avec « API Pro ».
    expect((await boss('PATCH', p('/api-keys/$id'), {'scopes': ['read', 'catalog']})).$1, 402);
    await paid();
    final e = await boss.ok('PATCH', p('/api-keys/$id'), {'name': 'ERP', 'scopes': ['catalog', 'read']});
    expect([e['name'], e['scopes']], ['ERP', ['read', 'catalog']]);
    expect((await ext('POST', '/ext/positions', k['key'], {'name': 'Caisse'})).$1, 201);
    // Retirer un droit : la même clé n'écrit plus.
    await boss.ok('PATCH', p('/api-keys/$id'), {'scopes': ['read']});
    expect((await ext('POST', '/ext/positions', k['key'], {'name': 'Bar'})).$1, 403);
    expect((await boss('PATCH', p('/api-keys/$id'), {'scopes': []})).$1, 400);
  });

  test('clés : le patron et les responsables qui gèrent l\'abonnement ; API Pro jamais offerte', () async {
    final m = await env.login('m');
    final compta = await env.login('compta');
    await env.store.addMember(company, m.id, Role.manager);
    await env.store.addMember(company, compta.id, Role.employee);
    // Responsable de toute l'entreprise, sans l'abonnement : pas de clés.
    expect((await m('GET', p('/api-keys'))).$1, 403);
    expect((await m('POST', p('/api-keys'), {'name': 'X'})).$1, 403);
    // Salarié comptable avec l'abonnement : pas responsable, pas de clés.
    await boss.ok('PUT', p('/members/${compta.id}/billing'), {'enabled': true});
    expect((await compta('POST', p('/api-keys'), {'name': 'X'})).$1, 403);
    await boss.ok('PUT', p('/members/${m.id}/billing'), {'enabled': true});
    await paid();
    final key = (await m.ok('POST', p('/api-keys'), {'name': 'Chef', 'scopes': ['read', 'catalog']}))['key'];
    expect((await ext('POST', '/ext/positions', key, {'name': 'Caisse'})).$1, 201);
    // Entreprise offerte : la lecture reste, l'écriture non (toujours payante).
    await boss.ok('PUT', '/admin/companies/$company/comped', {'comped': true});
    expect((await ext('GET', '/ext/company', key)).$1, 200);
    expect((await ext('POST', '/ext/positions', key, {'name': 'Bar'})).$1, 402);
  });
}
