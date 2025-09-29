import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/contstants/app_assets.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';

class CartListItemWidget extends StatelessWidget {
  final String? image;
  final String? name;
  final String? price;
  final int? qty;
  final Function() removeTap;
  final Function() addTap;
  final Function() deleteFromCart;
  final bool isLoading;

  const CartListItemWidget({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.qty,
    required this.removeTap,
    required this.addTap,
    required this.deleteFromCart,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: FadeInImage.assetNetwork(
                      placeholder: AppAssets.emptyImagePlaceHolder,
                      image: image ?? AppAssets.emptyImagePlaceHolder,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          CupertinoIcons.photo,
                          color: Colors.grey[400],
                          size: 30.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                
                16.horizontalSpace,
                
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        name ?? "",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      8.verticalSpace,
                      
                      // Price
                      Text(
                        "${AppMoneyFormatter.longFormatString(price) ?? ""} UZS",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      
                      12.verticalSpace,
                      
                      // Quantity Controls
                      Row(
                        children: [
                          Text(
                            'Quantity:',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // Quantity Counter
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Decrease Button
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20.r),
                                    onTap: isLoading ? null : removeTap,
                                    child: Container(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Icon(
                                        Icons.remove,
                                        size: 18.sp,
                                        color: isLoading ? Colors.grey : AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Quantity Display
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Text(
                                    "$qty",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                
                                // Increase Button
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20.r),
                                    onTap: isLoading ? null : addTap,
                                    child: Container(
                                      padding: EdgeInsets.all(8.sp),
                                      child: Icon(
                                        Icons.add,
                                        size: 18.sp,
                                        color: isLoading ? Colors.grey : AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                12.horizontalSpace,
                
                // Delete Button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: isLoading ? null : deleteFromCart,
                    child: Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        CupertinoIcons.trash,
                        size: 18.sp,
                        color: isLoading ? Colors.grey : Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Overlay для состояния загрузки
          if (isLoading)
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
