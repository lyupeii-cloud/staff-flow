// Application installée sur l'écran d'accueil (web), ou application native.
export 'standalone_io.dart' if (dart.library.js_interop) 'standalone_web.dart';
