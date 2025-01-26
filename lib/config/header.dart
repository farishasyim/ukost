import 'package:dio/dio.dart';
import 'package:ukost/config/constant.dart';

class Header {
  static Options init({
    bool isMultipart = false,
  }) {
    Map<String, dynamic> head = {
      'Accept': 'application/json',
    };
    if (isMultipart) {
      head["Content-Type"] = "multipart/form-data";
    }
    if (storage.token != null) {
      head["Authorization"] = "Bearer ${storage.token}";
    }
    return Options(
      headers: head,
    );
  }
}
