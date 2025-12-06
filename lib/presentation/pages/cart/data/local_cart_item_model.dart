class LocalCartProduct {
  final int? id;
  final String? name;
  final String? price;
  final String? image;
  final int? quantity;
  final String? description;
  final List<String>? images;

  LocalCartProduct({
    this.id,
    this.name,
    this.price,
    this.image,
    this.quantity,
    this.description,
    this.images,
  });

  factory LocalCartProduct.fromJson(Map<String, dynamic> json) => LocalCartProduct(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    quantity: json["quantity"],
    description: json["description"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "image": image,
    "quantity": quantity,
    "description": description,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x))
  };
}