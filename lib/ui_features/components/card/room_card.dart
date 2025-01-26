import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    super.key,
    this.title,
    this.subtitle,
    this.onLongPress,
    this.path,
    this.onTap,
  });
  final String? title, subtitle, path;
  final Function()? onTap, onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Material(
        borderRadius: BorderRadius.circular(6),
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onLongPress: onLongPress,
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 230,
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
                        image: NetworkImage(
                          path ??
                              "https://img.freepik.com/premium-photo/hotel-room-with-bed-window-with-view-city_865967-349517.jpg",
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
