import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

class ProductsListWidget extends ConsumerStatefulWidget {
  const ProductsListWidget({super.key});

  @override
  ConsumerState<ProductsListWidget> createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends ConsumerState<ProductsListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final notifier = ref.read(homeProvider.notifier);
      final favoriteNotifier = ref.read(favoritesProvider.notifier);
      final cartNotifier = ref.read(cartProvider.notifier);
      notifier.getProducts(isRefresh: true);
      cartNotifier.getCartItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(homeProvider);
    final cartState = ref.watch(cartProvider);
    final favoriteNotifier = ref.read(favoritesProvider.notifier);
    final favoritesState = ref.watch(favoritesProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    if (state.isLoading) {
      return CustomShimmerEffectSliver(
        isLoading: state.isLoading,
        child: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0.h,
            crossAxisSpacing: 10.0.h,
            childAspectRatio: .585,
          ),
          delegate: SliverChildBuilderDelegate(
            childCount: 10,
            (BuildContext context, int index) {
              return ProductWidget(
                name: "shimmer template",
                image: "shimmer template",
                price: "shimmer template",
                id: 0,
                isFavorite: false,
                onTap: () {},
                addToCart: (){},
              );
            },
            // Number of grid items
          ),
        ),
      );
    }
    
    // Если загрузка завершена, но данных нет - показываем ошибку
    if (state.products?.results == null || state.products!.results!.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: .8.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "${AppLocalization.getText(context)?.product_not_available}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 10.h, // Space between rows
        crossAxisSpacing: 10.h,
        childAspectRatio: .585, // Aspect ratio of the cards
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: state.products?.results?.length,
        (BuildContext context, int index) {
          final product = state.products?.results?[index];
          final isLiked = favoriteNotifier.checkFavorite(product?.id ?? 0);
          return InkWell(
            onTap: () {
              AppNavigator.push(
                ProductDetailRoute(
                  id: product?.id,
                  name: product?.name,
                  price: product?.price,
                  description: product?.description,
                  image: product?.image,
                  images: product?.images
                )
              );
            },
            child: ProductWidget(
              name: product?.name,
              image: product?.image,
              price: product?.price,
              id: product?.id,
              isFavorite: isLiked ?? false,
              onTap: () {
                if (product != null) {
                  favoriteNotifier.switchFavorite(
                      context,
                      isLiked ?? false,
                      product.id ?? 0,
                      product,
                  );
                }
              },
              addToCart: () {
                cartNotifier.addToCart(context, LocalCartProduct(
                  quantity: 1,
                  id: product?.id,
                  name: product?.name,
                  price: product?.price,
                  image: product?.image,
                  images: product?.images,
                  description: product?.description,
                ));
              },
            )
          );
        },
        // Number of grid items
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
