import 'package:flutter/material.dart';
import 'package:ukost/app/models/expense/expense.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/number_extension.dart';
import 'package:ukost/config/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportExpensePage extends StatelessWidget {
  const ReportExpensePage({
    super.key,
    required this.period,
    this.expenses = const [],
    this.request = const {},
  });
  final Map<String, dynamic> request;
  final List<Expense> expenses;
  final String period;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengeluaran $period"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String baseUrl = "${Routes.endpoint}/expense-report";

          if (request.containsKey("start")) {
            DateTime start = DateTime.parse(request["start"]);
            baseUrl += "?start=${DateFormatter.date(start, "yyyy-MM-dd")}&";
          }

          if (request.containsKey("end")) {
            DateTime end = DateTime.parse(request["end"]);
            baseUrl += "end=${DateFormatter.date(end, "yyyy-MM-dd")}";
          }

          print(baseUrl);

          launchUrl(Uri.parse(baseUrl));
        },
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
