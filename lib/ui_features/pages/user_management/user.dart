import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/card/user_card.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(120),
                  for (var i = 0; i < 5; i++)
                    UserCard(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      title: "Pengguna ${i + 1}",
                      subtitle: i.isEven ? "-" : "Kamar 201",
                      active: i.isEven,
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
                AppBarPrimary(
                  title: "Manajemen Pengguna",
                  trailing: const SizedBox(),
                  children: [
                    verticalSpace(10),
                    TextFieldPrimary(
                      hintText: "Mencari nama pengguna",
                      isRaw: true,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search_rounded,
                          color: ColorAsset.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
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
