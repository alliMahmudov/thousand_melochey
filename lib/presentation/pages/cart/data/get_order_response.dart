// To parse this JSON data, do
//
//     final getOrderResponse = getOrderResponseFromJson(jsonString);

import 'dart:convert';

GetOrderResponse getOrderResponseFromJson(String str) => GetOrderResponse.fromJson(json.decode(str));

String getOrderResponseToJson(GetOrderResponse data) => json.encode(data.toJson());

class GetOrderResponse {
  final String? name;
  final dynamic phoneNumber;
  final Address? address;
  final List<CartProduct>? cartProducts;
  final double? totalPrice;
  final DateTime? date;

  GetOrderResponse({
    this.name,
    this.phoneNumber,
    this.address,
    this.cartProducts,
    this.totalPrice,
    this.date,
  });

  factory GetOrderResponse.fromJson(Map<String, dynamic> json) => GetOrderResponse(
    name: json["name"],
    phoneNumber: json["phone_number"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    cartProducts: json["cart_products"] == null ? [] : List<CartProduct>.from(json["cart_products"]!.map((x) => CartProduct.fromJson(x))),
    totalPrice: json["total_price"]?.toDouble(),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone_number": phoneNumber,
    "address": address?.toJson(),
    "cart_products": cartProducts == null ? [] : List<dynamic>.from(cartProducts!.map((x) => x.toJson())),
    "total_price": totalPrice,
    "date": date?.toIso8601String(),
  };
}

class Address {
  final String? addressLine1;
  final dynamic addressLine2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  Address({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "state": state,
    "postal_code": postalCode,
    "country": country,
  };
}

class CartProduct {
  final Product? product;
  final int? quantity;

  CartProduct({
    this.product,
    this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
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

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
