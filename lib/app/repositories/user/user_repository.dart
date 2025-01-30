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

  static Future<User?> store(Map<String, dynamic> formData) async {
    try {
      var res = await dio.post(
        Routes.userManagementStore,
        data: FormData.fromMap(formData),
        options: Header.init(isMultipart: true),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        return User.fromJson(res.data["data"]);
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return null;
  }

  static Future<User?> update(
    int? id,
    Map<String, dynamic> request,
  ) async {
    try {
      var res = await dio.post(
        "${Routes.userManagement}/$id",
        data: FormData.fromMap(request),
        options: Header.init(isMultipart: true),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        return User.fromJson(res.data["data"]);
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return null;
  }

  static Future<bool> delete(int id) async {
    try {
      var res = await dio.delete(
        "${Routes.userManagement}/$id",
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
