import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/ui_features/components/loading/loading_widget.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onTap,
    this.label,
    this.radius,
    this.width,
    this.height,
    this.fontSize,
    this.textStyle,
    this.loading = false,
    this.icon,
    this.color,
    this.elevation,
    this.textColor,
    this.borderSide = BorderSide.none,
    this.overlayColor,
    this.trailingIcon,
  });
  final Function()? onTap;
  final String? label;
  final bool loading;
  final TextStyle? textStyle;
  final Widget? icon;
  final double? radius, width, height, fontSize, elevation;
  final Color? color, textColor;
  final BorderSide borderSide;
  final Color? overlayColor;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? screenWidth(context) * ((width ?? 100) / 100),
      height: height ?? 40,
      child: ElevatedButton(
        onPressed: !loading ? onTap : null,
        style: ElevatedButton.styleFrom(
          overlayColor: overlayColor ?? ColorAsset.violet,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 0),
            side: borderSide,
          ),
          backgroundColor: color ?? ColorAsset.white,
        ),
        child: loading
            ? SizedBox(
                width: width == null ? null : width! * 0.9,
                child: const LoadingWidget(),
              )
            : Row(
                mainAxisAlignment: icon == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                children: [
                  icon != null ? icon! : const Center(),
                  Expanded(
                    child: Center(
                      child: Text(
                        label ?? "",
                        style: textStyle ??
                            GoogleFonts.inter(
                              color: textColor ?? ColorAsset.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2,
                            ),
                      ),
                    ),
                  ),
                  trailingIcon != null ? trailingIcon! : const Center(),
                ],
              ),
      ),
    );
  }
}
