import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/card/expanse_card.dart';
import 'package:ukost/ui_features/components/card/main_menu_card.dart';
import 'package:ukost/ui_features/components/card/room_card.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (storage.account?.role == Role.customer) {
      return _customerView(context);
    }

    return _adminView(context);
  }

  Widget _adminView(BuildContext context) {
    List<Map<String, dynamic>> lines = [
      {
        "label": "11/02/24",
        "value": 14000,
      },
      {
        "label": "12/02/24",
        "value": 24000,
      },
      {
        "label": "13/02/24",
        "value": 5999,
      },
      {
        "label": "14/02/24",
        "value": 40000,
      },
      {
        "label": "15/02/24",
        "value": 2000,
      },
      {
        "label": "16/02/24",
        "value": 15000,
      },
      {
        "label": "17/02/24",
        "value": 30000,
      },
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBarPrimary(
            height: null,
            title: "Selamat Datang,",
            subtitle: storage.account?.name ?? "",
          ),
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
                for (var i = 1; i < 5; i++)
                  ExpanseCard(
                    onTap: () {},
                    title: "Admin $i",
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
                for (var i = 1; i < 4; i++)
                  RoomCard(
                    onTap: () {},
                    title: "Jenis Kamar $i",
                    subtitle: "Rp. $i,000,000",
                  ),
              ],
            ),
          ),
          verticalSpace(20),
          const HorizontalText(
            title: "Pembayaran",
            trailing: "7 Hari Terakhir",
          ),
          verticalSpace(10),
          Center(
            child: SizedBox(
              height: 200,
              width: screenWidth(context) * 0.9,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                // Chart title
                title: const ChartTitle(text: ''),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <LineSeries<Map, String>>[
                  LineSeries<Map, String>(
                    dataSource: lines,
                    markerSettings: const MarkerSettings(isVisible: true),
                    xValueMapper: (income, _) => income["label"],
                    yValueMapper: (income, _) => income["value"],
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          verticalSpace(20),
        ],
      ),
    );
  }

  Widget _customerView(BuildContext context) {
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
            titleStyle: const TextStyle(
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
                    SizedBox(
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
                    const SizedBox(width: 10), // Spasi antara kolom
                    // Kolom kedua
                    SizedBox(
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
                const SizedBox(height: 20),
                // Baris kedua (satu kolom)
                SizedBox(
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
