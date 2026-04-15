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
  final String? finalPriceUzs;
  final bool? isOnSale;
  final String? salePriceUzs;
  final String? discountPercent;
  final String? discountPriceValue;
  final String? image;
  final List<String>? images;
  final double? availableQuantity;


  FavoritesDatum({
    this.id,
    this.name,
    this.description,
    this.finalPriceUzs,
    this.isOnSale,
    this.salePriceUzs,
    this.discountPercent,
    this.discountPriceValue,
    this.image,
    this.images,
    this.availableQuantity,
  });

  factory FavoritesDatum.fromJson(Map<String, dynamic> json) => FavoritesDatum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    finalPriceUzs: json["final_price_uzs"],
    isOnSale: json["is_on_sale"],
    salePriceUzs: json["sale_price_uzs"],
    discountPercent: json["discount_percent"],
    discountPriceValue: json["discount_price_value"],
    image: json["image"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    availableQuantity: json["available_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "final_price_uzs": finalPriceUzs,
    "is_on_sale": isOnSale,
    "sale_price_uzs": salePriceUzs,
    "discount_percent": discountPercent,
    "discount_price_value": discountPriceValue,
    "image": image,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "available_quantity": availableQuantity,
  };
}
