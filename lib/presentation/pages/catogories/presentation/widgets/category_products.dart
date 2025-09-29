import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/custom_shimmer_effect.dart';

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
    final notifier = ref.read(homeProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.sp),
        child: CustomScrollView(
          slivers: [
            if (state.isLoading)
              CustomShimmerEffectSliver(
                isLoading: true,
                child: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0.h, // Space between columns
                    mainAxisSpacing: 10.0.h, // Space between rows
                    childAspectRatio: .95, // Aspect ratio of the cards
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
                  childAspectRatio: .95, // Aspect ratio of the cards
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: state.categoryProducts?.results?.length ?? 0,
                  (BuildContext context, int index) {
                    final product = state.categoryProducts?.results?[index];
                    final isLiked = ref.read(favoritesProvider.notifier).checkFavorite(product?.id ?? 0);
                    final isPending = ref.watch(favoritesProvider).pendingFavorites[product?.id ?? 0] ?? false;
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
                            ref.read(favoritesProvider.notifier).switchFavorite(isLiked ?? false, product?.id ?? 0, context);
                          },
                          addToCart: (){},
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
