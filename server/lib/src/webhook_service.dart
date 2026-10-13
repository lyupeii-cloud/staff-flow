import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart';
import 'package:postgres/postgres.dart';

import 'api_access.dart';
import 'errors.dart';
import 'models.dart';
import 'planning_service.dart' show formatDay;
import 'store.dart';

/// Webhooks (option « API Pro ») : Staff Flow prévient tout seul les logiciels
/// de l'entreprise quand quelque chose se passe (planning publié, demande,
/// nouveau salarié, annonce). Chaque envoi est signé (HMAC-SHA256) et
/// réessayé en cas d'échec ; une adresse qui échoue trop souvent est coupée.
class WebhookService {
  final Store store;
  final ApiAccessService access;
  final http.Client client;
  final DateTime Function() now;
  final Uint8List _aes;

  /// Adresses privées (localhost, réseau interne) refusées, sauf en test.
  final bool allowPrivate;

  WebhookService(
    this.store,
    this.access,
    String secret, {
    http.Client? client,
    required this.now,
    this.allowPrivate = false,
    this.autoDeliver = true,
  }) : client = client ?? http.Client(),
       _aes = Uint8List.fromList(sha256.convert(utf8.encode('$secret:aes')).bytes);

  /// Envoi aussitôt après un événement (désactivé en test : [deliver] à la main).
  final bool autoDeliver;

  static const maxHooks = 5;

  /// Chaque envoi (réussi ou non), pour les journaux de l'entreprise.
  Future<void> Function(String companyId, String event, String url, int? status, String? error, Duration took)? onSent;

  /// Envois ratés d'affilée avant de couper l'adresse.
  static const maxFailures = 10;

  /// Délais avant chaque nouvel essai ; après le dernier, l'envoi est abandonné.
  static const retries = [
    Duration(minutes: 1),
    Duration(minutes: 5),
    Duration(minutes: 30),
    Duration(hours: 2),
    Duration(hours: 6),
    Duration(hours: 12),
  ];

  static const events = [
    'schedule.published',
    'request.created',
    'request.decided',
    'request.cancelled',
    'request.cancel_asked',
    'request.cancel_decided',
    'request.ended',
    'member.joined',
    'announcement.published',
  ];

  /// Action du journal → événement envoyé.
  static const _fromAudit = {
    'planning.publish': 'schedule.published',
    'request.create': 'request.created',
    'request.approved': 'request.decided',
    'request.refused': 'request.decided',
    'request.cancelled': 'request.cancelled',
    'request.cancel_asked': 'request.cancel_asked',
    'request.cancel_approved': 'request.cancel_decided',
    'request.cancel_refused': 'request.cancel_decided',
    'request.ended': 'request.ended',
    'member.joined': 'member.joined',
    'news.publish': 'announcement.published',
  };

  static final _random = Random.secure();

  // --- Gestion (patron et responsables qui gèrent l'abonnement) -------------

  Future<List<Map<String, Object?>>> list(User actor, String companyId) async {
    await access.owned(actor, companyId);
    final hooks = await store.query(
      store.db,
      '''
      SELECT id::text, url, events, created_at, disabled_at, failures FROM webhooks
      WHERE company_id = @c::uuid ORDER BY created_at''',
      {'c': companyId},
    );
    return [
      for (final h in hooks)
        {
          'id': h[0],
          'url': h[1],
          'events': h[2],
          'createdAt': (h[3] as DateTime).toUtc().toIso8601String(),
          'enabled': h[4] == null,
          'failures': h[5],
          'recent': [
            for (final d in await store.query(
              store.db,
              '''
              SELECT event, status, attempts, last_status, created_at FROM webhook_deliveries
              WHERE webhook_id = @w::uuid ORDER BY created_at DESC LIMIT 10''',
              {'w': h[0]},
            ))
              {
                'event': d[0],
                'status': d[1],
                'attempts': d[2],
                'httpStatus': d[3],
                'at': (d[4] as DateTime).toUtc().toIso8601String(),
              },
          ],
        },
    ];
  }

  /// Nouvelle adresse ; le secret de signature n'est montré qu'une fois.
  Future<Map<String, Object?>> create(User actor, String companyId, Object? url, Object? wanted) async {
    final company = await access.owned(actor, companyId);
    if (!ApiAccessService.proAllowed(company)) {
      throw const ApiError(402, 'option_required', 'Option « API Pro » nécessaire pour les webhooks.');
    }
    final address = _checkUrl(url);
    final list = _events(wanted);
    final count = await store.query(store.db, 'SELECT count(*) FROM webhooks WHERE company_id = @c::uuid', {
      'c': companyId,
    });
    if ((count.first[0] as int) >= maxHooks) {
      throw const ApiError.conflict('5 webhooks au plus : supprimez-en un d\'abord.');
    }
    final secret = 'whsec_${List.generate(32, (_) => _random.nextInt(16).toRadixString(16)).join()}';
    final rows = await store.query(
      store.db,
      '''
      INSERT INTO webhooks (company_id, url, events, secret, created_by)
      VALUES (@c::uuid, @u, @e::text[], @s, @a::uuid) RETURNING id::text''',
      {'c': companyId, 'u': address, 'e': list, 's': _seal(secret), 'a': actor.id},
    );
    await store.audit(companyId: companyId, actorId: actor.id, action: 'webhook.created', details: {'url': address});
    return {'id': rows.first[0], 'url': address, 'events': list, 'secret': secret};
  }

  /// Événements choisis, ou réactivation d'une adresse coupée.
  Future<void> update(User actor, String companyId, String id, Map<String, dynamic> body) async {
    await access.owned(actor, companyId);
    final list = body.containsKey('events') ? _events(body['events']) : null;
    final enable = body['enabled'];
    if (enable is! bool?) throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    final rows = await store.query(
      store.db,
      '''
      UPDATE webhooks SET events = coalesce(@e::text[], events),
        disabled_at = CASE WHEN @on::boolean IS NULL THEN disabled_at WHEN @on THEN NULL ELSE coalesce(disabled_at, @t) END,
        failures = CASE WHEN @on::boolean THEN 0 ELSE failures END
      WHERE id::text = @w AND company_id = @c::uuid RETURNING id''',
      {'w': id, 'c': companyId, 'e': list, 'on': enable, 't': now()},
    );
    if (rows.isEmpty) throw const ApiError.notFound();
  }

  Future<void> delete(User actor, String companyId, String id) async {
    await access.owned(actor, companyId);
    final rows = await store.query(
      store.db,
      'DELETE FROM webhooks WHERE id::text = @w AND company_id = @c::uuid RETURNING url',
      {'w': id, 'c': companyId},
    );
    if (rows.isEmpty) throw const ApiError.notFound();
    await store.audit(
      companyId: companyId,
      actorId: actor.id,
      action: 'webhook.deleted',
      details: {'url': rows.first[0]},
    );
  }

  /// Envoi d'essai (« ping »), tout de suite ; renvoie le code HTTP reçu.
  Future<Map<String, Object?>> test(User actor, String companyId, String id) async {
    final company = await access.owned(actor, companyId);
    if (!ApiAccessService.proAllowed(company)) {
      throw const ApiError(402, 'option_required', 'Option « API Pro » nécessaire pour les webhooks.');
    }
    final hook = await store.query(store.db, 'SELECT id FROM webhooks WHERE id::text = @w AND company_id = @c::uuid', {
      'w': id,
      'c': companyId,
    });
    if (hook.isEmpty) throw const ApiError.notFound();
    final delivery = await _queue(store.db, company, id, 'ping', {'message': 'Staff Flow webhook test'});
    await _send(delivery, test: true);
    final d = await store.query(
      store.db,
      'SELECT status, last_status, last_error FROM webhook_deliveries WHERE id = @d::uuid',
      {'d': delivery},
    );
    return {'delivered': d.first[0] == 'delivered', 'httpStatus': d.first[1], 'error': d.first[2]};
  }

  String _checkUrl(Object? url) {
    final uri = url is String ? Uri.tryParse(url.trim()) : null;
    if (uri == null || uri.host.isEmpty || url.toString().length > 500 || !(uri.scheme == 'https' || (allowPrivate && uri.scheme == 'http'))) {
      throw const ApiError.badRequest('Adresse invalide : https://… attendue.');
    }
    final ip = InternetAddress.tryParse(uri.host);
    if (!allowPrivate && (uri.host == 'localhost' || uri.host.endsWith('.localhost') || (ip != null && _private(ip)))) {
      throw const ApiError.badRequest('Adresse invalide : https://… attendue.');
    }
    return uri.toString();
  }

  static List<String> _events(Object? wanted) {
    if (wanted is! List || wanted.isEmpty || wanted.any((e) => !events.contains(e))) {
      throw const ApiError.badRequest('Événements inconnus.');
    }
    return [
      for (final e in events)
        if (wanted.contains(e)) e,
    ];
  }

  static bool _private(InternetAddress a) {
    if (a.isLoopback || a.isLinkLocal || a.isMulticast) return true;
    final b = a.rawAddress;
    if (a.type == InternetAddressType.IPv4) {
      return b[0] == 10 ||
          b[0] == 0 ||
          (b[0] == 172 && b[1] >= 16 && b[1] < 32) ||
          (b[0] == 192 && b[1] == 168) ||
          (b[0] == 100 && b[1] >= 64 && b[1] < 128) ||
          (b[0] == 169 && b[1] == 254);
    }
    // IPv6 : adresses uniques locales (fc00::/7) et IPv4 encapsulée.
    if ((b[0] & 0xfe) == 0xfc) return true;
    if (b.sublist(0, 10).every((x) => x == 0) && b[10] == 0xff && b[11] == 0xff) {
      return _private(InternetAddress.fromRawAddress(Uint8List.fromList(b.sublist(12))));
    }
    return b.every((x) => x == 0);
  }

  // --- Événements -------------------------------------------------------------

  /// Appelé à chaque écriture du journal ([Store.audit]) : met en file les
  /// envois des adresses abonnées, dans la même transaction.
  Future<void> onAudit(Session s, String companyId, String action, Map<String, Object?> details) async {
    final event = _fromAudit[action];
    if (event == null) return;
    final hooks = await store.query(
      s,
      '''
      SELECT id::text FROM webhooks WHERE company_id = @c::uuid AND disabled_at IS NULL AND @e = ANY(events)''',
      {'c': companyId, 'e': event},
    );
    if (hooks.isEmpty) return;
    final company = Store.companyFromRow(
      (await store.query(s, 'SELECT * FROM companies WHERE id = @c::uuid', {'c': companyId})).first.toColumnMap(),
    );
    if (!ApiAccessService.proAllowed(company)) return;
    final data = await _data(s, companyId, action, details);
    for (final h in hooks) {
      await _queue(s, company, h[0] as String, event, data);
    }
    if (autoDeliver) _kick();
  }

  /// Contenu de l'événement : identifiants publics (ID SF, matricule), pas
  /// d'adresse e-mail.
  Future<Map<String, Object?>> _data(Session s, String companyId, String action, Map<String, Object?> d) async {
    Future<Map<String, Object?>?> person(Object? userId) async {
      if (userId == null) return null;
      final r = await store.query(
        s,
        '''
        SELECT u.public_id, coalesce(m.display_name, u.custom_name, u.name), m.employee_number, m.role
        FROM users u LEFT JOIN memberships m ON m.user_id = u.id AND m.company_id = @c::uuid AND m.left_at IS NULL
        WHERE u.id = @u::uuid''',
        {'u': userId, 'c': companyId},
      );
      if (r.isEmpty) return null;
      return {'sfId': r.first[0], 'name': r.first[1], 'employeeNumber': r.first[2], 'role': r.first[3]};
    }

    if (action == 'planning.publish') return {'shifts': d['count'], 'people': d['users']};
    if (action == 'member.joined') return {'person': await person(d['userId'])};
    if (action == 'news.publish') {
      final r = await store.query(s, 'SELECT title, body FROM announcements WHERE id::text = @i', {'i': d['id']});
      return {
        'id': d['id'],
        'recipients': d['recipients'],
        if (r.isNotEmpty) 'title': r.first[0],
        if (r.isNotEmpty) 'body': r.first[1],
      };
    }
    // Demandes.
    final r = await store.query(
      s,
      '''
      SELECT kind, status, requester_id::text, peer_id::text, start_day, end_day, shift_id::text, note
      FROM requests WHERE id::text = @i''',
      {'i': d['id']},
    );
    if (r.isEmpty) return {'id': d['id']};
    final x = r.first;
    String? day(Object? v) => v is DateTime ? formatDay(v) : null;
    return {
      'id': d['id'],
      'kind': x[0],
      'status': x[1],
      if (action == 'request.approved' || action == 'request.cancel_approved') 'approved': true,
      if (action == 'request.refused' || action == 'request.cancel_refused') 'approved': false,
      'person': await person(x[2]),
      if (x[3] != null) 'peer': await person(x[3]),
      if (x[4] != null) 'from': day(x[4]),
      if (x[5] != null) 'to': day(x[5]),
      if (x[6] != null) 'shiftId': x[6],
      if (x[7] != null) 'note': x[7],
    };
  }

  Future<String> _queue(Session s, Company company, String hookId, String event, Map<String, Object?> data) async {
    final rows = await store.query(
      s,
      '''
      INSERT INTO webhook_deliveries (webhook_id, event, payload, next_at, created_at)
      VALUES (@w::uuid, @e, '{}'::jsonb, @t, @t) RETURNING id::text''',
      {'w': hookId, 'e': event, 't': now()},
    );
    final id = rows.first[0] as String;
    final payload = {
      'id': id,
      'event': event,
      'createdAt': now().toUtc().toIso8601String(),
      'company': {'id': company.publicId, 'name': company.name},
      'data': data,
    };
    await store.query(s, 'UPDATE webhook_deliveries SET payload = @p::jsonb WHERE id = @d::uuid', {
      'p': jsonEncode(payload),
      'd': id,
    });
    return id;
  }

  // --- Envois -----------------------------------------------------------------

  Timer? _soon;
  bool _running = false;

  void _kick() {
    _soon ??= Timer(const Duration(seconds: 2), () {
      _soon = null;
      unawaited(
        deliver().catchError((Object e) {
          print('Webhooks : $e');
          return 0;
        }),
      );
    });
  }

  /// Envoie ce qui est dû (appelé aussi toutes les minutes).
  Future<int> deliver() async {
    if (_running) return 0;
    _running = true;
    try {
      var sent = 0;
      final due = await store.query(
        store.db,
        '''
        SELECT d.id::text FROM webhook_deliveries d JOIN webhooks w ON w.id = d.webhook_id
        WHERE d.status = 'pending' AND d.next_at <= @t AND w.disabled_at IS NULL
        ORDER BY d.next_at LIMIT 200''',
        {'t': now()},
      );
      for (final d in due) {
        if (await _send(d[0] as String)) sent++;
      }
      // Historique : 30 jours.
      await store.query(store.db, "DELETE FROM webhook_deliveries WHERE created_at < @t AND status <> 'pending'", {
        't': now().subtract(const Duration(days: 30)),
      });
      return sent;
    } finally {
      _running = false;
    }
  }

  /// [test] : envoi d'essai, ni réessayé ni compté dans les échecs.
  Future<bool> _send(String deliveryId, {bool test = false}) async {
    final rows = await store.query(
      store.db,
      '''
      SELECT d.payload, d.attempts, d.event, w.id::text, w.url, w.secret, w.company_id::text
      FROM webhook_deliveries d JOIN webhooks w ON w.id = d.webhook_id WHERE d.id = @d::uuid''',
      {'d': deliveryId},
    );
    if (rows.isEmpty) return false;
    final r = rows.first;
    final company = await store.findCompany(r[6] as String);
    // Option arrêtée (fin, grâce) : plus rien ne part.
    if (company == null || !ApiAccessService.proAllowed(company)) {
      await store.query(store.db, "UPDATE webhook_deliveries SET status = 'dropped' WHERE id = @d::uuid", {
        'd': deliveryId,
      });
      return false;
    }
    final body = jsonEncode(r[0]);
    final stamp = now().millisecondsSinceEpoch ~/ 1000;
    final signature = Hmac(sha256, utf8.encode(_open(r[5] as String))).convert(utf8.encode('$stamp.$body')).toString();
    int? code;
    final watch = Stopwatch()..start();
    String? error;
    try {
      final uri = Uri.parse(r[4] as String);
      if (!allowPrivate) {
        final addresses = await InternetAddress.lookup(uri.host).timeout(const Duration(seconds: 5));
        if (addresses.isEmpty || addresses.any(_private)) throw const SocketException('adresse privée refusée');
      }
      final res = await client
          .post(
            uri,
            headers: {
              'content-type': 'application/json',
              'user-agent': 'StaffFlow-Webhooks/1.0',
              'staff-flow-event': r[2] as String,
              'staff-flow-delivery': deliveryId,
              'staff-flow-signature': 't=$stamp,v1=$signature',
            },
            body: body,
          )
          .timeout(const Duration(seconds: 10));
      code = res.statusCode;
      if (code < 200 || code >= 300) error = 'HTTP $code';
    } catch (e) {
      error = e.toString();
      if (error.length > 300) error = error.substring(0, 300);
    }
    try {
      await onSent?.call(r[6] as String, r[2] as String, r[4] as String, code, error, watch.elapsed);
    } catch (e) {
      print('Journaux webhooks : $e');
    }
    final attempts = (r[1] as int) + 1;
    final ok = error == null;
    final giveUp = !ok && (test || attempts > retries.length);
    await store.query(
      store.db,
      '''
      UPDATE webhook_deliveries SET attempts = @n, last_status = @code, last_error = @err,
        status = @st, next_at = @next::timestamptz, delivered_at = CASE WHEN @ok::boolean THEN @t::timestamptz ELSE NULL END
      WHERE id = @d::uuid''',
      {
        'd': deliveryId,
        'n': attempts,
        'code': code,
        'err': error,
        'ok': ok,
        't': now(),
        'st': ok ? 'delivered' : (giveUp ? 'failed' : 'pending'),
        'next': ok || giveUp ? now() : now().add(retries[attempts - 1]),
      },
    );
    // Envois abandonnés d'affilée : au-delà de [maxFailures], l'adresse est coupée.
    if (test || !(ok || giveUp)) return ok;
    await store.query(
      store.db,
      '''
      UPDATE webhooks SET failures = CASE WHEN @ok THEN 0 ELSE failures + 1 END,
        disabled_at = CASE WHEN NOT @ok AND failures + 1 >= @max THEN @t ELSE disabled_at END
      WHERE id = @w::uuid''',
      {'w': r[3], 'ok': ok, 'max': maxFailures, 't': now()},
    );
    return ok;
  }

  // --- Secret chiffré en base (AES-GCM) ---------------------------------------

  String _seal(String secret) {
    final nonce = Uint8List.fromList([for (var i = 0; i < 12; i++) _random.nextInt(256)]);
    final c = GCMBlockCipher(AESEngine())..init(true, AEADParameters(KeyParameter(_aes), 128, nonce, Uint8List(0)));
    return base64.encode([...nonce, ...c.process(Uint8List.fromList(utf8.encode(secret)))]);
  }

  String _open(String sealed) {
    final raw = base64.decode(sealed);
    final c = GCMBlockCipher(AESEngine())
      ..init(false, AEADParameters(KeyParameter(_aes), 128, Uint8List.fromList(raw.sublist(0, 12)), Uint8List(0)));
    return utf8.decode(c.process(Uint8List.fromList(raw.sublist(12))));
  }
}
