import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/widgets/cart_list_item_widget.dart';

@RoutePage()
class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final notifier = ref.read(cartProvider.notifier);
      notifier.getCartProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    final state = ref.watch(cartProvider);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Cart",
              style: TextStyle(color: Colors.black),
            )),
        body: RawScrollbar(
          controller: notifier.scrollController,
          thumbColor: AppColors.primaryColor.withOpacity(.8),
          thumbVisibility: true,
          //interactive: true,
          thickness: 8,
          radius: const Radius.circular(10),
          child: RefreshIndicator(
            onRefresh: () {
              return notifier.getCartProducts();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: notifier.scrollController,
              slivers: [
                state.isProductLoading
                    ? const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : state.cartProduct?.data?.length != 0 &&
                            state.cartProduct?.data != null
                        ? SliverList.builder(
                            itemBuilder: (context, index) {
                              final cartProduct =
                                  state.cartProduct?.data?[index];
                              return CartListItemWidget(
                                image: cartProduct?.product?.image,
                                name: cartProduct?.product?.name,
                                price: cartProduct?.product?.price,
                                qty: cartProduct?.quantity,
                                removeTap: () {
                                  notifier.removeFromCart(
                                    context: context,
                                    id: cartProduct?.product?.id ?? 0,
                                    success: () {
                                      notifier.getCartProducts();
                                    },
                                  );
                                },
                                addTap: () {
                                  notifier.addToCart(
                                    context: context,
                                    id: cartProduct?.product?.id ?? 0,
                                    success: () {
                                      notifier.getCartProducts();
                                    },
                                  );
                                },
                                deleteFromCart: () {
                                  notifier.deleteFromCart(
                                    id: cartProduct?.product?.id ?? 0,
                                    context: context,
                                    success: () {
                                      notifier.getCartProducts();
                                    },
                                  );
                                },
                              );
                            },
                            itemCount: state.cartProduct?.data?.length,
                          )
                        : const SliverFillRemaining(
                            child: Center(
                              child: Text(
                                "Cart is empty",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: state.cartProduct?.data?.length != 0 &&
                state.cartProduct?.data != null
            ? Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.sizeOf(context).height * 0.004),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 10)
                    ]),
                padding: EdgeInsets.all(12.r),
                height: 70.h,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${state.cartProduct?.totalPrice}',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        Text('${state.cartProduct?.totalProducts} products'),
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                      child: CustomButtonWidget(
                          title: "Checkout",
                          isLoading: false,
                          onTap: () {
                            AppNavigator.push(const CheckOutRoute());
                          }),
                    )
                  ],
                ),
              )
            : const SizedBox.shrink());
  }
}
