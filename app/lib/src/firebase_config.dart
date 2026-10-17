import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Réglages publics du projet Firebase (console Firebase, « Paramètres du
/// projet »). Ce ne sont pas des secrets : ils désignent le projet, comme une
/// adresse. Vides : pas de notifications sur les appareils, les avis restent
/// visibles dans la cloche.
class FirebaseConfig {
  static const projectId = 'protean-fabric-497808-u7';
  static const messagingSenderId = '971132277831';

  /// Application Web (« firebaseConfig » de la console).
  static const webApiKey = 'AIzaSyCPLLXvFZRGcVLHUqz4g3VeCHVONWgtGf4';
  static const webAppId = '1:971132277831:web:b378b14cd10c39b03b4d62';

  /// Application Android (google-services.json : current_key, mobilesdk_app_id).
  static const androidApiKey = 'AIzaSyCbg8BGqCS_q7fGfpvl2zt1OK0BAFP0PS8';
  static const androidAppId = '1:971132277831:android:ab7451dc01a12bf43b4d62';

  /// Clé publique « Web Push » (Cloud Messaging > Certificats Web Push).
  static const vapidKey = 'BHma32dXDUUywshlgeDSc9-tnIfq89C-K-ylh-pG6eA7FkQIv950-1FaQVE7m-1UGjwgbNE2khn9lb4q5v8lyN4';

  static bool get configured => projectId.isNotEmpty;

  static FirebaseOptions get options => FirebaseOptions(
        apiKey: kIsWeb ? webApiKey : androidApiKey,
        appId: kIsWeb ? webAppId : androidAppId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
      );
}
