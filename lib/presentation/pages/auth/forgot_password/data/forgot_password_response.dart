// To parse this JSON data, do
//
//     final forgotPassResponse = forgotPassResponseFromJson(jsonString);

import 'dart:convert';

ForgotPassResponse forgotPassResponseFromJson(String str) => ForgotPassResponse.fromJson(json.decode(str));

String forgotPassResponseToJson(ForgotPassResponse data) => json.encode(data.toJson());

class ForgotPassResponse {
  final String? email;

  ForgotPassResponse({
    this.email,
  });

  factory ForgotPassResponse.fromJson(Map<String, dynamic> json) => ForgotPassResponse(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
