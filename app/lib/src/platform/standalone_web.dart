import 'dart:js_interop';

@JS('sfStandalone')
external bool? get _standalone;

/// Site ouvert depuis l'icône de l'écran d'accueil (voir web/index.html).
bool get isStandalone => _standalone ?? false;
