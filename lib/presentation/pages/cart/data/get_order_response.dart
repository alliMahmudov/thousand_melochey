// To parse this JSON data, do
//
//     final ordersResponse = ordersResponseFromJson(jsonString);

import 'dart:convert';

OrdersResponse ordersResponseFromJson(String str) => OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse data) => json.encode(data.toJson());

class OrdersResponse {
  final List<Order>? activeOrders;
  final List<Order>? finishedOrders;

  OrdersResponse({
    this.activeOrders,
    this.finishedOrders,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
    activeOrders: json["active_orders"] == null ? [] : List<Order>.from(json["active_orders"]!.map((x) => Order.fromJson(x))),
    finishedOrders: json["finished_orders"] == null ? [] : List<Order>.from(json["finished_orders"]!.map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "active_orders": activeOrders == null ? [] : List<dynamic>.from(activeOrders!.map((x) => x.toJson())),
    "finished_orders": finishedOrders == null ? [] : List<dynamic>.from(finishedOrders!.map((x) => x.toJson())),
  };
}

class Order {
  final int? id;
  final String? orderStatus;
  final String? totalPrice;
  final DateTime? date;
  final List<Item>? items;

  Order({
    this.id,
    this.orderStatus,
    this.totalPrice,
    this.date,
    this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    orderStatus: json["order_status"],
    totalPrice: json["total_price"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_status": orderStatus,
    "total_price": totalPrice,
    "date": date?.toIso8601String(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  final Product? product;
  final int? quantity;

  Item({
    this.product,
    this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
