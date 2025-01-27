class Routes {
  static const String development = "http://192.168.100.14:8000";
  static const String production = "https://ukost.farishasyim.my.id";

  static const String endpoint = development;

  static const String api = "$development/api";

  // --------- Routes -----------

  // ------------ AUTH -------------
  static const String login = "$api/login";
  static const String logout = "$api/logout";

  // -------------- ROOM MANAGEMENT -----------------
  static const String roomManagement = "$api/room-management";
  static const String storeRoom = "$roomManagement/store";
  static const String pivotRoom = "$roomManagement/pivot-store";
  static const String category = "$roomManagement/category";
  static const String storeCategory = "$category/store";

  // -------------- USER MANAGEMENT ------------------
  static const String userManagement = "$api/user-management";
}
