class Room {
  int? id, categoryId;
  String? name;

  Room({
    this.id,
    this.categoryId,
    this.name,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
      );
}
