import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/custom_shimmer_effect.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

@RoutePage()
class AllOrdersPage extends ConsumerStatefulWidget {
  const AllOrdersPage({super.key});

  @override
  ConsumerState<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends ConsumerState<AllOrdersPage> with TickerProviderStateMixin{

  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final notifier = ref.read(cartProvider.notifier);
      notifier.getOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    final state = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocalization.getText(context)?.orders}"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return notifier.getOrders();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: DefaultTabController(
                length: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.0.sp),
                  child: Row(
                    spacing: 14,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            notifier.selectOrderTab(0);
                            tabController.animateTo(0, duration: const Duration(milliseconds: 200));
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              color: notifier.isSelectedTab(0) ? AppColors.primaryColor : AppColors.white,
                              border: Border.all(color: AppColors.primaryColor, width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Text("${AppLocalization.getText(context)?.active}", style: TextStyle(
                              color: notifier.isSelectedTab(0) ? AppColors.white : AppColors.primaryColor,
                              fontWeight: FontWeight.w600
                            ),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            notifier.selectOrderTab(1);
                            tabController.animateTo(1, duration: const Duration(milliseconds: 200));
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              color: notifier.isSelectedTab(1) ? AppColors.primaryColor : AppColors.white,
                              border: Border.all(color: AppColors.primaryColor, width: 1),
                            ),
                            alignment: Alignment.center,
                            child: Text("${AppLocalization.getText(context)?.finished}", style: TextStyle(
                                color: notifier.isSelectedTab(1) ? AppColors.white : AppColors.primaryColor,
                                fontWeight: FontWeight.w600
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomShimmerEffectSliver(
              isLoading: state.isLoading,
              child: SliverFillRemaining(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      ListView.builder(
                          itemCount: state.getOrders?.activeOrders?.length,
                          itemBuilder: (context, index){
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                //color: Colors.white,
                                border: Border.all(color: AppColors.primaryColor.withAlpha(150))
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // ListTile(
                                  //   tileColor: Colors.yellow,
                                  //   title: Text("Order id: ${state.getOrders?.activeOrders?[index].id}"),
                                  //   trailing: Text("\$${state.getOrders?.activeOrders?[index].totalPrice}"),
                                  // ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.black12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${AppLocalization.getText(context)?.order_id}: ${state.getOrders?.activeOrders?[index].id}"),
                                        Text(AppMoneyFormatter.longFormatString("${state.getOrders?.activeOrders?[index].totalPrice} UZS")),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: (52 * (state.getOrders?.activeOrders?[index].items?.length ?? 0)).toDouble(),
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state.getOrders?.activeOrders?[index].items?.length,
                                        itemBuilder: (context, itemIndex){
                                      return ListTile(
                                        contentPadding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 12.sp),
                                        minTileHeight: 40,
                                        leading: Container(
                                            height: 35.sp,
                                            width: 35.sp,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.r),
                                              border: Border.all(color: AppColors.red.withAlpha(100)),
                                              image: DecorationImage(
                                                  image: NetworkImage("${state.getOrders?.activeOrders?[index].items?[itemIndex].product?.image}",), fit: BoxFit.fill)
                                            )),
                                        title: Text("${state.getOrders?.activeOrders?[index].items?[itemIndex].product?.name}", style: const TextStyle(color: Colors.red),),
                                        subtitle: Text("${AppLocalization.getText(context)?.order_qty}: ${state.getOrders?.activeOrders?[index].items?[itemIndex].quantity}"),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            );
                          }),
                      ListView.builder(
                          itemCount: state.getOrders?.finishedOrders?.length,
                          itemBuilder: (context, index){
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  //color: Colors.white,
                                  border: Border.all(color: AppColors.primaryColor.withAlpha(150))
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // ListTile(
                                  //   tileColor: Colors.yellow,
                                  //   title: Text("Order id: ${state.getOrders?.activeOrders?[index].id}"),
                                  //   trailing: Text("\$${state.getOrders?.activeOrders?[index].totalPrice}"),
                                  // ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.black12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${AppLocalization.getText(context)?.order_id}: ${state.getOrders?.finishedOrders?[index].id}"),
                                        Text("\$${state.getOrders?.finishedOrders?[index].totalPrice}"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 52 * (state.getOrders?.finishedOrders?[index].items?.length)!.toDouble(),
                                    child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state.getOrders?.finishedOrders?[index].items?.length,
                                        itemBuilder: (context, itemIndex){
                                          return ListTile(
                                            contentPadding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 12.sp),
                                            minTileHeight: 40,
                                            leading: Container(
                                                height: 35.sp,
                                                width: 35.sp,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.r),
                                                    border: Border.all(color: AppColors.red.withAlpha(100)),
                                                    image: DecorationImage(
                                                        image: NetworkImage("${state.getOrders?.finishedOrders?[index].items?[itemIndex].product?.image}",), fit: BoxFit.fill)
                                                )),
                                            title: Text("${state.getOrders?.finishedOrders?[index].items?[itemIndex].product?.name}", style: const TextStyle(color: Colors.red),),
                                            subtitle: Text("${AppLocalization.getText(context)?.order_qty}: ${state.getOrders?.finishedOrders?[index].items?[itemIndex].quantity}"),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            );
                          }),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
