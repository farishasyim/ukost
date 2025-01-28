import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/session_manager.dart';
import 'package:ukost/config/snackbar.dart';

class Log {
  Log(dynamic value) {
    log("$value", name: appname);
  }

  static void message(Response response) {
    Log("${response.realUri} | ${response.statusCode} => ${response.data}");
    if (response.statusCode == 201) {
      Snackbar.message(response.data["message"]);
    }
  }

  static void error(DioException exception) {
    try {
      Log("${exception.response?.realUri ?? "-"} | ERROR MESSAGE (${exception.response?.statusCode}) => ${exception.response?.data ?? "TERJADI KESALAHAN"}");

      if (exception.response?.statusCode == 401) {
        SessionManager.clearSession();
      }

      if (exception.response != null) {
        var message = exception.response?.data["message"];
        if (message is String) {
          Snackbar.error(message);
        }
      }
    } catch (e) {
      Log("ERROR => ${exception.message}");
      Snackbar.error("Terjadi kesalahan");
    }
  }

  static String? errorMessage(DioException exception) {
    if (exception.response != null) {
      var data = exception.response?.data;
      if (data is Map) {
        if (data.containsKey("message")) {
          return data["message"];
        }
      }
    }
    return null;
  }
}
