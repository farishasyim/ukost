import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/app/repositories/category/category_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/config/number_extension.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/card/expanse_card.dart';
import 'package:ukost/ui_features/components/card/room_card.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';
import 'package:ukost/ui_features/pages/room_management/detail_category.dart';

class AdminFragment extends StatefulWidget {
  const AdminFragment({super.key});

  @override
  State<AdminFragment> createState() => _AdminFragmentState();
}

class _AdminFragmentState extends State<AdminFragment> {
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
  List<Category> categories = [];

  void init() async {
    categories = await CategoryRepository.getCategory();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      init();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                for (var i = 1; i < 4; i++)
                  ExpanseCard(
                    onTap: () {},
                    title: "-",
                    subtitle: "-",
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
                for (var row in categories)
                  RoomCard(
                    onTap: () async {
                      Modals().loading();
                      var res = await CategoryRepository.show(row.id!);
                      backScreen();
                      if (res != null) {
                        nextScreen(DetailCategoryPage(
                          category: res,
                        ));
                      }
                    },
                    title: row.name ?? "-",
                    subtitle: row.price?.toCurrency(),
                    path: row.imageLink,
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
}
