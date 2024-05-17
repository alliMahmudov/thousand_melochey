// To parse this JSON data, do
//
//     final addToFavoritesResponse = addToFavoritesResponseFromJson(jsonString);

import 'dart:convert';

AddToFavoritesResponse addToFavoritesResponseFromJson(String str) => AddToFavoritesResponse.fromJson(json.decode(str));

String addToFavoritesResponseToJson(AddToFavoritesResponse data) => json.encode(data.toJson());

class AddToFavoritesResponse {
  final String? message;

  AddToFavoritesResponse({
    this.message,
  });

  factory AddToFavoritesResponse.fromJson(Map<String, dynamic> json) => AddToFavoritesResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
