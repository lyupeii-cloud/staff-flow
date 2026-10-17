import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import 'errors.dart';
import 'models.dart';
import 'store.dart';
import 'telegram.dart';

/// Connexion à l'application web sans compte Google : la personne qui a
/// relié son Telegram envoie `/connexion` au bot et reçoit un lien.
///
/// Le lien ne sert qu'une fois et expire au bout de 5 minutes. Telegram ne
/// montre pas d'aperçu (qui l'ouvrirait à sa place), et ouvrir l'adresse ne
/// suffit pas : c'est l'application web qui l'échange contre une session.
/// Après chaque connexion, le bot prévient la personne.
class TelegramLoginService {
  final Store store;
  final TelegramService telegram;
  final DateTime Function() now;

  /// Adresse de l'application web (`https://app.staff-flow.cloud`).
  final String appUrl;

  TelegramLoginService(this.store, this.telegram, {required this.now, required this.appUrl});

  static const lifetime = Duration(minutes: 5);
  static final _random = Random.secure();
  static const _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  static String _hash(String s) => sha256.convert(utf8.encode(s)).toString();

  /// Commande du bot ; `true` si elle a été traitée.
  Future<bool> onTelegram(int chatId, String lang, {String? text}) async {
    if (text != '/connexion' && text != '/login') return false;
    String t(String fr, [Map<String, String> args = const {}]) => TelegramService.t(fr, lang, args);
    final rows = await store.query(store.db,
        'SELECT id::text FROM users WHERE telegram_chat_id = @c AND deleted_at IS NULL', {'c': chatId});
    if (rows.isEmpty) {
      await telegram.reply(chatId, t('Ce compte Telegram n\'est relié à aucun compte Staff Flow. Reliez-le d\'abord depuis l\'application : Mon profil, puis Telegram.'));
      return true;
    }
    final userId = rows.first[0] as String;
    final recent = await store.query(store.db,
        'SELECT count(*) FROM telegram_logins WHERE user_id = @u::uuid AND created_at > @t',
        {'u': userId, 't': now().subtract(const Duration(hours: 1))});
    if ((recent.first[0] as num) >= 5) {
      await telegram.reply(chatId, t('Trop de liens demandés : réessayez dans une heure.'));
      return true;
    }
    final token = List.generate(40, (_) => _alphabet[_random.nextInt(_alphabet.length)]).join();
    await store.query(store.db, '''
      INSERT INTO telegram_logins (token_hash, user_id, created_at, expires_at) VALUES (@h, @u::uuid, @t, @x)''',
        {'h': _hash(token), 'u': userId, 't': now(), 'x': now().add(lifetime)});
    await telegram.reply(chatId, t('Votre lien de connexion à Staff Flow (valable 5 minutes, une seule fois). Ne le transférez à personne.'),
        buttons: [('$appUrl/connexion/$token', t('Se connecter'))]);
    return true;
  }

  /// L'application web échange le lien contre une session.
  Future<User> redeem(String token) async {
    final rows = await store.query(store.db, '''
      UPDATE telegram_logins SET used_at = @t
      WHERE token_hash = @h AND used_at IS NULL AND expires_at > @t RETURNING user_id::text''',
        {'h': _hash(token), 't': now()});
    final user = rows.isEmpty ? null : await store.findActiveUser(rows.first[0] as String);
    if (user == null) {
      throw const ApiError.notFound('Lien de connexion expiré : envoyez /connexion au bot pour en recevoir un nouveau.');
    }
    await store.audit(actorId: user.id, action: 'auth.telegram_link');
    await telegram.sendTo(
        user.id,
        TelegramService.t('Nouvelle connexion à Staff Flow avec votre lien Telegram. Si ce n\'est pas vous, déliez Telegram dans Mon profil et écrivez à contact@staff-flow.cloud.',
            user.locale ?? 'en'));
    return user;
  }
}
