import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../api.dart';
import '../session.dart';
import 'sync.dart';

/// Synchronisation en arrière-plan (Android).
///
/// Quand l'application quitte l'écran avec des modifications en attente,
/// une tâche Android (WorkManager) est programmée avec la condition « réseau
/// disponible » : au retour du réseau, Android la lance même si
/// l'application est fermée, et elle envoie la file. En cas d'échec, Android
/// la relance plus tard. Sur le web, le navigateur ne le permet pas : la file
/// part dès que l'onglet est ouvert.
class BackgroundSync {
  static const _task = 'staff-flow-sync';

  static bool get supported => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static Future<void> init() async {
    if (!supported) return;
    await Workmanager().initialize(backgroundSyncDispatcher);
  }

  /// À appeler quand l'application quitte l'écran avec une file non vide.
  static Future<void> schedule() async {
    if (!supported) return;
    await Workmanager().registerOneOffTask(
      _task,
      _task,
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingWorkPolicy.replace,
      backoffPolicy: BackoffPolicy.exponential,
      backoffPolicyDelay: const Duration(seconds: 30),
    );
  }

  /// L'application revient à l'écran : elle reprend la main.
  static Future<void> cancel() async {
    if (!supported) return;
    await Workmanager().cancelByUniqueName(_task);
  }
}

/// Point d'entrée de la tâche, lancée par Android sans l'interface.
@pragma('vm:entry-point')
void backgroundSyncDispatcher() {
  Workmanager().executeTask((task, _) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Session.tokenKey);
    if (token == null) return true;
    final api = Api()
      ..token = token
      ..language = prefs.getString(Session.languageKey) ?? PlatformDispatcher.instance.locale.languageCode;
    final sync = await Sync.open(api, watch: false);
    try {
      await sync.flush(force: true);
      // File encore pleine = pas de réseau finalement : Android réessaiera.
      return sync.queue.isEmpty;
    } finally {
      await sync.close();
    }
  });
}
