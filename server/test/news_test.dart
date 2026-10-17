import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Fil d'actualités : annonces du patron et des responsables, ciblées ou
/// pour tous, lues, traduites, retirées.
void main() {
  final env = TestEnv();

  late Client owner, manager, bob, eva, zoe;
  late String company, macon, nord;

  String p(String path) => '/companies/$company$path';

  setUp(() async {
    owner = await env.login('owner');
    manager = await env.login('manager');
    bob = await env.login('bob');
    eva = await env.login('eva');
    zoe = await env.login('zoe');
    company = await env.createCompany(owner);
    macon = (await owner.ok('POST', p('/positions'), {'name': 'Maçon'}))['id'];
    nord = (await owner.ok('POST', p('/sites'), {'name': 'Nord'}))['id'];
    await env.store.addMember(company, manager.id, Role.manager, sites: [nord]);
    await env.store.addMember(company, bob.id, Role.employee, sites: [nord]);
    await env.store.addMember(company, eva.id, Role.employee);
    await env.store.addMember(company, zoe.id, Role.extra);
    await owner.ok('PUT', p('/members/${eva.id}/profile'), {'positionId': macon});
  });

  Future<List<dynamic>> feed(Client c) async => (await c.ok('GET', p('/news')))['items'];

  test('pour tous : chacun la voit, non lue, notifiée ; puis lue', () async {
    await bob.ok('PUT', '/devices', {'token': 'tel-bob', 'platform': 'android', 'language': 'fr'});
    final r = await owner.ok('POST', p('/news'), {
      'title': 'Fermeture',
      'body': 'Le dépôt est fermé lundi.',
      'audience': {'everyone': true},
    });
    expect(r['recipients'], 4);
    final items = await feed(bob);
    expect([items.single['title'], items.single['read'], items.single['author']['name']], ['Fermeture', false, 'owner']);
    expect(items.single.containsKey('reads'), isFalse, reason: 'un salarié ne voit pas qui a lu');
    expect((await bob.ok('GET', '/me'))['unreadNews'], {company: 1});
    await env.api.notifications.settle();
    expect(env.push.sent.single.body, 'owner a publié une annonce : Fermeture');
    await bob.ok('POST', p('/news/read'));
    expect((await bob.ok('GET', '/me'))['unreadNews'], isEmpty);
    await owner.ok('POST', p('/news/read'));
    expect((await feed(owner)).single['reads'], 1, reason: "ni l'auteur ni qui n'est pas destinataire");
    // Un salarié ne publie pas.
    expect((await bob('POST', p('/news'), {'body': 'x', 'audience': {'everyone': true}})).$1, 403);
  });

  test('ciblée : poste, rôle, personne ; les autres ne la voient pas', () async {
    await owner.ok('POST', p('/news'), {
      'body': 'Casques obligatoires',
      'audience': {'positions': [macon], 'roles': ['extra']},
    });
    expect(await feed(eva), hasLength(1));
    expect(await feed(zoe), hasLength(1));
    expect(await feed(bob), isEmpty);
    expect(await feed(manager), isEmpty, reason: 'responsable de site : pas destinataire');
    await owner.ok('POST', p('/news'), {'body': 'Pour Bob', 'audience': {'users': [bob.id]}});
    expect([for (final i in await feed(bob)) i['body']], ['Pour Bob']);
    expect((await owner('POST', p('/news'), {'body': 'x', 'audience': {}})).$1, 400);
  });

  test('responsable de site : seulement les gens de ses sites', () async {
    final r = await manager.ok('POST', p('/news'), {'body': 'Réunion au Nord', 'audience': {'everyone': true}});
    expect(r['recipients'], 1);
    expect(await feed(bob), hasLength(1));
    expect(await feed(eva), isEmpty);
    expect(await feed(owner), hasLength(1), reason: 'le patron voit tout');
    await owner.ok('POST', p('/news/read'));
    expect((await feed(manager)).single['reads'], 0, reason: "le patron n'est pas destinataire");
    // Le responsable modifie la sienne ; le patron peut la retirer.
    final id = (await feed(manager)).single['id'];
    await manager.ok('PATCH', p('/news/$id'), {'body': 'Réunion déplacée'});
    expect((await feed(bob)).single['editedAt'], isNotNull);
    expect((await bob('DELETE', p('/news/$id'))).$1, 404);
    await owner.ok('DELETE', p('/news/$id'));
    expect(await feed(bob), isEmpty);
  });

  test('traduction gardée ; fil coupé par le patron', () async {
    await owner.ok('POST', p('/news'), {'title': 'Info', 'body': 'Bonjour', 'audience': {'everyone': true}});
    final id = (await feed(bob)).single['id'];
    final tr = await bob.ok('POST', p('/news/$id/translate'), {'lang': 'uk'});
    expect(tr, {'title': '[uk] Info', 'body': '[uk] Bonjour'});
    await bob.ok('POST', p('/news/$id/translate'), {'lang': 'uk'});
    expect(env.translator.calls, 2, reason: 'la seconde fois vient de la base');
    expect((await manager('PUT', p('/messaging'), {'enabled': false})).$1, 403);
    await owner.ok('PUT', p('/messaging'), {'enabled': false});
    expect((await bob('GET', p('/news'))).$1, 409);
    expect((await bob.ok('GET', '/me'))['unreadNews'], isEmpty);
  });

  test('une nouvelle entreprise a le fil actif', () async {
    final fresh = (await owner.ok('POST', '/companies', {'name': 'Neuve', 'timezone': 'Europe/Paris'}))['company'];
    expect(fresh['messagingEnabled'], true);
  });
}
