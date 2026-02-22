// To parse this JSON data, do
//
//     final newProductsResponse = newProductsResponseFromJson(jsonString);

import 'dart:convert';

NewProductsResponse newProductsResponseFromJson(String str) => NewProductsResponse.fromJson(json.decode(str));

String newProductsResponseToJson(NewProductsResponse data) => json.encode(data.toJson());

class NewProductsResponse {
  final int? count;
  final List<Result>? results;

  NewProductsResponse({
    this.count,
    this.results,
  });

  factory NewProductsResponse.fromJson(Map<String, dynamic> json) => NewProductsResponse(
    count: json["count"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final String? finalPriceUzs;
  final String? image;
  final List<String>? images;
  final double? availableQuantity;

  Result({
    this.id,
    this.name,
    this.description,
    this.price,
    this.finalPriceUzs,
    this.image,
    this.images,
    this.availableQuantity,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    finalPriceUzs: json["final_price_uzs"],
    image: json["image"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    availableQuantity: json["available_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "final_price_uzs": finalPriceUzs,
    "image": image,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "available_quantity": availableQuantity,
  };
}
