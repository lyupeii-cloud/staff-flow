import 'package:flutter_test/flutter_test.dart';
import 'package:staff_flow/main.dart';
import 'package:staff_flow/src/api.dart';
import 'package:staff_flow/src/session.dart';

void main() {
  testWidgets('sans session, l\'écran de connexion s\'affiche', (tester) async {
    final session = Session(Api())..state = SessionState.signedOut;
    await tester.pumpWidget(StaffFlowApp(session: session));
    expect(find.textContaining('Les plannings de votre équipe', findRichText: true), findsOneWidget);
    expect(find.textContaining('Connexion Google non configurée'), findsOneWidget);
  });
}
