// To parse this JSON data, do
//
//     final favoritesResponse = favoritesResponseFromJson(jsonString);

import 'dart:convert';

FavoritesResponse favoritesResponseFromJson(String str) => FavoritesResponse.fromJson(json.decode(str));

String favoritesResponseToJson(FavoritesResponse data) => json.encode(data.toJson());

class FavoritesResponse {
  final List<FavoritesDatum>? data;

  FavoritesResponse({
    this.data,
  });

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) => FavoritesResponse(
    data: json["data"] == null ? [] : List<FavoritesDatum>.from(json["data"]!.map((x) => FavoritesDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FavoritesDatum {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final List<String>? images;
  final double? availableQuantity;

  FavoritesDatum({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.images,
    this.availableQuantity,
  });

  factory FavoritesDatum.fromJson(Map<String, dynamic> json) => FavoritesDatum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    image: json["image"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    availableQuantity: json["available_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "image": image,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "available_quantity": availableQuantity,
  };
}
