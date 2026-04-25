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
  final CartProduct? product;
  final int? quantity;

  Datum({
    this.product,
    this.quantity,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    product: json["product"] == null ? null : CartProduct.fromJson(json["product"]),
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "quantity": quantity,
  };
}

class CartProduct {
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

  CartProduct({
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

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
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
