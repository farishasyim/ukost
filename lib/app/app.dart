import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/pages/auth/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appname,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.inter(
            fontSize: 16,
            color: ColorAsset.black,
          ),
          backgroundColor: ColorAsset.white,
          centerTitle: true,
        ),
      ),
      navigatorKey: navigatorKey,
      home: const LoginPage(),
    );
  }
}
