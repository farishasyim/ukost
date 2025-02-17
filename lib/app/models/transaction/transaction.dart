import 'package:ukost/app/models/pivot/pivot.dart';

class Transaction {
  int? id, pivotRoomId, adminId, price;
  String? invoice, status, proofPayment, url;
  PivotRoom? pivotRoom;
  DateTime? date, createdAt, startPeriod, endPeriod, dueDate;

  Transaction({
    this.date,
    this.adminId,
    this.id,
    this.startPeriod,
    this.dueDate,
    this.endPeriod,
    this.invoice,
    this.pivotRoom,
    this.createdAt,
    this.pivotRoomId,
    this.url,
    this.price,
    this.proofPayment,
    this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        url: json["url"],
        dueDate:
            json["due_date"] != null ? DateTime.parse(json["due_date"]) : null,
        pivotRoom: json["pivot_room"] != null
            ? PivotRoom.fromJson(json["pivot_room"])
            : null,
        adminId: json["admin_id"],
        pivotRoomId: json["pivot_room_id"],
        price: json["price"],
        invoice: json["invoice"],
        proofPayment: json["proof_payment"],
        status: json["status"],
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        startPeriod: json["start_period"] != null
            ? DateTime.parse(json["start_period"])
            : null,
        endPeriod: json["end_period"] != null
            ? DateTime.parse(json["end_period"])
            : null,
      );
}
