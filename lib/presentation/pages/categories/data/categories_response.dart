// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromJson(jsonString);

import 'dart:convert';

CategoriesResponse categoriesResponseFromJson(String str) => CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) => json.encode(data.toJson());

class CategoriesResponse {
  final Meta? meta;
  final List<Category>? data;

  CategoriesResponse({
    this.meta,
    this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Category {
  final int? id;
  final String? name;
  final String? image;

  Category({
    this.id,
    this.name,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
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
