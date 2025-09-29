import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/empty_page_template.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/widgets/cart_list_item_widget.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/provider/main_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

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
      notifier.getCartProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    final state = ref.watch(cartProvider);
    
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
          if (state.cartProduct?.data?.isNotEmpty ?? false)
            IconButton(
              onPressed: () {
                AppHelpers.showCustomAlertDialog(context: context,
                    title: "${AppLocalization.getText(context)?.clear_cart}",
                    actionButtonText: "${AppLocalization.getText(context)?.confirm}",
                    onTap: (){
                  AppNavigator.pop();
                  notifier.clearCart(
                    success: (){
                      notifier.getCartProducts();
                    }
                  );
                });
              },
              icon: Icon(
                CupertinoIcons.trash,
                size: 20.sp,
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          CustomShimmerEffect(
            isLoading: state.isLoading,
            leaf: false,
            child: state.cartProduct?.data?.isEmpty != false
                ? EmptyPageTemplate(
              icon: CupertinoIcons.shopping_cart,
              title: "${AppLocalization.getText(context)?.empty_cart}",
            ) : RefreshIndicator(
              onRefresh: () => notifier.getCartProducts(),
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
                        final productId = cartProduct?.product?.id ?? 0;
                        final isPending = notifier.isPendingOperation(productId);

                        return InkWell(
                          onTap: (){
                            AppNavigator.push(
                                ProductDetailRoute(
                                    id: cartProduct?.product?.id,
                                    name: cartProduct?.product?.name,
                                    price: cartProduct?.product?.price,
                                    description: cartProduct?.product?.description,
                                    image: cartProduct?.product?.image,
                                    images: cartProduct?.product?.images
                                ));
                          },
                          child: CartListItemWidget(
                            image: cartProduct?.product?.image,
                            name: cartProduct?.product?.name,
                            price: cartProduct?.product?.price,
                            qty: cartProduct?.quantity,
                            isLoading: isPending,
                            removeTap: () {
                              notifier.removeFromCart(
                                context: context,
                                id: productId,
                                success: () {
                                  notifier.getCartProducts();
                                },
                              );
                            },
                            addTap: () {
                              notifier.addToCart(
                                context: context,
                                id: productId,
                                success: () {
                                  notifier.getCartProducts();
                                },
                              );
                            },
                            deleteFromCart: () {
                              notifier.deleteFromCart(
                                id: productId,
                                context: context,
                                success: () {
                                  notifier.getCartProducts();
                                },
                              );
                            },
                          ),
                        );
                      },
                      itemCount: state.cartProduct?.data?.length,
                    ),
                  ),
                  SliverPadding(padding: EdgeInsets.only(bottom: 120.h)),
                ],
              ),
            )
          ),

          if (state.cartProduct?.data?.isNotEmpty == true)
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
                  '${AppMoneyFormatter.longFormatString(state.cartProduct?.totalPrice.toString())} UZS',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '${state.cartProduct?.totalProducts} ${(state.cartProduct?.totalProducts == 1
                      ? AppLocalization.getText(context)?.product
                      : AppLocalization.getText(context)?.products)}',
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
                AppNavigator.push(const CheckOutRoute());
              },
            ),
          ),
        ],
      ),
    );
  }
}
