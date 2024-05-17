import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';

class CartListItemWidget extends StatelessWidget {
  final String? image;
  final String? name;
  final String? price;
  final int? qty;
  final Function() removeTap;
  final Function() addTap;
  final Function() deleteFromCart;

  const CartListItemWidget({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.qty,
    required this.removeTap,
    required this.addTap,
    required this.deleteFromCart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading: Container(
            width: 70.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Image.network(image ??
                "https://t4.ftcdn.net/jpg/03/16/15/47/360_F_316154790_pnHGQkERUumMbzAjkgQuRvDgzjAHkFaQ.jpg"),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? ""),
                    Text("\$$price" ?? ""),
                  ],
                ),
              ),

              Container(
                // margin: EdgeInsets.only(bottom: 20),
                height: 40.h,
                //width: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        removeTap();
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text(
                      "$qty",
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    IconButton(onPressed: () {
                      addTap();
                    }, icon: const Icon(Icons.add)),
                  ],
                ),
              ),
            ],
          ),
          //subtitle: Text("PRice"),
          trailing: IconButton(
              onPressed: () {
                deleteFromCart();
              },
              icon: const Icon(
                Icons.delete_outline,
                size: 32,
                color: Colors.red,
              )),
          tileColor: Colors.white,
        ),
      ),
    );
  }
}
