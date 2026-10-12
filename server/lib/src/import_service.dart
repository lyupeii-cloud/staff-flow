import 'dart:convert';
import 'dart:math';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:excel/excel.dart';
import 'package:qr/qr.dart';

import 'company_service.dart';
import 'errors.dart';
import 'messages.dart';
import 'models.dart';
import 'store.dart';

/// Importation des salariés depuis un fichier (Excel ou CSV), puis
/// invitations : chacun reçoit un code personnel (et son QR code), et une
/// personne dont l'e-mail Google figure dans le fichier voit l'invitation
/// d'elle-même à sa connexion. Personne n'est ajouté sans son accord.
class ImportService {
  final Store store;
  final CompanyService companies;
  final SecretKey _key;
  final DateTime Function() now;
  final String appUrl;

  static const maxRows = 2000;
  static const maxBytes = 2 * 1024 * 1024;
  static const inviteLifetime = Duration(days: 90);
  static const maxFailures = 10;
  static const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  final _random = Random.secure();

  /// Codes erronés par personne (dernière heure).
  final Map<String, List<DateTime>> _failures = {};

  ImportService(this.store, this.companies, String secret, {required this.now, required this.appUrl})
      : _key = SecretKey(secret);

  // --- Modèle à remplir

  /// Fichier Excel vide, en-têtes dans la langue demandée.
  List<int> template(String lang) {
    String t(String fr) => translate(fr, lang);
    final headers = [
      t('Nom et prénom'),
      t('E-mail Google (facultatif)'),
      t('Matricule (facultatif)'),
      t('Poste (facultatif)'),
      t('Site (facultatif)'),
    ];
    final helpLines = [
      t('Une ligne par salarié, à partir de la ligne 2. Seul le nom est obligatoire.'),
      t('E-mail Google : la personne verra l\'invitation dès sa connexion à Staff Flow.'),
      t('Sans e-mail : donnez-lui son code d\'invitation ou son QR code (feuille à imprimer après l\'importation).'),
      t('Matricule : votre propre numéro de salarié ; l\'identifiant Staff Flow reste attribué.'),
      t('Poste et site : écrits comme dans Staff Flow ; ceux qui n\'existent pas encore seront créés.'),
    ];
    final excel = Excel.createExcel();
    final people = t('Salariés');
    excel.rename(excel.getDefaultSheet()!, people);
    final sheet = excel[people];
    final bold = CellStyle(bold: true);
    for (var i = 0; i < headers.length; i++) {
      final cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(headers[i]);
      cell.cellStyle = bold;
      sheet.setColumnWidth(i, i == 1 ? 34 : 24);
    }
    final help = excel[t('Aide')];
    for (var i = 0; i < helpLines.length; i++) {
      help.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i)).value = TextCellValue(helpLines[i]);
    }
    help.setColumnWidth(0, 110);
    return excel.encode()!;
  }

  // --- Lecture du fichier

  /// Lignes du fichier (première feuille pour Excel).
  static List<List<String>> readFile(List<int> bytes, String fileName) {
    if (bytes.length > maxBytes) throw const ApiError.badRequest('Fichier trop lourd (2 Mo au plus).');
    final name = fileName.toLowerCase();
    if (name.endsWith('.xlsx')) {
      final Excel excel;
      try {
        excel = Excel.decodeBytes(bytes);
      } catch (_) {
        throw const ApiError.badRequest('Fichier illisible : enregistrez-le au format Excel (.xlsx) ou CSV.');
      }
      final sheet = excel.tables.values.firstOrNull;
      if (sheet == null) return const [];
      return [
        for (final row in sheet.rows) [for (final c in row) _cellText(c?.value)],
      ];
    }
    if (name.endsWith('.csv') || name.endsWith('.txt')) {
      var text = utf8.decode(bytes, allowMalformed: true);
      if (text.startsWith('﻿')) text = text.substring(1);
      return _csv(text);
    }
    throw const ApiError.badRequest('Fichier illisible : enregistrez-le au format Excel (.xlsx) ou CSV.');
  }

  static String _cellText(CellValue? v) => switch (v) {
        null => '',
        // 12 plutôt que 12.0 pour un matricule numérique.
        DoubleCellValue(:final value) when value == value.roundToDouble() => value.toInt().toString(),
        _ => v.toString(),
      }
          .trim();

  /// CSV : virgule, point-virgule ou tabulation ; guillemets doublés.
  static List<List<String>> _csv(String text) {
    final first = text.split('\n').first;
    final sep = [';', '\t', ','].reduce((a, b) => first.split(a).length >= first.split(b).length ? a : b);
    final rows = <List<String>>[];
    var row = <String>[];
    final cell = StringBuffer();
    var quoted = false;
    for (var i = 0; i < text.length; i++) {
      final c = text[i];
      if (quoted) {
        if (c == '"' && i + 1 < text.length && text[i + 1] == '"') {
          cell.write('"');
          i++;
        } else if (c == '"') {
          quoted = false;
        } else {
          cell.write(c);
        }
      } else if (c == '"') {
        quoted = true;
      } else if (c == sep) {
        row.add(cell.toString().trim());
        cell.clear();
      } else if (c == '\n' || c == '\r') {
        if (c == '\r' && i + 1 < text.length && text[i + 1] == '\n') i++;
        row.add(cell.toString().trim());
        cell.clear();
        rows.add(row);
        row = <String>[];
      } else {
        cell.write(c);
      }
    }
    if (cell.isNotEmpty || row.isNotEmpty) {
      row.add(cell.toString().trim());
      rows.add(row);
    }
    return rows;
  }

  static String _fold(String s) {
    const from = 'àáâãäåçèéêëìíîïñòóôõöùúûüýÿœæąćęłńśźżășțđ';
    const to = 'aaaaaaceeeeiiiinooooouuuuyyoaacelnszzastd';
    final b = StringBuffer();
    for (final r in s.toLowerCase().trim().runes) {
      final c = String.fromCharCode(r);
      final i = from.indexOf(c);
      b.write(i < 0 ? c : to[i]);
    }
    return b.toString().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Colonne reconnue d'après son titre, dans les langues de l'application.
  static String? _column(String header) {
    final h = _fold(header);
    if (h.isEmpty) return null;
    bool any(List<String> keys) => keys.any(h.contains);
    if (any(['mail', 'почт', 'correo'])) return 'email';
    if (any(['matric', 'табел', 'numer', 'number', 'nummer', 'numero', 'n°', 'id '])) return 'number';
    if (any(['poste', 'position', 'job', 'metier', 'посад', 'должн', 'stanowisk', 'puesto', 'cargo', 'ruolo', 'post'])) {
      return 'position';
    }
    if (any(['site', 'об\'єкт', 'объект', "об'єкт", 'lokaliz', 'locat', 'standort', 'sitio', 'local', 'sede', 'equipe'])) {
      return 'site';
    }
    if (any(['nom', 'name', 'ім', 'им', 'імя', 'imi', 'nume', 'nombre', 'nome', 'prenom', 'фио', 'піб'])) return 'name';
    return null;
  }

  // --- Importation

  Future<Set<String>?> _manager(User actor, String companyId) async {
    final (company, role) = await companies.open(actor, companyId);
    if (company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
    // Qui gère toute l'entreprise : le patron, un responsable sans site.
    if (role == Role.owner) return null;
    if (role != Role.manager || await companies.managedSites(companyId, actor, role) != null) {
      throw const ApiError.forbidden();
    }
    return null;
  }

  /// Analyse le fichier ; sans [dryRun], crée les invitations des lignes
  /// valides (les lignes en erreur sont ignorées).
  Future<Map<String, dynamic>> run(User actor, String companyId, List<List<String>> table,
      {required bool dryRun, required String lang}) async {
    await _manager(actor, companyId);
    String t(String fr, [Map<String, String> args = const {}]) => translate(fr, lang, args);
    final rows = [for (final r in table) if (r.any((c) => c.trim().isNotEmpty)) r];
    if (rows.isEmpty) throw const ApiError.badRequest('Le fichier est vide.');
    // En-têtes reconnus, sinon l'ordre du modèle.
    final detected = [for (final h in rows.first) _column(h)];
    final hasHeader = detected.contains('name');
    final columns = hasHeader ? detected : const ['name', 'email', 'number', 'position', 'site'];
    final data = hasHeader ? rows.skip(1).toList() : rows;
    if (data.length > maxRows) throw const ApiError.badRequest('Trop de lignes (2000 au plus).');

    // Ce qui existe déjà dans l'entreprise.
    final members = await store.members(companyId);
    final memberByEmail = {for (final m in members) m.user.email.toLowerCase(): m};
    final numbersTaken = {
      for (final m in members)
        if (m.employeeNumber != null) _fold(m.employeeNumber!): m.user.id,
    };
    final invites = await store.query(store.db, '''
      SELECT lower(email), lower(employee_number) FROM member_invites
      WHERE company_id = @c::uuid AND used_at IS NULL AND expires_at > @now''', {'c': companyId, 'now': now()});
    final invitedEmails = {for (final r in invites) if (r[0] != null) r[0] as String};
    for (final r in invites) {
      if (r[1] != null) numbersTaken[_fold(r[1] as String)] = '';
    }
    Future<Map<String, String>> catalog(String table) async => {
          for (final r in await store.query(store.db,
              'SELECT id::text, name FROM $table WHERE company_id = @c::uuid AND archived_at IS NULL', {'c': companyId}))
            _fold(r[1] as String): r[0] as String,
        };
    final positions = await catalog('positions');
    final sites = await catalog('sites');

    final out = <Map<String, dynamic>>[];
    final seenEmails = <String>{}, seenNumbers = <String>{};
    for (var i = 0; i < data.length; i++) {
      final r = data[i];
      String cell(String key) {
        final at = columns.indexOf(key);
        return at < 0 || at >= r.length ? '' : r[at].trim();
      }

      final name = cell('name'), email = cell('email').toLowerCase(), number = cell('number');
      final position = cell('position');
      // « Nord › Lille » : on garde le dernier niveau.
      final site = cell('site').split(RegExp(r'\s*[›>/]\s*')).last.trim();
      final row = <String, dynamic>{
        'line': i + (hasHeader ? 2 : 1),
        'name': name,
        'email': email.isEmpty ? null : email,
        'number': number.isEmpty ? null : number,
        'position': position.isEmpty ? null : position,
        'site': site.isEmpty ? null : site,
        'newPosition': position.isNotEmpty && !positions.containsKey(_fold(position)),
        'newSite': site.isNotEmpty && !sites.containsKey(_fold(site)),
      };
      String? error;
      final member = email.isEmpty ? null : memberByEmail[email];
      if (name.isEmpty || name.length > 120) {
        error = t('Nom manquant ou trop long.');
      } else if (email.isNotEmpty && !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
        error = t('E-mail invalide.');
      } else if (email.isNotEmpty && !seenEmails.add(email)) {
        error = t('E-mail en double dans le fichier.');
      } else if (member == null && invitedEmails.contains(email)) {
        row['status'] = 'skip';
        row['message'] = t('Déjà invité(e).');
      } else if (number.length > 40) {
        error = t('Matricule : 40 caractères au plus.');
      } else if (number.isNotEmpty && !seenNumbers.add(_fold(number))) {
        error = t('Matricule en double dans le fichier.');
      } else if (number.isNotEmpty &&
          numbersTaken.containsKey(_fold(number)) &&
          numbersTaken[_fold(number)] != member?.user.id) {
        error = t('Ce matricule est déjà utilisé dans l\'entreprise.');
      } else if (position.length > 80 || site.length > 80) {
        error = t('Nom entre 1 et 80 caractères.');
      }
      if (row['status'] == 'skip') {
        // Rien à faire.
      } else if (error != null) {
        row['status'] = 'error';
        row['message'] = error;
      } else if (member != null) {
        row['status'] = 'update';
        row['userId'] = member.user.id;
        row['message'] = t('Déjà dans l\'entreprise : matricule et poste mis à jour.');
      } else {
        row['status'] = 'new';
      }
      out.add(row);
    }
    final summary = {
      for (final s in ['new', 'update', 'skip', 'error']) s: out.where((r) => r['status'] == s).length,
    };
    if (dryRun) return {'rows': out, 'summary': summary};

    final created = await store.db.runTx((tx) async {
      Future<String?> ensure(String table, Map<String, String> known, String? raw) async {
        if (raw == null) return null;
        final key = _fold(raw);
        if (known[key] case final id?) return id;
        final rows = await store.query(tx, 'INSERT INTO $table (company_id, name) VALUES (@c::uuid, @n) RETURNING id::text',
            {'c': companyId, 'n': raw});
        return known[key] = rows.first[0] as String;
      }

      var count = 0;
      for (final row in out) {
        final status = row['status'];
        if (status != 'new' && status != 'update') continue;
        final positionId = await ensure('positions', positions, row['position'] as String?);
        final siteId = await ensure('sites', sites, row['site'] as String?);
        if (status == 'update') {
          await store.query(tx, '''
            UPDATE memberships SET employee_number = coalesce(@n, employee_number), position_id = coalesce(@p::uuid, position_id)
            WHERE company_id = @c::uuid AND user_id = @u::uuid AND left_at IS NULL''',
              {'c': companyId, 'u': row['userId'], 'n': row['number'], 'p': positionId});
          continue;
        }
        await store.query(tx, '''
          INSERT INTO member_invites (company_id, code, name, email, employee_number, position_id, sites, created_by, expires_at)
          VALUES (@c::uuid, @code, @name, @email, @n, @p::uuid, @s::uuid[], @by::uuid, @exp)''', {
          'c': companyId,
          'code': _code(),
          'name': row['name'],
          'email': row['email'],
          'n': row['number'],
          'p': positionId,
          's': siteId == null ? null : [siteId],
          'by': actor.id,
          'exp': now().add(inviteLifetime),
        });
        count++;
      }
      await store.audit(
          companyId: companyId,
          actorId: actor.id,
          action: 'member.import',
          details: {'invites': count, 'updated': summary['update']},
          tx: tx);
      return count;
    });
    return {'rows': out, 'summary': summary, 'created': created};
  }

  String _code() => List.generate(8, (_) => _alphabet[_random.nextInt(_alphabet.length)]).join();

  /// « abcd-efgh » → « ABCDEFGH ».
  static String cleanCode(String raw) => raw.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

  // --- Invitations en attente

  Future<List<Map<String, dynamic>>> list(User actor, String companyId) async {
    await _manager(actor, companyId);
    final rows = await store.query(store.db, '''
      SELECT i.id::text, i.code, i.name, i.email, i.employee_number, i.position_id::text, i.sites::text[],
        i.created_at, i.expires_at, EXISTS (SELECT 1 FROM join_requests r WHERE r.invite_id = i.id AND r.status = 'pending')
      FROM member_invites i
      WHERE i.company_id = @c::uuid AND i.used_at IS NULL AND i.expires_at > @now
      ORDER BY i.name''', {'c': companyId, 'now': now()});
    return [
      for (final r in rows)
        {
          'id': r[0],
          'code': r[1],
          'name': r[2],
          'email': r[3],
          'employeeNumber': r[4],
          'positionId': r[5],
          'sites': r[6],
          'createdAt': (r[7] as DateTime).toUtc().toIso8601String(),
          'expiresAt': (r[8] as DateTime).toUtc().toIso8601String(),
          'requested': r[9],
          'link': '$appUrl/invite/${r[1]}',
        },
    ];
  }

  Future<void> delete(User actor, String companyId, String inviteId) async {
    await _manager(actor, companyId);
    // Une invitation déjà proposée (e-mail) n'attend plus de réponse.
    await store.query(store.db, '''
      UPDATE join_requests SET status = 'declined', resolved_at = now()
      WHERE invite_id::text = @i AND company_id = @c::uuid AND status = 'pending' ''', {'i': inviteId, 'c': companyId});
    final rows = await store.query(store.db, '''
      DELETE FROM member_invites WHERE id::text = @i AND company_id = @c::uuid AND used_at IS NULL RETURNING id''',
        {'i': inviteId, 'c': companyId});
    if (rows.isEmpty) throw const ApiError.notFound('Invitation introuvable.');
    await store.audit(companyId: companyId, actorId: actor.id, action: 'member.invite_delete', details: {'id': inviteId});
  }

  /// La personne saisit (ou scanne) son code : elle rejoint l'entreprise.
  Future<(String, String)> redeem(User user, String raw) async {
    final at = now();
    final recent = (_failures[user.id] ?? const <DateTime>[])
        .where((d) => at.difference(d) < const Duration(hours: 1))
        .toList();
    _failures[user.id] = recent;
    if (recent.length >= maxFailures) {
      throw const ApiError(429, 'too_many_attempts', 'Trop de codes erronés : réessayez dans une heure.');
    }
    final code = cleanCode(raw);
    final rows = await store.query(store.db, '''
      SELECT i.id::text, i.company_id::text, c.name FROM member_invites i JOIN companies c ON c.id = i.company_id
      WHERE i.code = @code AND i.used_at IS NULL AND i.expires_at > @now''', {'code': code, 'now': at});
    if (rows.isEmpty) {
      recent.add(at);
      throw const ApiError.notFound('Code d\'invitation inconnu ou expiré.');
    }
    final inviteId = rows.first[0] as String, companyId = rows.first[1] as String;
    if (await store.roleOf(companyId, user.id) != null) {
      throw const ApiError.conflict('Vous faites déjà partie de cette entreprise.');
    }
    final company = await store.findCompany(companyId);
    if (company == null || company.status == CompanyStatus.readOnly) {
      throw const ApiError.conflict('Cette entreprise est en lecture seule.');
    }
    final invite = await store.query(store.db, 'SELECT sites::text[] FROM member_invites WHERE id = @i::uuid', {'i': inviteId});
    await store.addMember(companyId, user.id, Role.employee, sites: (invite.first[0] as List?)?.cast<String>());
    await applyInvite(store, companyId, user.id, inviteId);
    await store.audit(companyId: companyId, actorId: user.id, action: 'join.invite_code', details: {'inviteId': inviteId});
    return (companyId, rows.first[2] as String);
  }

  /// Une fois la personne dans l'entreprise : nom donné par l'employeur,
  /// matricule (s'il est encore libre) et poste ; l'invitation est utilisée.
  static Future<void> applyInvite(Store store, String companyId, String userId, String inviteId) async {
    final rows = await store.query(store.db, '''
      UPDATE member_invites SET used_at = now(), used_by = @u::uuid
      WHERE id = @i::uuid AND used_at IS NULL
      RETURNING name, employee_number, position_id::text''', {'i': inviteId, 'u': userId});
    if (rows.isEmpty) return;
    await store.setMemberName(companyId, userId, rows.first[0] as String);
    final number = rows.first[1] as String?, position = rows.first[2] as String?;
    if (!await store.setMemberProfile(companyId, userId, number, position)) {
      await store.setMemberProfile(companyId, userId, null, position);
    }
  }

  /// Invitations dont l'e-mail est celui du compte Google : proposées à la
  /// personne (elle accepte ou refuse, comme une invitation par QR code).
  Future<void> claimByEmail(User user) async {
    if (user.email.isEmpty) return;
    await store.query(store.db, '''
      INSERT INTO join_requests (company_id, user_id, role, invited_by, sites, invite_id)
      SELECT i.company_id, @u::uuid, 'employee', i.created_by, i.sites, i.id
      FROM member_invites i
      WHERE lower(i.email) = lower(@e) AND i.used_at IS NULL AND i.expires_at > @now
        AND NOT EXISTS (SELECT 1 FROM join_requests r WHERE r.invite_id = i.id)
        AND NOT EXISTS (SELECT 1 FROM memberships m WHERE m.company_id = i.company_id AND m.user_id = @u::uuid AND m.left_at IS NULL)
      ON CONFLICT DO NOTHING''', {'u': user.id, 'e': user.email, 'now': now()});
  }

  // --- Feuille à imprimer : un code et un QR code par personne

  Future<String> sheetLink(User actor, String companyId, String lang) async {
    await _manager(actor, companyId);
    final jwt = JWT({'c': companyId, 'l': lang}, subject: actor.id, issuer: 'staff-flow-invites');
    return '/api/v1/invite-sheets/${jwt.sign(_key, expiresIn: const Duration(minutes: 10))}';
  }

  Future<String> sheet(String token) async {
    final JWT jwt;
    try {
      jwt = JWT.verify(token, _key, issuer: 'staff-flow-invites');
    } on JWTException {
      throw const ApiError.notFound('Lien expiré.');
    }
    final claims = jwt.payload as Map<String, dynamic>;
    final user = await store.findUser(jwt.subject!);
    if (user == null) throw const ApiError.notFound('Lien expiré.');
    final companyId = claims['c'] as String;
    final company = await store.findCompany(companyId);
    final invites = await list(user, companyId);
    final lang = claims['l'] as String? ?? 'en';
    String t(String fr) => _esc(translate(fr, lang));
    final positions = {
      for (final r in await store.query(store.db, 'SELECT id::text, name FROM positions WHERE company_id = @c::uuid',
          {'c': companyId}))
        r[0] as String: r[1] as String,
    };
    final cards = StringBuffer();
    for (final i in invites) {
      final code = i['code'] as String;
      cards.write('''
<div class="card">
  <div class="qr">${_qrSvg(i['link'] as String)}</div>
  <div class="info">
    <div class="name">${_esc(i['name'] as String)}</div>
    <div class="meta">${[?i['employeeNumber'], ?positions[i['positionId']]].map((s) => _esc('$s')).join(' · ')}</div>
    <div class="code">${code.substring(0, 4)}-${code.substring(4)}</div>
    <div class="how">${t('Installez Staff Flow (ou ouvrez app.staff-flow.cloud), connectez-vous avec Google, puis scannez ce QR code ou saisissez ce code d\'invitation.')}</div>
  </div>
</div>''');
    }
    return '''<!doctype html><html lang="$lang"><head><meta charset="utf-8">
<title>${t('Invitations')} — ${_esc(company?.name ?? '')}</title>
<style>
body{font-family:Arial,sans-serif;margin:24px;color:#061440}
h1{font-size:20px;margin:0 0 16px}
.grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
.card{display:flex;gap:12px;border:1px dashed #8a94b0;border-radius:12px;padding:12px;break-inside:avoid}
.qr svg{width:120px;height:120px}
.name{font-weight:bold;font-size:16px}.meta{color:#555;font-size:12px;margin:2px 0 6px}
.code{font-family:monospace;font-size:22px;letter-spacing:2px;margin-bottom:6px}
.how{font-size:11px;color:#333}
@media print{body{margin:8mm}button{display:none}}
</style></head><body>
<h1>${t('Invitations')} — ${_esc(company?.name ?? '')}</h1>
<button onclick="print()">${t('Imprimer')}</button><p></p>
<div class="grid">$cards</div>
</body></html>''';
  }

  static String _qrSvg(String data) {
    final image = QrImage(QrCode.fromData(data: data, errorCorrectLevel: QrErrorCorrectLevel.M));
    final n = image.moduleCount;
    final path = StringBuffer();
    for (var y = 0; y < n; y++) {
      for (var x = 0; x < n; x++) {
        if (image.isDark(y, x)) path.write('M${x + 2} ${y + 2}h1v1h-1z');
      }
    }
    return '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${n + 4} ${n + 4}" shape-rendering="crispEdges">'
        '<rect width="100%" height="100%" fill="#fff"/><path d="$path" fill="#000"/></svg>';
  }

  static String _esc(String s) =>
      s.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;').replaceAll('"', '&quot;');
}
