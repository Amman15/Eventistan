// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String? phone;
  final String? teamName;
  final int? teamSize;
  final String? id;
  final String? email;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? profilePicture;
  final int? age;
  final String? bio;
  final String? name;
  final String? city;
  final String? fcmToken;

  User({
    this.phone,
    this.teamName,
    this.teamSize,
    this.id,
    this.email,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.profilePicture,
    this.age,
    this.bio,
    this.name,
    this.city,
    this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        phone: json["phone"],
        teamName: json["teamName"],
        teamSize: json["teamSize"],
        id: json["_id"],
        email: json["email"],
        role: json["role"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        profilePicture: json["profilePicture"],
        age: json["age"],
        bio: json["bio"],
        name: json["name"],
        city: json["city"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "teamName": teamName,
        "teamSize": teamSize,
        "_id": id,
        "email": email,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "profilePicture": profilePicture,
        "age": age,
        "bio": bio,
        "name": name,
        "city": city,
        "fcmToken": fcmToken,
      };
}
