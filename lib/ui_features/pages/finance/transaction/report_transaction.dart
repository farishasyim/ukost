import 'package:flutter/material.dart';
import 'package:ukost/app/models/transaction/transaction.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/number_extension.dart';
import 'package:ukost/config/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportTransactionPage extends StatelessWidget {
  const ReportTransactionPage({
    super.key,
    this.transactions = const [],
    this.request = const {},
  });
  final Map<String, dynamic> request;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laporan Pembayaran"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String baseUrl = "${Routes.endpoint}/income-report";

          if (request.containsKey("customer_id")) {
            baseUrl += "?customer_id=${request["customer_id"]}&";
          }

          String status = "";

          if (request.containsKey("status")) {
            if (request["status"] is List) {
              status = (request["status"] as List).join(",");
            }
            baseUrl += "?status=$status";
          }

          print(baseUrl);

          launchUrl(Uri.parse(baseUrl));
        },
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
                      label: Text("Invoice"),
                    ),
                    DataColumn(
                      label: Text("Pengguna"),
                    ),
                    DataColumn(
                      label: Text("Kamar / Kategori"),
                    ),
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("Periode Tagihan"),
                    ),
                    DataColumn(
                      label: Text("Tanggal Bayar"),
                    ),
                    DataColumn(
                      label: Text("Harga"),
                    ),
                  ],
                  rows: [
                    for (var row in transactions)
                      DataRow(
                        cells: [
                          DataCell(
                            Text(row.invoice ?? "-"),
                          ),
                          DataCell(
                            Text(row.pivotRoom?.user?.name ?? "-"),
                          ),
                          DataCell(
                            Text(
                                "${row.pivotRoom?.room?.name ?? "-"} / ${row.pivotRoom?.room?.category?.name ?? "-"}"),
                          ),
                          DataCell(
                            Text(row.status ?? ""),
                          ),
                          DataCell(
                            Text(
                                "${DateFormatter.date(row.startPeriod, "dd MMM yy")} - ${DateFormatter.date(row.endPeriod, "dd MMM yy")}"),
                          ),
                          DataCell(
                            Text(row.date == null
                                ? "-"
                                : DateFormatter.dateTime(row.date)),
                          ),
                          DataCell(
                            Text((row.price ?? 0).toCurrency()),
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
