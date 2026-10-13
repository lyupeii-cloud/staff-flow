import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Jeton de session. Sur Android : dans le coffre chiffré du téléphone
/// (Keystore), exclu des sauvegardes. Sur le web : dans le stockage du
/// navigateur, comme avant.
class TokenStore {
  static const key = 'session_token';

  static const _secure = FlutterSecureStorage();

  static bool get _android => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    if (!_android) return prefs.getString(key);
    final token = await _secure.read(key: key);
    if (token != null) return token;
    // Version précédente : jeton en clair dans les préférences, déplacé une fois.
    final old = prefs.getString(key);
    if (old != null) {
      await _secure.write(key: key, value: old);
      await prefs.remove(key);
    }
    return old;
  }

  static Future<void> write(String token) async {
    if (!_android) return (await SharedPreferences.getInstance()).setString(key, token).then((_) {});
    await _secure.write(key: key, value: token);
  }

  static Future<void> delete() async {
    await (await SharedPreferences.getInstance()).remove(key);
    if (_android) await _secure.delete(key: key);
  }
}
