import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/app/models/expense/expense.dart';
import 'package:ukost/app/models/graph/graph.dart';
import 'package:ukost/app/repositories/category/category_repository.dart';
import 'package:ukost/app/repositories/finance/finance_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/format_date.dart';
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
  List<Graph> lines = [];
  List<Category> categories = [];
  List<Expense> expenses = [];

  Future<void> init() async {
    categories = await CategoryRepository.getCategory();
    expenses = await FinanceRepository.getExpense(DateTime.now());
    lines = await CategoryRepository.getRecentTransaction();
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
    return RefreshIndicator(
      onRefresh: () async {
        await init();
      },
      child: SingleChildScrollView(
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
              title: "Pengeluaran ${DateFormatter.date(null, "MMMM yyyy")}",
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
                  for (var row in expenses)
                    ExpanseCard(
                      onTap: () {},
                      path: row.user?.profileLink,
                      title: row.title ?? "",
                      subtitle: row.description ?? "",
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
                  series: <LineSeries<Graph, String>>[
                    LineSeries<Graph, String>(
                      dataSource: lines,
                      markerSettings: const MarkerSettings(isVisible: true),
                      xValueMapper: (transaction, _) => transaction.xAxis,
                      yValueMapper: (transaction, _) => transaction.yAxis,
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
      ),
    );
  }
}
