import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/assets.dart';
import 'package:ukost/config/color_assets.dart';

class AppBarPrimary extends StatelessWidget {
  const AppBarPrimary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Selamat Datang,",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    color: ColorAsset.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Pengguna A",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: ColorAsset.violet,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            Assets.logo,
            height: 50,
            width: 50,
          ),
        ],
      ),
    );
  }
}
