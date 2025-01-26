import 'package:dio/dio.dart';
import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/header.dart';
import 'package:ukost/config/json_list.dart';
import 'package:ukost/config/log.dart';
import 'package:ukost/config/routes.dart';

class CategoryRepository {
  static Future<List<Category>> getCategory() async {
    try {
      var res = await dio.get(
        Routes.roomManagement,
        options: Header.init(),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        return JsonList<Category>(res.data, (e) => Category.fromJson(e)).data;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return [];
  }

  static Future<bool> storeCategory(Map<String, dynamic> request) async {
    try {
      var res = await dio.post(
        Routes.storeCategory,
        data: FormData.fromMap(request),
        options: Header.init(isMultipart: true),
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
