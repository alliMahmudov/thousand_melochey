import 'package:thousand_melochey/core/imports/imports.dart';

class ScrewdriversWidget extends ConsumerStatefulWidget {
  const ScrewdriversWidget({super.key});

  @override
  ConsumerState<ScrewdriversWidget> createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends ConsumerState<ScrewdriversWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final notifier = ref.read(homeProvider.notifier);
      notifier.getScrewdriversCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final notifier = ref.read(homeProvider.notifier);
    final state = ref.watch(homeProvider);
    final favoriteNotifier = ref.read(favoritesProvider.notifier);
    final favoriteState = ref.watch(favoritesProvider);
    return CustomScrollView(
      slivers: [
        state.isProductLoading
            ? SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0.h, // Space between columns
                  mainAxisSpacing: 10.0.h, // Space between rows
                  childAspectRatio: .95, // Aspect ratio of the cards
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: 8,
                  (BuildContext context, int index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.grey.shade300,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppColors.white),
                        // height: 100.0,
                      ),
                    );
                  },
                  // Number of grid items
                ),
              )
            : state.screwdriversCategory?.data?.length != 0 &&
                    state.screwdriversCategory?.data != null
                ? SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10.0.h, // Space between columns
                      mainAxisSpacing: 10.0.h, // Space between rows
                      childAspectRatio: .95, // Aspect ratio of the cards
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.screwdriversCategory?.data?.length,
                      (BuildContext context, int index) {
                        final product =
                            state.screwdriversCategory?.data?[index];
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
                              id: product?.id,
                              image: product?.image,
                              price: product?.price,
                              isFavorite: isLiked ?? false,
                              onTap: () {
                                favoriteNotifier.switchFavorite(
                                    isLiked ?? false,
                                    product?.id ?? 0,
                                    context);
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
