import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
import 'calendar_sync.dart';
import 'config.dart';
import 'i18n.dart';
import 'models.dart';
import 'offline/background.dart';
import 'offline/sync.dart';
import 'push.dart';

enum SessionState { loading, signedOut, signedIn }

/// Connexion Google, jeton de session et données de l'utilisateur (`/me`).
class Session extends ChangeNotifier {
  final Api api;

  Session(this.api);

  /// Données hors connexion et file d'attente ; prête après [start].
  late final Sync sync;

  /// Notifications sur l'appareil.
  late final Push push = Push(api);

  /// Conversation affichée à l'écran : ses notifications ne s'affichent pas en plus.
  String? openConversation;

  /// Demande à montrer (notification touchée, icône du planning) : l'onglet
  /// de l'entreprise passe à « Demandes » et la met en évidence.
  final openRequest = ValueNotifier<({String companyId, String requestId})?>(null);

  static const tokenKey = 'session_token';

  SessionState state = SessionState.loading;
  Me? me;
  Localized? error;
  bool _googleReady = false;

  bool get googleReady => _googleReady;

  static const languageKey = 'language';

  /// Langue choisie à la main dans le menu « Langue » (code `uk`, `fr`…) ;
  /// `null` = automatique (téléphone, ou compte Google sur le web).
  String? language;

  Future<void> setLanguage(String? code) async {
    language = code;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    code == null ? await prefs.remove(languageKey) : await prefs.setString(languageKey, code);
    // Les notifications suivent la langue de l'écran (réglée au prochain affichage).
    WidgetsBinding.instance.addPostFrameCallback((_) => push.languageChanged());
  }

  Future<void> start() async {
    unawaited(_initGoogle());
    unawaited(_initPush());
    unawaited(_initPush());
    try {
      final prefs = await SharedPreferences.getInstance();
      language = prefs.getString(languageKey);
      sync = await Sync.open(api);
      _watchLifecycle();
      api.token = prefs.getString(tokenKey);
      if (api.token == null) return _set(SessionState.signedOut);
      // Lancement : l'écran s'affiche tout de suite avec les données de la
      // dernière utilisation, puis se met à jour.
      final cached = await sync.cached('me');
      if (cached != null) {
        me = Me.fromJson((cached as Map).cast<String, dynamic>());
        _set(SessionState.signedIn);
        unawaited(refresh().catchError((Object e) {
          if (e is ApiException && e.status == 401) signOut();
        }));
        return;
      }
      await refresh();
    } on ApiException catch (e) {
      if (e.status == 401) return signOut();
      error = e.describe;
      _set(SessionState.signedOut);
    } catch (_) {
      error = (t) => t.serverUnreachable;
      _set(SessionState.signedOut);
    }
  }

  Future<void> _initPush() async {
    await push.init();
    push.events.listen((e) async {
      // Nouvel avis : la cloche se met à jour ; planning publié : il se recharge.
      if (state != SessionState.signedIn) return;
      if (e.kind == 'schedule_published' || e.kind == 'member_joined' || e.data['requestId'] != null) {
        sync.markChanged();
      }
      // Planning changé : l'agenda du téléphone suivra dans 2 minutes.
      if (e.kind == 'schedule_published' || e.kind == 'request_approved') CalendarSync.schedule(api);
      await refresh().catchError((_) {});
    });
    if (state == SessionState.signedIn) await push.signedIn();
  }

  /// Hors de l'écran, Android peut geler l'application : une tâche
  /// d'arrière-plan prend alors le relais pour envoyer la file d'attente
  /// dès que le réseau revient (voir [BackgroundSync]).
  void _watchLifecycle() {
    if (!BackgroundSync.supported) return;
    unawaited(BackgroundSync.init().then((_) => BackgroundSync.cancel()));
    _lifecycle = AppLifecycleListener(
      onHide: () {
        sync.pause();
        if (sync.queue.isNotEmpty) unawaited(BackgroundSync.schedule());
      },
      onShow: () async {
        await BackgroundSync.cancel();
        await sync.resume(reload: true);
        // Retour dans l'application : l'agenda est revérifié (au plus toutes les 10 minutes).
        unawaited(CalendarSync.sync(api, minInterval: const Duration(minutes: 10)).then((_) {}, onError: (_) {}));
      },
    );
  }

  AppLifecycleListener? _lifecycle;

  @override
  void dispose() {
    _lifecycle?.dispose();
    super.dispose();
  }

  Future<void> _initGoogle() async {
    if (Config.googleWebClientId.isEmpty) return;
    final google = GoogleSignIn.instance;
    try {
      await google.initialize(
        clientId: kIsWeb ? Config.googleWebClientId : null,
        serverClientId: kIsWeb ? null : Config.googleWebClientId,
      );
    } catch (e) {
      error = (t) => t.googleUnavailable('$e');
      notifyListeners();
      return;
    }
    google.authenticationEvents.listen((event) async {
      if (event is GoogleSignInAuthenticationEventSignIn) {
        final idToken = event.user.authentication.idToken;
        if (idToken != null && state != SessionState.signedIn) {
          await _guard(() async => _signedIn(await api.loginGoogle(idToken)));
        }
      }
    }, onError: (Object e) {
      if (e is GoogleSignInException && e.code == GoogleSignInExceptionCode.canceled) return;
      error = (t) => t.googleFailed('$e');
      notifyListeners();
    });
    _googleReady = true;
    notifyListeners();
  }

  /// Android : ouvre le sélecteur de compte Google. Sur le web, c'est le
  /// bouton officiel de Google qui déclenche la connexion.
  Future<void> signInWithGoogle() => _guard(() async {
        await GoogleSignIn.instance.authenticate();
      });

  Future<void> signInDev(String email) =>
      _guard(() async => _signedIn(await api.loginDev(email)));

  Future<void> _signedIn((String, User) login) async {
    final (token, _) = login;
    api.token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    await refresh();
  }

  /// Recharge `/me` ; hors connexion, garde la dernière version enregistrée.
  Future<void> refresh() async {
    me = Me.fromJson(await sync.read('me', '/me'));
    _set(SessionState.signedIn);
  }

  Future<void> signOut() async {
    await push.signOut();
    api.token = null;
    me = null;
    await sync.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    if (_googleReady) await GoogleSignIn.instance.signOut();
    _set(SessionState.signedOut);
  }

  Future<void> _guard(Future<void> Function() action) async {
    error = null;
    notifyListeners();
    try {
      await action();
    } on ApiException catch (e) {
      error = e.describe;
      notifyListeners();
    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        error = (t) => t.googleFailed(e.description ?? e.code.name);
        notifyListeners();
      }
    } catch (e) {
      error = (t) => t.serverUnreachable;
      notifyListeners();
    }
  }

  void _set(SessionState s) {
    if (s == SessionState.signedIn && state != SessionState.signedIn) {
      unawaited(push.signedIn());
      // Ouverture de l'application : l'agenda du téléphone est mis à jour.
      unawaited(CalendarSync.sync(api).then((_) {}, onError: (_) {}));
    }
    state = s;
    notifyListeners();
  }
}
