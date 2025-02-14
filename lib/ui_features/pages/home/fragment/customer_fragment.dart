import 'package:flutter/material.dart';
import 'package:ukost/app/models/transaction/transaction.dart';
import 'package:ukost/app/repositories/finance/finance_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/card/expanse_card.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';

class CustomerFragment extends StatefulWidget {
  const CustomerFragment({super.key});

  @override
  State<CustomerFragment> createState() => _CustomerFragmentState();
}

class _CustomerFragmentState extends State<CustomerFragment> {
  List<Transaction> transactions = [];

  Future<void> init() async {
    transactions = await FinanceRepository.getIncome(TransactionStatus.unpaid);
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
      child: ListView(
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
            title: "Tagihan anda",
            trailing: "",
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
                for (var row in transactions)
                  ExpanseCard(
                    onTap: () {},
                    title: row.pivotRoom?.user?.name ?? "-",
                    subtitle: DateFormatter.date(row.date, "dd/MM/yyyy"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
