import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/all_adresses_response.dart';

import '../../../../../core/imports/imports.dart';
import '../../../../../service/localizations/localization.dart';

class UserAddressesModal extends ConsumerWidget {
  const UserAddressesModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cartProvider);
    final notifier = ref.read(cartProvider.notifier);
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.userAllAddresses?.addresses?.isNotEmpty ?? false) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${AppLocalization.getText(context)?.saved_addresses}",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: state.userAllAddresses?.addresses?.length ?? 0,
                itemBuilder: (context, index) {
                  final address = state.userAllAddresses?.addresses?[index];
                  return CupertinoListTile(
                    onTap: () {
                      if (address != null) {
                        notifier.selectUserAddress(address);
                        notifier.removeErrorMessage();
                        AppNavigator.pop();
                      }
                    },
                    title: Text(
                        "${index+1}. ${address?.districtName}, ${address?.addressLine1}"),
                    trailing: CupertinoRadio(
                        value: address,
                        groupValue: state.selectedUserAddress,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: Colors.grey.shade300,
                        onChanged: (value) {
                          notifier.selectUserAddress(value ?? Address());
                        }),
                  );
                }),
          ] else
            emptyAddressWidget(context)
        ],
      ),
    );
  }
}

Widget emptyAddressWidget(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        spacing: 10,
        children: [
          Text(
            "${AppLocalization.getText(context)?.no_saved_addresses}",
            style: TextStyle(fontSize: 14.sp),
          ),
          ElevatedButton.icon(
            style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(AppColors.primaryColor)),
            onPressed: () {
              AppNavigator.pop();
              AppNavigator.push(const UserAddressesRoute());
            },
            icon: const Icon(Icons.add),
            label: Text(
              "${AppLocalization.getText(context)?.add_address}",
              style: TextStyle(fontSize: 14.sp),
            ),
          )
        ],
      ));
}
