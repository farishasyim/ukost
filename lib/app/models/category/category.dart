import 'package:ukost/app/models/room/room.dart';
import 'package:ukost/config/json_list.dart';

class Category {
  int? id, price;
  String? name, description, photo;
  List<Room> rooms;

  Category({
    this.rooms = const [],
    this.id,
    this.price,
    this.name,
    this.description,
    this.photo,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        photo: json["photo"],
        rooms: JsonList<Room>(json, (e) => Room.fromJson(e), key: "rooms").data,
      );
}
