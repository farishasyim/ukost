import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/ui_features/components/buttons/profile_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menus = [
      {
        "icon": Icons.person,
        "label": "Ubah profile",
      },
      {
        "icon": Icons.logout,
        "label": "Keluar",
      },
    ];
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(20),
            const ProfileButton(),
            verticalSpace(10),
            Text(
              "Faris Hasyim",
              style: GoogleFonts.inter(
                color: ColorAsset.black.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.4,
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  for (var row in menus)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: ColorAsset.black.withOpacity(0.8),
                          ),
                        ),
                        dense: true,
                        onTap: () {},
                        leading: Icon(
                          row["icon"],
                          color: ColorAsset.black.withOpacity(
                            0.8,
                          ),
                        ),
                        title: Text(
                          row["label"],
                          style: GoogleFonts.inter(
                            color: ColorAsset.black.withOpacity(
                              0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
