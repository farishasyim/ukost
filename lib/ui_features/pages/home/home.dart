import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/card/expanse_card.dart';
import 'package:ukost/ui_features/components/card/room_card.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const AppBarPrimary(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: ColorAsset.violet,
              ),
            ),
            verticalSpace(10),
            HorizontalText(
              title: "Pengeluaran November 2024",
              trailing: "Detil",
              onTap: () {},
            ),
            verticalSpace(10),
            SizedBox(
              height: 70,
              width: screenWidth(context),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                children: [
                  for (var i = 0; i < 4; i++)
                    ExpanseCard(
                      onTap: () {},
                      title: "Pnegguna A",
                      subtitle: "Pembelian gembok asdasdas as dadad sas a",
                    ),
                ],
              ),
            ),
            verticalSpace(20),
            HorizontalText(
              title: "Jenis Kamar",
              trailing: "Detil",
              onTap: () {},
            ),
            verticalSpace(10),
            SizedBox(
              height: 200,
              width: screenWidth(context),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                children: [
                  for (var i = 0; i < 4; i++)
                    RoomCard(
                      onTap: () {},
                      title: "Room $i",
                      subtitle: "$i",
                    ),
                ],
              ),
            ),
            verticalSpace(20),
            const HorizontalText(
              title: "Pembayaran",
              trailing: "7 Hari Terakhir",
            ),
          ],
        ),
      ),
    );
  }
}
