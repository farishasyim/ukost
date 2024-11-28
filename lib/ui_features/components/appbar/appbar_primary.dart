import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/assets.dart';
import 'package:ukost/config/color_assets.dart';

class AppBarPrimary extends StatelessWidget {
  const AppBarPrimary({super.key, this.title, this.subtitle, this.trailing});
  final String? title, subtitle;
  final Widget? trailing;

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
                if (title != null)
                  Text(
                    title ?? "",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: ColorAsset.black,
                      fontSize: 16,
                    ),
                  ),
                if (subtitle != null)
                  Text(
                    subtitle ?? "",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: ColorAsset.violet,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
          if (trailing != null)
            trailing!
          else
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
