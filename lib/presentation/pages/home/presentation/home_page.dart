import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/provider/categories_provider.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/carousel_slide_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/all_products_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/product_categories_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/new_arrivals_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/home_new_arrivals_section_widget.dart';
import 'package:thousand_melochey/core/config/banner_config.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';

import '../../../../service/localizations/localization.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(homeProvider.notifier);
    final categoryNotifier = ref.read(categoriesProvider.notifier);
    final homeState = ref.watch(homeProvider);
    ref.watch(categoriesProvider);
    
    // Get new products (first 20 products from the list)
    // final List<Product> newProducts = homeState.products?.data?.take(20).toList() ?? [];
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "1000 МЕЛОЧЕЙ",
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: RefreshIndicator(
            onRefresh: (){
              categoryNotifier.getCategories();
              notifier.getNewProducts();
              return notifier.getProducts(isRefresh: true);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
                    controller: notifier.searchTextFieldController,
                    onChanged: (value) {
                      notifier.onSearchChanged(value);
                    },
                  ),
                ),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification is! ScrollEndNotification) {
                        return false;
                      }
                      final m = notification.metrics;
                      if (m.maxScrollExtent <= 0 ||
                          m.pixels < m.maxScrollExtent - 1.0) {
                        return false;
                      }
                      final hs = ref.read(homeProvider);
                      final hn = ref.read(homeProvider.notifier);
                      if (hs.isLoadMore) return false;
                      final hasNext = hs.products?.meta?.hasNext ??
                          (hs.products?.meta != null &&
                              hs.products!.meta!.totalPages != null &&
                              hs.products!.meta!.page != null &&
                              hs.products!.meta!.page! <
                                  hs.products!.meta!.totalPages!);
                      if (!hasNext) return false;
                      final page = hs.products?.meta?.page ?? 0;
                      final q = hn.searchTextFieldController.text.trim();
                      hn.getProducts(
                        currentPage: page + 1,
                        isRefresh: false,
                        searchQuery: hs.isSearching && q.isNotEmpty ? q : null,
                      );
                      return false;
                    },
                    child: CustomScrollView(
                      controller: notifier.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                      if (!homeState.isSearching) ...[
                        SliverToBoxAdapter(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 150.h,
                              viewportFraction: 0.85,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 4),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.2,
                            ),
                            items: BannerData.getBanners().map((banner) {
                              return CarouselSlideWidget(
                                bannerConfig: banner,
                              );
                            }).toList(),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: ProductCategoriesWidget()
                        ),
                        const SliverToBoxAdapter(
                          child: HomeNewArrivalsSectionWidget(),
                        ),
                      ],
                      const ProductsListWidget(),
                      if (homeState.isLoadMore)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 16.h, top: 8.h),
                            child: const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
