import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/pages/auth/login.dart';

class SessionManager {
  static late SharedPreferences _pref;

  static Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  static void getSession() async {
    var account = _pref.getString("account");
    var token = _pref.getString("token");

    if (account != null && token != null) {
      storage.copyWith(
        account: User.fromJson(jsonDecode(account)),
        token: token,
      );
    }
  }

  static Future<void> setSession(User user) async {
    await _pref.setString("account", user.toJson());
    await _pref.setString("token", storage.token!);
  }

  static void clearSession() async {
    await _pref.clear();
    storage.clear();
    nextRemoveUntil(const LoginPage());
  }
}
