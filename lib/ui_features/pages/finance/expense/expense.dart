import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/app/models/expense/expense.dart';
import 'package:ukost/app/repositories/finance/finance_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';
import 'package:ukost/ui_features/components/tile/finance_tile.dart';
import 'package:ukost/ui_features/pages/finance/expense/form_expense.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Expense> expenses = [];
  int? selected;

  Future<void> init() async {
    expenses = await FinanceRepository.getExpense();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    init().ignore();
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
            padding: const EdgeInsets.symmetric(),
            children: [
              for (var row in expenses)
                FinanceTile(
                  title: row.title,
                  price: row.price,
                  subtitle: row.user?.name,
                  onTap: () {
                    setState(() {
                      if (selected == row.id) {
                        selected = null;
                      } else {
                        selected = row.id;
                      }
                    });
                  },
                  onLongPress: () {
                    Modals().action(
                      onDelete: () {
                        Modals().confirmation(
                          onTap: () async {
                            var res =
                                await FinanceRepository.deleteExpense(row.id!);
                            if (res) {
                              init();
                            }
                          },
                        );
                      },
                      onEdit: () {
                        nextScreen(FormExpensePage(expense: row));
                      },
                    );
                  },
                  expanded: selected == row.id,
                  children: [
                    HorizontalText(
                      titleStyle: GoogleFonts.inter(
                        fontSize: 12,
                      ),
                      title: DateFormatter.dateTime(row.createdAt),
                    ),
                    verticalSpace(10),
                    HorizontalText(
                      title: row.description,
                    ),
                    if (row.urls.isNotEmpty)
                      HorizontalText(
                        title: "",
                        trailing: "Lihat kwitansi",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (e) {
                              return PageView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (var row in row.urls) Image.network(row),
                                ],
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
                bottom: 15,
              ),
              child: FloatingActionButton(
                heroTag: "expense",
                onPressed: () {
                  nextScreen(const FormExpensePage());
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
