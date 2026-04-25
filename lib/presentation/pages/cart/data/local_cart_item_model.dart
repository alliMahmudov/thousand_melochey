class LocalCartProduct {
  final int? id;
  final String? name;
  final String? price;
  final String? salePriceUzs;
  final bool? isOnSale;
  final String? discountPercent;
  final String? image;
  final int? quantity;
  final String? description;
  final List<String>? images;

  LocalCartProduct({
    this.id,
    this.name,
    this.price,
    this.salePriceUzs,
    this.isOnSale,
    this.discountPercent,
    this.image,
    this.quantity,
    this.description,
    this.images,
  });

  factory LocalCartProduct.fromJson(Map<String, dynamic> json) => LocalCartProduct(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    salePriceUzs: json["sale_price_uzs"],
    isOnSale: json["is_on_sale"],
    discountPercent: json["discount_percent"],
    image: json["image"],
    quantity: json["quantity"],
    description: json["description"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "sale_price_uzs": salePriceUzs,
    "is_on_sale": isOnSale,
    "discount_percent": discountPercent,
    "image": image,
    "quantity": quantity,
    "description": description,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x))
  };
}