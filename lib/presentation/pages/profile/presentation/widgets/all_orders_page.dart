import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:thousand_melochey/core/extension/int_extensions.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/empty_page_template.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_order_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/presentation/widgets/order_contact_info_widget.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

@RoutePage()
class AllOrdersPage extends ConsumerStatefulWidget {
  const AllOrdersPage({super.key});

  @override
  ConsumerState<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends ConsumerState<AllOrdersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(cartProvider.notifier).getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    final state = ref.watch(cartProvider);
    final active = state.getOrders?.activeOrders ?? const <Order>[];
    final finished = state.getOrders?.finishedOrders ?? const <Order>[];
    final isActiveTab = state.selectedOrderTab == 0;
    final list = isActiveTab ? active : finished;

    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalization.getText(context)?.orders}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.sp),
            child: Row(
              spacing: 14,
              children: [
                Expanded(
                  child: _OrderTabChip(
                    label: '${AppLocalization.getText(context)?.active}',
                    selected: notifier.isSelectedTab(0),
                    onTap: () => notifier.selectOrderTab(0),
                  ),
                ),
                Expanded(
                  child: _OrderTabChip(
                    label: '${AppLocalization.getText(context)?.finished}',
                    selected: notifier.isSelectedTab(1),
                    onTap: () => notifier.selectOrderTab(1),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => notifier.getOrders(),
              child: CustomShimmerEffect(
                isLoading: state.isLoading,
                child: _OrdersListBody(
                  orders: list,
                  emptyTitle: isActiveTab
                      ? '${AppLocalization.getText(context)?.you_have_no_active_orders}'
                      : '${AppLocalization.getText(context)?.you_have_no_finished_orders}',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderTabChip extends StatelessWidget {
  const _OrderTabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          color: selected ? AppColors.primaryColor : AppColors.white,
          border: Border.all(color: AppColors.primaryColor, width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.white : AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _OrdersListBody extends StatelessWidget {
  const _OrdersListBody({
    required this.orders,
    required this.emptyTitle,
  });

  final List<Order> orders;
  final String emptyTitle;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 0.2.sh),
          EmptyPageTemplate(
            icon: CupertinoIcons.tray,
            title: emptyTitle,
          ),
        ],
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 16.h),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final lang = AppLocalization.getText(context);
        final productQty = "${order.items?.length} ${order.items?.length.plural(
          one: "${lang?.product}",
          few: "${lang?.products}",
          many: "${lang?.many_products}",
        )}";
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primaryColor.withAlpha(150)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${lang?.order_status}",
                            style: TextStyle(
                                fontSize: 12.sp, color: Colors.black54),
                          ),
                          4.verticalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withAlpha(28),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "${order.orderStatus}",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    8.verticalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${lang?.order_id}",
                            style: TextStyle(
                                fontSize: 12.sp, color: Colors.black54),
                          ),
                          4.verticalSpace,
                          Text(
                            "${order.orderNumber}",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${lang?.order_created_at}",
                      style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss').format(order.date?.toLocal() ?? DateTime.now()),
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                6.verticalSpace,
                OrderContactInfoWidget(
                    title: "${lang?.address}",
                    subTitle: order.address != null
                        ? "${order.address?.city}, ${order.address?.districtName}, ${order.address?.addressLine1}"
                        : "${lang?.shop_address}",
                    icon: CupertinoIcons.location_solid),
                6.verticalSpace,
                OrderContactInfoWidget(title: "${lang?.phone_number}",
                    subTitle: "NONE{}",
                    icon: CupertinoIcons.phone_fill,
                ),
                if (orders.isNotEmpty) ...[
                  8.verticalSpace,
                  Divider(height: 1, color: Colors.grey.shade300),
                  8.verticalSpace,
                  SizedBox(
                    height: 130.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: order.items?.length ?? 0,
                      separatorBuilder: (_, __) => SizedBox(width: 10.w),
                      itemBuilder: (context, index) {
                        final product = order.items?[index].product;
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.r),
                            onTap: () {
                              AppNavigator.push(
                                ProductDetailRoute(
                                  id: product?.id,
                                  name: product?.name,
                                  price: AppMoneyFormatter.longFormatString(
                                      product?.finalPriceUzs),
                                  description: product?.description,
                                  image: product?.image,
                                  images: product?.images,
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 96.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: product?.image?.isEmpty ??
                                                  false
                                              ? ColoredBox(
                                                  color: Colors.grey.shade200,
                                                  child: Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      color:
                                                          Colors.grey.shade500),
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: "${product?.image}",
                                                  fit: BoxFit.fill,
                                                  placeholder: (_, __) =>
                                                      ColoredBox(
                                                    color: Colors.grey.shade200,
                                                    child: const Center(
                                                      child: SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                                strokeWidth: 2),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (_, __, ___) =>
                                                      ColoredBox(
                                                    color: Colors.grey.shade200,
                                                    child: Icon(
                                                        Icons
                                                            .broken_image_outlined,
                                                        color: Colors
                                                            .grey.shade500),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6.w, vertical: 2.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Text(
                                            '${AppLocalization.getText(context)?.order_qty ?? ''}: 1',
                                            style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  6.verticalSpace,
                                  Text(
                                    '${AppMoneyFormatter.longFormatString(product?.finalPriceUzs)} UZS',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$productQty ▪ ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${AppMoneyFormatter.longFormatString(order.totalPrice)} UZS',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
