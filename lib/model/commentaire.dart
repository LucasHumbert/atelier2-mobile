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
  });

  String userId;
  String content;
  String date;

  Commentaire.fromJson(Map<String, dynamic> json) :
    userId = json["user_id"],
    content = json["content"],
    date = json["date"];

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "content": content,
    "date": date,
  };
}
