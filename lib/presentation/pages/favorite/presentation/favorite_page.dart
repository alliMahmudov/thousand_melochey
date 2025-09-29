import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/widgets/favorite_products_widget.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/provider/main_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/riverpod/provider/cart_provider.dart';
import 'package:thousand_melochey/presentation/global_widgets/cached_network_image.dart';
import 'package:thousand_melochey/presentation/global_widgets/custom_shimmer_effect.dart';
import 'package:thousand_melochey/contstants/app_colors.dart';
import 'package:thousand_melochey/presentation/pages/favorite/data/favorites_response.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  List<FavoritesDatum> _localFavorites = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(favoritesProvider.notifier).getFavoritesList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(favoritesProvider.notifier);
    final state = ref.watch(favoritesProvider);
    final isLoading = state.isFavoritesLoading;
    final cartNotifier = ref.read(cartProvider.notifier);
    final bottomNavNotifier = ref.read(mainProvider(0).notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          '${AppLocalization.getText(context)?.favorite}',
        ),
      ),
      body: CustomShimmerEffect(
        leaf: false,
        isLoading: isLoading,
        child: notifier.localFavorites.isEmpty
            ? Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.white,
                AppColors.backgroundColor,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated heart icon
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 1500),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 0.8 + (0.2 * value),
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor.withAlpha(20),
                              AppColors.primaryColor.withAlpha(10),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          size: 70.sp * value,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                ),
                32.verticalSpace,
                Text(
                  '${AppLocalization.getText(context)?.empty_favorite}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
                12.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    '${AppLocalization.getText(context)?.empty_favorite_title}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ),
                24.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryColor, AppColors.primaryShadeColor],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withAlpha(70),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      bottomNavNotifier.incrementPageIndex(0);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.shopping_bag, color: AppColors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '${AppLocalization.getText(context)?.start_shopping}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            : RefreshIndicator(
          onRefresh: () async {
            await notifier.getFavoritesList();
            },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 16),
                sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = notifier.localFavorites[index];
                            return InkWell(
                              onTap: () {
                                AppNavigator.push(ProductDetailRoute(
                                    id: product.id,
                                    name: product.name,
                                    price: product.price,
                                    description: product.description,
                                    image: product.image,
                                    images: product.images
                                ));
                              },
                              child: FavoriteProductsWidget(
                                  product: product,
                                  notifier: notifier,
                                  cartNotifier: cartNotifier,
                                  productIndex: index),
                            );
                          },
                          childCount: notifier.localFavorites.length,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget favoritesInfoCard({required int length, required BuildContext context}) {
//   return SliverToBoxAdapter(
//     child: Container(
//       margin: EdgeInsets.all(16.sp),
//       padding: EdgeInsets.all(20.sp),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.primaryShadeColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primaryColor.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${AppLocalization.getText(context)?.favorite_products}',
//                   style: const TextStyle(
//                     color: AppColors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: AppColors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(
//               Icons.favorite,
//               color: AppColors.white,
//               size: 24,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
