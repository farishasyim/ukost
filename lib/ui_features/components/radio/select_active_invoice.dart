import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/export.dart';

class SelectActiveInvoiceRadio extends StatelessWidget {
  const SelectActiveInvoiceRadio({super.key, this.value, this.onChanged});
  final Function(String e)? onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Status Invoice",
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        verticalSpace(8),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: ColorAsset.black.withOpacity(0.3),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Belum Lunas",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: ColorAsset.black.withOpacity(0.6),
                  ),
                ),
                value: "unpaid",
                groupValue: value,
                onChanged: (e) {
                  if (onChanged != null) {
                    onChanged!(e!);
                  }
                },
              ),
            ),
            horizontalSpace(10),
            Expanded(
              child: RadioListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: ColorAsset.black.withOpacity(0.3),
                  ),
                ),
                title: Text(
                  "Lunas",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: ColorAsset.black.withOpacity(0.6),
                  ),
                ),
                value: "paid",
                groupValue: value,
                onChanged: (e) {
                  if (onChanged != null) {
                    onChanged!(e!);
                  }
                },
              ),
            ),
          ],
        ),
        verticalSpace(10),
      ],
    );
  }
}
