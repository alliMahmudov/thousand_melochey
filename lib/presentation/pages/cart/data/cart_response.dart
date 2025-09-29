// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

CartResponse cartResponseFromJson(String str) => CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  final double? totalPrice;
  final List<Datum>? data;
  final int? totalProducts;

  CartResponse({
    this.totalPrice,
    this.data,
    this.totalProducts,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    totalPrice: json["total_price"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    totalProducts: json["total_products"],
  );

  Map<String, dynamic> toJson() => {
    "total_price": totalPrice,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total_products": totalProducts,
  };
}

class Datum {
  final Product? product;
  final int? quantity;

  Datum({
    this.product,
    this.quantity,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "quantity": quantity,
  };
}

class Product {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final List<String>? images;
  final double? availableQuantity;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
    this.images,
    this.availableQuantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
