import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/card/main_menu_card.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Membungkus seluruh halaman agar scrollable
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const AppBarPrimary(
            height: null,
            title: "UKost,",
            titleStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: ColorAsset.violet,
            ),
          ),
          verticalSpace(10),
          HorizontalText(
            title: "Main Menu",
            titleStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            onTap: () {},
          ),
          verticalSpace(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                // Baris pertama (dua kolom)
                Row(
                  children: [
                    // Kolom pertama
                    Container(
                      height: 125, // Tentukan tinggi kontainer
                      width: (screenWidth(context) - 30) /
                          2, // Pembagian lebar antar kolom
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 10),
                        children: [
                          MenuUserCard(
                            onTap: () {},
                            imagePath: 'assets/images/Image1.png',
                            title: "Manajemen Kamar",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10), // Spasi antara kolom
                    // Kolom kedua
                    Container(
                      height: 125, // Tentukan tinggi kontainer
                      width: (screenWidth(context) - 30) /
                          2, // Pembagian lebar antar kolom
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 10),
                        children: [
                          MenuUserCard(
                            onTap: () {},
                            imagePath: 'assets/images/Image2.png',
                            title: "Manajemen Kamar",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Baris kedua (satu kolom)
                Container(
                  height: 125, // Tentukan tinggi kontainer
                  width: screenWidth(context),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 10),
                    children: [
                      MenuUserCard(
                        onTap: () {},
                        imagePath: 'assets/images/Image3.png',
                        title: "Manajemen Kamar",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
