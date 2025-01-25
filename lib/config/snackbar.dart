import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/navigation_services.dart';

class Snackbar {
  static message(String? title, [BuildContext? context]) =>
      ScaffoldMessenger.of(context ?? navigatorKey.currentContext!)
          .showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(title ?? ""),
        ),
      );

  static error(String? title, [BuildContext? context]) =>
      ScaffoldMessenger.of(context ?? navigatorKey.currentContext!)
          .showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(title ?? ""),
          backgroundColor: ColorAsset.red,
        ),
      );
}
