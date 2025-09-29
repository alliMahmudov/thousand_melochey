import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_districts_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/presentation/widgets/user_address_widget.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

import '../../../../../core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/all_adresses_response.dart';

@RoutePage()
class UserAddressesPage extends ConsumerStatefulWidget {
  const UserAddressesPage({super.key});

  @override
  ConsumerState<UserAddressesPage> createState() => _UserAddressesPageState();
}

class _UserAddressesPageState extends ConsumerState<UserAddressesPage> with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final notifier = ref.read(profileProvider.notifier);
      final state = ref.watch(profileProvider);
      state.districts ?? notifier.getDistricts();
      state.userAllAddresses ?? notifier.getAllAddresses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text("${AppLocalization.getText(context)?.my_addresses}"),
      ),
      body: RefreshIndicator(
        onRefresh: (){
          return notifier.getAllAddresses();
        },
        child: CustomScrollView(

          slivers: [
            if (state.isLoading)
              CustomShimmerEffectSliver(
                isLoading: state.isLoading,
                child: SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  sliver: SliverList.separated(
                    itemCount: 3,
                    separatorBuilder: (_, __) => 12.verticalSpace,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(14.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 44.r,
                              height: 44.r,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.location_pin,
                                color: AppColors.primaryColor,
                                size: 22.sp,
                              ),
                            ),
                            12.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 6.h,
                                children: [
                                  Text(
                                    "Street name",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.building_2_fill,
                                        size: 16.sp,
                                        color: Colors.grey.shade600,
                                      ),
                                      6.horizontalSpace,
                                      Flexible(
                                        child: Text(
                                          "City, District",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            8.horizontalSpace,
                            Icon(
                              CupertinoIcons.chevron_right,
                              size: 18.sp,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

            if (!state.isLoading &&
                (state.userAllAddresses?.addresses == null || (state.userAllAddresses?.addresses?.isEmpty ?? false)))
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 12.h,
                      children: [
                        Container(
                          width: 90.r,
                          height: 90.r,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                              Icons.location_on_rounded,
                              color: AppColors.primaryColor,
                              size: 36.sp,
                          ),
                        ),
                        Text(
                          "${AppLocalization.getText(context)?.no_saved_addresses}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            if (!state.isLoading && (state.userAllAddresses?.addresses?.isNotEmpty ?? false))
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                sliver: SliverList.separated(
                  itemCount: state.userAllAddresses?.addresses?.length,
                  separatorBuilder: (_, __) => 12.verticalSpace,
                  itemBuilder: (context, index) {
                    final address = state.userAllAddresses?.addresses?[index];
                    return UserAddressWidget(
                      address: address,
                      deleteOnTap: () {
                        notifier.deleteAddress(
                            addressID: address?.id ?? 0,
                            success: () { notifier.getAllAddresses(); },
                        );
                      },
                      editOnTap: () {
                        if (address == null) return;
                        _showEditAddressDialog(context, address);
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final notifier = ref.read(profileProvider.notifier);
          // Always open add dialog with empty fields
          notifier.streetNameController.clear();
          notifier.selectDistrict(District());
          _showAddAddressDialog(context);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    AppHelpers.showCustomAlertDialog(
      actionButtonText: "${AppLocalization.getText(context)?.save}",
      content: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final districtNotifier = ref.read(profileProvider.notifier);
          final districtState = ref.watch(profileProvider);
          
          return Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: districtNotifier.streetNameController, 
                title: "${AppLocalization.getText(context)?.address}", 
                labelText: "${AppLocalization.getText(context)?.street_address}"
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    "${AppLocalization.getText(context)?.district}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (districtState.districts?.data?.districts != null &&
                          districtState.districts!.data!.districts!.isNotEmpty) {
                         _showDistrictPicker(context, districtNotifier, districtState);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            districtState.selectedDistrict?.name ?? "${AppLocalization.getText(context)?.select_district}",
                            style: TextStyle(
                              color: districtState.selectedDistrict != null
                                  ? Colors.black
                                  : Colors.grey.shade600,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      context: context,
      onTap: () {
        final currentState = ref.read(profileProvider);
        final notifier = ref.read(profileProvider.notifier);

        if (notifier.streetNameController.text.isNotEmpty && currentState.selectedDistrict != null) {
          AppNavigator.pop();
          notifier.addingNewAddress(
            streetName: notifier.streetNameController.text.trim(),
            districtID: currentState.selectedDistrict!.id!,
            success: () {
              notifier.streetNameController.clear();
              notifier.selectDistrict(District());

              notifier.getAllAddresses(
                success: (){
                  ref.read(cartProvider.notifier).getAllAddresses();
                }
              );
              AppHelpers.showSuccessToast(message: "${AppLocalization.getText(context)?.address_added_successfully}");
            },
          );
        } else {
          AppHelpers.showErrorToast(errorMessage: "${AppLocalization.getText(context)?.fill_all_fields}");
        }
      },
    );
  }

  void _showEditAddressDialog(BuildContext context, Address address) {
    // Prefill current values
    final notifier = ref.read(profileProvider.notifier);
    final state = ref.read(profileProvider);

    notifier.streetNameController.text = address.addressLine1 ?? '';

    // Preselect district if available
    final districts = state.districts?.data?.districts ?? [];
    final matchedDistrict = districts.firstWhere(
      (d) => d.id == address.districtIdRead,
      orElse: () => District(),
    );
    notifier.selectDistrict(matchedDistrict);

    AppHelpers.showCustomAlertDialog(
      actionButtonText: "${AppLocalization.getText(context)?.save}",
      content: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final districtNotifier = ref.read(profileProvider.notifier);
          final districtState = ref.watch(profileProvider);

          return Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                  controller: districtNotifier.streetNameController,
                  title: "${AppLocalization.getText(context)?.address}",
                  labelText: "${AppLocalization.getText(context)?.street_address}"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    "${AppLocalization.getText(context)?.district}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (districtState.districts?.data?.districts != null &&
                          districtState.districts!.data!.districts!.isNotEmpty) {
                        _showDistrictPicker(context, districtNotifier, districtState);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            districtState.selectedDistrict?.name ?? "${AppLocalization.getText(context)?.select_district}",
                            style: TextStyle(
                              color: districtState.selectedDistrict != null
                                  ? Colors.black
                                  : Colors.grey.shade600,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      context: context,
      onTap: () {
        final currentState = ref.read(profileProvider);
        final notifier = ref.read(profileProvider.notifier);

        if (notifier.streetNameController.text.isNotEmpty && currentState.selectedDistrict != null) {
          AppNavigator.pop();
          notifier.changeAddress(
            addressID: address.id ?? 0,
            streetName: notifier.streetNameController.text.trim(),
            districtID: currentState.selectedDistrict!.id!,
            success: () {
              notifier.streetNameController.clear();
              notifier.selectDistrict(District());

              notifier.getAllAddresses(success: () {
                ref.read(cartProvider.notifier).getAllAddresses();
              });
              AppHelpers.showSuccessToast(message: "Address updated");
            },
          );
        } else {
          AppHelpers.showErrorToast(errorMessage: "${AppLocalization.getText(context)?.fill_all_fields}");
        }
      },
    );
  }

  void _showDistrictPicker(BuildContext context, ProfileNotifier notifier, ProfileState state) {
    int selectedIndex = 0;

    // Найти индекс выбранного района
    if (state.selectedDistrict != null) {
      final districts = state.districts?.data?.districts ?? [];
      for (int i = 0; i < districts.length; i++) {
        if (districts[i].id == state.selectedDistrict!.id) {
          selectedIndex = i;
          break;
        }
      }
    }

    return AppHelpers.showCustomModalBottomSheetWithoutIosIcon(context: context, modal: Container(
      height: 300,
      padding: EdgeInsets.all(6.0.sp),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text('${AppLocalization.getText(context)?.cancel}', style: const TextStyle(color: Colors.black),),
                  onPressed: () => AppNavigator.pop(),
                ),
                TextButton(
                  child: Text('${AppLocalization.getText(context)?.save}', style: const TextStyle(color: AppColors.primaryColor),),
                  onPressed: () {
                    final districts = state.districts?.data?.districts ?? [];
                    if (districts.isNotEmpty) {
                      notifier.selectDistrict(districts[selectedIndex]);
                    }
                    AppNavigator.pop();
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoPicker(
                magnification: 1.2,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 32.0,
                scrollController: FixedExtentScrollController(initialItem: selectedIndex),
                onSelectedItemChanged: (int selectedItem) {
                  selectedIndex = selectedItem;
                },
                children: (state.districts?.data?.districts ?? []).map((district) {
                  return Center(
                    child: Text(
                      district.name ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ));

    // return showCupertinoModalPopup<void>(
    //   context: context,
    //   builder: (BuildContext context) => Container(
    //     height: 400,
    //     //padding: const EdgeInsets.only(top: 6.0),
    //     color: CupertinoColors.systemBackground.resolveFrom(context),
    //     child: SafeArea(
    //       top: false,
    //       child: Column(
    //         children: [
    //           Container(
    //             // height: 40,
    //             decoration: const BoxDecoration(
    //               border: Border(
    //                 bottom: BorderSide(
    //                   color: AppColors.primaryColor,
    //                   width: 0.0,
    //                 ),
    //               ),
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 CupertinoButton(
    //                   child: Text('${AppLocalization.getText(context)?.cancel}'),
    //                   onPressed: () => AppNavigator.pop(),
    //                 ),
    //                 CupertinoButton(
    //                   child: Text('${AppLocalization.getText(context)?.save}'),
    //                   onPressed: () {
    //                     final districts = state.districts?.data?.districts ?? [];
    //                     if (districts.isNotEmpty) {
    //                       notifier.selectDistrict(districts[selectedIndex]);
    //                     }
    //                     AppNavigator.pop();
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: CupertinoPicker(
    //               magnification: 1.2,
    //               squeeze: 1.2,
    //               useMagnifier: true,
    //               itemExtent: 32.0,
    //               scrollController: FixedExtentScrollController(initialItem: selectedIndex),
    //               onSelectedItemChanged: (int selectedItem) {
    //                 selectedIndex = selectedItem;
    //               },
    //               children: (state.districts?.data?.districts ?? []).map((district) {
    //                 return Center(
    //                   child: Text(
    //                     district.name ?? '',
    //                     style: const TextStyle(fontSize: 16),
    //                   ),
    //                 );
    //               }).toList(),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
