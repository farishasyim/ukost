import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';

class TextFieldPrimary extends StatelessWidget {
  const TextFieldPrimary({
    super.key,
    this.label,
    required this.hintText,
    this.expands,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onEditingComplete,
    this.isRaw = false,
    this.onChanged,
    this.errorText,
    this.helperText,
    this.suffix,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.color,
    this.focusColor,
    this.unFocusColor,
    this.maxLines = 1,
    this.prefixIcon,
    this.isCurrency = false,
    this.style,
    this.cursorColor,
    this.onSend,
    this.obs = false,
    this.focusNode,
  });

  final String? label;
  final TextEditingController? controller;
  final String hintText;
  final bool? expands;
  final bool readOnly, isRaw, obs;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function()? onTap, onSend, onEditingComplete;
  final Function(String?)? onChanged;
  final String? errorText;
  final Widget? suffixIcon, suffix;
  final Color? color, focusColor, unFocusColor;
  final String? helperText;
  final Widget? prefixIcon;
  final bool isCurrency;
  final TextStyle? style;
  final Color? cursorColor;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isRaw)
            Text(
              label ?? "",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          if (!isRaw) verticalSpace(8),
          SizedBox(
            height: expands ?? false ? 150 : null,
            child: TextFormField(
              onFieldSubmitted: (e) {
                if (onSend != null) {
                  onSend!();
                }
              },
              focusNode: focusNode,
              readOnly: readOnly,
              controller: controller,
              onTap: onTap,
              keyboardType: keyboardType,
              expands: expands ?? false,
              obscureText: obs,
              maxLines: maxLines,
              minLines: null,
              textInputAction: expands ?? false
                  ? TextInputAction.newline
                  : TextInputAction.done,
              textAlignVertical: TextAlignVertical.top,
              style: style ??
                  GoogleFonts.inter(
                    fontSize: 14,
                    color: focusColor ?? Colors.black,
                  ),
              validator: (e) {
                if (e != null && e.isEmpty) {
                  return "Kolom ${(label ?? '-').toLowerCase()} harus di isi";
                }
                if (validator != null) {
                  return validator!(e);
                }
                return null;
              },
              cursorColor: cursorColor ?? ColorAsset.violet,
              inputFormatters: [
                if (isCurrency)
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) {
                if (onChanged != null) onChanged!(value);
                if (isCurrency && value.isNotEmpty) {
                  value = value.replaceAll(".", "").replaceAll("Rp", "");
                  if (value.isNotEmpty) {
                    // final amt = double.parse(value);
                    // controller?.text = amt.toRawCurrency();
                  }
                }
              },
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                suffix: suffix,
                prefixIcon: prefixIcon,
                fillColor: color ?? Colors.transparent,
                filled: color != null,
                isDense: true,
                hintText: hintText,
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.5),
                ),
                errorStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.red,
                ),
                errorText: errorText,
                helperStyle: GoogleFonts.inter(
                  fontSize: 14,
                ),
                helperText: helperText,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: focusColor ?? ColorAsset.violet,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: unFocusColor ?? Colors.black.withOpacity(0.2),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: unFocusColor ?? Colors.black.withOpacity(0.2),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          verticalSpace(10),
        ],
      ),
    );
  }
}
