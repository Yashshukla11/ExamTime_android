// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  User? user;
  String? token;
  String? message;

  UserModel({
    this.user,
    this.token,
    this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
        "message": message,
      };
}

class User {
  String? username;
  String? email;
  String? password;
  String? userPhoto;
  List<dynamic>? notes;
  List<dynamic>? likedNotes;
  List<dynamic>? bookMarkedNotes;
  int? coins;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.username,
    this.email,
    this.password,
    this.userPhoto,
    this.notes,
    this.likedNotes,
    this.bookMarkedNotes,
    this.coins,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        userPhoto: json["userPhoto"],
        notes: json["notes"] == null
            ? []
            : List<dynamic>.from(json["notes"]!.map((x) => x)),
        likedNotes: json["likedNotes"] == null
            ? []
            : List<dynamic>.from(json["likedNotes"]!.map((x) => x)),
        bookMarkedNotes: json["bookMarkedNotes"] == null
            ? []
            : List<dynamic>.from(json["bookMarkedNotes"]!.map((x) => x)),
        coins: json["coins"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "userPhoto": userPhoto,
        "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x)),
        "likedNotes": likedNotes == null
            ? []
            : List<dynamic>.from(likedNotes!.map((x) => x)),
        "bookMarkedNotes": bookMarkedNotes == null
            ? []
            : List<dynamic>.from(bookMarkedNotes!.map((x) => x)),
        "coins": coins,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
