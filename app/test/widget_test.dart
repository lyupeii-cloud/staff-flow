import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:staff_flow/main.dart';
import 'package:staff_flow/src/api.dart';
import 'package:staff_flow/src/i18n.dart';
import 'package:staff_flow/src/session.dart';

void main() {
  Future<void> pumpLogin(WidgetTester tester, List<Locale> phoneLocales) async {
    tester.platformDispatcher.localesTestValue = phoneLocales;
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    final session = Session(Api())..state = SessionState.signedOut;
    await tester.pumpWidget(StaffFlowApp(session: session));
    await tester.pumpAndSettle();
  }

  testWidgets('téléphone en ukrainien : écran de connexion en ukrainien', (tester) async {
    await pumpLogin(tester, const [Locale('uk', 'UA')]);
    expect(find.textContaining('Графіки вашої команди', findRichText: true), findsOneWidget);
  });

  testWidgets('téléphone en français : écran en français', (tester) async {
    await pumpLogin(tester, const [Locale('fr', 'FR')]);
    expect(find.textContaining('Les plannings de votre équipe', findRichText: true), findsOneWidget);
  });

  testWidgets('langue non proposée (polonais) : anglais', (tester) async {
    await pumpLogin(tester, const [Locale('pl', 'PL')]);
    expect(find.textContaining('Your team\'s schedules', findRichText: true), findsOneWidget);
  });

  test('langue du compte Google : seules les langues proposées sont retenues', () {
    expect(supportedLocaleFor('uk'), const Locale('uk'));
    expect(supportedLocaleFor('fr-CA'), const Locale('fr'));
    expect(supportedLocaleFor('pl'), isNull);
    expect(supportedLocaleFor(null), isNull);
  });

  test('fuseau proposé d\'après le pays, puis la langue', () {
    expect(defaultTimezone(const Locale('uk', 'UA')), 'Europe/Kyiv');
    expect(defaultTimezone(const Locale('fr', 'BE')), 'Europe/Brussels');
    expect(defaultTimezone(const Locale('fr')), 'Europe/Paris');
    expect(defaultTimezone(const Locale('ja', 'JP')), 'UTC');
  });
}
