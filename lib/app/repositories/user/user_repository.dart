import 'package:dio/dio.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/header.dart';
import 'package:ukost/config/json_list.dart';
import 'package:ukost/config/log.dart';
import 'package:ukost/config/routes.dart';

class UserRepository {
  static Future<List<User>> getUser({
    UserStatus userStatus = UserStatus.all,
  }) async {
    try {
      var res = await dio.get(
        Routes.userManagement,
        queryParameters: {
          "type": userStatus.name,
        },
        options: Header.init(),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        return JsonList<User>(res.data, (e) => User.fromJson(e)).data;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return [];
  }
}
