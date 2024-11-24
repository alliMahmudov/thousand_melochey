import 'package:thousand_melochey/core/imports/imports.dart';

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
      notifier.getProducts();
      favoriteNotifier.getFavoritesList();
     // cartNotifier.getCartProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final notifier = ref.read(homeProvider.notifier);
    final state = ref.watch(homeProvider);
    final favoriteNotifier = ref.read(favoritesProvider.notifier);
    return RefreshIndicator(
      onRefresh: ()  {
        return notifier.getProducts();
      },
      child: CustomScrollView(
        slivers: [
          state.isProductLoading
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : state.products?.data?.length != 0 &&
                      state.products?.data != null
                  ? SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10.0.h, // Space between columns
                        mainAxisSpacing: 10.0.h, // Space between rows
                        childAspectRatio: .95, // Aspect ratio of the cards
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.products?.data?.length,
                        (BuildContext context, int index) {
                          final product = state.products?.data?[index];
                          final isLiked =
                              favoriteNotifier.checkFavorite(product?.id ?? 0);
                          return InkWell(
                              onTap: () {
                                AppNavigator.push(ProductDetailRoute(
                                  id: product?.id,
                                  name: product?.name,
                                  price: product?.price,
                                  description: product?.description,
                                  image: product?.image,
                                ));
                              },
                              child: ProductWidget(
                                name: product?.name,
                                image: product?.image,
                                price: product?.price,
                                id: product?.id,
                                isFavorite: isLiked ?? false,
                                onTap: () {
                                  favoriteNotifier.switchFavorite(
                                    isLiked ?? false,
                                    product?.id ?? 0,
                                    context,
                                    success: () async {
                                      await notifier.getProducts();

                                    },
                                  );
                                },
                                addToCart: () {},
                              ));
                        },
                        // Number of grid items
                      ),
                    )
                  : const SliverFillRemaining(
            child: Center(
              child: Text("Data is empty"),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
