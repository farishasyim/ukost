import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/date_picker.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';

class DialogFilterExpense extends StatefulWidget {
  const DialogFilterExpense({super.key, required this.onTap});
  final Function(Map<String, dynamic>) onTap;

  @override
  State<DialogFilterExpense> createState() => _DialogFilterExpenseState();
}

class _DialogFilterExpenseState extends State<DialogFilterExpense> {
  DateTime? start, end;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFieldPrimary(
            controller: TextEditingController(
                text: start != null ? DateFormatter.date(start) : ""),
            isRaw: true,
            onTap: () async {
              var pick =
                  await DatePicker.getDatePicker(start?.toIso8601String());
              if (pick != null) {
                setState(() {
                  start = pick;
                });
              }
            },
            readOnly: true,
            hintText: "Masukan tanggal mulai",
            label: "Tanggal mulai",
          ),
          verticalSpace(15),
          TextFieldPrimary(
            controller: TextEditingController(
                text: end != null ? DateFormatter.date(end) : ""),
            isRaw: true,
            onTap: () async {
              var pick = await DatePicker.getDatePicker(end?.toIso8601String());
              if (pick != null) {
                setState(() {
                  end = pick;
                });
              }
            },
            readOnly: true,
            hintText: "Masukan tanggal berakhir",
            label: "Tanggal berakhir",
          ),
          if (start != null && end != null) ...[
            verticalSpace(10),
            PrimaryButton(
              radius: 8,
              label: "Cari",
              color: ColorAsset.violet,
              onTap: () {
                Map<String, dynamic> request = {
                  "start": start?.toIso8601String(),
                  "end": end?.toIso8601String(),
                };
                backScreen();
                widget.onTap(request);
              },
            ),
          ]
        ],
      ),
    );
  }
}
