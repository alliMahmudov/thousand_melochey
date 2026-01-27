import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/custom_pagination_widget.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/provider/categories_provider.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';
import '../../../../../service/localizations/localization.dart';

@RoutePage()
class CategoryProductsPage extends ConsumerStatefulWidget {
  final String categoryName;
  final int? categoryId;
  const CategoryProductsPage({
    required this.categoryName,
    this.categoryId,
    super.key});

  @override
  ConsumerState<CategoryProductsPage> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends ConsumerState<CategoryProductsPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final notifier = ref.read(categoriesProvider.notifier);
      notifier.getCategoryProducts(categoryId: widget.categoryId ?? 0, isRefresh: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesProvider);
    final notifier = ref.read(categoriesProvider.notifier);
    final cart = ref.read(categoriesProvider.notifier);
    ref.watch(favoritesProvider); // подписка для обновления UI при изменении лайков
    final favoriteNotifier = ref.read(favoritesProvider.notifier);

    // Determine which data source to use based on viewAll flag
    final isLoading = state.isLoading;
    final isLoadMore = state.isLoadMore;
    final products = state.categoryProducts;


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: CustomPaginationWidget(
          scrollController: notifier.scrollController,
          scrollIndicatorShow: false,
          isLoadingMore: isLoadMore,
          loadMore: () {
            final currentPage = products?.meta?.page ?? 0;
            final hasNext = products?.meta?.hasNext ?? false;

            if (!isLoadMore && hasNext) {
                notifier.getPaginationCategoryProducts(
                  categoryId: widget.categoryId ?? 0,
                  currentPage: currentPage + 1,
                  isRefresh: false,
                );
            }
          },
          onRefresh: () async {
              await notifier.getCategoryProducts(
                categoryId: widget.categoryId ?? 0, 
                isRefresh: true
              );
          },
          child: CustomScrollView(
            slivers: [
              if (isLoading)
                CustomShimmerEffectSliver(
                  isLoading: true,
                  child: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0.h,
                      mainAxisSpacing: 10.0.h,
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
                    ),
                  ),
                )
              else if (products?.data?.isNotEmpty ?? false) ...[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0.h,
                    mainAxisSpacing: 10.0.h,
                    childAspectRatio: .585,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: products?.data?.length,
                    (BuildContext context, int index) {
                      final product = products?.data?[index];
                      final isLiked = favoriteNotifier.checkFavorite(product?.id ?? 0);
                      return InkWell(
                          onTap: () {
                            AppNavigator.push(
                                ProductDetailRoute(
                                    id: product?.id ?? 0,
                                    name: product?.name,
                                    price: product?.finalPriceUzs,
                                    description: product?.description,
                                    image: product?.image,
                                    images: product?.images
                                ));
                          },
                          child: ProductWidget(
                            name: product?.name,
                            image: product?.image,
                            price: product?.finalPriceUzs,
                            id: product?.id,
                            isFavorite: isLiked ?? false,
                            onTap: () {
                              if (product != null) {
                                if (product.id != null) {
                                  if (isLiked ?? false) {
                                    favoriteNotifier.removeFromFavorites(productID: product.id ?? 0);
                                  } else {
                                    favoriteNotifier.addToFavorites(productID: product.id ?? 0);
                                  }
                                }
                              }
                            },
                            addToCart: () {
                              if (product != null) {
                                product.name;
                                product.finalPriceUzs;
                                product.image;

                                final cartItem = LocalCartProduct(
                                  id: product.id,
                                  name: product.name,
                                  price: product.finalPriceUzs,
                                  image: product.image,
                                  images: product.images,
                                  description: product.description,
                                  quantity: 1,
                                );

                                ref.read(cartProvider.notifier).addToCart(context, cartItem);
                              }
                            },
                          ));
                    },
                    // Number of grid items
                  ),
                ),
              ]
              else SliverToBoxAdapter(
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
                )
            ],
          ),
        ),
      ),
    );
  }
}
