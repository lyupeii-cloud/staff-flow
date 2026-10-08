import 'package:flutter/material.dart';

import 'src/api.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/login_screen.dart';
import 'src/session.dart';

void main() {
  final session = Session(Api())..start();
  runApp(StaffFlowApp(session: session));
}

class StaffFlowApp extends StatelessWidget {
  final Session session;

  const StaffFlowApp({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final seed = const Color(0xFF2F6F5E);
    return MaterialApp(
      title: 'Staff Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: seed),
      darkTheme: ThemeData(colorSchemeSeed: seed, brightness: Brightness.dark),
      home: ListenableBuilder(
        listenable: session,
        builder: (context, _) => switch (session.state) {
          SessionState.loading => const Scaffold(body: Center(child: CircularProgressIndicator())),
          SessionState.signedOut => LoginScreen(session: session),
          SessionState.signedIn => HomeScreen(session: session),
        },
      ),
    );
  }
}
