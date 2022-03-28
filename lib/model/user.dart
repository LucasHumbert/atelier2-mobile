// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.choice,
  });

  String userId;
  String firstname;
  String lastname;
  int choice;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    choice: json["choice"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "firstname": firstname,
    "lastname": lastname,
    "choice": choice,
  };
}
