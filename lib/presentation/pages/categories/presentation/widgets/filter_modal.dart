import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/provider/categories_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

class FilterModal extends ConsumerWidget {
  final int categoryId;
  const FilterModal({
    required this.categoryId,
    super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(categoriesProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppLocalization.getText(context)?.filter_by_price}",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                  onTap: () {
                    notifier.filterMaxPrice.clear();
                    notifier.filterMinPrice.clear();
                  },
                  child: const Icon(CupertinoIcons.restart))
            ],
          ),
          12.verticalSpace,
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: notifier.filterMinPrice,
                  title: "${AppLocalization.getText(context)?.from}",
                  labelText: "0",
                  keyboardType: TextInputType.number,
                ),
              ),

              Expanded(
                child: CustomTextField(
                  controller: notifier.filterMaxPrice,
                  title: "${AppLocalization.getText(context)?.to}",
                  labelText: "0",
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          24.verticalSpace,
          CustomButtonWidget(
            title: "${AppLocalization.getText(context)?.apply}",
            isLoading: false,
            isDisabled: false,
            onTap: () {
              notifier.getCategoryProducts(
                  categoryId: categoryId,
                  isRefresh: true,
                  success: (){
                    AppNavigator.pop();
                  }
              );
            },
          ),
          16.verticalSpace,
        ],
      ),
    );
  }
}
