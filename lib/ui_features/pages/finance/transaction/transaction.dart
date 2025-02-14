import 'package:flutter/material.dart';
import 'package:ukost/app/models/transaction/transaction.dart';
import 'package:ukost/app/repositories/finance/finance_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';
import 'package:ukost/ui_features/components/tile/finance_tile.dart';
import 'package:ukost/ui_features/pages/finance/transaction/form_transaction.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<Transaction> transactions = [];
  int? selected;

  Future<void> init() async {
    transactions = await FinanceRepository.getIncome();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await init();
      },
      child: Stack(
        children: [
          ListView(
            children: [
              for (var row in transactions)
                FinanceTile(
                  onLongPress: storage.account?.role == Role.admin
                      ? () {
                          Modals().action(
                            onDelete: () {
                              Modals().confirmation(
                                onTap: () async {
                                  var res =
                                      await FinanceRepository.deleteIncome(
                                          row.id!);
                                  if (res) {
                                    init();
                                  }
                                },
                              );
                            },
                            onEdit: () {
                              nextScreen(
                                FormTransactionPage(
                                  transaction: row,
                                ),
                              );
                            },
                          );
                        }
                      : null,
                  onTap: () {
                    setState(() {
                      if (selected == row.id) {
                        selected = null;
                      } else {
                        selected = row.id;
                      }
                    });
                  },
                  expanded: selected == row.id,
                  title: row.invoice,
                  subtitle: row.pivotRoom?.user?.name,
                  price: row.price ?? 0,
                  children: [
                    HorizontalText(
                      trailing: DateFormatter.dateTime(row.date),
                    ),
                    HorizontalText(
                      trailing:
                          row.status == "paid" ? "Lunas" : "Belum Dibayar",
                    ),
                  ],
                ),
            ],
          ),
          if (storage.account?.role == Role.admin)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  bottom: 15,
                ),
                child: FloatingActionButton(
                  heroTag: "income",
                  onPressed: () {
                    nextScreen(const FormTransactionPage());
                  },
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
    );
  }
}
