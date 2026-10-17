import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'api.dart';
import 'firebase_config.dart';

enum PushState {
  /// Pas de Firebase (pas configuré, ou plateforme sans notifications).
  unavailable,

  /// Pas encore autorisé sur cet appareil.
  off,

  /// Refusé : seule la personne peut le réautoriser, dans les réglages du
  /// téléphone ou du navigateur.
  blocked,
  on,
}

/// Notification reçue pendant que l'application est à l'écran (Android ne
/// l'affiche pas lui-même dans ce cas), ou touchée par l'utilisateur.
class PushEvent {
  final String? title;
  final String? body;
  final Map<String, dynamic> data;
  final bool opened;

  const PushEvent(this.title, this.body, this.data, {required this.opened});

  String? get kind => data['kind'] as String?;
}

/// Notifications sur le téléphone et dans le navigateur (Firebase Cloud
/// Messaging). L'appareil est enregistré auprès du serveur avec sa langue ;
/// le serveur envoie, Firebase ne fait que transporter.
class Push extends ChangeNotifier {
  final Api api;

  Push(this.api);

  PushState state = PushState.unavailable;
  String? _token;
  bool _ready = false;

  final _events = StreamController<PushEvent>.broadcast();
  Stream<PushEvent> get events => _events.stream;

  static bool get _platformSupported => kIsWeb || defaultTargetPlatform == TargetPlatform.android;

  Future<void> init() async {
    if (!FirebaseConfig.configured || !_platformSupported) return;
    try {
      await Firebase.initializeApp(options: FirebaseConfig.options);
      final messaging = FirebaseMessaging.instance;
      _setState((await messaging.getNotificationSettings()).authorizationStatus);
      FirebaseMessaging.onMessage.listen((m) => _emit(m, opened: false));
      FirebaseMessaging.onMessageOpenedApp.listen((m) => _emit(m, opened: true));
      messaging.onTokenRefresh.listen((t) {
        _token = t;
        unawaited(_register());
      });
      final initial = await messaging.getInitialMessage();
      if (initial != null) _emit(initial, opened: true);
      _ready = true;
    } catch (e) {
      debugPrint('Notifications indisponibles : $e');
      state = PushState.unavailable;
    }
    notifyListeners();
  }

  void _emit(RemoteMessage m, {required bool opened}) =>
      _events.add(PushEvent(m.notification?.title, m.notification?.body, m.data, opened: opened));

  void _setState(AuthorizationStatus s) {
    state = switch (s) {
      AuthorizationStatus.authorized || AuthorizationStatus.provisional => PushState.on,
      AuthorizationStatus.denied || AuthorizationStatus.deniedPermanently => PushState.blocked,
      AuthorizationStatus.notDetermined => PushState.off,
    };
    notifyListeners();
  }

  /// Après la connexion. Sur Android, l'autorisation est demandée tout de
  /// suite la première fois ; un navigateur n'accepte de la demander qu'après
  /// un clic (bouton de l'écran « Notifications »).
  Future<void> signedIn() async {
    if (!_ready) return;
    if (state == PushState.on || (state == PushState.off && !kIsWeb)) await enable();
  }

  /// Demande l'autorisation si besoin, puis enregistre l'appareil.
  Future<void> enable() async {
    if (!_ready) return;
    final messaging = FirebaseMessaging.instance;
    _setState((await messaging.requestPermission()).authorizationStatus);
    if (state != PushState.on) return;
    try {
      _token = await messaging.getToken(vapidKey: kIsWeb ? FirebaseConfig.vapidKey : null);
      await _register();
    } catch (e) {
      debugPrint('Jeton de notification : $e');
    }
  }

  Future<void> _register() async {
    if (_token == null || api.token == null) return;
    try {
      await api.send('PUT', '/devices',
          body: {'token': _token, 'platform': kIsWeb ? 'web' : 'android', 'language': api.language});
    } catch (_) {
      // Hors connexion : réessayé au prochain démarrage.
    }
  }

  /// La langue de l'application a changé : les notifications suivent.
  Future<void> languageChanged() => _register();

  /// À la déconnexion, avant d'oublier la session : l'appareil ne reçoit
  /// plus rien pour ce compte.
  Future<void> signOut() async {
    final token = _token;
    if (token == null) return;
    try {
      await api.send('POST', '/devices/forget', body: {'token': token});
    } catch (_) {}
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (_) {}
    _token = null;
  }
}
