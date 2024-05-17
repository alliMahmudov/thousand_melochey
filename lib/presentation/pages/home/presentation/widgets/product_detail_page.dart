import 'package:thousand_melochey/core/imports/imports.dart';

@RoutePage()
class ProductDetailPage extends ConsumerStatefulWidget {
  final int? id;
  final String? name;
  final String? price;
  final String? description;
  final String? image;

  const ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(favoritesProvider.notifier);
    final state = ref.watch(favoritesProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final cartState = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          widget.name ?? "",
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              AppNavigator.pop();
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            )),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 310.h,
                child: Image.network(widget.image ?? ""),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  4.verticalSpace,
                  Text(
                    "\$${widget.price}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  16.verticalSpace,
                  const Text(
                    "Description:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(widget.description ?? "")
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: AppColors.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 10,
                          color: AppColors.primaryColor.withOpacity(.5))
                    ]),
                child: Center(
                    child: IconButton(
                  onPressed: () {
                    notifier.switchFavorite(
                        notifier.checkFavorite(widget.id ?? 0) ?? false,
                        widget.id ?? 0,
                        context);
                  },
                  icon: Icon(
                    notifier.checkFavorite(widget.id ?? 0) == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                )),
              ),
            ),
            cartNotifier.checkForExistence(widget.id ?? 0) == true
                ? Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        alignment: Alignment.center,
                        child: const Text(
                          "+1",
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      15.horizontalSpace,
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 40.h,
                          //width: 60.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                                color: AppColors.primaryColor, width: 2),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Go to cart",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () {
                      cartNotifier.addToCart(
                          id: widget.id ?? 0, context: context, success: (){
                            cartNotifier.getCartProducts();
                      });
                    },
                    child: Container(
                      height: 40.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12.r)),
                      child: const Row(
                        children: [
                          Text(
                            "Add to cart",
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
