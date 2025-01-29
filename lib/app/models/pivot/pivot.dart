import 'package:ukost/app/models/room/room.dart';
import 'package:ukost/app/models/user/user.dart';

class PivotRoom {
  int? id, customerId, roomId;
  DateTime? leftAt, createdAt;
  User? user;
  Room? room;

  PivotRoom({
    this.room,
    this.createdAt,
    this.customerId,
    this.id,
    this.leftAt,
    this.roomId,
    this.user,
  });

  factory PivotRoom.fromJson(Map<String, dynamic> json) => PivotRoom(
        id: json["id"],
        room: json["room"] != null ? Room.fromJson(json["room"]) : null,
        customerId: json["customer_id"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        roomId: json["room_id"],
        leftAt:
            json["left_at"] != null ? DateTime.parse(json["left_at"]) : null,
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "customer_id": customerId,
      "left_at": leftAt,
      "room_id": roomId,
      "user": user?.toMap(),
    };
  }
}
