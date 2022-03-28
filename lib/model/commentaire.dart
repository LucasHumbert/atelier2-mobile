// To parse this JSON data, do
//
//     final commentaire = commentaireFromJson(jsonString);

import 'dart:convert';

Commentaire commentaireFromJson(String str) => Commentaire.fromJson(json.decode(str));

String commentaireToJson(Commentaire data) => json.encode(data.toJson());

class Commentaire {
  Commentaire({
    required this.userId,
    required this.content,
    required this.date,
    required this.userfirstname,
    required this.userlastname
  });

  String userId;
  String content;
  String date;
  String userfirstname;
  String userlastname;

  Commentaire.fromJson(Map<String, dynamic> json) :
    userId = json["user_id"],
    content = json["content"],
    date = json["date"],
    userfirstname = json['user_firstname'],
    userlastname = json['user_lastname'];


  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "content": content,
    "date": date,
    "user_firstame": userfirstname,
    "user_lastname": userlastname
  };
}
