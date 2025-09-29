// To parse this JSON data, do
//
//     final successResponse = successResponseFromJson(jsonString);

import 'dart:convert';

AddToCartResponse successResponseFromJson(String str) => AddToCartResponse.fromJson(json.decode(str));

String successResponseToJson(AddToCartResponse data) => json.encode(data.toJson());

class AddToCartResponse {
  final String? message;

  AddToCartResponse({
    this.message,
  });

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) => AddToCartResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
