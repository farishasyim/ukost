import 'package:dio/dio.dart';
import 'package:ukost/config/log.dart';

class UserRepository {
  Future login(String username, String password) async {
    try {
      // todo
    } on DioException catch (e) {
      Log.error(e);
    }
  }
}
