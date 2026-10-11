import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Compte : export des données, suppression (fantôme ou effacement), nouveau
/// QR code, Telegram vérifié, reprise avec un autre compte Google ; factures
/// des entreprises fermées.
void main() {
  final env = TestEnv();

  Future<(int, Map<String, String>, List<int>)> download(String path) async {
    final res = await env.handler(Request('GET', Uri.parse('http://localhost$path')));
    return (res.statusCode, res.headers, await res.read().expand((b) => b).toList());
  }

  /// Relie le Telegram [chatId] (nom [username]) au compte de [c], comme le bot.
  Future<void> linkTelegram(Client c, int chatId, String? username) async {
    final url = (await c.ok('POST', '/me/telegram/link'))['url'] as String;
    expect(url, startsWith('https://t.me/StaffFlowTestBot?start='));
    await env.api.telegram.handle({
      'update_id': 1,
      'message': {
        'chat': {'id': chatId, 'type': 'private'},
        'from': {'id': chatId, 'username': ?username, 'language_code': 'fr'},
        'text': '/start ${Uri.parse(url).queryParameters['start']}',
      },
    });
  }

  test('export : un fichier JSON de toutes ses données, par un lien temporaire', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, eva.id, Role.employee);
    await eva.ok('POST', '/companies/$company/requests', {'kind': 'leave', 'startDay': '2026-10-10', 'endDay': '2026-10-11'});
    final path = (await eva.ok('GET', '/me/export/link'))['path'] as String;
    final (status, headers, bytes) = await download(path);
    expect(status, 200);
    expect(headers['content-disposition'], contains('staff-flow-${eva.user['publicId']}.json'));
    final data = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    expect(data['account']['email'], 'eva@example.com');
    expect((data['companies'] as List).single['company'], 'Boulangerie');
    expect((data['requests'] as List).single['kind'], 'leave');
    expect((await download('/api/v1/account-exports/faux')).$1, 404);
  });

  test('suppression en fantôme : on revient avec le même compte Google', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, eva.id, Role.employee);
    // Le propriétaire doit d'abord transférer son entreprise.
    final (status, body) = await boss('POST', '/me/delete', {'erase': false});
    expect([status, body['error']['code']], [409, 'owner_must_transfer']);
    expect((await eva('POST', '/me/delete', {'erase': false})).$1, 204);
    expect((await eva('GET', '/me')).$1, 401, reason: 'la session ne vaut plus');
    final members = (await boss.ok('GET', '/companies/$company/members'))['members'] as List;
    expect(members.map((m) => m['user']['name']), isNot(contains('eva')));
    // Reconnexion : même compte, même numéro, sans entreprise.
    final back = await Client(env.handler).call('POST', '/auth/google', {'idToken': 'google:eva'});
    expect(back.$2['restored'], true);
    expect(back.$2['user']['publicId'], eva.user['publicId']);
    final again = await env.login('eva');
    expect((await again.ok('GET', '/me'))['companies'], isEmpty);
  });

  test('effacement définitif : il ne reste qu\'un « Ghost » dans l\'historique', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, eva.id, Role.employee);
    final leave = await eva.ok('POST', '/companies/$company/requests', {'kind': 'leave', 'startDay': '2026-10-10', 'endDay': '2026-10-11'});
    await eva.ok('POST', '/me/delete', {'erase': true});
    final rows = await env.admin.execute('SELECT name, email, google_sub, erased FROM users WHERE id = \'${eva.id}\'');
    expect(rows.first[0], 'Ghost · ${eva.user['publicId']}');
    expect([rows.first[1], (rows.first[2] as String).startsWith('erased:'), rows.first[3]], ['', true, true]);
    // La demande reste, annulée, pour l'historique de l'entreprise.
    final r = await boss.ok('GET', '/requests/${leave['id']}');
    expect(r['status'], 'cancelled');
    // Le même compte Google repart de zéro, avec un nouveau numéro.
    final fresh = await env.login('eva');
    expect(fresh.user['publicId'], isNot(eva.user['publicId']));
  });

  test('nouveau QR code : l\'ancien ne sert plus, la place dans l\'entreprise reste', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, eva.id, Role.employee);
    final old = eva.user['publicId'];
    final updated = await eva.ok('POST', '/me/qr');
    expect(updated['publicId'], isNot(old));
    expect((await eva.ok('GET', '/me'))['companies'], hasLength(1));
    expect((await boss('POST', '/companies/$company/invite', {'qr': old})).$1, 404);
  });

  test('Telegram : vérifié par le bot, affiché seulement dans les entreprises choisies', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, eva.id, Role.employee);
    expect((await eva.ok('GET', '/me'))['telegramBot'], 'StaffFlowTestBot');
    expect((await eva('PUT', '/companies/$company/telegram', {'show': true})).$1, 409, reason: 'pas encore relié');
    await linkTelegram(eva, 42, 'eva_tg');
    expect(env.telegram.sent.last.$1, 42);
    expect(env.telegram.sent.last.$2, contains(eva.user['publicId']));
    expect((await eva.ok('GET', '/me'))['telegram']['username'], 'eva_tg');
    Future<Object?> shown() async => ((await boss.ok('GET', '/companies/$company/members'))['members'] as List)
        .firstWhere((m) => m['user']['id'] == eva.id)['telegram'];
    expect(await shown(), isNull);
    await eva.ok('PUT', '/companies/$company/telegram', {'show': true});
    expect(await shown(), 'eva_tg');
    // Un lien déjà utilisé ne relie plus rien.
    await env.api.telegram.handle({
      'message': {
        'chat': {'id': 7, 'type': 'private'},
        'from': {'id': 7},
        'text': '/start AAAAAAAAAAAAAAAAAAAAAAAA',
      },
    });
    expect(env.telegram.sent.last.$2, contains('expired'), reason: 'langue inconnue : anglais');
    await eva.ok('DELETE', '/me/telegram');
    expect(await shown(), isNull);
  });

  test('changer de compte Google : code envoyé sur Telegram, même compte et même numéro', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, eva.id, Role.employee);
    await linkTelegram(eva, 42, 'eva_tg');
    final neu = await env.login('eva2');
    // Sans Telegram vérifié, ou numéro inconnu : rien n'est envoyé.
    expect((await neu('POST', '/me/recover', {'publicId': 'SF-INCONNU1'})).$1, 404);
    final sent = await neu.ok('POST', '/me/recover', {'publicId': eva.user['publicId']});
    expect(sent['telegram'], 'eva_tg');
    final message = env.telegram.sent.last;
    expect([message.$1, message.$2.contains('eva2@example.com')], [42, true]);
    final code = RegExp(r'\d{6}').firstMatch(message.$2)![0]!;
    expect((await neu('POST', '/me/recover/confirm', {'code': '000000' == code ? '111111' : '000000'})).$1, 400);
    final session = await neu.ok('POST', '/me/recover/confirm', {'code': code});
    expect([session['user']['id'], session['user']['publicId'], session['user']['email']],
        [eva.id, eva.user['publicId'], 'eva2@example.com']);
    // Le nouveau compte Google ouvre l'ancien compte, avec ses entreprises.
    final again = await env.login('eva2');
    expect(again.id, eva.id);
    expect((await again.ok('GET', '/me'))['companies'], hasLength(1));
    // L'ancien compte Google n'y donne plus accès.
    expect((await env.login('eva')).id, isNot(eva.id));
  });

  test('changement de compte Google : 5 codes par jour au plus pour un même compte, quel que soit le demandeur', () async {
    final eva = await env.login('eva');
    await linkTelegram(eva, 42, 'eva_tg');
    for (var i = 0; i < 5; i++) {
      await (await env.login('pirate$i')).ok('POST', '/me/recover', {'publicId': eva.user['publicId']});
    }
    final (status, body) = await (await env.login('pirate9')).call('POST', '/me/recover', {'publicId': eva.user['publicId']});
    expect(status, 409);
    expect(body['error']['message'], contains('tomorrow'));
    expect(env.telegram.sent.last.$2, contains('Never give it to anyone'), reason: 'mise en garde contre le vol du code');
  });

  test('un compte Google déjà dans une entreprise ne peut pas reprendre un autre compte', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    await linkTelegram(eva, 42, 'eva_tg');
    await env.createCompany(boss);
    expect((await boss('POST', '/me/recover', {'publicId': eva.user['publicId']})).$1, 409);
  });

  test('entreprise fermée : son dernier patron garde ses factures (PDF et ZIP)', () async {
    final boss = await env.login('boss');
    final company = await env.createCompany(boss);
    await boss.ok('PUT', '/admin/texts/sellerAddressLatin', {'value': 'Kyiv, Ukraine'});
    expect((await boss.ok('GET', '/admin/texts'))['texts']['sellerName'], 'Vercane');
    final b = await boss.ok('GET', '/companies/$company/billing');
    final quote = b['quotes']['year'];
    expect(quote['total'], b['dueNow']['year']);
    expect([for (final l in quote['lines']) l['label']], ['prorata', 'subscription']);
    await boss.ok('POST', '/companies/$company/billing/checkout', {'period': 'month', 'cascade': false});
    // ZIP de toutes les factures de l'entreprise.
    final zip = (await boss.ok('GET', '/companies/$company/invoices-zip/link?lang=uk'))['path'] as String;
    final (status, _, bytes) = await download(zip);
    expect(status, 200);
    expect(ZipDecoder().decodeBytes(bytes).files.single.name, startsWith('SF-${b['publicId']}-2026-'));
    // Non payée, puis supprimée : les factures restent au dernier patron.
    env.clock.advance(const Duration(days: 60));
    await env.api.billing.tick();
    env.clock.advance(const Duration(days: 16));
    await env.api.billing.tick();
    expect((await boss.ok('GET', '/me'))['companies'], isEmpty);
    final archived = (await boss.ok('GET', '/me/invoices'))['invoices'] as List;
    expect(archived.single['companyCode'], b['publicId']);
    final pdf = (await boss.ok('GET', '/me/invoices/${archived.single['id']}/link'))['path'] as String;
    expect((await download(pdf)).$1, 200);
    final other = await env.login('other');
    expect((await other('GET', '/me/invoices/${archived.single['id']}/link')).$1, 404);
    // L'administration les retrouve par l'identifiant de l'entreprise.
    final admin = (await boss.ok('GET', '/admin/invoices?code=${b['publicId']}'))['invoices'] as List;
    expect(admin.single['closed'], true);
    // Gardées la durée légale (10 ans), puis effacées.
    env.clock.advance(const Duration(days: 365 * 10 + 5));
    await env.api.billing.tick();
    expect((await boss.ok('GET', '/me/invoices'))['invoices'], isEmpty);
  });
}
