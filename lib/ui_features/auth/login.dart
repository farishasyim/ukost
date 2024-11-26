import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/assets.dart';
import 'package:ukost/config/constraint.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 304,
            width: screenWidth(context),
            child: PageView(
              children: [
                for (var row in [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                ])
                  Container(
                    color: row,
                  ),
              ],
            ),
          ),
          verticalSpace(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Masuk",
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      Assets.logo,
                      width: 41,
                      height: 46,
                    ),
                  ],
                ),
                verticalSpace(10),
                Text(
                  "Selamat datang di sistem manajemen kost, silahkan\nmasukkan email dan password anda yang terdaftar\ndi sistem untuk memulai penggunaan aplikasi ini.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
