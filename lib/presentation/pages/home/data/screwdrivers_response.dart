// To parse this JSON data, do
//
//     final productsResponse = productsResponseFromJson(jsonString);

import 'dart:convert';

ScrewdriversResponse productsResponseFromJson(String str) => ScrewdriversResponse.fromJson(json.decode(str));

String productsResponseToJson(ScrewdriversResponse data) => json.encode(data.toJson());

class ScrewdriversResponse {
  final List<Datum>? data;

  ScrewdriversResponse({
    this.data,
  });

  factory ScrewdriversResponse.fromJson(Map<String, dynamic> json) => ScrewdriversResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final String? image;

  Datum({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "image": image,
  };
}
