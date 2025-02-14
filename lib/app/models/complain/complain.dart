import 'package:ukost/app/models/user/user.dart';

class Complain {
  int? id, customerId, adminId;
  String? title, description;
  DateTime? createdAt;
  List<String> urls, photos;
  User? customer, admin;

  Complain({
    this.customer,
    this.admin,
    this.photos = const [],
    this.id,
    this.createdAt,
    this.description,
    this.title,
    this.urls = const [],
    this.customerId,
    this.adminId,
  });

  factory Complain.fromJson(Map<String, dynamic> json) => Complain(
        id: json["id"],
        customer:
            json["customer"] != null ? User.fromJson(json["customer"]) : null,
        admin: json["admin"] != null ? User.fromJson(json["admin"]) : null,
        customerId: json["customer_id"],
        adminId: json["admin_id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        urls: List<String>.from(json["urls"].map((e) => e.toString())),
        photos: List<String>.from(json["photos"].map((e) => e.toString())),
      );
}
