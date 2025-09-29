import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
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
      notifier.getUserInfo();
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
          title: Text(
        "${AppLocalization.getText(context)?.profile}",
      )),
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              await notifier.getUserInfo();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  60.verticalSpace,
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
                      icon: Icons.add_location_alt,
                      title:
                          "${AppLocalization.getText(context)?.my_addresses}",
                      onTap: () {
                        AppNavigator.push(const UserAddressesRoute());
                      }),
                  SectionButtonWidget(
                    icon: Icons.support_agent,
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
                    /*{
                      */ /*AppHelpers.showCustomAlertDialog(
                        context: context,
                        padding: const EdgeInsets.all(12),
                        title: "Connact number",
                        content: "+99893 712-80-03",
                        actions: [
                          Material(
                            child: InkWell(
                                onTap: () {
                                  AppNavigator.pop();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(12),
                                    child: const Text('close'))),
                          )
                        ]);*/ /*
                    }*/
                  ),
                  SectionButtonWidget(
                      icon: Icons.language,
                      title: "${AppLocalization.getText(context)?.lang}",
                      onTap: () {
                        AppHelpers.showCustomModalBottomSheetWithoutIosIcon(
                            context: context, modal: const ChangeLangModal());
                      }),
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
                                    const SignInRoute());
                                LocalStorage.instance.logout();
                              });
                            });
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
