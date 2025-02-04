import 'package:flutter/material.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/ui_features/pages/finance/transaction/transaction.dart';

class FinanceLayout extends StatefulWidget {
  const FinanceLayout({super.key});

  @override
  State<FinanceLayout> createState() => _FinanceLayoutState();
}

class _FinanceLayoutState extends State<FinanceLayout> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: padTop(context)),
          ),
          TabBar(
            onTap: (e) {
              setState(() {
                index = e;
              });
            },
            tabs: const [
              Tab(
                text: "Pemasukan",
              ),
              Tab(
                text: "Pengeluaran",
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: index,
              children: const [
                TransactionPage(),
                Placeholder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
