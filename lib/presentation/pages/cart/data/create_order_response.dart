// To parse this JSON data, do
//
//     final createOrderResponse = createOrderResponseFromJson(jsonString);

import 'dart:convert';

CreateOrderResponse createOrderResponseFromJson(String str) => CreateOrderResponse.fromJson(json.decode(str));

String createOrderResponseToJson(CreateOrderResponse data) => json.encode(data.toJson());

class CreateOrderResponse {
  final String? name;
  final OrderAddress? address;
  final List<CartProduct>? cartProducts;
  final DateTime? date;

  CreateOrderResponse({
    this.name,
    this.address,
    this.cartProducts,
    this.date,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) => CreateOrderResponse(
    name: json["name"],
    address: json["address"] == null ? null : OrderAddress.fromJson(json["address"]),
    cartProducts: json["cart_products"] == null ? [] : List<CartProduct>.from(json["cart_products"]!.map((x) => CartProduct.fromJson(x))),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address?.toJson(),
    "cart_products": cartProducts == null ? [] : List<dynamic>.from(cartProducts!.map((x) => x.toJson())),
    "date": date?.toIso8601String(),
  };
}

class OrderAddress {
  final String? addressLine1;
  final dynamic addressLine2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;

  OrderAddress({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  factory OrderAddress.fromJson(Map<String, dynamic> json) => OrderAddress(
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
