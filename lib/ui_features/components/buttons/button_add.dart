import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({
    super.key,
    this.onTap,
    this.padding,
  });
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(right: 20),
      child: Material(
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Ink(
            width: 50,
            decoration: BoxDecoration(
              color: ColorAsset.violet,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
