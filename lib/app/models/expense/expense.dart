import 'package:ukost/app/models/user/user.dart';

class Expense {
  int? id, userId;
  String? title, description;
  DateTime? createdAt;
  int price;
  List<String> urls, photos;
  User? user;

  Expense({
    this.user,
    this.photos = const [],
    this.id,
    this.price = 0,
    this.createdAt,
    this.description,
    this.title,
    this.urls = const [],
    this.userId,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json["id"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        price: json["price"] ?? 0,
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        urls: List<String>.from(json["urls"].map((e) => e.toString())),
        photos: List<String>.from(json["photos"].map((e) => e.toString())),
      );
}
