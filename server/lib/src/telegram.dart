import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'errors.dart';
import 'messages.dart';
import 'models.dart';
import 'store.dart';

/// Ce que nous utilisons de l'API des bots Telegram.
abstract class TelegramApi {
  /// Nom du bot (sans « @ »).
  Future<String> botName();

  /// Messages reçus par le bot depuis [offset] (attente longue).
  Future<List<Map<String, dynamic>>> updates(int offset);

  /// Envoie un message (avec des boutons `(données, libellé)`) ; lève
  /// [TelegramBlocked] si la personne a bloqué le bot.
  Future<void> send(int chatId, String text, {List<(String, String)>? buttons});

  /// Réglage du bot (nom, description, commandes).
  Future<void> configure(String method, Map<String, Object?> body);
}

class TelegramBlocked implements Exception {}

/// API HTTP de Telegram, avec le jeton donné par @BotFather.
class HttpTelegramApi implements TelegramApi {
  final String _token;
  final http.Client _client;

  HttpTelegramApi(this._token, {http.Client? client}) : _client = client ?? http.Client();

  Uri _uri(String method) => Uri.parse('https://api.telegram.org/bot$_token/$method');

  Future<Map<String, dynamic>> _call(String method, Map<String, Object?> body, {Duration? timeout}) async {
    final res = await _client
        .post(_uri(method), headers: {'content-type': 'application/json'}, body: jsonEncode(body))
        .timeout(timeout ?? const Duration(seconds: 20));
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 403) throw TelegramBlocked();
    if (json['ok'] != true) throw StateError('Telegram $method : ${json['description']}');
    return json;
  }

  @override
  Future<String> botName() async => ((await _call('getMe', {}))['result'] as Map)['username'] as String;

  @override
  Future<List<Map<String, dynamic>>> updates(int offset) async {
    final json = await _call('getUpdates', {'offset': offset, 'timeout': 50, 'allowed_updates': ['message', 'callback_query']},
        timeout: const Duration(seconds: 70));
    return [for (final u in json['result'] as List) (u as Map).cast<String, dynamic>()];
  }

  @override
  Future<void> send(int chatId, String text, {List<(String, String)>? buttons}) => _call('sendMessage', {
        'chat_id': chatId,
        'text': text,
        if (buttons != null)
          'reply_markup': {
            'inline_keyboard': [
              [for (final (data, label) in buttons) {'text': label, 'callback_data': data}],
            ],
          },
      });

  @override
  Future<void> configure(String method, Map<String, Object?> body) => _call(method, body);
}

/// Compte Telegram vérifié de chaque personne : la personne ouvre le bot
/// depuis l'application (lien à usage unique), le bot reçoit « /start
/// jeton » et rattache ce compte Telegram au sien. Le bot envoie ensuite
/// les codes de vérification (reprise du compte avec un autre compte Google).
class TelegramService {
  final Store store;
  final TelegramApi? api;
  final DateTime Function() now;
  String? _bot;

  TelegramService(this.store, this.api, {required this.now});

  /// Conversations plus longues (changement de compte Google) : `true` si
  /// le message a été traité.
  Future<bool> Function(int chatId, String lang, {String? text, String? button})? interceptor;

  bool get enabled => api != null;

  /// Nom du bot, demandé une fois à Telegram.
  Future<String?> botName() async {
    if (api == null) return null;
    return _bot ??= await api!.botName();
  }

  static final _random = Random.secure();
  static const _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  /// Lien qui ouvre le bot ; valable 15 minutes, une seule fois.
  Future<String> linkUrl(User user) async {
    final bot = await botName();
    if (bot == null) throw const ApiError.conflict('Telegram n\'est pas encore disponible.');
    final token = List.generate(24, (_) => _alphabet[_random.nextInt(_alphabet.length)]).join();
    await store.query(store.db, 'DELETE FROM telegram_links WHERE user_id = @u::uuid OR expires_at < @t',
        {'u': user.id, 't': now()});
    await store.query(store.db, 'INSERT INTO telegram_links (token, user_id, expires_at) VALUES (@k, @u::uuid, @e)',
        {'k': token, 'u': user.id, 'e': now().add(const Duration(minutes: 15))});
    return 'https://t.me/$bot?start=$token';
  }

  Future<void> unlink(User user) async {
    await store.query(store.db, '''
      UPDATE users SET telegram_chat_id = NULL, telegram_username = NULL, telegram_linked_at = NULL
      WHERE id = @u::uuid''', {'u': user.id});
    await store.query(store.db, 'UPDATE memberships SET show_telegram = false WHERE user_id = @u::uuid', {'u': user.id});
    await store.audit(actorId: user.id, action: 'telegram.unlink');
  }

  /// Compte Telegram de la personne : `null` si aucun.
  Future<Map<String, Object?>?> of(String userId) async {
    final rows = await store.query(store.db,
        'SELECT telegram_username, telegram_linked_at FROM users WHERE id = @u::uuid AND telegram_chat_id IS NOT NULL',
        {'u': userId});
    if (rows.isEmpty) return null;
    return {'username': rows.first[0], 'linkedAt': (rows.first[1] as DateTime).toIso8601String()};
  }

  /// Envoie [text] au compte Telegram vérifié de la personne ; `false` si
  /// elle n'en a pas ou a bloqué le bot.
  Future<bool> sendTo(String userId, String text) async {
    if (api == null) return false;
    final rows = await store.query(store.db,
        'SELECT telegram_chat_id FROM users WHERE id = @u::uuid AND telegram_chat_id IS NOT NULL', {'u': userId});
    if (rows.isEmpty) return false;
    try {
      await api!.send(rows.first[0] as int, text);
      return true;
    } on TelegramBlocked {
      return false;
    }
  }

  /// Un message reçu par le bot.
  Future<void> handle(Map<String, dynamic> update) async {
    final callback = update['callback_query'] as Map?;
    if (callback != null) {
      final chatId = ((callback['message'] as Map?)?['chat'] as Map?)?['id'] as int?;
      await api!.configure('answerCallbackQuery', {'callback_query_id': callback['id']}).catchError((_) {});
      if (chatId == null) return;
      final lang = await _language(chatId, (callback['from'] as Map?)?['language_code'] as String?);
      await interceptor?.call(chatId, lang, button: callback['data'] as String?);
      return;
    }
    final message = update['message'] as Map?;
    if (message == null) return;
    final chat = message['chat'] as Map?;
    final from = message['from'] as Map?;
    if (chat == null || from == null || chat['type'] != 'private') return;
    final chatId = chat['id'] as int;
    final username = from['username'] as String?;
    final text = (message['text'] as String? ?? '').trim();
    // Le nom Telegram peut changer : on garde le dernier connu.
    await store.query(store.db, 'UPDATE users SET telegram_username = @n WHERE telegram_chat_id = @c',
        {'n': username, 'c': chatId});
    final lang = await _language(chatId, from['language_code'] as String?);
    final command = text.split(RegExp(r'[\s@]')).first.toLowerCase();
    if (interceptor != null &&
        await interceptor!(chatId, lang, text: command.startsWith('/') && command != '/start' ? command : text)) {
      return;
    }
    final start = RegExp(r'^/start\s+([A-Za-z0-9]{24})$').firstMatch(text);
    if (start == null) {
      await _reply(chatId, t('Bonjour ! Pour relier ce compte Telegram à Staff Flow, ouvrez l\'application : Mon profil, puis Telegram.', lang));
      return;
    }
    final rows = await store.query(store.db,
        'DELETE FROM telegram_links WHERE token = @k AND expires_at > @t RETURNING user_id::text',
        {'k': start[1], 't': now()});
    if (rows.isEmpty) {
      await _reply(chatId, t('Ce lien a expiré. Recommencez depuis l\'application Staff Flow.', lang));
      return;
    }
    final userId = rows.first[0] as String;
    final user = await store.findUser(userId);
    await store.db.runTx((tx) async {
      // Un compte Telegram ne sert qu'à un seul compte Staff Flow.
      await store.query(tx, '''
        UPDATE users SET telegram_chat_id = NULL, telegram_username = NULL, telegram_linked_at = NULL
        WHERE telegram_chat_id = @c AND id <> @u::uuid''', {'c': chatId, 'u': userId});
      await store.query(tx, '''
        UPDATE users SET telegram_chat_id = @c, telegram_username = @n, telegram_linked_at = @t
        WHERE id = @u::uuid''', {'c': chatId, 'n': username, 't': now(), 'u': userId});
      await store.audit(actorId: userId, action: 'telegram.link', details: {'username': username}, tx: tx);
    });
    await _reply(chatId,
        t('C\'est fait : ce compte Telegram est relié à votre compte Staff Flow {id}.', user?.locale ?? lang, {'id': user?.publicId ?? ''}));
  }

  Future<String> _language(int chatId, String? telegramLanguage) async {
    final rows = await store.query(store.db, 'SELECT locale FROM users WHERE telegram_chat_id = @c', {'c': chatId});
    return (rows.isEmpty ? null : rows.first[0] as String?) ?? negotiateLanguage(telegramLanguage);
  }

  Future<void> reply(int chatId, String text, {List<(String, String)>? buttons}) => _reply(chatId, text, buttons: buttons);

  Future<void> _reply(int chatId, String text, {List<(String, String)>? buttons}) async {
    try {
      await api!.send(chatId, text, buttons: buttons);
    } on TelegramBlocked {
      // La personne a bloqué le bot entre-temps.
    }
  }

  /// Présentation du bot, par langue (`''` : toutes les autres).
  static const _profile = {
    '': (
      'Staff Flow',
      'Staff Flow — your team\'s schedule.\n\nThis bot verifies your Staff Flow account. Link it from the app (My profile → Telegram). It sends you verification codes, for example to change Google account.\n\nhttps://staff-flow.cloud',
      'Staff Flow account verification · staff-flow.cloud',
      'Link your Staff Flow account',
      'Change the Google account of your Staff Flow account',
    ),
    'fr': (
      'Staff Flow',
      'Staff Flow — le planning de votre équipe.\n\nCe bot vérifie votre compte Staff Flow. Reliez-le depuis l\'application (Mon profil → Telegram). Il vous envoie les codes de vérification, par exemple pour changer de compte Google.\n\nhttps://staff-flow.cloud',
      'Vérification des comptes Staff Flow · staff-flow.cloud',
      'Relier votre compte Staff Flow',
      'Changer le compte Google de votre compte Staff Flow',
    ),
    'uk': (
      'Staff Flow',
      'Staff Flow — графік вашої команди.\n\nЦей бот підтверджує ваш обліковий запис Staff Flow. Прив\'яжіть його в застосунку (Мій профіль → Telegram). Він надсилає коди підтвердження, наприклад для зміни облікового запису Google.\n\nhttps://staff-flow.cloud',
      'Підтвердження облікових записів Staff Flow · staff-flow.cloud',
      'Прив\'язати обліковий запис Staff Flow',
      'Змінити обліковий запис Google для Staff Flow',
    ),
    'ru': (
      'Staff Flow',
      'Staff Flow — график вашей команды.\n\nЭтот бот подтверждает ваш аккаунт Staff Flow. Привяжите его в приложении (Мой профиль → Telegram). Он присылает коды подтверждения, например для смены аккаунта Google.\n\nhttps://staff-flow.cloud',
      'Подтверждение аккаунтов Staff Flow · staff-flow.cloud',
      'Привязать аккаунт Staff Flow',
      'Сменить аккаунт Google для Staff Flow',
    ),
  };

  /// Nom, descriptions et commande du bot, dans chaque langue. (La photo et
  /// l'image de description se règlent dans @BotFather : deploy/telegram/.)
  Future<void> customize() async {
    if (api == null) return;
    // Telegram limite ces réglages : une erreur (déjà réglé, trop souvent) n'empêche pas le reste.
    Future<void> set(String method, Map<String, Object?> body) =>
        api!.configure(method, body).catchError((Object e) => print('Telegram $method : $e'));
    for (final MapEntry(key: lang, value: (name, description, short, command, change)) in _profile.entries) {
      final l = lang.isEmpty ? const <String, Object?>{} : {'language_code': lang};
      await set('setMyName', {'name': name, ...l});
      await set('setMyDescription', {'description': description, ...l});
      await set('setMyShortDescription', {'short_description': short, ...l});
      await set('setMyCommands', {
        'commands': [
          {'command': 'start', 'description': command},
          {'command': 'changegoogle', 'description': change},
        ],
        ...l,
      });
    }
  }

  /// Écoute le bot (attente longue), tant que le serveur tourne.
  Future<void> run() async {
    if (api == null) return;
    var offset = 0;
    while (true) {
      try {
        for (final u in await api!.updates(offset)) {
          offset = (u['update_id'] as int) + 1;
          await handle(u).catchError((Object e) => print('Telegram : $e'));
        }
      } catch (e) {
        print('Telegram : $e');
        await Future<void>.delayed(const Duration(seconds: 10));
      }
    }
  }

  static String t(String fr, String lang, [Map<String, String> args = const {}]) => translate(fr, lang, args);
}
