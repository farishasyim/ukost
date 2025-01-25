import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';

class MenuUserCard extends StatelessWidget {
  const MenuUserCard({
    super.key,
    this.title,
    this.subtitle,
    this.imagePath,
    this.onTap,
  });
  final String? title, subtitle, imagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Material(
        borderRadius: BorderRadius.circular(6),
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 165,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: ColorAsset.black.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Ink(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          imagePath ?? 'assets/images/Image1.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title ?? "",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: ColorAsset.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          subtitle ?? "",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w300,
                            color: ColorAsset.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
