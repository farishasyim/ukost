import 'dart:convert';

import 'package:ukost/config/constant.dart';

class User {
  int? id, identityNumber;
  String? name, email, identityCard, profilePicture, gender, phone;
  DateTime? dateOfBirth;
  Role? role;

  User({
    this.id,
    this.role,
    this.dateOfBirth,
    this.email,
    this.gender,
    this.identityCard,
    this.identityNumber,
    this.name,
    this.phone,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
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
        "email": email,
        "phone": phone,
        "role": role?.name,
        "profile_picture": profilePicture,
        "identity_card": identityCard,
        "identity_number": identityNumber,
        "date_of_birth": dateOfBirth?.toIso8601String(),
      };

  String toJson() => jsonEncode(toMap());
}
