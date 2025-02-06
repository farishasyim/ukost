import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/number_extension.dart';

class FinanceTile extends StatelessWidget {
  const FinanceTile({
    super.key,
    this.price = 0,
    this.title,
    this.subtitle,
    this.children = const [],
    this.onLongPress,
    this.expanded = false,
    this.onTap,
  });
  final String? title, subtitle;
  final int price;
  final List<Widget> children;
  final Function()? onLongPress, onTap;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: ListTile(
            onLongPress: onLongPress,
            onTap: onTap,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            dense: true,
            title: Text(
              title ?? "",
              style: GoogleFonts.inter(),
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle ?? "",
                    style: GoogleFonts.inter(),
                  )
                : null,
            trailing: Text(
              price.toCurrency(),
              style: GoogleFonts.inter(
                fontSize: 12,
                color: ColorAsset.success,
              ),
            ),
          ),
        ),
        SizedBox(
          width: screenWidth(context),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorAsset.violetLight,
                  ),
                ),
                color: ColorAsset.white,
              ),
              height: expanded ? null : 0,
              duration: const Duration(milliseconds: 200),
              child: Column(
                children: [
                  ...children,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
