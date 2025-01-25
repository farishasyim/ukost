import 'package:flutter/material.dart';
import 'package:ukost/app/app.dart';
import 'package:ukost/config/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.initialize();
  runApp(const App());
}
