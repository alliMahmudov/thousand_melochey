import 'package:thousand_melochey/core/imports/imports.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(favoritesProvider.notifier);
    final state = ref.watch(favoritesProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: const Text(
            "Favorites",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return notifier.getFavoritesList();
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            child: CustomScrollView(
              slivers: [
                state.isFavoritesLoading
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                    : state.favoritesList?.data?.length != 0 &&
                            state.favoritesList?.data != null
                        ? SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              crossAxisSpacing: 10.0.h, // Space between columns
                              mainAxisSpacing: 10.0.h, // Space between rows
                              childAspectRatio:
                                  .95, // Aspect ratio of the cards
                            ),
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.favoritesList?.data?.length,
                              (BuildContext context, int index) {
                                final favProduct =
                                    state.favoritesList?.data?[index];
                                final product = ref
                                    .watch(homeProvider)
                                    .products
                                    ?.data?[index];
                                return ProductWidget(
                                  name: favProduct?.name,
                                  image: favProduct?.image,
                                  price: favProduct?.price,
                                  id: product?.id,
                                  isFavorite: true,
                                  isFavProduct: true,
                                  onTap: () {
                                    notifier.removeFromFavorites(productID: favProduct?.id ?? 0,
                                        success: (){
                                          notifier.getFavoritesList();
                                        });
                                  },
                                  addToCart: (){},
                                );
                              },
                              // Number of grid items
                            ),
                          )
                        : const SliverToBoxAdapter(
                            child: Center(
                              child: Text("Something went wrong"),
                            ),
                          )
              ],
            ),
          ),
        ));
  }
}
