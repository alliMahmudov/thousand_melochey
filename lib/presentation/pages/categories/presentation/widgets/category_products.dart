import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/custom_pagination_widget.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/provider/categories_provider.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/widgets/filter_modal.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/optimized_product_item.dart';
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
      notifier.getCategoryProducts(
        categoryId: widget.categoryId ?? 0,
        isRefresh: true,
      );
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
    final products = state.products;


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          IconButton(onPressed: () {
            AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
              context: context,
              modal: FilterModal(categoryId: widget.categoryId ?? 0)
            );
          }, icon: const Icon(CupertinoIcons.slider_horizontal_3))
        ],
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
                  minPrice: notifier.filterMinPrice.text
                );
            }
          },
          onRefresh: () async {
              await notifier.getCategoryProducts(
                categoryId: widget.categoryId ?? 0, 
                isRefresh: true,
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
                      if (product == null) return const SizedBox.shrink();

                      return InkWell(
                          onTap: () {
                            AppNavigator.push(
                                ProductDetailRoute(
                                    id: product.id ?? 0,
                                    name: product.name,
                                    price: product.finalPriceUzs,
                                    description: product.description,
                                    image: product.image,
                                    images: product.images
                                ));
                          },
                          child: 
                        OptimizedProductItem(product: product));
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
