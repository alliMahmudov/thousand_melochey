import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/empty_page_template.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/widgets/cart_list_item_widget.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:vibration/vibration.dart';

@RoutePage()
class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final notifier = ref.read(cartProvider.notifier);
      notifier.getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    final state = ref.watch(cartProvider);
    final isAuth = LocalStorage.instance.isAuthenticated();
    final localCart = LocalStorage.instance.getLocalCart();
    // Проверяем, есть ли pending операции
    final hasPendingOperations = state.pendingCartOperations.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          "${AppLocalization.getText(context)?.cart}",
        ),
        centerTitle: true,
        actions: [
          if (!isCartListEmpty(state))
            IconButton(
              onPressed: () {
                AppHelpers.showCustomAlertDialog(context: context,
                    title: "${AppLocalization.getText(context)?.clear_cart}",
                    actionButtonText: "${AppLocalization.getText(context)?.confirm}",
                    onTap: (){
                  AppNavigator.pop();
                  notifier.clearCart();
                });
              },
              icon: const Icon(CupertinoIcons.trash,),
            ),
        ],
      ),
      body: Stack(
        children: [
          CustomShimmerEffect(
            isLoading: state.isLoading,
            leaf: false,
            child: isCartListEmpty(state)
                ? EmptyPageTemplate(
              icon: CupertinoIcons.shopping_cart,
              title: "${AppLocalization.getText(context)?.empty_cart}",
              subTitle: "${AppLocalization.getText(context)?.empty_cart_title}",
            )
                : RefreshIndicator(
              onRefresh: () => notifier.getCartItems(),
              color: AppColors.primaryColor,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: notifier.scrollController,
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
                    sliver: SliverList.builder(
                      itemBuilder: (context, index) {

                        final cartProduct = state.cartProduct?.data?[index];
                        final productId = isAuth ? cartProduct?.product?.id ?? 0 : localCart[index].id ?? 0;
                        final productName = isAuth ? cartProduct?.product?.name ?? "" : localCart[index].name ?? "";
                        final productPrice = isAuth ?  cartProduct?.product?.price ?? "" : localCart[index].price ?? "";
                        final productImage = isAuth ?  cartProduct?.product?.image ?? "" : localCart[index].image ?? "";
                        final productDescription = isAuth ? cartProduct?.product?.description ?? "" : localCart[index].description ?? "";
                        final productQuantity = isAuth ? cartProduct?.quantity ?? 0 : localCart[index].quantity ?? 0;
                        final productListImages = isAuth ? cartProduct?.product?.images ?? [] : localCart[index].images ?? [];
                        final isPending = notifier.isPendingOperation(productId);

                        return InkWell(
                          onTap: () {
                            AppNavigator.push(
                                ProductDetailRoute(
                                    id: productId,
                                    name: productName,
                                    price: productPrice,
                                    description: productDescription,
                                    image: productImage,
                                    images: productListImages
                                ));
                          },
                          child: CartListItemWidget(
                            image: productImage,
                            name: productName,
                            price: productPrice,
                            qty: productQuantity,
                            isLoading: isPending,
                            removeTap: () {
                              notifier.removeFromCart(context, productId);
                            },
                            addTap: () {
                              notifier.addToCart(context,
                                LocalCartProduct(
                                  id: productId,
                                  name: productName,
                                  price: productPrice,
                                  image: productImage,
                                  description: productDescription,
                                  images: productListImages,
                                ),
                              );
                            },
                            deleteFromCart: () {
                              notifier.deleteFromCart(context, productId);
                            },
                          ),
                        );
                      },
                      itemCount:
                      isAuth ? state.cartProduct?.data?.length :
                      LocalStorage.instance.getLocalCart().length,
                    ),
                  ),
                  SliverPadding(padding: EdgeInsets.only(bottom: 120.h)),
                ],
              ),
            )
          ),

          if (!isCartListEmpty(state))
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomBar(state),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(state) {
    final isAuth = LocalStorage.instance.isAuthenticated();
    final int totalProducts = isAuth
        ? (state.cartProduct?.totalProducts ?? 0)
        : LocalStorage.instance.getLocalCartTotalQuantity();
    final double totalPrice = isAuth
        ? (state.cartProduct?.totalPrice ?? 0)
        : LocalStorage.instance.getLocalCartTotalPrice();

    return Container(
      //margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h + MediaQuery.of(context).padding.bottom),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${AppLocalization.getText(context)?.total}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '${AppMoneyFormatter.longFormatString(totalPrice.toString())} UZS',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '$totalProducts '
                  '${totalProducts == 1
                      ? AppLocalization.getText(context)?.product
                      : AppLocalization.getText(context)?.products}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: CustomButtonWidget(
              title: "${AppLocalization.getText(context)?.checkout}",
              isLoading: false,
              onTap: () {
                // Проверяем авторизацию перед переходом на checkout
                if (isAuth) {
                  AppNavigator.push(const CheckOutRoute());
                } else {
                  // AppHelpers.showErrorToast(errorMessage: "Please sign in to continue");
                  AppNavigator.push(SignInRoute(redirectFromCart: true));
                }
                //
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isCartListEmpty(CartState state) {
    if (LocalStorage.instance.isAuthenticated()) {
      return state.cartProduct?.data?.isEmpty != false;
    } else {
      return LocalStorage.instance.getLocalCart().isEmpty;
    }
  }
}
