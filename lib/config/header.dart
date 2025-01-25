import 'package:dio/dio.dart';
import 'package:ukost/config/constant.dart';

class Header {
  static final Map<String, dynamic> _head = {
    'Accept': 'application/json',
  };
  static Options init({
    bool isMultipart = false,
  }) {
    if (isMultipart) {
      _head["Content-Type"] = "multipart/form-data";
    }
    if (storage.token != null) {
      _head["Authorization"] = "Bearer ${storage.token}";
    }
    return Options(
      headers: _head,
    );
  }
}
