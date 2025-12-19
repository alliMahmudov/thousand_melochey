import 'package:flutter/cupertino.dart';
import 'package:restart_app/restart_app.dart';
import 'package:thousand_melochey/contstants/app_assets.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/restart_widget.dart';
import 'package:thousand_melochey/presentation/pages/profile/presentation/widgets/change_lang_modal.dart';
import 'package:thousand_melochey/presentation/pages/profile/presentation/widgets/section_button_widget.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/service/localizations/riverpod/provider/localization_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final notifier = ref.read(profileProvider.notifier);
      if(LocalStorage.instance.isAuthenticated()) {
        notifier.getUserInfo(context: context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(profileProvider.notifier);
    final langNotifier = ref.read(langProvider(0).notifier);
    final state = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocalization.getText(context)?.profile}",),
        actions: [
          if(LocalStorage.instance.isAuthenticated()) IconButton(
              onPressed: () {
                AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
                      context: context,
                      modal: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${AppLocalization.getText(context)?.delete_account}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                            8.verticalSpace,
                            Text("${AppLocalization.getText(context)?.delete_account_info}"),

                            16.verticalSpace,
                            CustomTextField(
                              controller: notifier.currentPasswordController,
                              title: "${AppLocalization.getText(context)?.current_password}",
                              labelText: "${AppLocalization.getText(context)?.enter_current_password}",
                            ),

                            16.verticalSpace,
                            CustomButtonWidget(
                              title: "${AppLocalization.getText(context)?.delete}",
                              isLoading: state.isLoading,
                              onTap: () {
                                if (notifier.currentPasswordController.text.isEmpty) {
                                  AppHelpers.showErrorToast(errorMessage: "${AppLocalization.getText(context)?.fill_all_fields}");
                                } else {
                                  notifier.deleteAccount(
                                      success: () {
                                        AppNavigator.pushAndPopUntil(const MainRoute());
                                        LocalStorage.instance.logout();
                                      }
                                  );
                                }
                              },
                            ),
                            16.verticalSpace
                          ],
                        ),
                      ));
              },
              icon: const Icon(CupertinoIcons.delete))
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              await notifier.getUserInfo(context: context);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  60.verticalSpace,
                  LocalStorage.instance.isAuthenticated() 
                      ? asUser(state: state, notifier: notifier)
                      : asGuest()
                ],
              ),
            )),
      ),
    );
  }

  Widget asGuest() {
    return Column(
      children: [
        Container(
          height: 100.h,
          width: 110.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.primaryColor
          ),
          child: const Image(image: AssetImage(AppAssets.appLogo)),
        ),
        12.verticalSpace,
        SectionButtonWidget(
          icon: Icons.email_outlined,
          title: "${AppLocalization.getText(context)?.contact_us}",
          onTap: () async {
            final tgUri = Uri.parse("tg://resolve?domain=unusualuser");
            final httpUri = Uri.parse("https://t.me/unusualuser");

            final bool canOpenTg = await canLaunchUrl(tgUri);
            if (canOpenTg) {
              await launchUrl(
                tgUri,
                mode: LaunchMode.externalApplication,
              );
              return;
            }

            if (await canLaunchUrl(httpUri)) {
              await launchUrl(
                httpUri,
                mode: LaunchMode.externalApplication,
              );
              return;
            }
          },
        ),
        SectionButtonWidget(
            icon: CupertinoIcons.location_solid,
            title: "Bizning manzilimiz",
            onTap: () {

              final locationFunc = ref.read(cartProvider.notifier);

              locationFunc.openMap();

            }),
        SectionButtonWidget(
            icon: Icons.language,
            title: "${AppLocalization.getText(context)?.lang}",
            onTap: () {
              AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
                  context: context, modal: const ChangeLangModal());
            }),
        Padding(
          padding: EdgeInsets.all(16.sp),
          child: CustomButtonWidget(
            title: "${AppLocalization.getText(context)?.sign_in}",
            isLoading: false,
            isDisabled: false,
            onTap: () async {
              AppNavigator.push(SignInRoute());
              // state.isLoading
              //     ? null
              //     : ref.read(signUpProvider.notifier).signUp(
              //     context: context,
              //     success: () {
              //       if (context.mounted) {
              //         AppNavigator.push(
              //             OTPRoute(email: notifier.emailController.text)
              //         );
              //       }
              //     },checkYourNetwork: (){
              //   AppHelpers.showMaterialBannerError(errorMessage: "Network error!");
              // });
            },
          ),
        ),
      ],
    );
  }

  Widget asUser({required ProfileState state, required ProfileNotifier notifier}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 34.0.w),
          child: Row(
            spacing: 20.sp,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(
                    Icons.person,
                    size: 24.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.sp,
                children: [
                  state.isUserInfoLoading
                      ? Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      width: 90.w,
                      height: 20.h,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(12.r),
                          color: AppColors.white),
                      // height: 100.0,
                    ),
                  )
                      : Text(
                    state.userInfo?.name ?? "",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  state.isUserInfoLoading
                      ? Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      width: 90.w,
                      height: 20.h,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(12.r),
                          color: AppColors.white),
                      // height: 100.0,
                    ),
                  )
                      : Text(
                    state.userInfo?.email ?? "",
                  ),
                ],
              )
            ],
          ),
        ),
        12.verticalSpace,
        SectionButtonWidget(
            icon: Icons.receipt_long_outlined,
            title: "${AppLocalization.getText(context)?.my_orders}",
            onTap: () {
              AppNavigator.push(const AllOrdersRoute());
            }),
        SectionButtonWidget(
            icon: Icons.house_outlined,
            title:
            "${AppLocalization.getText(context)?.my_addresses}",
            onTap: () {
              AppNavigator.push(const UserAddressesRoute());
            }),
        SectionButtonWidget(
            icon: Icons.language,
            title: "${AppLocalization.getText(context)?.lang}",
            onTap: () {
              AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
                  context: context, modal: const ChangeLangModal());
            }),
        SectionButtonWidget(
            icon: Icons.storefront_sharp,
            title: "Bizning manzilimiz",
            onTap: () {

              final locationFunc = ref.read(cartProvider.notifier);

              locationFunc.openMap();

            }),
        SectionButtonWidget(
          icon: Icons.email_outlined,
          title: "${AppLocalization.getText(context)?.contact_us}",
          onTap: () async {
            final tgUri = Uri.parse("tg://resolve?domain=unusualuser");
            final httpUri = Uri.parse("https://t.me/unusualuser");

            final bool canOpenTg = await canLaunchUrl(tgUri);
            if (canOpenTg) {
              await launchUrl(
                tgUri,
                mode: LaunchMode.externalApplication,
              );
              return;
            }

            if (await canLaunchUrl(httpUri)) {
              await launchUrl(
                httpUri,
                mode: LaunchMode.externalApplication,
              );
              return;
            }
          },
        ),
        SectionButtonWidget(
            icon: Icons.exit_to_app,
            title: "${AppLocalization.getText(context)?.log_out}",
            onTap: () {
              AppHelpers.showCustomAlertDialog(
                  context: context,
                  actionButtonText:
                  "${AppLocalization.getText(context)?.log_out}",
                  title:
                  "${AppLocalization.getText(context)?.log_out_title}",
                  onTap: () {
                    notifier.logOut(success: () {
                      AppNavigator.pushAndPopUntil(
                          const MainRoute());
                      // AppNavigator.pop();
                      LocalStorage.instance.logout();
                      // RestartWidget.restartApp(context);
                    });
                  });
            }),
      ],
    );
  }
}