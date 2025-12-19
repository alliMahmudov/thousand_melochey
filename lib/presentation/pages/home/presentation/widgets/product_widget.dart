import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/contstants/app_assets.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/presentation/global_widgets/cached_network_image.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import '../../../cart/data/cart_response.dart';

class ProductWidget extends ConsumerStatefulWidget {
  final int? id;
  final String? name;
  final String? price;
  final String? image;
  final bool isFavorite;
  final bool existInCart;
  final Function() onTap;
  final Function() addToCart;

  const ProductWidget(
      {super.key,
      required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.onTap,
      required this.addToCart,
      this.existInCart = false,
      this.isFavorite = false
      });

  @override
  ConsumerState<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends ConsumerState<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.read(cartProvider.notifier);
    final cartState = ref.watch(cartProvider);

    int quantityInCart() {
      if (widget.id == null) return 0;
      final int productId = widget.id!;
      if (LocalStorage.instance.isAuthenticated()) {
        final items = cartState.cartProduct?.data ?? [];
        final found = items.firstWhere(
          (e) => e.product?.id == productId,
          orElse: () => Datum(product: null, quantity: 0),
        );
        return found.quantity ?? 0;
      } else {
        final items = cartState.localCartItems ?? [];
        final found = items.firstWhere(
          (e) => e.id == productId,
          orElse: () => LocalCartProduct(id: productId, quantity: 0),
        );
        return found.quantity ?? 0;
      }
    }

    void increment() {
      if (widget.id == null) return;
      final product = LocalCartProduct(
        id: widget.id,
        name: widget.name,
        price: widget.price,
        image: widget.image,
        quantity: 1,
      );
      cartNotifier.addToCart(context, product);
    }

    void decrement() {
      if (widget.id == null) return;
      final id = widget.id!;
      if (LocalStorage.instance.isAuthenticated()) {
        cartNotifier.removeFromGlobalCart(
          id: id,
          context: context,
          success: () {
            // cartNotifier.getCartProducts();
          },
        );
      } else {
        cartNotifier.removeFromLocalCart(id);
      }
    }

    final qty = quantityInCart();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.9,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: widget.image != null && widget.image!.isNotEmpty
                        ?
                        CustomNetworkImage(imagePath: widget.image)
                        // CachedNetworkImage(imageUrl: widget.image ?? AppAssets.emptyImagePlaceHolder)
                    // FadeInImage.assetNetwork(
                    //         placeholder: AppAssets.emptyImagePlaceHolder,
                    //         image: widget.image!,
                    //         fit: BoxFit.cover,
                    //         imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                    //           AppAssets.emptyImagePlaceHolder,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       )
                        : Image.asset(
                            AppAssets.emptyImagePlaceHolder,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: widget.onTap,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                          child: widget.isFavorite
                                  ? const Icon(CupertinoIcons.heart_fill, color: Colors.red, key: ValueKey('fav'))
                                  : const Icon(CupertinoIcons.heart, color: Colors.grey, key: ValueKey('notfav')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              color: Colors.black54,
            ),

            Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.price != null ? "${AppMoneyFormatter.longFormatString(widget.price)} UZS" : "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                qty > 0
                    ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.primaryColor.withAlpha(30),
                    border: Border.all(color: AppColors.primaryColor.withAlpha(100)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: decrement,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
                          ),
                          child: Icon(Icons.remove, size: 18.sp, color: AppColors.primaryColor),
                        ),
                      ),
                      Text(
                        '$qty',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: increment,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(4.sp),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.add, size: 18.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      backgroundColor: AppColors.primaryColor,
                      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30))
                  ),
                  onPressed: () {
                    increment();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalization.getText(context)?.add_to_cart ?? 'Add',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
