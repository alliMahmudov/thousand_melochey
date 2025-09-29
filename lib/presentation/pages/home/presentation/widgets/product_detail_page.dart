import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/provider/main_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/presentation/global_widgets/fullscreen_image_viewer.dart';

@RoutePage()
class ProductDetailPage extends ConsumerStatefulWidget {
  final int? id;
  final String? name;
  final String? price;
  final String? description;
  final String? image;
  final List<String>? images;

  const ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    this.images,
  });

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    print(widget.images);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(favoritesProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);
    final cartState = ref.watch(cartProvider);
    final checkingProductExistence = cartState.cartProduct?.data?.any((cartProduct) => cartProduct.product?.id == widget.id);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.only(left: 8.w),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => AppNavigator.pop(),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Consumer(
              builder: (context, ref, child) {
                final isLiked = notifier.checkFavorite(widget.id ?? 0);
                final isPending = ref.watch(favoritesProvider).pendingFavorites[widget.id ?? 0] ?? false;
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      notifier.switchFavorite(
                        isLiked ?? false,
                        widget.id ?? 0,
                        context,
                      );
                    },
                    icon: isPending
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                            ),
                          )
                        : Icon(
                            (isLiked == true) ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                            color: AppColors.primaryColor,
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child:  SizedBox(
              height: 360.h,
              child: Builder(
                builder: (context) {
                  final List<String> imageList = (widget.images != null && widget.images!.isNotEmpty)
                      ? widget.images!
                      : [if ((widget.image ?? '').isNotEmpty) widget.image! else ''];

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: imageList.length,
                        onPageChanged: (index) => setState(() => _currentIndex = index),
                        itemBuilder: (context, index) {
                          final imgUrl = imageList[index];
                          final heroTag = 'product_${widget.id ?? imgUrl}_${index.toString()}';
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => FullscreenImageViewer(
                                    imageUrl: imgUrl,
                                    heroTag: heroTag,
                                  ),
                                  transitionDuration: const Duration(milliseconds: 250),
                                  reverseTransitionDuration: const Duration(milliseconds: 250),
                                  opaque: false,
                                ),
                              );
                            },
                            child: Hero(
                              tag: heroTag,
                              child: Container(
                                color: AppColors.white,
                                child: CachedNetworkImage(
                                  imageUrl: imgUrl,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => const Icon(Icons.image, size: 48),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (imageList.length > 1)
                        Positioned(
                          bottom: 12.h,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(imageList.length, (index) {
                              final bool isActive = index == _currentIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                height: 6.h,
                                width: isActive ? 18.w : 6.w,
                                decoration: BoxDecoration(
                                  color: isActive ? AppColors.primaryColor : Colors.black26,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              );
                            }),
                          ),
                        ),
                        Positioned(
                        left: 16.w,
                        right: 16.w,
                        bottom: 24.h,
                        child: Text(
                          widget.name ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child:  Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppMoneyFormatter.longFormatString(widget.price) ?? ''} UZS",
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
                      ),
                    ),
                    16.verticalSpace,
                    Text(
                      "${AppLocalization.getText(context)?.description}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    8.verticalSpace,
                    AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        widget.description ?? '',
                        // maxLines: null,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              if (checkingProductExistence ?? false) ...[
                InkWell(
                  onTap: (){
                    cartNotifier.addToCart(
                      id: widget.id ?? 0,
                      context: context,
                      success: () {
                        // AppHelpers.showSuccessToast(message: "${AppLocalization.getText(context)?.product_added_to_cart}");
                        cartNotifier.getCartProducts();
                      },
                    );
                  },
                  child: Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "+1",
                      style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: InkWell(
                    onTap: () {
                      AppNavigator.pushAndPopUntil(const MainRoute());
                      ref.read(mainProvider(0).notifier).incrementPageIndex(3);
                    },
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.primaryColor, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${AppLocalization.getText(context)?.go_to_cart}",
                        style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      cartNotifier.addToCart(
                        id: widget.id ?? 0,
                        context: context,
                        success: () {
                          cartNotifier.getCartProducts();
                        },
                      );
                    },
                    child: Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.shopping_bag_outlined, color: AppColors.white),
                          8.horizontalSpace,
                          Text(
                            "${AppLocalization.getText(context)?.add_to_cart}",
                            style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
