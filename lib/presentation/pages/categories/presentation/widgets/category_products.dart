import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/custom_shimmer_effect.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';

@RoutePage()
class CategoryProductsPage extends ConsumerStatefulWidget {
  final String categoryName;
  const CategoryProductsPage({
    required this.categoryName,
    super.key});

  @override
  ConsumerState<CategoryProductsPage> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends ConsumerState<CategoryProductsPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final notifier = ref.read(categoriesProvider.notifier);
      notifier.getCategoryProducts(categoryName: widget.categoryName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesProvider);
    ref.watch(favoritesProvider); // подписка для обновления UI при изменении лайков
    final favoriteNotifier = ref.read(favoritesProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: CustomScrollView(
          slivers: [
            if (state.isLoading) CustomShimmerEffectSliver(
                isLoading: true,
                child: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0.h, // Space between columns
                    mainAxisSpacing: 10.0.h, // Space between rows
                    childAspectRatio: .6,
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
                  ),
                ),
              )
            else if ((state.categoryProducts?.results?.isNotEmpty ?? false) && state.categoryProducts?.results != null)
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0.h, // Space between columns
                  mainAxisSpacing: 10.0.h, // Space between rows
                  childAspectRatio: .6, // Aspect ratio of the cards
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: state.categoryProducts?.results?.length ?? 0,
                  (BuildContext context, int index) {
                    final product = state.categoryProducts?.results?[index];
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
                              ));
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
                                Product(
                                  id: product.id,
                                  name: product.name,
                                  price: product.price,
                                  description: product.description,
                                  image: product.image,
                                ),
                              );
                            }
                            // ref.read(favoritesProvider.notifier).switchGlobalFavorite(isLiked ?? false, product?.id ?? 0, context);
                          },
                          addToCart: () {
                            ref.read(cartProvider.notifier).addToCart(context, LocalCartProduct(
                              quantity: 1,
                              id: product?.id,
                              name: product?.name,
                              price: product?.price,
                              image: product?.image,
                              images: product?.images,
                              description: product?.description,
                            ));
                          },
                        ));
                  },
                  // Number of grid items
                ),
              )
            else const SliverToBoxAdapter(
                child: Center(
                  child: Text("Something went wrong"),
                ),
              )
          ],
        ),
      ),
    );
  }
}
