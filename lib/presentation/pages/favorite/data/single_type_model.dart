import 'package:thousand_melochey/presentation/pages/favorite/data/favorites_response.dart';

import '../../cart/data/cart_response.dart';



class ProductView {
  final int id;
  final String name;
  final String price;
  final String? salePriceUzs;
  final bool? isOnSale;
  final String? discountPercent;
  final String description;
  final String image;
  final List<String> images;

  ProductView({
    required this.id,
    required this.name,
    required this.price,
    this.salePriceUzs,
    this.isOnSale,
    this.discountPercent,
    required this.description,
    required this.image,
    required this.images,
  });

  factory ProductView.fromResult(CartProduct r) => ProductView(
    id: r.id ?? 0,
    name: r.name ?? "",
    price: r.finalPriceUzs ?? "",
    salePriceUzs: r.salePriceUzs,
    isOnSale: r.isOnSale,
    discountPercent: r.discountPercent,
    description: r.description ?? "",
    image: r.image ?? "",
    images: r.images ?? [],
  );

  factory ProductView.fromFavorites(FavoritesDatum f) => ProductView(
    id: f.id ?? 0,
    name: f.name ?? "",
    price: f.finalPriceUzs ?? "",
    salePriceUzs: f.salePriceUzs,
    isOnSale: f.isOnSale,
    discountPercent: f.discountPercent,
    description: f.description ?? "",
    image: f.image ?? "",
    images: f.images ?? [],
  );
}
