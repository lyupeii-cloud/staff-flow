// Notifications du site quand l'onglet est fermé ou en arrière-plan.
// Fichier produit par tool/firebase_setup.dart.
importScripts('https://www.gstatic.com/firebasejs/12.19.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/12.19.0/firebase-messaging-compat.js');

firebase.initializeApp({
  "apiKey": "AIzaSyCPLLXvFZRGcVLHUqz4g3VeCHVONWgtGf4",
  "appId": "1:971132277831:web:b378b14cd10c39b03b4d62",
  "messagingSenderId": "971132277831",
  "projectId": "protean-fabric-497808-u7"
});

// Les messages du serveur contiennent déjà le titre et le texte : le
// navigateur les affiche lui-même.
firebase.messaging();
