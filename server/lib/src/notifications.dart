import 'dart:async';
import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:postgres/postgres.dart' show Session;

import 'errors.dart';
import 'messages.dart';
import 'store.dart';

/// Familles de notifications que chacun peut couper (section 7).
enum NotifyCategory { planning, requests, messages, overlap, conflicts, billing }

/// Une notification à afficher sur un appareil.
class PushMessage {
  final String token;
  final String title;
  final String body;

  /// Données lues par l'application quand on touche la notification.
  final Map<String, String> data;

  const PushMessage(this.token, this.title, this.body, this.data);
}

enum PushOutcome { sent, invalidToken, failed }

abstract class PushSender {
  Future<PushOutcome> send(PushMessage message);
}

/// Envoi par Firebase Cloud Messaging (API HTTP v1), avec un compte de
/// service Google. Le jeton d'accès est gardé 50 minutes.
class FcmSender implements PushSender {
  final Map<String, dynamic> _account;
  final http.Client _http;
  String? _accessToken;
  DateTime _expires = DateTime(0);

  /// [signingKey] : remplace la clé privée du compte de service (tests).
  FcmSender(this._account, {http.Client? client, JWTKey? signingKey})
      : _http = client ?? http.Client(),
        _key = signingKey ?? RSAPrivateKey(_account['private_key'] as String);

  final JWTKey _key;

  /// [json] : le fichier JSON du compte de service, tel que Firebase le donne.
  factory FcmSender.fromJson(String json) => FcmSender(jsonDecode(json) as Map<String, dynamic>);

  String get projectId => _account['project_id'] as String;

  Future<String> _token() async {
    if (_accessToken != null && DateTime.now().isBefore(_expires)) return _accessToken!;
    final tokenUri = _account['token_uri'] as String? ?? 'https://oauth2.googleapis.com/token';
    final now = DateTime.now();
    final assertion = JWT({
      'scope': 'https://www.googleapis.com/auth/firebase.messaging',
      'aud': tokenUri,
      'iat': now.millisecondsSinceEpoch ~/ 1000,
      'exp': now.add(const Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
    }, issuer: _account['client_email'] as String)
        .sign(_key,
            algorithm: JWTAlgorithm.RS256, noIssueAt: true);
    final res = await _http.post(Uri.parse(tokenUri), body: {
      'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
      'assertion': assertion,
    });
    if (res.statusCode != 200) throw StateError('FCM : jeton refusé (${res.statusCode}) ${res.body}');
    _accessToken = jsonDecode(res.body)['access_token'] as String;
    _expires = now.add(const Duration(minutes: 50));
    return _accessToken!;
  }

  @override
  Future<PushOutcome> send(PushMessage m) async {
    final res = await _http.post(
      Uri.parse('https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
      headers: {'authorization': 'Bearer ${await _token()}', 'content-type': 'application/json'},
      body: jsonEncode({
        'message': {
          'token': m.token,
          'notification': {'title': m.title, 'body': m.body},
          'data': m.data,
          'android': {
            'priority': 'high',
            'notification': {'channel_id': 'staff_flow', 'tag': m.data['tag']},
          },
          'webpush': {
            'fcm_options': {'link': '/'},
            'notification': {'icon': '/icons/Icon-192.png', 'tag': m.data['tag']},
          },
        },
      }),
    );
    if (res.statusCode == 200) return PushOutcome.sent;
    // Appareil désinscrit ou jeton invalide : on l'oublie.
    if (res.statusCode == 404 || (res.statusCode == 400 && res.body.contains('registration token'))) {
      return PushOutcome.invalidToken;
    }
    print('FCM : ${res.statusCode} ${res.body}');
    return PushOutcome.failed;
  }
}

/// Avis dans l'application (cloche) et notifications sur le téléphone ou le
/// navigateur. L'avis est toujours gardé ; la notification n'est envoyée
/// que si la personne n'a pas coupé cette famille de notifications.
class NotificationService {
  final Store store;
  final PushSender? push;

  NotificationService(this.store, {this.push});

  final _inflight = <Future<void>>{};

  /// Attendre la fin des envois en cours (tests, arrêt du serveur).
  Future<void> settle() async {
    while (_inflight.isNotEmpty) {
      await Future.wait(_inflight.toList());
    }
  }

  static const kinds = {
    'schedule_published': NotifyCategory.planning,
    'join_invite': NotifyCategory.requests,
    'transfer_offer': NotifyCategory.requests,
    'shift_overwritten': NotifyCategory.conflicts,
  };

  /// Crée un avis par personne ([s] : la transaction en cours, s'il y en a
  /// une). Renvoie leurs identifiants, à passer à [deliver] une fois la
  /// transaction validée.
  Future<List<String>> add(Session s, Iterable<String> userIds,
      {String? companyId, required String kind, Map<String, Object?> data = const {}}) async {
    assert(kinds.containsKey(kind), kind);
    final ids = <String>[];
    for (final u in userIds.toSet()) {
      final rows = await store.query(s, '''
        INSERT INTO notices (user_id, company_id, kind, data)
        VALUES (@u::uuid, @c::uuid, @k, @d::jsonb) RETURNING id::text''',
          {'u': u, 'c': companyId, 'k': kind, 'd': jsonEncode(data)});
      ids.add(rows.first[0] as String);
    }
    return ids;
  }

  /// Crée les avis et envoie les notifications.
  Future<void> notify(Iterable<String> userIds,
      {String? companyId, required String kind, Map<String, Object?> data = const {}}) async {
    deliver(await add(store.db, userIds, companyId: companyId, kind: kind, data: data));
  }

  /// Envoie les notifications des avis [noticeIds], en arrière-plan : la
  /// requête qui les a créés n'attend pas Firebase.
  void deliver(List<String> noticeIds) {
    if (push == null || noticeIds.isEmpty) return;
    late final Future<void> f;
    f = _deliver(noticeIds)
        .catchError((Object e) => print('Notifications : $e'))
        .whenComplete(() => _inflight.remove(f));
    _inflight.add(f);
  }

  Future<void> _deliver(List<String> noticeIds) async {
    final rows = await store.query(store.db, '''
      SELECT n.id::text, n.kind, n.data, n.company_id::text, c.name, u.notification_prefs,
             d.token, coalesce(d.language, u.locale, 'en')
      FROM notices n
      JOIN users u ON u.id = n.user_id
      JOIN push_devices d ON d.user_id = n.user_id
      LEFT JOIN companies c ON c.id = n.company_id
      WHERE n.id = ANY(@ids::uuid[])''', {'ids': noticeIds});
    await Future.wait([
      for (final r in rows)
        if (wants(r[5] as Map<String, dynamic>, r[1] as String))
          _send(r[6] as String, r[0] as String, r[1] as String, r[2] as Map<String, dynamic>,
              r[3] as String?, r[4] as String?, negotiateLanguage(r[7] as String)),
    ]);
  }

  /// La personne veut-elle être prévenue pour cet avis ?
  static bool wants(Map<String, dynamic> prefs, String kind) => prefs[kinds[kind]!.name] != false;

  Future<void> _send(String token, String noticeId, String kind, Map<String, dynamic> data,
      String? companyId, String? companyName, String lang) async {
    final (title, body) = text(kind, data, companyName, lang);
    final outcome = await push!.send(PushMessage(token, title, body, <String, String>{
      'kind': kind,
      'noticeId': noticeId,
      'companyId': ?companyId,
      // Une seule notification « planning » par entreprise à l'écran.
      'tag': kind == 'schedule_published' ? 'planning-$companyId' : noticeId,
    }));
    if (outcome == PushOutcome.invalidToken) {
      await store.query(store.db, 'DELETE FROM push_devices WHERE token = @t', {'t': token});
    }
  }

  /// Titre et texte de la notification, dans la langue de l'appareil.
  static (String, String) text(String kind, Map<String, dynamic> data, String? company, String lang) {
    String t(String fr, [Map<String, String> args = const {}]) => translate(fr, lang, args);
    final title = company ?? 'Staff Flow';
    final name = '${data['byName'] ?? '?'}';
    return switch (kind) {
      'schedule_published' => (title, t('Votre planning a été publié ou modifié.')),
      'join_invite' => (title, t('Cette entreprise veut vous ajouter à son équipe.')),
      'transfer_offer' =>
        (title, t('{name} vous propose de devenir propriétaire de l\'entreprise.', {'name': name})),
      'shift_overwritten' => (
          t('Un autre responsable a modifié ce planning'),
          '$title · ${t('{name} a remplacé votre modification.', {'name': name})}'
        ),
      _ => (title, kind),
    };
  }

  // --- Appareils et préférences ---------------------------------------------

  Future<void> registerDevice(String userId, String token, String platform, String? language) async {
    if (token.isEmpty || token.length > 4096 || (platform != 'android' && platform != 'web')) {
      throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
    }
    // Un jeton appartient à un seul compte : le dernier connecté sur l'appareil.
    await store.query(store.db, '''
      INSERT INTO push_devices (token, user_id, platform, language) VALUES (@t, @u::uuid, @p, @l)
      ON CONFLICT (token) DO UPDATE
        SET user_id = EXCLUDED.user_id, platform = EXCLUDED.platform,
            language = EXCLUDED.language, seen_at = now()''',
        {'t': token, 'u': userId, 'p': platform, 'l': language});
  }

  Future<void> forgetDevice(String userId, String token) async {
    await store.query(store.db, 'DELETE FROM push_devices WHERE token = @t AND user_id = @u::uuid',
        {'t': token, 'u': userId});
  }

  /// Familles activées (toutes par défaut).
  Future<Map<String, bool>> prefs(String userId) async {
    final rows = await store.query(
        store.db, 'SELECT notification_prefs FROM users WHERE id = @u::uuid', {'u': userId});
    final stored = rows.first[0] as Map<String, dynamic>;
    return {for (final c in NotifyCategory.values) c.name: stored[c.name] != false};
  }

  Future<Map<String, bool>> setPrefs(String userId, Map<String, dynamic> changes) async {
    for (final e in changes.entries) {
      if (!NotifyCategory.values.any((c) => c.name == e.key) || e.value is! bool) {
        throw const ApiError.badRequest('Champ manquant ou de mauvais type.');
      }
    }
    await store.query(store.db,
        'UPDATE users SET notification_prefs = notification_prefs || @p::jsonb WHERE id = @u::uuid',
        {'u': userId, 'p': jsonEncode(changes)});
    return prefs(userId);
  }
}
