// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

import 'dart:convert';

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  final String? message;
  final String? jwt;

  OtpResponse({
    this.message,
    this.jwt,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
    message: json["message"],
    jwt: json["jwt"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "jwt": jwt,
  };
}
