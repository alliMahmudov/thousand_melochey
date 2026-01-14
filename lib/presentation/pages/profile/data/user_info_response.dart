// To parse this JSON data, do
//
//     final userInfoResponse = userInfoResponseFromJson(jsonString);

import 'dart:convert';

UserInfoResponse userInfoResponseFromJson(String str) => UserInfoResponse.fromJson(json.decode(str));

String userInfoResponseToJson(UserInfoResponse data) => json.encode(data.toJson());

class UserInfoResponse {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? language;

  UserInfoResponse({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.language,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) => UserInfoResponse(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "language": language,
  };
}
