import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/custom_pagination_widget.dart';
import 'package:thousand_melochey/presentation/global_widgets/empty_page_template.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/provider/categories_provider.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';

import '../../../../../service/localizations/localization.dart';

@RoutePage()
class CategoryProductsPage extends ConsumerStatefulWidget {
  final String categoryName;
  final int categoryId;
  const CategoryProductsPage({
    required this.categoryName,
    required this.categoryId,
    super.key});

  @override
  ConsumerState<CategoryProductsPage> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends ConsumerState<CategoryProductsPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final notifier = ref.read(categoriesProvider.notifier);
      notifier.getCategoryProducts(categoryId: widget.categoryId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesProvider);
    final notifier = ref.read(categoriesProvider.notifier);
    ref.watch(favoritesProvider); // подписка для обновления UI при изменении лайков
    final favoriteNotifier = ref.read(favoritesProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: CustomPaginationWidget(
          scrollController: notifier.scrollController,
          scrollIndicatorShow: false,
          isLoadingMore: state.isLoadMore,
          loadMore: () {
            final currentPage = state.categoryProducts?.meta?.page ?? 0;
            final hasNext = state.categoryProducts?.meta?.hasNext ?? false;

            if (!state.isLoadMore && hasNext) {
              notifier.getPaginationCategoryProducts(
                categoryId: widget.categoryId,
                currentPage: currentPage + 1,
                isRefresh: false,
              );
            }
          },
          onRefresh: () {
            return notifier.getCategoryProducts(categoryId: widget.categoryId, isRefresh: true);
          },
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
              else if ((state.categoryProducts?.data?.isNotEmpty ?? false) && state.categoryProducts?.data != null) ...[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0.h, // Space between columns
                    mainAxisSpacing: 10.0.h, // Space between rows
                    childAspectRatio: .585, // Aspect ratio of the cards
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.categoryProducts?.data?.length ?? 0,
                        (BuildContext context, int index) {
                      final product = state.categoryProducts?.data?[index];
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
