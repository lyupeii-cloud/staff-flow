import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Changer de compte Google : par le bot (/changegoogle) ou par un lien du
/// patron ; toutes les anciennes sessions sont fermées.
void main() {
  final env = TestEnv();

  Future<void> say(int chatId, String text) => env.api.telegram.handle({
        'message': {
          'chat': {'id': chatId, 'type': 'private'},
          'from': {'id': chatId, 'language_code': 'fr'},
          'text': text,
        },
      });

  Future<void> press(int chatId, String data) => env.api.telegram.handle({
        'callback_query': {
          'id': 'cb',
          'from': {'id': chatId, 'language_code': 'fr'},
          'message': {
            'chat': {'id': chatId, 'type': 'private'},
          },
          'data': data,
        },
      });

  Future<void> linkTelegram(Client c, int chatId) async {
    final url = (await c.ok('POST', '/me/telegram/link'))['url'] as String;
    await say(chatId, '/start ${Uri.parse(url).queryParameters['start']}');
  }

  test('bot : adresse, confirmation, connexion dans les 10 minutes ; anciennes sessions fermées', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, eva.id, Role.employee);
    await linkTelegram(eva, 42);
    await say(42, '/changegoogle');
    expect(env.telegram.sent.last.$2, contains(eva.user['publicId']));
    await say(42, 'pas une adresse');
    expect(env.telegram.sent.last.$2, contains('invalide'));
    await say(42, 'boss@example.com');
    expect(env.telegram.sent.last.$2, contains('déjà utilisé'), reason: 'compte Google d\'une autre personne');
    await say(42, 'Eva.New@example.com');
    expect([for (final b in env.telegram.lastButtons!) b.$1], ['gs:yes', 'gs:no']);
    await press(42, 'gs:yes');
    expect(env.telegram.sent.last.$2, contains('10 minutes'));
    // Connexion avec le nouveau compte Google : même compte, anciennes sessions fermées.
    final (status, body) = await Client(env.handler).call('POST', '/auth/google', {'idToken': 'google:eva.new'});
    expect(status, 200);
    expect([body['switched'], body['user']['id'], body['user']['email']], [true, eva.id, 'eva.new@example.com']);
    expect((await eva('GET', '/me')).$1, 401, reason: 'ancien appareil déconnecté');
    expect(env.telegram.sent.last.$2, contains('signed out'), reason: 'langue du compte inconnue : anglais');
    final again = await env.login('eva.new');
    expect([again.id, (await again.ok('GET', '/me'))['companies'].length], [eva.id, 1]);
  });

  test('bot : sans connexion dans les 10 minutes, rien ne change', () async {
    final eva = await env.login('eva');
    await linkTelegram(eva, 42);
    await say(42, '/changegoogle');
    await say(42, 'eva.new@example.com');
    await press(42, 'gs:yes');
    env.clock.advance(const Duration(minutes: 11));
    final fresh = await env.login('eva.new');
    expect(fresh.id, isNot(eva.id));
    expect((await eva('GET', '/me')).$1, 200);
  });

  test('bot : Telegram non relié, ou annulation', () async {
    await say(7, '/changegoogle');
    expect(env.telegram.sent.last.$2, contains('aucun compte Staff Flow'));
    final eva = await env.login('eva');
    await linkTelegram(eva, 42);
    await say(42, '/changegoogle');
    await say(42, 'eva.new@example.com');
    await press(42, 'gs:no');
    expect(env.telegram.sent.last.$2, contains('Annulé'));
    expect((await env.login('eva.new')).id, isNot(eva.id));
  });

  test('lien du patron pour un salarié sans Telegram, à usage unique', () async {
    final boss = await env.login('boss');
    final eva = await env.login('eva');
    final zoe = await env.login('zoe');
    final company = await env.createCompany(boss);
    await env.store.addMember(company, eva.id, Role.employee);
    await env.store.addMember(company, zoe.id, Role.employee);
    expect((await zoe('POST', '/companies/$company/members/${eva.id}/google-link')).$1, 403, reason: 'salarié');
    final members = (await boss.ok('GET', '/companies/$company/members'))['members'] as List;
    expect(members.firstWhere((m) => m['user']['id'] == eva.id)['telegramLinked'], false);
    final path = (await boss.ok('POST', '/companies/$company/members/${eva.id}/google-link'))['path'] as String;
    expect(path, startsWith('/switch/'));
    final notices = (await eva.ok('GET', '/notices'))['notices'] as List;
    expect(notices.first['kind'], 'google_switch_link');
    final token = path.substring('/switch/'.length);
    final (status, body) =
        await Client(env.handler).call('POST', '/auth/google', {'idToken': 'google:eva.new', 'switchToken': token});
    expect([status, body['user']['id']], [200, eva.id]);
    expect((await eva('GET', '/me')).$1, 401);
    expect((await Client(env.handler).call('POST', '/auth/google', {'idToken': 'google:x', 'switchToken': token})).$1, 404,
        reason: 'une seule fois');
    // Avec un Telegram relié : la personne passe par le bot.
    await linkTelegram(zoe, 43);
    expect((await boss('POST', '/companies/$company/members/${zoe.id}/google-link')).$1, 409);
  });
}
