import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/custom_pagination_widget.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/provider/categories_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/optimized_product_item.dart';

class ProductsListWidget extends ConsumerStatefulWidget {
  const ProductsListWidget({super.key});

  @override
  ConsumerState<ProductsListWidget> createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends ConsumerState<ProductsListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final notifier = ref.read(homeProvider.notifier);
      final cartNotifier = ref.read(cartProvider.notifier);
      final categoryNotifier = ref.read(categoriesProvider.notifier);
      notifier.getProducts(isRefresh: true);
      notifier.getNewProducts();
      cartNotifier.getCartItems();
      categoryNotifier.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(homeProvider);
    ref.watch(favoritesProvider); // подписка для обновления UI при изменении лайков
    final favoriteNotifier = ref.read(favoritesProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);

    if (state.isLoading) {
      return CustomShimmerEffectSliver(
        isLoading: state.isLoading,
        child: SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          sliver: SliverGrid(
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
        ),
      );
    }

    // Если загрузка завершена, но данных нет - показываем ошибку
    if (state.products?.data == null || state.products!.data!.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: SizedBox(
          height: 0.8.sh,
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
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 16.0.h, left: 8.w, right: 8.w), // Add some bottom padding
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0.h,
          crossAxisSpacing: 4.0.h,
          childAspectRatio: .585,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final product = state.products?.data?[index];
            if (product == null) return const SizedBox.shrink();
            
            return InkWell(
              onTap: (){
                AppNavigator.push(
                    ProductDetailRoute(
                        id: product.id,
                        name: product.name,
                        price: product.finalPriceUzs,
                        description: product.description,
                        image: product.image,
                        images: product.images
                    )
                );
              },
              child: OptimizedProductItem(
                product: product,
              ),
            );
          },
          childCount: state.products?.data?.length ?? 0,
        ),
      ),
    );

  }

  @override
  bool get wantKeepAlive => true;
}
