// Remplit la configuration Firebase de l'application à partir des fichiers
// de la console Firebase. Ces valeurs ne sont pas secrètes (elles désignent
// le projet) ; le compte de service, lui, ne va que sur le serveur.
//
//   dart run tool/firebase_setup.dart <google-services.json> <web-config.json> <clé VAPID>
//
// web-config.json : l'objet « firebaseConfig » de l'application Web, en JSON
// ({"apiKey": "...", "appId": "...", "messagingSenderId": "...", "projectId": "..."}).
import 'dart:convert';
import 'dart:io';

/// Version du SDK JavaScript utilisée par firebase_core_web.
const jsSdk = '12.19.0';

void main(List<String> args) {
  if (args.length != 3) {
    stderr.writeln('Usage : dart run tool/firebase_setup.dart <google-services.json> <web-config.json> <clé VAPID>');
    exit(64);
  }
  final android = jsonDecode(File(args[0]).readAsStringSync()) as Map<String, dynamic>;
  final web = jsonDecode(File(args[1]).readAsStringSync()) as Map<String, dynamic>;
  final vapid = args[2].trim();

  final projectId = android['project_info']['project_id'] as String;
  final senderId = android['project_info']['project_number'] as String;
  final client = (android['client'] as List).cast<Map<String, dynamic>>().firstWhere(
      (c) => c['client_info']['android_client_info']['package_name'] == 'com.staffflow.staff_flow');
  final androidAppId = client['client_info']['mobilesdk_app_id'] as String;
  final androidApiKey = (client['api_key'] as List).first['current_key'] as String;
  if (web['projectId'] != projectId) throw 'Les deux fichiers viennent de projets différents.';

  final config = File('lib/src/firebase_config.dart');
  var source = config.readAsStringSync();
  void set(String name, String value) {
    source = source.replaceFirst(RegExp("static const $name = '[^']*';"), "static const $name = '$value';");
  }

  set('projectId', projectId);
  set('messagingSenderId', senderId);
  set('webApiKey', web['apiKey'] as String);
  set('webAppId', web['appId'] as String);
  set('androidApiKey', androidApiKey);
  set('androidAppId', androidAppId);
  set('vapidKey', vapid);
  config.writeAsStringSync(source);

  File('web/firebase-messaging-sw.js').writeAsStringSync('''
// Notifications du site quand l'onglet est fermé ou en arrière-plan.
// Fichier produit par tool/firebase_setup.dart.
importScripts('https://www.gstatic.com/firebasejs/$jsSdk/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/$jsSdk/firebase-messaging-compat.js');

firebase.initializeApp(${const JsonEncoder.withIndent('  ').convert({
    'apiKey': web['apiKey'],
    'appId': web['appId'],
    'messagingSenderId': senderId,
    'projectId': projectId,
  })});

// Les messages du serveur contiennent déjà le titre et le texte : le
// navigateur les affiche lui-même.
firebase.messaging();
''');
  stdout.writeln('Configuration Firebase écrite pour le projet $projectId.');
}
