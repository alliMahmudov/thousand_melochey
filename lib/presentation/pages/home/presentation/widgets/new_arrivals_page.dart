import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_order_response.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/widgets/optimized_product_item.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

import '../../data/new_products_response.dart';

@RoutePage()
class NewArrivalsPage extends ConsumerWidget {
  final List<Result> newProducts;

  const NewArrivalsPage({
    super.key,
    required this.newProducts,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteState = ref.watch(favoritesProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("${AppLocalization.getText(context)?.new_arrivals}",),
      ),
      body: newProducts.isEmpty
          ? Center(
              child: Text(
                AppLocalization.getText(context)?.product_not_available ?? 'Товары отсутствуют',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.all(8.w),
              child: CustomScrollView(
                slivers: [
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0.h,
                      mainAxisSpacing: 10.0.h,
                      childAspectRatio: .585,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final product = newProducts[index];
                        return InkWell(
                          onTap: () {
                            AppNavigator.push(
                              ProductDetailRoute(
                                id: product.id,
                                name: product.name,
                                price: product.finalPriceUzs,
                                description: product.description,
                                image: product.image,
                                images: product.images,
                              ),
                            );
                          },
                          child: OptimizedProductItem(product: product),
                        );
                      },
                      childCount: newProducts.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
