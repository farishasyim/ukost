import 'package:intl/intl.dart';

class DateFormatter {
  static int timeToNameFormat(int hour) {
    int status = 0;
    if (hour > 2 && hour < 11) {
      status = 0;
    } else if (hour > 10 && hour < 15) {
      status = 1;
    } else if (hour > 14 && hour < 19) {
      status = 2;
    } else {
      status = 3;
    }

    return status;
  }

  static String time(DateTime? time, [String? format]) =>
      DateFormat(format ?? "HH:mm a", "id_ID").format(time ?? DateTime.now());

  static String date(DateTime? date, [String? format]) =>
      DateFormat(format ?? "dd-MM-yyyy", "id_ID")
          .format(date ?? DateTime.now());

  static String dateTime(DateTime? date, [String? format]) =>
      DateFormat(format ?? "dd-MM-yyyy HH:mm a", "id_ID")
          .format(date ?? DateTime.now());
}
