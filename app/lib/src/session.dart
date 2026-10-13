import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;
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

  /// Annonce touchée dans une notification : onglet de l'entreprise, vue « Actualités ».
  final openNews = ValueNotifier<String?>(null);

  /// Demande à montrer (notification touchée, icône du planning) : l'onglet
  /// de l'entreprise passe à « Demandes » et la met en évidence.
  final openRequest = ValueNotifier<({String companyId, String requestId})?>(null);

  /// Jour à montrer dans le planning d'une entreprise (« Tous mes plannings »).
  final openDay = ValueNotifier<({String companyId, DateTime day})?>(null);

  static const tokenKey = 'session_token';

  SessionState state = SessionState.loading;
  Me? me;
  Localized? error;
  bool _googleReady = false;

  bool get googleReady => _googleReady;

  static const languageKey = 'language';
  static const themeKey = 'theme';
  static const timeFormatKey = 'time_format';

  /// Format de l'heure : `auto` (12 h en anglais américain, 24 h sinon), `h12` ou `h24`.
  String timeFormat = 'auto';

  Future<void> setTimeFormat(String format) async {
    timeFormat = format;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(timeFormatKey, format);
  }

  /// Heures sur 24 h pour cette langue d'affichage ?
  bool uses24h(Locale locale) => switch (timeFormat) {
        'h12' => false,
        'h24' => true,
        _ => !(locale.languageCode == 'en' && locale.countryCode != 'GB'),
      };

  /// Apparence : comme le système (par défaut), claire ou foncée.
  ThemeMode themeMode = ThemeMode.system;

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, mode.name);
  }

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

  /// Lien de changement de compte Google ouvert dans le navigateur.
  String? googleSwitchToken = kIsWeb && Uri.base.path.startsWith('/switch/') ? Uri.base.path.substring(8) : null;

  /// Lien de connexion envoyé par le bot Telegram (/connexion), ouvert dans le navigateur.
  String? telegramLoginToken =
      kIsWeb && Uri.base.path.startsWith('/connexion/') ? Uri.base.path.substring('/connexion/'.length) : null;

  /// Lien d'invitation (importation) ouvert dans le navigateur : proposé après la connexion.
  String? inviteCode = kIsWeb && Uri.base.path.startsWith('/invite/') ? Uri.base.path.substring('/invite/'.length) : null;

  /// La connexion vient de rattacher ce compte Google à un compte existant.
  bool accountSwitched = false;

  bool _revoking = false;

  /// Session fermée par le serveur : déconnexion ; [switched] : le compte
  /// vient d'être rattaché à un autre compte Google (on le dit).
  void _sessionRevoked({bool switched = false}) {
    if (state != SessionState.signedIn || _revoking) return;
    _revoking = true;
    unawaited(signOut().whenComplete(() {
      _revoking = false;
      if (switched) error = (t) => t.sessionRevoked;
      notifyListeners();
    }));
  }

  Future<void> start() async {
    api.onUnauthorized = _sessionRevoked;
    unawaited(_initGoogle());
    unawaited(_initPush());
    unawaited(_initPush());
    try {
      final prefs = await SharedPreferences.getInstance();
      language = prefs.getString(languageKey);
      themeMode = ThemeMode.values.asNameMap()[prefs.getString(themeKey)] ?? ThemeMode.system;
      timeFormat = prefs.getString(timeFormatKey) ?? 'auto';
      sync = await Sync.open(api);
      _watchLifecycle();
      api.token = prefs.getString(tokenKey);
      // Lien du bot Telegram : connexion directe (il ne sert qu'une fois).
      final link = telegramLoginToken;
      if (link != null) {
        telegramLoginToken = null;
        try {
          return await _signedIn(await api.loginTelegram(link));
        } on ApiException catch (e) {
          error = e.describe;
        }
      }
      if (api.token == null) return _set(SessionState.signedOut);
      // Connexion gardée : le jeton est renouvelé à chaque ouverture (il ne
      // périme pas tant que l'application sert au moins une fois par mois).
      unawaited(api.send('POST', '/auth/refresh').then((r) async {
        final token = r['token'] as String?;
        if (token == null || api.token == null) return;
        api.token = token;
        await prefs.setString(tokenKey, token);
      }, onError: (_) {}));
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
      // Compte rattaché à un autre compte Google : cet appareil se déconnecte.
      if (e.kind == 'session_revoked') return _sessionRevoked(switched: true);
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
          await _guard(() async => _signedIn(await api.loginGoogle(idToken, switchToken: googleSwitchToken)));
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
      _guard(() async => _signedIn(await api.loginDev(email, switchToken: googleSwitchToken)));

  /// Compte supprimé en fantôme, réactivé par cette connexion (message d'accueil).
  bool accountRestored = false;

  Future<void> _signedIn((String, User) login) async {
    final (token, _) = login;
    accountRestored = api.lastLoginRestored;
    accountSwitched = api.lastLoginSwitched;
    googleSwitchToken = null;
    await switchToken(token);
  }

  /// Nouvelle session (par exemple : ancien compte repris avec ce compte Google).
  /// [remember] faux : la connexion n'est pas gardée sur l'appareil (il
  /// faudra se reconnecter à la prochaine ouverture).
  Future<void> switchToken(String token, {bool remember = true}) async {
    await sync.clear();
    api.token = token;
    final prefs = await SharedPreferences.getInstance();
    remember ? await prefs.setString(tokenKey, token) : await prefs.remove(tokenKey);
    await refresh();
  }

  /// Connexion par application 2FA (ou activation du compte).
  Future<void> signInWithToken(String token, {required bool remember}) async {
    error = null;
    linkingGoogle = false;
    await switchToken(token, remember: remember);
  }

  /// Compte sans Google qui relie un compte Google : la prochaine connexion
  /// Google sera rattachée à ce compte.
  bool linkingGoogle = false;

  Future<void> startGoogleLink(String token) async {
    await signOut();
    googleSwitchToken = token;
    linkingGoogle = true;
    notifyListeners();
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
