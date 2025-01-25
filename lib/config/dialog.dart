import 'package:flutter/material.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/loading/loading_widget.dart';

class Modals {
  BuildContext? context;
  Modals([context]);
  void loading() {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 70,
          width: screenWidth(context) * 0.05,
          child: const LoadingWidget(),
        ),
      ),
    );
  }
}
