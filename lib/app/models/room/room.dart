import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/app/models/pivot/pivot.dart';

class Room {
  int? id, categoryId;
  String? name;
  PivotRoom? pivot;
  Category? category;

  Room({
    this.id,
    this.pivot,
    this.categoryId,
    this.category,
    this.name,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        name: json["name"],
        category: json["category"] != null
            ? Category.fromJson(json["category"])
            : null,
        categoryId: json["category_id"],
        pivot: json["pivot"] != null ? PivotRoom.fromJson(json["pivot"]) : null,
      );
}
