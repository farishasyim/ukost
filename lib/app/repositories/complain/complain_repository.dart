import 'package:dio/dio.dart';
import 'package:ukost/app/models/complain/complain.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/header.dart';
import 'package:ukost/config/json_list.dart';
import 'package:ukost/config/log.dart';
import 'package:ukost/config/routes.dart';

class ComplainRepository {
  static Future<List<Complain>> getComplains() async {
    try {
      var res = await dio.get(
        Routes.complain,
        options: Header.init(),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        Log.message(res);
        return JsonList<Complain>(res.data, (e) => Complain.fromJson(e)).data;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return [];
  }

  static Future<bool> storeComplain(Map<String, dynamic> request) async {
    try {
      var res = await dio.post(
        "${Routes.complain}/store",
        data: FormData.fromMap(request),
        options: Header.init(isMultipart: true),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        Log.message(res);
        return true;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return false;
  }

  static Future<bool> updateComplain(
    int id,
    Map<String, dynamic> request,
  ) async {
    try {
      var res = await dio.post(
        "${Routes.complain}/$id",
        data: FormData.fromMap(request),
        options: Header.init(isMultipart: true),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        Log.message(res);
        return true;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return false;
  }

  static Future<bool> deleteComplain(int id) async {
    try {
      var res = await dio.delete(
        "${Routes.complain}/$id",
        options: Header.init(),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        Log.message(res);
        return true;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return false;
  }
}
