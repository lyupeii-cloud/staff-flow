import 'dart:convert';

import 'package:excel/excel.dart';
import 'package:shelf/shelf.dart';
import 'package:staff_flow_server/staff_flow_server.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final env = TestEnv();

  late Client boss, bob;
  late String company;

  setUp(() async {
    boss = await env.login('boss');
    bob = await env.login('bob');
    company = await env.createCompany(boss);
  });

  String p(String path) => '/companies/$company$path';

  Map<String, Object?> csv(String text, {bool dryRun = false}) =>
      {'file': base64Encode(utf8.encode(text)), 'fileName': 'equipe.csv', 'dryRun': dryRun};

  group('importation', () {
    test('aperçu puis invitations ; postes et sites créés ; erreurs signalées', () async {
      const file = 'Nom et prénom;E-mail Google;Matricule;Poste;Site\n'
          'Marie Dupont;;M-1;Maçon;Chantier Nord\n'
          '"Jean ""Jo"" Martin";jean@example.com;M-2;maçon;\n'
          ';x@example.com;M-3;;\n'
          'Paul;;m-1;;\n';
      final preview = await boss.ok('POST', p('/imports'), csv(file, dryRun: true));
      expect([for (final r in preview['rows']) r['status']], ['new', 'new', 'error', 'error']);
      expect(preview['rows'][1]['name'], 'Jean "Jo" Martin');
      expect(preview['rows'][0]['newPosition'], isTrue);
      expect((await boss.ok('GET', p('/invites')))['invites'], isEmpty, reason: 'aperçu : rien de créé');

      final done = await boss.ok('POST', p('/imports'), csv(file));
      expect(done['created'], 2);
      final invites = (await boss.ok('GET', p('/invites')))['invites'] as List;
      expect([for (final i in invites) i['name']], ['Jean "Jo" Martin', 'Marie Dupont']);
      expect(invites.first['code'], hasLength(8));
      final positions = (await boss.ok('GET', p('/positions')))['items'] as List;
      expect([for (final x in positions) x['name']], ['Maçon'], reason: 'un seul poste malgré la casse');
      expect(((await boss.ok('GET', p('/sites')))['items'] as List).single['name'], 'Chantier Nord');

      // Réimporter le même fichier : les matricules sont déjà réservés par les invitations.
      // La colonne e-mail est ignorée (deux personnes peuvent avoir le même).
      final again = await boss.ok('POST', p('/imports'), csv(file, dryRun: true));
      expect([again['rows'][0]['status'], again['rows'][1]['status']], ['error', 'error']);
      expect(again['rows'][1]['email'], isNull);
    });

    test('Excel, sans en-têtes reconnus : ordre du modèle', () async {
      final excel = Excel.createExcel();
      final sheet = excel[excel.getDefaultSheet()!];
      sheet.appendRow([TextCellValue('Ana'), IntCellValue(42)]);
      final r = await boss.ok('POST', p('/imports'),
          {'file': base64Encode(excel.encode()!), 'fileName': 'a.xlsx', 'dryRun': true});
      expect(r['rows'].single['number'], '42');
    });

    test('le modèle se télécharge dans la langue demandée', () async {
      final res = await env.handler(Request('GET', Uri.parse('http://localhost/api/v1/import-template?lang=uk')));
      expect(res.statusCode, 200);
      final excel = Excel.decodeBytes(await res.read().expand((b) => b).toList());
      expect(excel.tables.keys, contains('Працівники'));
    });

    test('code personnel : la personne rejoint, avec son nom, son matricule et son poste', () async {
      await boss.ok('POST', p('/imports'), csv('Nom;Matricule;Poste\nRobert;R-7;Caisse\n'));
      final invite = ((await boss.ok('GET', p('/invites')))['invites'] as List).single;
      final code = invite['code'] as String;
      expect((await bob('POST', '/invites/redeem', {'code': 'ZZZZZZZZ'})).$1, 404);
      final joined = await bob.ok('POST', '/invites/redeem', {'code': '${code.substring(0, 4)}-${code.substring(4).toLowerCase()}'});
      expect(joined['companyId'], company);
      final m = ((await boss.ok('GET', p('/members')))['members'] as List).firstWhere((m) => m['user']['id'] == bob.id);
      expect(m['user']['name'], 'Robert');
      expect(m['employeeNumber'], 'R-7');
      expect(m['positionId'], isNotNull);
      expect((await bob('POST', '/invites/redeem', {'code': code})).$1, 404, reason: 'une seule fois');
      expect((await boss.ok('GET', p('/invites')))['invites'], isEmpty);
    });

    test('un salarié n\'importe pas ; feuille à imprimer avec les codes', () async {
      await env.store.addMember(company, bob.id, Role.employee);
      expect((await bob('POST', p('/imports'), csv('Nom\nA\n', dryRun: true))).$1, 403);
      await boss.ok('POST', p('/imports'), csv('Nom\nAlice\n'));
      final link = (await boss.ok('POST', p('/invites/sheet-link')))['path'] as String;
      final res = await env.handler(Request('GET', Uri.parse('http://localhost$link')));
      final html = await res.readAsString();
      expect(html, contains('Alice'));
      expect(html, contains('<svg'));
      final id = ((await boss.ok('GET', p('/invites')))['invites'] as List).single['id'];
      await boss.ok('DELETE', p('/invites/$id'));
      expect((await boss.ok('GET', p('/invites')))['invites'], isEmpty);
    });
  });
}
