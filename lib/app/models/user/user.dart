import 'dart:convert';

import 'package:ukost/app/models/pivot/pivot.dart';
import 'package:ukost/config/constant.dart';

class User {
  int? id, identityNumber;
  String? name,
      email,
      identityCard,
      profilePicture,
      gender,
      phone,
      profileLink,
      identityCardLink;
  DateTime? dateOfBirth;
  Role? role;
  PivotRoom? pivot;
  bool isDefault;

  User({
    this.id,
    this.isDefault = false,
    this.role,
    this.identityCardLink,
    this.dateOfBirth,
    this.profileLink,
    this.email,
    this.gender,
    this.identityCard,
    this.identityNumber,
    this.name,
    this.pivot,
    this.phone,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        isDefault: json["is_default"],
        pivot: json["pivot"] != null ? PivotRoom.fromJson(json["pivot"]) : null,
        profileLink: json["profile_link"],
        identityCardLink: json["identity_card_link"],
        email: json["email"],
        gender: json["gender"],
        phone: json["phone"],
        role: json["role"] == "admin" ? Role.admin : Role.customer,
        profilePicture: json["profile_picture"],
        identityCard: json["identity_card"],
        identityNumber: json["identity_number"],
        dateOfBirth: json["date_of_birth"] != null
            ? DateTime.parse(json["date_of_birth"])
            : null,
      );

  factory User.set(User user) => user;

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "is_default": isDefault,
        "email": email,
        "pivot": pivot?.toMap(),
        "phone": phone,
        "identity_card_link": identityCardLink,
        "profile_link": profileLink,
        "gender": gender,
        "role": role?.name,
        "profile_picture": profilePicture,
        "identity_card": identityCard,
        "identity_number": identityNumber,
        "date_of_birth": dateOfBirth?.toIso8601String(),
      };

  String toJson() => jsonEncode(toMap());
}
