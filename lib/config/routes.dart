class Routes {
  static const String development = "https://ukost.farishasyim.my.id";

  static const String endpoint = development;

  static const String api = "$development/api";

  // --------- Routes -----------

  // ------------ AUTH -------------
  static const String login = "$api/login";
  static const String logout = "$api/logout";

  // -------------- ROOM MANAGEMENT -----------------
  static const String roomManagement = "$api/room-management";
}
