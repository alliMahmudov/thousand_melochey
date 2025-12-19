import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/empty_page_template.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import 'package:thousand_melochey/presentation/pages/favorite/data/single_type_model.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/riverpod/state/favorites_state.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/widgets/favorite_products_widget.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/provider/main_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (LocalStorage.instance.isAuthenticated()) {
        ref.read(favoritesProvider.notifier).getFavoritesList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(favoritesProvider.notifier);
    final state = ref.watch(favoritesProvider);
    final isLoading = state.isFavoritesLoading;
    final cartNotifier = ref.read(cartProvider.notifier);
    final bottomNavNotifier = ref.read(mainProvider(0).notifier);
    final storage = LocalStorage.instance;

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
        child: isFavoriteListEmpty(state)
            ? EmptyPageTemplate(
          icon: CupertinoIcons.heart,
          title: "${AppLocalization.getText(context)?.empty_favorite}",
          subTitle: "${AppLocalization.getText(context)?.empty_favorite_title}",
        ) : RefreshIndicator(
                onRefresh: () async {
                  if (storage.isAuthenticated()) {
                    await notifier.getFavoritesList();
                  }
                },
                child: CustomScrollView (
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final product = storage.isAuthenticated()
                                    ? ProductView.fromFavorites(notifier.localFavorites[index])
                                    : ProductView.fromResult(storage.getLocalFavorites()[index]);
                                return InkWell(
                                  onTap: () {
                                    AppNavigator.push(
                                      ProductDetailRoute(
                                        id: product.id,
                                        name: product.name,
                                        price: product.price,
                                        description: product.description,
                                        image: product.image,
                                        images: product.images,
                                      ),
                                    );
                                  },
                                  child: FavoriteProductsWidget(
                                    id: product.id ?? 0,
                                    name: product.name ?? "",
                                    image: product.image ?? "",
                                    price: product.price ?? "",
                                    description: product.description ?? "",
                                    productIndex: index,
                                    addToFavorite: () {
                                      if (LocalStorage.instance.isAuthenticated()) {
                                        notifier.localFavorites.removeAt(index);
                                        notifier.removeFromFavorites(productID: product.id);
                                      } else {
                                        notifier.removeLocalFavorite(product.id);
                                      }
                                    },
                                    addToCart: () {
                                      cartNotifier.addToCart(context, LocalCartProduct(
                                        quantity: 1,
                                        id: product.id,
                                        name: product.name,
                                        price: product.price,
                                        image: product.image,
                                        images: product.images,
                                        description: product.description,
                                      ));
                                    },
                                  ),
                                );
                              },
                          childCount: storage.isAuthenticated()
                              ? notifier.localFavorites.length
                              : storage.getLocalFavorites().length,
                        ),
                      ),
                    ),
                  ],
                ),
            ),
        ),
      );
    }
    bool isFavoriteListEmpty(FavoritesState state) {
    if (LocalStorage.instance.isAuthenticated()) {
      return state.favoritesList?.data?.isEmpty ?? false;
    } else {
      return LocalStorage.instance.getLocalFavorites().isEmpty;
    }
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
