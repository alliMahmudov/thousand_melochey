import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/product_widget.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';

class NewArrivalsWidget extends ConsumerWidget {
  final List<Product> newProducts;
  final Function(Product) onProductTap;
  final VoidCallback onViewMore;

  const NewArrivalsWidget({
    super.key,
    required this.newProducts,
    required this.onProductTap,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayProducts = newProducts.take(20).toList();
    final showViewMoreCard = displayProducts.isNotEmpty;
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
    final favoritesState = ref.watch(favoritesProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    bool isProductFavorite(int productId) {
      if (favoritesState.pendingFavorites.containsKey(productId)) {
        return favoritesState.pendingFavorites[productId] ?? false;
      }
      return favoritesState.favoritesList?.data?.any((item) => item.id == productId) ?? false;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(showViewMoreCard),
          _buildProductsList(
            displayProducts,
            showViewMoreCard,
            favoritesNotifier,
            favoritesState,
            cartNotifier,
            isProductFavorite,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool showViewMore) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.08),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              CupertinoIcons.sparkles,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Новинки',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: onViewMore,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          'HOT',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange[700],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Свежие поступления этой недели',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (showViewMore)
            GestureDetector(
              onTap: onViewMore,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Все',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 12.sp,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductsList(
    List<Product> displayProducts,
    bool showViewMoreCard,
    dynamic favoritesNotifier,
    dynamic favoritesState,
    dynamic cartNotifier,
    bool Function(int) isProductFavorite,
  ) {
    return Container(
      height: 320.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: displayProducts.length + (showViewMoreCard ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == displayProducts.length && showViewMoreCard) {
            return _buildViewMoreCard();
          }

          final product = displayProducts[index];
          final productId = product.id ?? 0;
          final isFavorite = isProductFavorite(productId);

          return Container(
            width: 170.w,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => onProductTap(product),
              borderRadius: BorderRadius.circular(8.r),
              child: ProductWidget(
                id: productId,
                name: product.name,
                price: product.finalPriceUzs ?? product.price,
                image: product.image,
                isFavorite: isFavorite,
                onTap: () => favoritesNotifier.switchGlobalFavorite(isFavorite, productId, context),
                addToCart: () {
                  final cartProduct = LocalCartProduct(
                    id: productId,
                    name: product.name,
                    price: product.finalPriceUzs ?? product.price,
                    image: product.image,
                    quantity: 1,
                  );
                  cartNotifier.addToCart(context, cartProduct);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildViewMoreCard() {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: onViewMore,
          child: Container(
            width: 160.w,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.02),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.15),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50.r,
                  height: 50.r,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.1),
                        AppColors.primaryColor.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(
                    CupertinoIcons.arrow_right_circle,
                    size: 24.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Смотреть все',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Смотреть больше',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
