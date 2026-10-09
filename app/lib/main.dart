import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/api.dart';
import 'src/brand.dart';
import 'src/i18n.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/login_screen.dart';
import 'src/session.dart';

void main() {
  // Les plugins (stockage, Google) exigent le moteur Flutter prêt.
  WidgetsFlutterBinding.ensureInitialized();
  final session = Session(Api())..start();
  runApp(StaffFlowApp(session: session));
}

class StaffFlowApp extends StatelessWidget {
  final Session session;

  const StaffFlowApp({super.key, required this.session});

  /// Langue affichée : celle choisie dans le menu « Langue » si l'utilisateur
  /// en a choisi une ; sinon, sur Android, celle du téléphone (`null` = langue
  /// du système) et, sur le web, celle du compte Google une fois connecté,
  /// ou à défaut celle du navigateur. Une langue non proposée donne l'anglais.
  Locale? get _locale =>
      supportedLocaleFor(session.language) ??
      (kIsWeb ? supportedLocaleFor(session.me?.user.locale) : null);

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: session,
        builder: (context, _) => MaterialApp(
          onGenerateTitle: (_) => 'Staff Flow',
          debugShowCheckedModeBanner: false,
          theme: Brand.theme(Brightness.light),
          darkTheme: Brand.theme(Brightness.dark),
          themeMode: session.themeMode,
          locale: _locale,
          supportedLocales: supportedLocales,
          localizationsDelegates: const [
            L10n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            // Le serveur répond dans la langue de l'écran.
            session.api.language = Localizations.localeOf(context).languageCode;
            return FramedApp(child: child!);
          },
          home: switch (session.state) {
            SessionState.loading => Scaffold(
                backgroundColor: Brand.navy,
                body: Center(child: Image.asset('assets/brand/logo-mark.png', width: 160)),
              ),
            SessionState.signedOut => LoginScreen(session: session),
            SessionState.signedIn => HomeScreen(session: session),
          },
        ),
      );
}
