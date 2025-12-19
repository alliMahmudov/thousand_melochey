// To parse this JSON data, do
//
//     final categoryProductsResponse = categoryProductsResponseFromJson(jsonString);

import 'dart:convert';

CategoryProductsResponse categoryProductsResponseFromJson(String str) => CategoryProductsResponse.fromJson(json.decode(str));

String categoryProductsResponseToJson(CategoryProductsResponse data) => json.encode(data.toJson());

class CategoryProductsResponse {
  final Meta? meta;
  final List<Datum>? data;

  CategoryProductsResponse({
    this.meta,
    this.data,
  });

  factory CategoryProductsResponse.fromJson(Map<String, dynamic> json) => CategoryProductsResponse(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final List<String>? images;
  final double? availableQuantity;

  Datum({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.images,
    this.availableQuantity,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

class Meta {
  final int? page;
  final int? pageSize;
  final int? totalItems;
  final int? totalPages;
  final bool? hasNext;
  final bool? hasPrevious;

  Meta({
    this.page,
    this.pageSize,
    this.totalItems,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    pageSize: json["page_size"],
    totalItems: json["total_items"],
    totalPages: json["total_pages"],
    hasNext: json["has_next"],
    hasPrevious: json["has_previous"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "page_size": pageSize,
    "total_items": totalItems,
    "total_pages": totalPages,
    "has_next": hasNext,
    "has_previous": hasPrevious,
  };
}
