import 'package:thousand_melochey/core/imports/imports.dart';

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
      this.isFavorite = false});

  @override
  ConsumerState<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends ConsumerState<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(.3),
            blurRadius: 6,
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              widget.onTap();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10.0.w, top: 6.0.h),
              child: widget.isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border),
            ),
          ),
          Center(
            child: SizedBox(
              height: 100.h,
              width: 100.h,
              child: Image.network(widget.image ??
                  "https://t4.ftcdn.net/jpg/03/16/15/47/360_F_316154790_pnHGQkERUumMbzAjkgQuRvDgzjAHkFaQ.jpg"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0.w),
            child: Text(
              widget.name ?? "",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              10.horizontalSpace,
              Text("\$${widget.price}"),
              const Spacer(),
              !widget.isFavProduct
                  ? Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r)),
                        color: AppColors.primaryColor,
                      ),
                      child: InkWell(
                        onTap: () {
                          notifier.addToCart(
                              id: widget.id ?? 0,
                              context: context,
                              success: () {
                                notifier.getCartProducts();
                              });
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppColors.white,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 30.h,
                      width: 30.w,
                    )
            ],
          ),
        ],
      ),
    );
  }
}
