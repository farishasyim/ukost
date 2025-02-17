import 'package:flutter/material.dart';
import 'package:ukost/app/models/expense/expense.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/number_extension.dart';

class ReportExpensePage extends StatelessWidget {
  const ReportExpensePage({
    super.key,
    required this.period,
    this.expenses = const [],
  });
  final List<Expense> expenses;
  final String period;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengeluaran $period"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        heroTag: "print-pengeluaran",
        child: const Icon(Icons.print_rounded),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: screenHeight(context) * 0.8,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                DataTable(
                  columns: const [
                    DataColumn(
                      label: Text("Tanggal"),
                    ),
                    DataColumn(
                      label: Text("Nama Pengeluaran"),
                    ),
                    DataColumn(
                      label: Text("Deskripsi"),
                    ),
                    DataColumn(
                      label: Text("PIC"),
                    ),
                    DataColumn(
                      label: Text("Harga"),
                    ),
                  ],
                  rows: [
                    for (var row in expenses)
                      DataRow(
                        cells: [
                          DataCell(
                            Text(DateFormatter.dateTime(row.createdAt)),
                          ),
                          DataCell(
                            Text(row.title ?? "-"),
                          ),
                          DataCell(
                            Text(row.description ?? "-"),
                          ),
                          DataCell(
                            Text(row.user?.name ?? ""),
                          ),
                          DataCell(
                            Text(row.price.toCurrency()),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
