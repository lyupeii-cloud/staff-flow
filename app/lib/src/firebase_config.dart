import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Réglages publics du projet Firebase (console Firebase, « Paramètres du
/// projet »). Ce ne sont pas des secrets : ils désignent le projet, comme une
/// adresse. Vides : pas de notifications sur les appareils, les avis restent
/// visibles dans la cloche.
class FirebaseConfig {
  static const projectId = '';
  static const messagingSenderId = '';

  /// Application Web (« firebaseConfig » de la console).
  static const webApiKey = '';
  static const webAppId = '';

  /// Application Android (google-services.json : current_key, mobilesdk_app_id).
  static const androidApiKey = '';
  static const androidAppId = '';

  /// Clé publique « Web Push » (Cloud Messaging > Certificats Web Push).
  static const vapidKey = '';

  static bool get configured => projectId.isNotEmpty;

  static FirebaseOptions get options => FirebaseOptions(
        apiKey: kIsWeb ? webApiKey : androidApiKey,
        appId: kIsWeb ? webAppId : androidAppId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
      );
}
