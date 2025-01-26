import 'package:dio/dio.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/header.dart';
import 'package:ukost/config/log.dart';
import 'package:ukost/config/routes.dart';

class RoomRepository {
  static Future<bool> storeRoom(Map<String, dynamic> request) async {
    try {
      var res = await dio.post(
        Routes.storeRoom,
        data: request,
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
