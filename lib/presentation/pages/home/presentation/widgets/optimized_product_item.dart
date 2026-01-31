import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/product_widget.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';

import '../../../../../core/handlers/local_storage.dart';

class OptimizedProductItem extends ConsumerWidget {
  final dynamic product;
  final String? name;
  final String? price;
  final String? image;
  final int? id;

  const OptimizedProductItem({
    super.key,
    required this.product,
    this.name,
    this.price,
    this.image,
    this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartProvider.notifier);
    final favoriteNotifier = ref.read(favoritesProvider.notifier);

    // Кешируем проверку избранного через select
    final productId = id ?? product?.id ?? 0;
    final isLiked = favoriteNotifier.checkFavorite(product?.id ?? 0);


    return ProductWidget(
      name: name ?? product?.name,
      image: image ?? product?.image,
      price: price ?? product?.finalPriceUzs,
      id: productId,
      isFavorite: favoriteNotifier.checkFavorite(product?.id ?? 0) ?? false,
      onTap: () {
        favoriteNotifier.switchFavorite(
          context,
          isLiked ?? false,
          product.id ?? 0,
          product,
        );
      },
      addToCart: () {
        cartNotifier.addToCart(context, LocalCartProduct(
          quantity: 1,
          id: productId,
          name: name ?? product?.name,
          price: price ?? product?.finalPriceUzs,
          image: image ?? product?.image,
          images: product?.images,
          description: product?.description,
        ));
      },
    );
  }
}
