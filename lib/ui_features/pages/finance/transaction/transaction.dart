import 'package:flutter/material.dart';
import 'package:ukost/app/models/transaction/transaction.dart';
import 'package:ukost/app/repositories/finance/finance_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/config/snackbar.dart';
import 'package:ukost/ui_features/components/dialog/dialog_filter_transaction.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';
import 'package:ukost/ui_features/components/tile/finance_tile.dart';
import 'package:ukost/ui_features/pages/finance/transaction/form_transaction.dart';
import 'package:ukost/ui_features/pages/finance/transaction/report_transaction.dart';

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
            padding:
                storage.account?.role == Role.admin ? EdgeInsets.zero : null,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      elevation: 1,
                      mini: true,
                      heroTag: "report_transaction",
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          builder: (e) {
                            return DialogFilterTransaction(
                              onTap: (e) async {
                                var res = await FinanceRepository
                                    .getReportTransaction(e);
                                if (res.isEmpty) {
                                  Snackbar.error("Data kosong");
                                  return;
                                }
                                nextScreen(
                                  ReportTransactionPage(
                                    transactions: res,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.summarize_rounded,
                        color: ColorAsset.white,
                      ),
                    ),
                    verticalSpace(5),
                    FloatingActionButton(
                      elevation: 1,
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
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
