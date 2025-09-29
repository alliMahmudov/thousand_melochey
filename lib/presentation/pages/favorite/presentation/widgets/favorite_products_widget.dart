import 'package:thousand_melochey/presentation/pages/favorite/data/favorites_response.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/riverpod/notifier/favorites_notifier.dart';

import '../../../../../core/imports/imports.dart';
import '../../../../../service/localizations/localization.dart';
import '../../../../global_widgets/cached_network_image.dart';

class FavoriteProductsWidget extends StatelessWidget {
  final FavoritesDatum product;
  final FavoritesNotifier notifier;
  final CartNotifier cartNotifier;
  final int productIndex;

  const FavoriteProductsWidget({
    required this.product,
    required this.notifier,
    required this.cartNotifier,
    required this.productIndex,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product image
            Container(
              width: 120.w,
              height: 120.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                ),
                child: CustomNetworkImage(imagePath: product.image),
              ),
            ),

            // Product details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      product.name ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // Product description
                    if (product.description?.isNotEmpty == true)...[
                      4.verticalSpace,
                      Text(
                        product.description!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                      ),
                    ],

                    12.verticalSpace,

                    // Price and actions
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${AppLocalization.getText(context)?.price}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '${product.price ?? '0'} UZS',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          spacing: 6,
                          children: [
                            // Remove from favorites (лайк)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red.withAlpha(20),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 20.sp,
                                ),
                                onPressed: () {
                                  notifier.localFavorites.removeAt(productIndex);
                                  notifier.removeFromFavorites(productID: product.id ?? 0);
                                },
                              ),
                            ),
                            // Add to cart
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                  color: AppColors.white,
                                  size: 20.sp,
                                ),
                                onPressed: () {
                                  cartNotifier.addToCart(id: product.id ?? 0, context: context,
                                      success: (){
                                        cartNotifier.getCartProducts();
                                      }
                                  );
                                  // AppHelpers.showErrorToast(errorMessage: "Added to cart");
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
