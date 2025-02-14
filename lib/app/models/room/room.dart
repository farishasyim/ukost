import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/app/models/pivot/pivot.dart';
import 'package:ukost/app/models/transaction/transaction.dart';
import 'package:ukost/config/json_list.dart';

class Room {
  int? id, categoryId;
  String? name;
  PivotRoom? pivot;
  Category? category;
  List<Transaction> transactions;

  Room({
    this.transactions = const [],
    this.id,
    this.pivot,
    this.categoryId,
    this.category,
    this.name,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        name: json["name"],
        transactions: JsonList<Transaction>(
          json,
          (e) => Transaction.fromJson(e),
          key: "transactions",
        ).data,
        category: json["category"] != null
            ? Category.fromJson(json["category"])
            : null,
        categoryId: json["category_id"],
        pivot: json["pivot"] != null ? PivotRoom.fromJson(json["pivot"]) : null,
      );
}
