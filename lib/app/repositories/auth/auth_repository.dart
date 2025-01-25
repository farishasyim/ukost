import 'package:dio/dio.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/header.dart';
import 'package:ukost/config/log.dart';
import 'package:ukost/config/routes.dart';

class AuthRepository {
  static Future<bool> login(String email, String password) async {
    try {
      var res = await dio.post(
        Routes.login,
        data: {
          'email': email,
          'password': password,
        },
        options: Header.init(),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        storage.copyWith(
          account: User.fromJson(res.data["data"]),
          token: res.data["token"],
        );
        return true;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return false;
  }

  static Future<bool> logout() async {
    try {
      var res = await dio.post(
        Routes.logout,
        options: Header.init(),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        return true;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return false;
  }
}
