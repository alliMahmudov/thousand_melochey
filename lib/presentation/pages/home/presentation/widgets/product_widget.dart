import 'package:flutter/cupertino.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:thousand_melochey/contstants/app_assets.dart';
import 'package:thousand_melochey/contstants/app_constants.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:toastification/toastification.dart';

class ProductWidget extends ConsumerStatefulWidget {
  final int? id;
  final String? name;
  final String? price;
  final String? image;
  final bool isFavorite;
  final bool isFavProduct;
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
      this.isFavProduct = false,
      this.isFavorite = false
      });

  @override
  ConsumerState<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends ConsumerState<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: widget.image != null && widget.image!.isNotEmpty
                          ? FadeInImage.assetNetwork(
                              placeholder: AppAssets.emptyImagePlaceHolder,
                              image: widget.image!,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                                AppAssets.emptyImagePlaceHolder,
                                fit: BoxFit.cover,
                              ),
                            )
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
            ),
            //6.verticalSpace,
            const Divider(
              color: Colors.black54,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.3,
                      //fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.price != null ? "${AppMoneyFormatter.longFormatString(widget.price)} UZS" : "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),

                      !widget.isFavProduct
                          ? Material(
                              color: AppColors.primaryColor,
                              shape: const CircleBorder(),
                              elevation: 4,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () {

                                  notifier.addToCart(
                                      id: widget.id ?? 0,
                                      context: context,
                                      success: () {
                                        notifier.getCartProducts();
                                      });
                                },
                                child: SizedBox(
                                  height: 32.h,
                                  width: 32.w,
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
