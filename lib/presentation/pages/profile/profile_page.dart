import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/core/handlers/sp.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
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
    final state = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Профиль",
      )),
      body: RefreshIndicator(
        onRefresh: () {
          return notifier.getUserInfo();
        },
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
                      child: Icon(
                        Icons.person,
                        size: 24.sp,
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppColors.white),
                                // height: 100.0,
                              ),
                            )
                          : Text(
                              state.userInfo?.name ?? "NULL",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                      state.isUserInfoLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.black12,
                              highlightColor: Colors.grey.shade300,
                              child: Container(
                                width: 90.w,
                                height: 20.h,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppColors.white),
                                // height: 100.0,
                              ),
                            )
                          : Text(
                              state.userInfo?.email ?? "NULL",
                            ),
                    ],
                  )
                ],
              ),
            ),
            12.verticalSpace,
            //   SectionButtonWidget(icon: Icons.person_outline, title: "Profile", onTap: (){}),
            SectionButtonWidget(
                icon: CupertinoIcons.profile_circled,
                title: "Личные данные",
                onTap: () {}),
            SectionButtonWidget(
                icon: Icons.receipt_long_outlined,
                title: "Мои заказы",
                onTap: () {
                  AppNavigator.push(const AllOrdersRoute());
                }),
            SectionButtonWidget(
                icon: Icons.support_agent,
                title: "Связаться с нами",
                onTap: () {
                  /*AppHelpers.showCustomAlertDialog(
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
                      ]);*/
                }),
            SectionButtonWidget(
                icon: Icons.language,
                title: "Язык приложения",
                onTap: () {
                  showModalBottomSheet(context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context){
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Spacer(flex: 3,),
                                Center(child: Text("Выберите язык", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),)),
                                const Spacer(flex: 2,),
                                InkWell(
                                  onTap: (){
                                    AppNavigator.pop();
                                  },
                                  child: const CircleAvatar(
                                    radius: 16,
                                    backgroundColor: AppColors.primaryColor,
                                    child: Center(
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  minTileHeight: 55.h,
                                  title: const Text(
                                    "O'zbek tili",
                                  ),
                                  trailing: Transform.scale(
                                    scale: 1.5,
                                    child: CupertinoRadio(
                                      toggleable: true,
                                        inactiveColor: AppColors.backgroundColor,
                                        activeColor: AppColors.primaryColor,
                                        value: "uz",
                                        groupValue: 'uz',
                                        onChanged: (value) {
                                          //langNotifier.changeLang("uz");
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            child: Column(
                              children: [
                                ListTile(
                                  minTileHeight: 55.h,
                                  title: const Text(
                                    "Русский язык",
                                  ),
                                  trailing: Transform.scale(
                                    scale: 1.5,
                                    child: CupertinoRadio(
                                      toggleable: true,
                                        inactiveColor: AppColors.backgroundColor,
                                        activeColor: AppColors.primaryColor,
                                        value: true,
                                        groupValue: 'uz',
                                        onChanged: (value) {
                                          //langNotifier.changeLang("uz");
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(thickness: .6, color: Colors.grey),
                          CustomButtonWidget(title: 'Применить', isLoading: false, onTap: (){}),
                          10.h.verticalSpace,
                        ],
                      ),
                    );
                  });
                }),
            SectionButtonWidget(
                icon: Icons.exit_to_app,
                title: "Выйти",
                onTap: () {
                  AppHelpers.showCustomAlertDialog(
                      context: context,
                      title: "Вы хотите выйти?",
                      onTap: () {
                        notifier.logOut(success: () {
                          AppNavigator.pushAndPopUntil(const SignInRoute());
                          SP.deleteJWT();
                        });
                      });
                }),
          ],
        ),
      ),
    );
  }
}
/* SliverAppBar(
              //title: const Text("Personal Area",style: TextStyle(color: Colors.black),),
              pinned: false,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black12,
              collapsedHeight: 70,
              expandedHeight: .15.sh,
              flexibleSpace: ValueListenableBuilder<double>(
                valueListenable: notifier.scrollPosition,
                builder: (context, value, child) {
                  final bool isPinned = value > (MediaQuery.sizeOf(context).height*.07- kToolbarHeight);
                  return FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(top: 10),
                    centerTitle: true,
                    title: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.0.w, bottom: 30.h),
                          child: Row(
                            children: [
                               CircleAvatar(
                                radius: isPinned  ? 24:32,
                                child: Icon(Icons.person,size: 32,),
                              ),
                              12.horizontalSpace,
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ali", style: TextStyle(color: Colors.black),),
                                  Text("wearfitpro2@gmail.com",style: TextStyle(color: Colors.black),),
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                    expandedTitleScale: 1,
                  );
                },
              ),
            ),*/
