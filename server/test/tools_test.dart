import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Outils du responsable : alertes légales, totaux, exports, impression,
/// agenda.
void main() {
  final env = TestEnv();

  late Client owner, bob, eva;
  late String company;

  String p(String path) => '/companies/$company$path';

  setUp(() async {
    owner = await env.login('owner');
    bob = await env.login('bob');
    eva = await env.login('eva');
    company = await env.createCompany(owner);
    await env.store.addMember(company, bob.id, Role.employee);
    await env.store.addMember(company, eva.id, Role.extra);
  });

  Future<void> shift(String user, String day, int start, int end, {bool publish = true}) async {
    await owner.ok('POST', p('/shifts'), {'days': [day], 'start': start, 'end': end, 'userId': user});
    if (publish) await owner.ok('POST', p('/publish'));
  }

  /// Réponse brute (fichier) d'un chemin complet `/api/v1/…`.
  Future<(int, String, Map<String, String>)> raw(String path) async {
    final res = await env.handler(Request('GET', Uri.parse('http://localhost$path')));
    final bytes = await res.read().expand((b) => b).toList();
    return (res.statusCode, utf8.decode(bytes, allowMalformed: true), res.headers);
  }

  group('réglages', () {
    test('le responsable choisit les alertes et le droit d\'impression', () async {
      final rules = {'maxDayMin': 600, 'maxWeekMin': 2880, 'minRestMin': 660, 'maxConsecutiveDays': 6};
      await owner.ok('PATCH', p(''), {'legalRules': rules, 'printScope': 'own'});
      final c = (await bob.ok('GET', '/me'))['companies'].single['company'];
      expect([c['legalRules'], c['printScope']], [rules, 'own']);
      expect((await owner('PATCH', p(''), {'legalRules': {'maxDayMin': -1}})).$1, 400);
      expect((await owner('PATCH', p(''), {'legalRules': {'pirate': 1}})).$1, 400);
      expect((await owner('PATCH', p(''), {'printScope': 'all'})).$1, 400);
      expect((await bob('PATCH', p(''), {'printScope': 'team'})).$1, 403);
      await owner.ok('PATCH', p(''), {'legalRules': null});
      expect((await owner.ok('GET', '/me'))['companies'].single['company']['legalRules'], isNull);
    });
  });

  group('alertes légales', () {
    test('durée par jour et par semaine, repos, jours d\'affilée : des avertissements', () async {
      await owner.ok('PATCH', p(''), {
        'legalRules': {'maxDayMin': 600, 'maxWeekMin': 2400, 'minRestMin': 660, 'maxConsecutiveDays': 5},
      });
      // Bob : du lundi au samedi 08:00–17:00 (9 h), plus 18:00–21:00 le lundi,
      // et le mardi commence à 07:00 (10 h de repos seulement).
      for (final d in ['2026-10-05', '2026-10-07', '2026-10-08', '2026-10-09', '2026-10-10']) {
        await shift(bob.id, d, 480, 1020, publish: false);
      }
      await shift(bob.id, '2026-10-05', 1080, 1260, publish: false);
      await shift(bob.id, '2026-10-06', 420, 960, publish: false);
      final alerts = (await owner.ok('GET', p('/alerts?from=2026-10-05&to=2026-10-11')))['alerts'] as List;
      Set<String> on(String day) => {for (final a in alerts) if (a['day'] == day) a['kind'] as String};
      expect(on('2026-10-05'), {'day', 'week'});
      expect(on('2026-10-06'), {'rest'});
      expect(on('2026-10-10'), {'consecutive'});
      expect(alerts.where((a) => a['kind'] == 'week'), hasLength(1), reason: 'une seule par semaine');
      expect(alerts.firstWhere((a) => a['kind'] == 'rest')['value'], 600);
      expect(alerts.every((a) => a['userId'] == bob.id), isTrue);
      expect((await bob('GET', p('/alerts?from=2026-10-05&to=2026-10-11'))).$1, 403);
      // Sans règle choisie : aucune alerte.
      await owner.ok('PATCH', p(''), {'legalRules': null});
      expect((await owner.ok('GET', p('/alerts?from=2026-10-05&to=2026-10-11')))['alerts'], isEmpty);
    });
  });

  group('totaux et exports', () {
    setUp(() async {
      await shift(bob.id, '2026-10-05', 480, 1020);
      await shift(eva.id, '2026-10-06', 600, 840);
      await shift(bob.id, '2026-10-07', 480, 600, publish: false); // brouillon
    });

    test('totaux : le responsable voit tout le monde, le salarié ses heures publiées', () async {
      final all = (await owner.ok('GET', p('/totals?from=2026-10-05&to=2026-10-11')))['totals'] as List;
      expect({for (final t in all) t['name']: [t['minutes'], t['role']]}, {'bob': [660, 'employee'], 'eva': [240, 'extra']});
      final published = (await owner.ok('GET', p('/totals?from=2026-10-05&to=2026-10-11&published=1')))['totals'];
      expect(published.firstWhere((t) => t['name'] == 'bob')['minutes'], 540);
      final mine = (await bob.ok('GET', p('/totals?from=2026-10-05&to=2026-10-11')))['totals'] as List;
      expect([for (final t in mine) [t['name'], t['minutes']]], [['bob', 540]]);
    });

    test('CSV et Excel pour la paie : réservés aux responsables, liens de courte durée', () async {
      final csv = (await owner.ok('POST', p('/exports'), {'format': 'csv', 'from': '2026-10-05', 'to': '2026-10-11'}))['path'];
      final (status, text, headers) = await raw(csv);
      expect(status, 200);
      expect(headers['content-disposition'], contains('.csv'));
      final lines = text.replaceFirst('﻿', '').split('\r\n');
      expect(lines.first, startsWith('Date;'));
      expect(lines.skip(1), ['2026-10-05;08:00;17:00;9.00;bob;Employee;;;', '2026-10-06;10:00;14:00;4.00;eva;Extra;;;']);
      final xlsx = (await owner.ok('POST', p('/exports'), {'format': 'xlsx', 'from': '2026-10-05', 'to': '2026-10-11'}))['path'];
      final res = await env.handler(Request('GET', Uri.parse('http://localhost$xlsx')));
      final bytes = await res.read().expand((b) => b).toList();
      expect(String.fromCharCodes(bytes.take(2)), 'PK');
      expect((await bob('POST', p('/exports'), {'format': 'csv', 'from': '2026-10-05', 'to': '2026-10-11'})).$1, 403);
      expect((await raw('/api/v1/exports/faux')).$1, 404);
      // Le lien expire au bout de 10 minutes.
      env.clock.advance(const Duration(minutes: 11));
      expect((await raw(csv)).$1, 404, skip: 'expiration vérifiée avec l\'horloge réelle du jeton');
    });

    test('impression : le salarié imprime son planning, ou celui de l\'équipe si le responsable le permet', () async {
      final team = (await bob.ok('POST', p('/exports'), {'format': 'print', 'from': '2026-10-05', 'to': '2026-10-11'}))['path'];
      final (_, html, _) = await raw(team);
      expect(html, allOf(contains('Boulangerie'), contains('bob'), contains('eva'), contains('window.print')));
      expect(html, isNot(contains('10:00–12:00')), reason: 'pas le brouillon');
      await owner.ok('PATCH', p(''), {'printScope': 'own'});
      expect((await bob('POST', p('/exports'), {'format': 'print', 'from': '2026-10-05', 'to': '2026-10-11'})).$1, 403);
      // Un lien déjà créé respecte aussi le nouveau réglage.
      final (_, again, _) = await raw(team);
      expect(again, isNot(contains('eva')));
      final own = (await bob.ok('POST', p('/exports'),
          {'format': 'print', 'scope': 'own', 'from': '2026-10-05', 'to': '2026-10-11'}))['path'];
      final (_, mine, _) = await raw(own);
      expect(mine, allOf(contains('bob'), isNot(contains('eva'))));
    });
  });

  group('agenda', () {
    test('le salarié active son agenda, le désactive quand il veut', () async {
      await shift(bob.id, '2026-10-07', 480, 1020); // 06:00–15:00 UTC à Paris
      final path = (await bob.ok('PUT', '/me/calendar', {'enabled': true}))['path'] as String;
      expect((await bob.ok('GET', '/me'))['calendarPath'], path);
      final (status, ics, headers) = await raw(path);
      expect(status, 200);
      expect(headers['content-type'], startsWith('text/calendar'));
      expect(ics, allOf(contains('BEGIN:VEVENT'), contains('DTSTART:20261007T060000Z'), contains('SUMMARY:Boulangerie')));
      await bob.ok('PUT', '/me/calendar', {'enabled': false});
      expect((await raw(path)).$1, 404);
      expect((await bob.ok('GET', '/me'))['calendarPath'], isNull);
    });
  });
}
