import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ukost/app/app.dart';
import 'package:ukost/config/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.initialize();

  initializeDateFormatting("id_ID");

  runApp(const App());
}
