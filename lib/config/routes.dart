class Routes {
  static const String development = "http://192.168.100.14:8000";
  static const String production = "https://ukost.farishasyim.my.id";

  static const String endpoint = development;

  static const String api = "$endpoint/api";

  // ---------- Routes -----------

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
  static const String userManagementStore = "$userManagement/store";
  static const String sentCredential = "$userManagement/sent-credential";

  // --------------- FINANCE ---------------
  static const String transaction = "$api/transaction";
  static const String recentTransaction = "$transaction/recent";
  static const String sentInvoice = "$transaction/sent-invoice";
  static const String reportTransaction = "$transaction/report";
  static const String storeTransaction = "$transaction/store";
  static const String expense = "$api/expense";
  static const String reportExpense = "$expense/report";
  static const String storeExpense = "$expense/store";

  static const String complain = "$api/complain";
}
