import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_order_response.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

class OrdersWidget extends StatefulWidget {
  final String id;
  final String totalPrice;
  final int ordersLength;
  final Order? ordersData;

  const OrdersWidget({
  required this.id,
  required this.totalPrice,
  required this.ordersLength,
  required this.ordersData,
  super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.black12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${AppLocalization.getText(context)?.order_id}: ${widget.id}"),
                Text("\$${widget.totalPrice}"),
              ],
            ),
          ),
          SizedBox(
            height: 52 * (widget.ordersLength).toDouble(),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.ordersLength,
                itemBuilder: (context, index){
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
                                image: NetworkImage("${widget.ordersData?.items?[index].product?.image}",), fit: BoxFit.fill)
                        )),
                    title: Text("${widget.ordersData?.items?[index].product?.name}", style: const TextStyle(color: Colors.red),),
                    subtitle: Text("${AppLocalization.getText(context)?.order_qty}: ${widget.ordersData?.items?[index].quantity}"),
                  );
                }),
          )
        ],
      ),
    );
  }
}
