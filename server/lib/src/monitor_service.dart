import 'dart:io';

import 'store.dart';
import 'telegram.dart';

/// Surveillance interne : prévient les administrateurs de la plateforme (sur
/// Telegram) quand le serveur a trop d'erreurs, que le disque se remplit ou
/// que les sauvegardes ne se font plus. Une même alerte au plus toutes les
/// 6 heures. La panne complète du serveur, elle, est vue par la
/// surveillance externe (qui appelle `/health`).
class MonitorService {
  final Store store;
  final TelegramService telegram;
  final Set<String> adminEmails;
  final DateTime Function() now;

  /// Dossier des sauvegardes, monté en lecture seule (vide : pas de contrôle).
  final String? backupDir;

  MonitorService(this.store, this.telegram, this.adminEmails, {required this.now, this.backupDir});

  /// Erreurs inattendues en une heure avant d'alerter.
  static const errorAlert = 20;

  /// Disque rempli au-delà (pour cent).
  static const diskAlert = 80;

  /// Âge maximal de la dernière sauvegarde chiffrée.
  static const backupMaxAge = Duration(hours: 26);

  final _sent = <String, DateTime>{};
  final _errors = <DateTime>[];

  /// Envoyé aux administrateurs (et écrit dans le journal du serveur).
  Future<void> alert(String key, String text) async {
    final t = now();
    final last = _sent[key];
    if (last != null && t.difference(last) < const Duration(hours: 6)) return;
    _sent[key] = t;
    print('ALERTE $key : $text');
    final admins = await store.query(store.db, '''
      SELECT id::text FROM users WHERE lower(email) = ANY(@e::text[]) AND deleted_at IS NULL''',
        {'e': [for (final e in adminEmails) e.toLowerCase()]});
    for (final a in admins) {
      try {
        await telegram.sendTo(a[0] as String, '⚠️ Staff Flow — $text');
      } catch (e) {
        print('Alerte Telegram : $e');
      }
    }
  }

  /// Une erreur inattendue (500) : au-delà de [errorAlert] en une heure, alerte.
  void error(Object e) {
    final t = now();
    _errors
      ..add(t)
      ..removeWhere((x) => t.difference(x) > const Duration(hours: 1));
    if (_errors.length >= errorAlert) {
      _errors.clear();
      alert('errors', '$errorAlert erreurs du serveur en moins d\'une heure (dernière : $e).');
    }
  }

  /// Contrôles périodiques (avec les autres échéances, toutes les 10 minutes).
  Future<void> check() async {
    // Disque.
    try {
      final r = await Process.run('df', ['-P', '/']);
      final used = int.tryParse(RegExp(r'(\d+)%').firstMatch('${r.stdout}'.split('\n').skip(1).join())?.group(1) ?? '');
      if (used != null && used >= diskAlert) await alert('disk', 'Disque du serveur rempli à $used %.');
    } catch (e) {
      print('Disque : $e');
    }
    // Sauvegardes : la plus récente doit avoir moins de 26 heures.
    final dir = backupDir;
    if (dir == null || !Directory(dir).existsSync()) return;
    final files = Directory(dir).listSync().whereType<File>().where((f) => f.path.endsWith('.enc')).toList();
    final newest = files.isEmpty
        ? null
        : files.map((f) => f.lastModifiedSync()).reduce((a, b) => a.isAfter(b) ? a : b);
    if (newest == null || now().difference(newest) > backupMaxAge) {
      await alert('backup', 'Aucune sauvegarde chiffrée depuis plus de 26 heures.');
    }
    // Copie hors du serveur : l'outil d'envoi écrit l'heure de son dernier succès.
    final offsite = File('$dir/offsite-ok');
    if (offsite.existsSync() && now().difference(offsite.lastModifiedSync()) > const Duration(hours: 50)) {
      await alert('offsite', 'La copie des sauvegardes hors du serveur échoue depuis 2 nuits.');
    }
  }
}
