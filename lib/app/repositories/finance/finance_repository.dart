import 'package:dio/dio.dart';
import 'package:ukost/app/models/expense/expense.dart';
import 'package:ukost/app/models/transaction/transaction.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/header.dart';
import 'package:ukost/config/json_list.dart';
import 'package:ukost/config/log.dart';
import 'package:ukost/config/routes.dart';

class FinanceRepository {
  static Future<List<Transaction>> getIncome(
      [TransactionStatus? status]) async {
    Map<String, dynamic> request = {};
    if (status != null) {
      request["status"] = status.name;
    }
    try {
      var res = await dio.get(
        Routes.transaction,
        queryParameters: request,
        options: Header.init(),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        return JsonList<Transaction>(res.data, (e) => Transaction.fromJson(e))
            .data;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return [];
  }

  static Future<List<Transaction>> getReportTransaction(
      Map<String, dynamic> request) async {
    try {
      var res = await dio.get(
        Routes.reportTransaction,
        data: request,
        options: Header.init(),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        return JsonList<Transaction>(res.data, (e) => Transaction.fromJson(e))
            .data;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return [];
  }

  static Future<List<Expense>> getReportExpense(
      Map<String, dynamic> request) async {
    try {
      var res = await dio.get(
        Routes.reportExpense,
        data: request,
        options: Header.init(),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        return JsonList<Expense>(res.data, (e) => Expense.fromJson(e)).data;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return [];
  }

  static Future<List<Expense>> getExpense([DateTime? date]) async {
    try {
      var res = await dio.get(
        Routes.expense,
        queryParameters: {
          "date": date != null ? DateFormatter.date(date, "yyyy-MM-dd") : null,
        },
        options: Header.init(),
      );
      if (res.statusCode == 200) {
        Log.message(res);
        return JsonList<Expense>(res.data, (e) => Expense.fromJson(e)).data;
      }
    } on DioException catch (e) {
      Log.error(e);
    }
    return [];
  }

  static Future<bool> storeIncome(Map<String, dynamic> request) async {
    try {
      var res = await dio.post(
        Routes.storeTransaction,
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

  static Future<bool> sentInvoice(int id) async {
    try {
      var res = await dio.get(
        "${Routes.sentInvoice}/$id",
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

  static Future<bool> storeExpense(Map<String, dynamic> request) async {
    try {
      var res = await dio.post(
        Routes.storeExpense,
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

  static Future<bool> updateIncome(int id, Map<String, dynamic> request) async {
    try {
      var res = await dio.post(
        "${Routes.transaction}/$id",
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

  static Future<bool> updateExpense(
      int id, Map<String, dynamic> request) async {
    try {
      var res = await dio.post(
        "${Routes.expense}/$id",
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

  static Future<bool> deleteIncome(int id) async {
    try {
      var res = await dio.delete(
        "${Routes.transaction}/$id",
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

  static Future<bool> deleteExpense(int id) async {
    try {
      var res = await dio.delete(
        "${Routes.expense}/$id",
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
