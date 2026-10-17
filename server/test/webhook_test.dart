import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Webhooks (option « API Pro ») : envois signés, réessais, coupure.
void main() {
  final env = TestEnv();

  late Client boss;
  late String company;

  setUp(() async {
    boss = await env.login('boss');
    company = await env.createCompany(boss);
  });

  String p(String path) => '/companies/$company$path';

  Future<void> pro() async {
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false});
    await boss.ok('POST', p('/billing/addon'), {'option': 'pro'});
  }

  Future<Map> hook(List<String> events, [String url = 'https://erp.example.com/staff-flow']) async =>
      await boss.ok('POST', p('/webhooks'), {'url': url, 'events': events}) as Map;

  test('API Pro seulement ; patron et responsables qui gèrent l\'abonnement ; 5 au plus', () async {
    final body = {'url': 'https://erp.example.com/x', 'events': ['member.joined']};
    expect((await boss('POST', p('/webhooks'), body)).$1, 402);
    await boss.ok('POST', p('/billing/checkout'), {'period': 'month', 'cascade': false});
    expect((await boss('POST', p('/webhooks'), body)).$1, 402);
    await boss.ok('POST', p('/billing/addon'), {'option': 'pro'});
    expect((await boss('POST', p('/webhooks'), {...body, 'events': ['nope']})).$1, 400);
    expect((await boss('POST', p('/webhooks'), {...body, 'url': 'ftp://x'})).$1, 400);
    final m = await env.login('m');
    await env.store.addMember(company, m.id, Role.manager);
    expect((await m('GET', p('/webhooks'))).$1, 403);
    await boss.ok('PUT', p('/members/${m.id}/billing'), {'enabled': true});
    final created = await m.ok('POST', p('/webhooks'), body);
    expect((created['secret'] as String).startsWith('whsec_'), true);
    for (var i = 0; i < 4; i++) {
      await hook(['member.joined'], 'https://erp.example.com/$i');
    }
    expect((await boss('POST', p('/webhooks'), body)).$1, 409);
    // Le secret n'est jamais relu.
    expect(((await boss.ok('GET', p('/webhooks')))['webhooks'] as List).first.containsKey('secret'), false);
  });

  test('événements signés : salarié arrivé, planning publié, demande ; option terminée : plus rien', () async {
    await pro();
    final h = await hook(['member.joined', 'schedule.published', 'request.created', 'request.decided']);
    final bob = await env.login('bob');
    await env.store.addMember(company, bob.id, Role.employee);
    await boss.ok('PUT', p('/members/${bob.id}/profile'), {'employeeNumber': 'M-7'});
    await boss.ok('POST', p('/shifts'), {'userId': bob.id, 'days': ['2026-10-20'], 'start': 480, 'end': 960});
    await boss.ok('POST', p('/publish'));
    final req = await bob.ok('POST', p('/requests'), {'kind': 'leave', 'startDay': '2026-11-02', 'endDay': '2026-11-03'});
    await boss.ok('POST', '/requests/${req['id']}/approve');
    expect(await env.api.webhooks.deliver(), 4);
    expect([for (final r in env.hooks) r.headers['staff-flow-event']],
        ['member.joined', 'schedule.published', 'request.created', 'request.decided']);
    // Signature : HMAC-SHA256 de « horodatage.corps » avec le secret.
    final first = env.hooks.first;
    final sig = RegExp(r't=(\d+),v1=([0-9a-f]+)').firstMatch(first.headers['staff-flow-signature']!)!;
    expect(Hmac(sha256, utf8.encode(h['secret'] as String)).convert(utf8.encode('${sig[1]}.${first.body}')).toString(),
        sig[2]);
    final joined = jsonDecode(first.body) as Map;
    expect([joined['event'], joined['data']['person']['sfId'] != null, joined['company']['name']],
        ['member.joined', true, 'Boulangerie']);
    final decided = jsonDecode(env.hooks.last.body)['data'] as Map;
    expect([decided['kind'], decided['approved'], decided['person']['employeeNumber']], ['leave', true, 'M-7']);
    // Option non renouvelée puis terminée : plus d'envoi.
    await boss.ok('PUT', p('/billing/renewal'), {'option': 'pro', 'renew': false});
    env.clock.advance(const Duration(days: 70));
    await env.api.billing.tick();
    await env.store.addMember(company, (await env.login('eve')).id, Role.employee);
    expect(await env.api.webhooks.deliver(), 0);
    expect(env.hooks, hasLength(4));
  });

  test('échec : réessai après le délai ; envoi d\'essai ; coupure après 10 abandons', () async {
    await pro();
    final h = await hook(['member.joined']);
    env.hookStatus = 500;
    final test = await boss.ok('POST', p('/webhooks/${h['id']}/test'));
    env.clock.advance(const Duration(seconds: 1));
    expect([test['delivered'], test['httpStatus']], [false, 500]);
    await env.store.addMember(company, (await env.login('bob')).id, Role.employee);
    expect(await env.api.webhooks.deliver(), 0);
    expect(env.hooks, hasLength(2));
    // Pas de nouvel essai avant le délai.
    await env.api.webhooks.deliver();
    expect(env.hooks, hasLength(2));
    env.hookStatus = 200;
    env.clock.advance(const Duration(minutes: 2));
    expect(await env.api.webhooks.deliver(), 1);
    var list = ((await boss.ok('GET', p('/webhooks')))['webhooks'] as List).first as Map;
    expect([list['enabled'], list['failures'], list['recent'][0]['status'], list['recent'][0]['attempts']],
        [true, 0, 'delivered', 2]);
    // 10 envois abandonnés d'affilée : l'adresse est coupée, puis réactivée.
    env.hookStatus = 500;
    for (var i = 0; i < 10; i++) {
      await env.store.addMember(company, (await env.login('p$i')).id, Role.employee);
    }
    for (var i = 0; i <= WebhookService.retries.length; i++) {
      await env.api.webhooks.deliver();
      env.clock.advance(const Duration(hours: 13));
    }
    list = ((await boss.ok('GET', p('/webhooks')))['webhooks'] as List).first as Map;
    expect([list['enabled'], list['failures']], [false, 10]);
    await boss.ok('PATCH', p('/webhooks/${h['id']}'), {'enabled': true});
    list = ((await boss.ok('GET', p('/webhooks')))['webhooks'] as List).first as Map;
    expect([list['enabled'], list['failures']], [true, 0]);
    expect((await boss('DELETE', p('/webhooks/${h['id']}'))).$1, 204);
  });
}
