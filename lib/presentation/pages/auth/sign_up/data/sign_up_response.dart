// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  final String? message;
  final String? email;

  SignUpResponse({
    this.message,
    this.email,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    message: json["message"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "email": email,
  };
}
