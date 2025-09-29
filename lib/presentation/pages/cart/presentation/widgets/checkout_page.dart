import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/money_formatter.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/widgets/selection_field_widget.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/widgets/user_addresses_modal.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/provider/main_provider.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/all_adresses_response.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

@RoutePage()
class CheckOutPage extends ConsumerStatefulWidget {
  const CheckOutPage({super.key});

  @override
  ConsumerState<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends ConsumerState<CheckOutPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final notifier = ref.read(cartProvider.notifier);
      final state = ref.watch(cartProvider);
      final profileNotifier = ref.read(profileProvider.notifier);
      final profileState = ref.watch(profileProvider);
      state.userAllAddresses ?? notifier.getAllAddresses();
      profileState.userAllAddresses ?? profileNotifier.getAllAddresses();
      profileState.userInfo ?? profileNotifier.getUserInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final notifier = ref.read(cartProvider.notifier);
    final state = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("${AppLocalization.getText(context)?.checkout}"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          spacing: 12,
          children: [
            SelectionFieldWidget(
              onTap: () {
                AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
                    context: context,
                    modal: const UserAddressesModal());
              },
              title: "${AppLocalization.getText(context)?.address}",
              value: "${state.selectedUserAddress?.districtName ?? ""} ${state.selectedUserAddress?.addressLine1 ?? ""}",
              errorMessage: state.errorMessage,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${AppLocalization.getText(context)?.payment_type}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => notifier.togglePaymentType('cash'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: state.paymentType == 'cash' ? AppColors.primaryColor : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(blurRadius: 6, color: Colors.black12),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.attach_money, size: 28.sp, color: state.paymentType == 'cash' ? AppColors.primaryColor : Colors.black87),
                          8.verticalSpace,
                          Text("${AppLocalization.getText(context)?.cash}")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => notifier.togglePaymentType('card'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: state.paymentType == 'card' ? AppColors.primaryColor : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(blurRadius: 6, color: Colors.black12),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.credit_card, size: 28.sp, color: state.paymentType == 'card' ? AppColors.primaryColor : Colors.black87),
                          8.verticalSpace,
                          Text("${AppLocalization.getText(context)?.card}")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${AppLocalization.getText(context)?.delivery_type}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => notifier.toggleDeliveryType('pick_up'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: state.deliveryType == 'pick_up' ? AppColors.primaryColor : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(blurRadius: 6, color: Colors.black12),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.store_mall_directory, size: 28.sp, color: state.deliveryType == 'pick_up' ? AppColors.primaryColor : Colors.black87),
                          8.verticalSpace,
                          Text("${AppLocalization.getText(context)?.pick_up}")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => notifier.toggleDeliveryType('courier'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: state.deliveryType == 'courier' ? AppColors.primaryColor : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(blurRadius: 6, color: Colors.black12),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_shipping, size: 28.sp, color: state.deliveryType == 'courier' ? AppColors.primaryColor : Colors.black87),
                          8.verticalSpace,
                          Text("${AppLocalization.getText(context)?.courier}")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),



            CustomTextField(
              controller: notifier.orderCommentController,
              title: "${AppLocalization.getText(context)?.comment}",
              labelText: "${AppLocalization.getText(context)?.comment_to_seller}",
              errorText: AppTextFieldErrorsStatus.status(state.errorMessage, "comment"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        height: 120.h,
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${AppLocalization.getText(context)?.total}:",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "${AppMoneyFormatter.longFormatString(state.cartProduct?.totalPrice.toString())} UZS",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            12.verticalSpace,
            CustomButtonWidget(
                title: "${AppLocalization.getText(context)?.create_an_order}",
                isLoading: state.isLoading,
                onTap: () {
                  if((state.paymentType.isEmpty) || (state.deliveryType.isEmpty)){
                    AppHelpers.showErrorToast(errorMessage: "${AppLocalization.getText(context)?.fill_all_fields}");
                    return;
                  }
                  if(state.selectedUserAddress?.id != null && state.selectedUserAddress?.id != 0) {
                    notifier.createOrder(
                        context: context,
                        addressID: state.selectedUserAddress?.id ?? 0,
                        success: (){
                          AppHelpers.showSuccessToast(message: "${AppLocalization.getText(context)?.order_successfully_created}");
                          notifier.selectUserAddress(Address());
                          notifier.togglePaymentType("");
                          notifier.toggleDeliveryType("");
                          AppNavigator.pushAndPopUntil(const MainRoute());
                          ref.read(mainProvider(0).notifier).incrementPageIndex(0);
                        }
                    );
                  } else {
                    AppHelpers.showErrorToast(errorMessage: "${AppLocalization.getText(context)?.select_an_address_before_saving}");
                  }
                })
          ],
        ),
      ),
    );
  }
}
