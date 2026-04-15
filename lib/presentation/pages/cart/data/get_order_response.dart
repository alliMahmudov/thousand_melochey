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
  final int? orderNumber;
  final String? orderStatus;
  final String? orderStatusDisplay;
  final String? totalPrice;
  final DateTime? date;
  final List<Item>? items;
  final String? comment;
  final OrderAddress? address;
  final String? paymentType;
  final String? deliveryType;
  final int? addressId;

  Order({
    this.id,
    this.orderNumber,
    this.orderStatus,
    this.orderStatusDisplay,
    this.totalPrice,
    this.date,
    this.items,
    this.comment,
    this.address,
    this.paymentType,
    this.deliveryType,
    this.addressId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    orderNumber: json["order_number"],
    orderStatus: json["order_status"],
    orderStatusDisplay: json["order_status_display"],
    totalPrice: json["total_price"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    comment: json["comment"],
    address: json["address"] == null ? null : OrderAddress.fromJson(json["address"]),
    paymentType: json["payment_type"],
    deliveryType: json["delivery_type"],
    addressId: json["address_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_number": orderNumber,
    "order_status": orderStatus,
    "order_status_display": orderStatusDisplay,
    "total_price": totalPrice,
    "date": date?.toIso8601String(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "comment": comment,
    "address": address?.toJson(),
    "payment_type": paymentType,
    "delivery_type": deliveryType,
    "address_id": addressId,
  };
}

class OrderAddress {
  final int? id;
  final String? addressLine1;
  final dynamic addressLine2;
  final String? city;
  final int? districtIdRead;
  final String? districtName;

  OrderAddress({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.districtIdRead,
    this.districtName,
  });

  factory OrderAddress.fromJson(Map<String, dynamic> json) => OrderAddress(
    id: json["id"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    city: json["city"],
    districtIdRead: json["district_id_read"],
    districtName: json["district_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "district_id_read": districtIdRead,
    "district_name": districtName,
  };
}

class Item {
  final Product? product;
  final int? quantity;
  final String? priceAtPurchase;
  final bool? wasOnSale;

  Item({
    this.product,
    this.quantity,
    this.priceAtPurchase,
    this.wasOnSale,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    quantity: json["quantity"],
    priceAtPurchase: json["price_at_purchase"],
    wasOnSale: json["was_on_sale"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "quantity": quantity,
    "price_at_purchase": priceAtPurchase,
    "was_on_sale": wasOnSale,
  };
}

class Product {
  final int? id;
  final String? name;
  final String? description;
  final String? finalPriceUzs;
  final bool? isOnSale;
  final dynamic salePriceUzs;
  final dynamic discountPercent;
  final dynamic discountPriceValue;
  final String? image;
  final List<String>? images;
  final double? availableQuantity;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
