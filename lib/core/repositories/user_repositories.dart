import 'package:dio/dio.dart';
import 'package:ukost/core/utils/constant.dart';
import 'package:ukost/core/utils/routes.dart';

class UserRepositories {
  static Future<List> getUser() async {
    var res = await dio.get(Routes.userManagement);
    if (res.statusCode == 200) {
      return res.data['data'];
    }
    return [];
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      var res = await dio.post(
        Routes.login,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (res.statusCode == 200) {
        return {
          'token': res.data['token'],
          'message': 'Login successful',
        };
      } else {
        return {
          'message': 'Login failed. Please check your email and password.',
        };
      }
    } catch (e) {
      print('Error: $e');
      return {'message': 'Username atau Password anda salah.'};
    }
  }
}
