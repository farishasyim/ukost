import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/buttons/button_add.dart';
import 'package:ukost/ui_features/components/card/room_card.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(60),
                  for (var i = 1; i < 5; i++)
                    Column(
                      children: [
                        HorizontalText(
                          title: "Tipe Kamar $i",
                          trailing: "Detil",
                          onTap: () {},
                        ),
                        verticalSpace(10),
                        SizedBox(
                          height: 200,
                          width: screenWidth(context),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 20),
                            children: [
                              for (var i = 1; i < 5; i++)
                                RoomCard(
                                  onTap: () {},
                                  title: "Kamar $i",
                                  subtitle: "Tersedia",
                                ),
                              ButtonAdd(
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  verticalSpace(60),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight(context) * 0.88,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppBarPrimary(
                  title: "Manajemen Kamar",
                  trailing: SizedBox(),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: ColorAsset.violet,
                      child: Icon(
                        Icons.add_rounded,
                        color: ColorAsset.white,
                      ),
                    ),
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
