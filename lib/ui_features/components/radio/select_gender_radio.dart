import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/export.dart';

class SelectGenderRadio extends StatelessWidget {
  const SelectGenderRadio({super.key, this.value, this.onChanged});
  final Function(String e)? onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jenis kelamin",
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
                title: Text(
                  "Laki-laki",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: ColorAsset.black.withOpacity(0.6),
                  ),
                ),
                value: "laki-laki",
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
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: ColorAsset.black.withOpacity(0.3),
                  ),
                ),
                title: Text(
                  "Perempuan",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: ColorAsset.black.withOpacity(0.6),
                  ),
                ),
                value: "perempuan",
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
