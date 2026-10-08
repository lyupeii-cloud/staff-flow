import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
import 'config.dart';
import 'models.dart';

enum SessionState { loading, signedOut, signedIn }

/// Connexion Google, jeton de session et données de l'utilisateur (`/me`).
class Session extends ChangeNotifier {
  final Api api;

  Session(this.api);

  static const _tokenKey = 'session_token';

  SessionState state = SessionState.loading;
  Me? me;
  String? error;
  bool _googleReady = false;

  bool get googleReady => _googleReady;

  Future<void> start() async {
    unawaited(_initGoogle());
    try {
      final prefs = await SharedPreferences.getInstance();
      api.token = prefs.getString(_tokenKey);
      if (api.token == null) return _set(SessionState.signedOut);
      await refresh();
    } on ApiException catch (e) {
      if (e.status == 401) return signOut();
      error = e.message;
      _set(SessionState.signedOut);
    } catch (_) {
      error = 'Serveur injoignable.';
      _set(SessionState.signedOut);
    }
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
      error = 'Connexion Google indisponible : $e';
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
      error = 'Connexion Google impossible : $e';
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
    await prefs.setString(_tokenKey, token);
    await refresh();
  }

  Future<void> refresh() async {
    me = await api.me();
    _set(SessionState.signedIn);
  }

  Future<void> signOut() async {
    api.token = null;
    me = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    if (_googleReady) await GoogleSignIn.instance.signOut();
    _set(SessionState.signedOut);
  }

  Future<void> _guard(Future<void> Function() action) async {
    error = null;
    notifyListeners();
    try {
      await action();
    } on ApiException catch (e) {
      error = e.message;
      notifyListeners();
    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        error = 'Connexion Google impossible : ${e.description ?? e.code.name}';
        notifyListeners();
      }
    } catch (e) {
      error = 'Serveur injoignable.';
      notifyListeners();
    }
  }

  void _set(SessionState s) {
    state = s;
    notifyListeners();
  }
}
