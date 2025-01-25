import 'package:flutter/material.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/pages/auth/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const LoginPage(),
    );
  }
}
