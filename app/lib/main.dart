import 'package:flutter/material.dart';

import 'src/api.dart';
import 'src/brand.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staff Flow',
      debugShowCheckedModeBanner: false,
      theme: Brand.theme(Brightness.light),
      darkTheme: Brand.theme(Brightness.dark),
      home: ListenableBuilder(
        listenable: session,
        builder: (context, _) => switch (session.state) {
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
}
