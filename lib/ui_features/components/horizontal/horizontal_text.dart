import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';

class HorizontalText extends StatelessWidget {
  const HorizontalText({
    super.key,
    this.title,
    this.trailing,
    this.padding,
    this.onTap,
  });
  final String? title, trailing;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: ColorAsset.black,
              fontSize: 16,
            ),
          ),
          if (trailing != null)
            InkWell(
              onTap: onTap,
              child: Text(
                trailing ?? "",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.normal,
                  color: ColorAsset.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
