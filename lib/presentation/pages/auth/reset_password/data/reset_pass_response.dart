// To parse this JSON data, do
//
//     final resetPassResponse = resetPassResponseFromJson(jsonString);

import 'dart:convert';

ResetPassResponse resetPassResponseFromJson(String str) => ResetPassResponse.fromJson(json.decode(str));

String resetPassResponseToJson(ResetPassResponse data) => json.encode(data.toJson());

class ResetPassResponse {
  final String? message;

  ResetPassResponse({
    this.message,
  });

  factory ResetPassResponse.fromJson(Map<String, dynamic> json) => ResetPassResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
