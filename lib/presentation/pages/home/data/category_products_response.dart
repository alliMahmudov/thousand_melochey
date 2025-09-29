// To parse this JSON data, do
//
//     final categoryProductsResponse = categoryProductsResponseFromJson(jsonString);

import 'dart:convert';

CategoryProductsResponse categoryProductsResponseFromJson(String str) => CategoryProductsResponse.fromJson(json.decode(str));

String categoryProductsResponseToJson(CategoryProductsResponse data) => json.encode(data.toJson());

class CategoryProductsResponse {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Result>? results;

  CategoryProductsResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory CategoryProductsResponse.fromJson(Map<String, dynamic> json) => CategoryProductsResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final List<String>? images;
  final double? availableQuantity;

  Result({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.images,
    this.availableQuantity,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
