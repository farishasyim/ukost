import 'package:flutter/material.dart';
import 'package:ukost/config/navigation_services.dart';

class DatePicker {
  static Future<DateTime?> getDatePicker(
    String? initDate, {
    int lastDate = 2010,
  }) async {
    return showDatePicker(
      context: navigatorKey.currentContext!,
      initialDate: initDate != null
          ? DateTime.parse(
              initDate,
            )
          : DateTime.now(),
      firstDate: DateTime(lastDate),
      lastDate: DateTime(
        DateTime.now().year + 10,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );
  }

  static Future<TimeOfDay?> getTimePicker() async {
    return showTimePicker(
      context: navigatorKey.currentContext!,
      initialTime: TimeOfDay.now(),
    );
  }
}
