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
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          )),
      body: RefreshIndicator(
        onRefresh: () {
          return notifier.getUserInfo();
        },
        child: Column(
          children: [
            12.verticalSpace,
            Center(
              child: CircleAvatar(
                radius: 50.r,
                child: Icon(
                  Icons.person,
                  size: 38.sp,
                ),
              ),
            ),
            12.verticalSpace,
            state.isUserInfoLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      width: 90.w,
                      height: 20.h,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.white),
                      // height: 100.0,
                    ),
                  )
                : state.userInfo != null
                    ? Text(
                        state.userInfo?.name ?? "NULL",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      )
                    : const SizedBox.shrink(),

            4.verticalSpace,

            state.isUserInfoLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      width: 120.w,
                      height: 18.h,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.white),
                    ),
                  )
                : state.userInfo != null
                    ? Text(state.userInfo?.email ?? "NULL")
                    : const SizedBox.shrink(),
            12.verticalSpace,
            //   SectionButtonWidget(icon: Icons.person_outline, title: "Profile", onTap: (){}),
            // SectionButtonWidget(
            //     icon: Icons.event_note,
            //     title: "Orders",
            //     onTap: () {
            //       AppNavigator.push(AllOrdersRoute());
            //     }),
            SectionButtonWidget(
                icon: Icons.location_on_outlined,
                title: "Address",
                onTap: () {
                  AppHelpers.showCustomAlertDialog(
                      context: context,
                      padding: const EdgeInsets.all(12),
                      title: "Address",
                      content: "Usta Shirin Street, 122/1",
                      actions: [
                        Material(
                          child: Column(
                            children: [
                              /* InkWell(
                          onTap:( ){
                            launchUrl(
                                Uri.parse("https://yandex.com/navi/?whatshere%5Bzoom%5D=19&whatshere%5Bpoint%5D=69.253385,41.355337"),
                            );
                          },
                          child: Container(
                            color: Colors.grey.withOpacity(.2),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                              child: Text('Location'))),*/

                              InkWell(
                                  onTap: () {
                                    AppNavigator.pop();
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(12),
                                      child: const Text('close'))),
                            ],
                          ),
                        )
                      ]);
                }),
            SectionButtonWidget(
                icon: Icons.support_agent,
                title: "Connect with us",
                onTap: () {
                  AppHelpers.showCustomAlertDialog(
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
                      ]);
                }),
            SectionButtonWidget(
                icon: Icons.exit_to_app,
                title: "Sign out",
                onTap: () {
                  /*AppHelpers.showCustomAlertDialog(context: context,
                  padding: EdgeInsets.all(12),
                  title: "Do you want to log out?",
                  actions: [
                    Material(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap:( ){
                                AppNavigator.pop();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(12),
                                  child: Text('cancel', style: TextStyle(color:AppColors.primaryColor ),))),    InkWell(
                              onTap:( ){
                                AppNavigator.pop();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(12),
                                  child: Text('confirm', style: TextStyle(color: AppColors.primaryColor),))),
                        ],
                      ),
                    )
                  ]);*/

                  showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: const Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  AppNavigator.pop();
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  notifier.logOut(
                                    success: (){
                                      AppNavigator.pushAndPopUntil(
                                          const SignInRoute());
                                    }
                                  );

                                },
                                child: const Text("Log out")),
                          ],
                        );
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
