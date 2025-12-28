import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/provider/categories_provider.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/carousel_slide_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/all_products_widget.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/product_categories_widget.dart';

import '../../../../service/localizations/localization.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;


  @override
  void didChangeDependencies() {
    final notifier = ref.read(homeProvider.notifier);

    tabController = TabController(length: notifier.tabs(context).length, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(homeProvider.notifier);
    final categoryNotifier = ref.read(categoriesProvider.notifier);
    ref.watch(categoriesProvider);
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
                      notifier.getProducts(
                        searchQuery: notifier.searchTextFieldController.text,
                        isRefresh: true
                      );
                    },
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 150.h,
                            viewportFraction: 0.9,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 4),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.2,
                          ),
                          items: [
                            CarouselSlideWidget(
                              title: AppLocalization.getText(context)
                                      ?.carousel_delivery ??
                                  '',
                              icon: Icons.local_shipping_rounded,
                              accentColor: AppColors.primaryColor,
                              slideIndex: 0,
                            ),
                            CarouselSlideWidget(
                              title: AppLocalization.getText(context)
                                      ?.carousel_popular ??
                                  '',
                              icon: Icons.star_rounded,
                              accentColor: Color(0xFFF57C00),
                              slideIndex: 1,
                            ),
                            CarouselSlideWidget(
                              title: AppLocalization.getText(context)
                                      ?.carousel_search ??
                                  '',
                              icon: Icons.search_rounded,
                              accentColor: AppColors.primaryShadeColor,
                              slideIndex: 2,
                            ),
                            CarouselSlideWidget(
                              title: AppLocalization.getText(context)
                                      ?.carousel_payment ??
                                  '',
                              icon: Icons.payment_rounded,
                              accentColor: AppColors.red,
                              slideIndex: 3,
                            ),
                          ],
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
                      // const SliverToBoxAdapter(
                      //   child: SizedBox(
                      //     height: 10,
                      //   ),
                      // ),
                      const ProductsListWidget()
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
