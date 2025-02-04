import 'package:dio/dio.dart';
import 'package:ukost/app/models/room/room.dart';
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
      if (res.statusCode == 200 || res.statusCode == 201) {
        Log.message(res);
        return true;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return false;
  }

  static Future<bool> updateRoom(int? id, Map<String, dynamic> request) async {
    try {
      var res = await dio.post(
        "${Routes.roomManagement}/$id",
        data: request,
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

  static Future<bool> deleteRoom(int? id) async {
    try {
      var res = await dio.delete(
        "${Routes.roomManagement}/$id",
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

  static Future<bool> pivotRoom(Map<String, dynamic> request) async {
    try {
      var res = await dio.post(
        Routes.pivotRoom,
        data: request,
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

  static Future<Room?> show(int id) async {
    try {
      var res = await dio.get(
        "${Routes.roomManagement}/$id",
        options: Header.init(),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        Log.message(res);
        return Room.fromJson(res.data['data']);
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return null;
  }
}
