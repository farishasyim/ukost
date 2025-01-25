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
}
