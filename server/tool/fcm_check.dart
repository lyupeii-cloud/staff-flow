// Vérifie un compte de service Firebase : signature, jeton d'accès et droit
// d'envoi, avec un jeton d'appareil volontairement faux (rien n'est envoyé).
//   dart run tool/fcm_check.dart <compte-de-service.json>
import 'dart:io';

import 'package:staff_flow_server/staff_flow_server.dart';

Future<void> main(List<String> args) async {
  final sender = FcmSender.fromJson(File(args[0]).readAsStringSync());
  final outcome = await sender.send(const PushMessage('jeton-de-test-invalide', 'Test', 'Test', {}));
  // « invalidToken » : Firebase a accepté nos droits et refusé seulement l'appareil inventé.
  stdout.writeln('Projet ${sender.projectId} : $outcome');
  exit(outcome == PushOutcome.invalidToken ? 0 : 1);
}
