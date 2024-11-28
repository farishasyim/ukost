import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    this.active = false,
    this.title,
    this.subtitle,
  });
  final String? title, subtitle;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: ColorAsset.black.withOpacity(0.2),
          ),
        ),
        dense: true,
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorAsset.violet,
          ),
        ),
        title: Text(
          title ?? "",
          style: GoogleFonts.inter(
            color: ColorAsset.black,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle ?? "",
          style: GoogleFonts.inter(
            color: ColorAsset.black.withOpacity(
              0.8,
            ),
            fontSize: 12,
          ),
        ),
        trailing: Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? ColorAsset.red : ColorAsset.success,
          ),
        ),
      ),
    );
  }
}
