import 'package:flutter/foundation.dart';

/// Achats dans l'application : seulement dans la version web (le SaaS).
///
/// L'application Android ne vend rien : elle utilise les droits accordés
/// par le serveur (abonnement, places, options payés sur le web). Aucun
/// prix, aucun bouton d'achat, aucun lien vers un paiement n'y apparaît,
/// comme l'exigent les règles de Google Play sur les paiements.
///
/// Pour vendre un jour sur mobile (facturation Google Play, ou programme
/// de paiement externe autorisé par Google) : brancher ce paiement, puis
/// construire avec `--dart-define=MOBILE_PURCHASES=true` ; tous les écrans
/// d'achat réapparaissent alors, car ils passent tous par [enabled].
class Purchases {
  static const _mobile = bool.fromEnvironment('MOBILE_PURCHASES');

  static bool get enabled => kIsWeb || _mobile;
}
