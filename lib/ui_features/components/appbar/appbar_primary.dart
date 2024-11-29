import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/assets.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';

class AppBarPrimary extends StatelessWidget {
  const AppBarPrimary({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    this.height,
    this.children = const [],
  });
  final String? title, subtitle;
  final Widget? trailing;
  final double? height;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: padTop(context) + 20,
        bottom: 10,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
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
          ...children,
        ],
      ),
    );
  }
}
