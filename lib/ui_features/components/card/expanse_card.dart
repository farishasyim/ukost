import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';

class ExpanseCard extends StatelessWidget {
  const ExpanseCard({
    super.key,
    this.title = "",
    this.path,
    this.subtitle = "",
    this.trailing,
    this.onTap,
  });
  final String title, subtitle;
  final String? path, trailing;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.only(right: 20),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ColorAsset.black.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorAsset.violet,
                      image: path != null
                          ? DecorationImage(
                              image: NetworkImage(path!),
                              fit: BoxFit.cover,
                            )
                          : null),
                ),
                horizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: ColorAsset.violet,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle.length > 20
                          ? "${subtitle.substring(0, 20)}..."
                          : subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: ColorAsset.black.withOpacity(0.4),
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
