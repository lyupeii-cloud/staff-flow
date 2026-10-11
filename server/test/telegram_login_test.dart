import 'package:test/test.dart';

import 'helpers.dart';

/// /connexion : lien de connexion à l'application web, envoyé par le bot.
void main() {
  final env = TestEnv();

  Future<void> say(int chatId, String text) => env.api.telegram.handle({
        'message': {
          'chat': {'id': chatId, 'type': 'private'},
          'from': {'id': chatId, 'language_code': 'fr'},
          'text': text,
        },
      });

  test('lien à usage unique, 5 minutes ; le bot prévient de la connexion', () async {
    final eva = await env.login('eva');
    final url = (await eva.ok('POST', '/me/telegram/link'))['url'] as String;
    await say(42, '/start ${Uri.parse(url).queryParameters['start']}');
    await say(42, '/connexion');
    final link = env.telegram.lastButtons!.single.$1;
    expect(link, startsWith('https://app.staff-flow.cloud/connexion/'));
    final token = link.split('/').last;
    final (status, body) = await Client(env.handler).call('POST', '/auth/telegram', {'token': token});
    expect([status, body['user']['id']], [200, eva.id]);
    expect(env.telegram.sent.last.$1, 42, reason: 'le bot prévient');
    expect((await Client(env.handler).call('POST', '/auth/telegram', {'token': token})).$1, 404, reason: 'une seule fois');
    // Expiré au bout de 5 minutes.
    await say(42, '/connexion');
    final late = env.telegram.lastButtons!.single.$1.split('/').last;
    env.clock.advance(const Duration(minutes: 6));
    expect((await Client(env.handler).call('POST', '/auth/telegram', {'token': late})).$1, 404);
  });

  test('Telegram non relié : pas de lien ; 5 liens par heure au plus', () async {
    await say(7, '/connexion');
    expect([env.telegram.sent.last.$2.contains('aucun compte'), env.telegram.lastButtons], [true, null]);
    final eva = await env.login('eva');
    final url = (await eva.ok('POST', '/me/telegram/link'))['url'] as String;
    await say(42, '/start ${Uri.parse(url).queryParameters['start']}');
    for (var i = 0; i < 5; i++) {
      await say(42, '/connexion');
    }
    await say(42, '/connexion');
    expect(env.telegram.sent.last.$2, contains('Trop de liens'));
  });
}
