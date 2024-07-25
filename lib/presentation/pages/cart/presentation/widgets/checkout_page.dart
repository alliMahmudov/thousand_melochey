import 'package:thousand_melochey/core/imports/imports.dart';

@RoutePage()
class CheckOutPage extends ConsumerStatefulWidget {
  const CheckOutPage({super.key});

  @override
  ConsumerState<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends ConsumerState<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(cartProvider.notifier);
    final state = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            18.verticalSpace,
            CustomTextField(
              controller: notifier.phoneController,
              title: "Phone",
              labelText: "Enter your phone number*",
              errorText:
                  AppTextFieldErrorsStatus.status(state.errorMessage, "phone"),
              keyboardType: TextInputType.phone,
            ),
            12.verticalSpace,
            CustomTextField(
              controller: notifier.addressController,
              title: "Address",
              labelText: "Enter your address*",
              errorText: AppTextFieldErrorsStatus.status(
                  state.errorMessage, "address"),
            ),
            12.verticalSpace,
            CustomTextField(
              controller: notifier.cityController,
              title: "City",
              labelText: "Enter your city*",
              errorText:
                  AppTextFieldErrorsStatus.status(state.errorMessage, "City"),
            ),
            12.verticalSpace,
            CustomTextField(
              controller: notifier.postalCodeController,
              title: "Postal code",
              labelText: "Enter your postal code*",
              errorText: AppTextFieldErrorsStatus.status(
                  state.errorMessage, "Postal code"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        height: 120.h,
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 1, color: Colors.black12)]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "\$${state.cartProduct?.totalPrice}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            12.verticalSpace,
            CustomButtonWidget(
                title: "Create an order",
                isLoading: state.isLoading,
                onTap: () {
                 print("12");
                 notifier.fillAddress(
                     context: context,
                     success: () {
                       notifier.createOrder(success: () {
                         showDialog(
                             context: context,
                             builder: (context) {
                               return Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: AlertDialog.adaptive(
                                   title: const Text(
                                     "Order successfully created",
                                     style: TextStyle(fontSize: 18),
                                   ),
                                   content: const Padding(
                                     padding: EdgeInsets.all(8.0),
                                     child: Text("Our staff will contact you soon"),
                                   ),
                                   actions: [
                                     Material(
                                       child: InkWell(
                                         onTap: () => AppNavigator.pushAndPopUntil(const MainRoute()),
                                         child: Container(
                                           padding: const EdgeInsets.all(12),
                                           color: AppColors.primaryColor,
                                           height: 50,
                                           alignment: Alignment.center,
                                           child: const Text(
                                             "Back to shopping",
                                             style: TextStyle(
                                                 color: AppColors.white,
                                                 fontWeight: FontWeight.bold),
                                           ),
                                         ),
                                       ),
                                     )
                                   ],
                                   actionsPadding: const EdgeInsets.all(20),
                                 ),
                               );
                             });
                       });
                     });
                  /*AppHelpers.showCustomAlertDialog(
                context: context,
                title:
                "Order Created Successfully",
                content:
                "Order Created Successfully",
                actions: [
                  SizedBox(
                    height: 35.h,
                    child: OutlinedButton(
                      onPressed: () {
                        AppNavigator.pop();

                        AppNavigator.pushAndPopUntil(
                          const MainRoute(),
                        );
                      },
                      child: const Text(
                        "back to shopping",
                        style: TextStyle(
                            color:AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              );*/
                })
          ],
        ),
      ),
    );
  }
}
