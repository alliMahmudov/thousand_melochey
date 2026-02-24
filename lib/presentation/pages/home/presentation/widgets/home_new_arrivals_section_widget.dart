import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/data/new_products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/product_widget.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import 'package:thousand_melochey/presentation/global_widgets/custom_shimmer_effect.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

/// Оптимизированный виджет секции "Новинки" для главной страницы
/// Отображает горизонтальный список новинок с shimmer эффектом при загрузке
class HomeNewArrivalsSectionWidget extends ConsumerStatefulWidget {
  const HomeNewArrivalsSectionWidget({super.key});

  @override
  ConsumerState<HomeNewArrivalsSectionWidget> createState() =>
      _HomeNewArrivalsSectionWidgetState();
}

class _HomeNewArrivalsSectionWidgetState
    extends ConsumerState<HomeNewArrivalsSectionWidget> {
  late ScrollController _scrollController;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    // Загружаем новинки при инициализации, если они еще не загружены
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final homeState = ref.read(homeProvider);
    //   if (homeState.newProducts == null) {
    //     final notifier = ref.read(homeProvider.notifier);
    //     notifier.getNewProducts();
    //   }
    // });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 50 &&
        !_hasNavigated) {
      final homeState = ref.read(homeProvider);
      final newProducts = homeState.newProducts?.results ?? [];
      if (newProducts.isNotEmpty) {
        _hasNavigated = true;
        // _navigateToNewArrivalsPage(newProducts);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final favoritesState = ref.watch(favoritesProvider);
    final favoritesNotifier = ref.read(favoritesProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);

    final newProducts = homeState.newProducts?.results ?? [];
    final isLoading = homeState.newProducts == null;

    bool isProductFavorite(int productId) {
      if (favoritesState.pendingFavorites.containsKey(productId)) {
        return favoritesState.pendingFavorites[productId] ?? false;
      }
      return favoritesState.favoritesList?.data?.any((item) => item.id == productId) ?? false;
    }

    if (isLoading) {
      return _buildShimmerLoading();
    }

    if (newProducts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryColor.withAlpha(100)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withAlpha(100),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, newProducts.isNotEmpty),
          SizedBox(
            height: 320.h,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: newProducts.length + (newProducts.isNotEmpty ?? false ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == newProducts.length) {
                  return _buildViewMoreCard(context, newProducts);
                }

                final product = newProducts[index];
                final productId = product.id ?? 0;
                final isFavorite = favoritesNotifier.checkFavorite(product.id ?? 0);

                return Container(
                  width: 170.w,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => _navigateToProductDetail(product),
                    borderRadius: BorderRadius.circular(8.r),
                    child: ProductWidget(
                      id: productId,
                      name: product.name,
                      price: product.finalPriceUzs ?? product.price,
                      image: product.image,
                      isFavorite: isFavorite ?? false,
                      onTap: () => favoritesNotifier.switchFavorite(
                          context,
                          isFavorite ?? false,
                          productId,
                        Product(
                          id: productId,
                          name: product.name,
                          price: product.finalPriceUzs,
                          description: product.description,
                          image: product.image,
                        ),
                      ),
                      addToCart: () {
                        final cartProduct = LocalCartProduct(
                          id: productId,
                          name: product.name,
                          price: product.finalPriceUzs ?? product.price,
                          image: product.image,
                          quantity: 1,
                        );
                        cartNotifier.addToCart(context, cartProduct);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          12.verticalSpace
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Container(
      margin: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 180.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 320.h,
            child: CustomShimmerEffect(
              isLoading: true,
              leaf: false,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 170.w,
                    margin: EdgeInsets.only(right: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: ProductWidget(
                      id: 0,
                      name: "shimmer template",
                      image: "shimmer template",
                      price: "shimmer template",
                      isFavorite: false,
                      onTap: () {},
                      addToCart: () {},
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool showViewMore) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.08),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.local_fire_department,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${AppLocalization.getText(context)?.new_arrivals}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        '${AppLocalization.getText(context)?.hot}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.orange[800],
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                // Text(
                //   'Свежие поступления этой недели',
                //   style: TextStyle(
                //     fontSize: 12.sp,
                //     color: Colors.grey[600],
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
          ),
          if (showViewMore)
            GestureDetector(
              onTap: () {
                final homeState = ref.read(homeProvider);
                final newProducts = homeState.newProducts?.results ?? [];
                if (newProducts.isNotEmpty) {
                  _navigateToNewArrivalsPage(newProducts);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.15),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${AppLocalization.getText(context)?.all}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 12.sp,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildViewMoreCard(BuildContext context, List<Result> newProducts) {
    return GestureDetector(
      onTap: () => _navigateToNewArrivalsPage(newProducts),
      child: Container(
        width: 160.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50.r,
              height: 50.r,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor.withOpacity(0.1),
                    AppColors.primaryColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Icon(
                CupertinoIcons.arrow_right_circle,
                size: 24.sp,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '${AppLocalization.getText(context)?.see_all}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNewArrivalsPage(List<Result> newProducts) {
    AppNavigator.push(
      NewArrivalsRoute(newProducts: newProducts),
    );
  }

  void _navigateToProductDetail(Result product) {
    AppNavigator.push(
      ProductDetailRoute(
        id: product.id,
        name: product.name,
        price: product.finalPriceUzs,
        description: product.description,
        image: product.image,
        images: product.images,
      ),
    );
  }
}

