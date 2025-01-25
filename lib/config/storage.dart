import 'package:ukost/app/models/user/user.dart';

class Storage {
  User? account;
  String? token;

  void copyWith({User? account, String? token}) {
    this.account = account ?? this.account;
    this.token = token ?? this.token;
  }

  void clear() {
    account = null;
    token = null;
  }
}
