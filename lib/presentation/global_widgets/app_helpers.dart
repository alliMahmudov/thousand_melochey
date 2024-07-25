import 'dart:async';

import 'package:thousand_melochey/contstants/global_key.dart';

import '../../core/imports/imports.dart';

class AppHelpers {
  AppHelpers._();

  static void showCustomModalBottomSheetWithoutIosIcon({
    required BuildContext context,
    required Widget modal,
    // required double initialSize,
    // double radius = 16,
    // bool isDrag = true,
    // AnimationController? controller,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        // transitionAnimationController: controller ,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          // double size = (MediaQuery.of(context).viewInsets.bottom / 1.sh) > 0.3 ? (initialSize > 0.5 ? 0.8 : (initialSize + 0.38))  : (initialSize);

          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: modal,
          );
        });
  }

  static showCustomAlertDialog({
    required BuildContext context,
    EdgeInsets? padding,
    String? title,
    String? content,
    required Function? onTap,
    // required bool isDarkMode,

  }) {
    showAdaptiveDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          //titlePadding: padding,
          content: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      onTap?.call();
                    },
                    style: TextButton.styleFrom(
                      maximumSize: Size(100.sp, 40.sp),
                      minimumSize: Size(100.sp, 40.sp),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),),
                    child: const Text(
                      "Выйти",
                      style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      AppNavigator.pop();
                    },
                    style: TextButton.styleFrom(
                        maximumSize: Size(100.sp, 40.sp),
                        minimumSize: Size(100.sp, 40.sp),
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        )),
                    child: const Text(
                      "Остаться",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  static showMaterialBannerError({required String errorMessage}) {
    Timer(const Duration(seconds: 4), () {
      AppGlobalKey.rootScaffoldMessengerKey.currentState
          ?.clearMaterialBanners();
    });
    // ShowModal(errorMessage: errorMessage);

    return AppGlobalKey.rootScaffoldMessengerKey.currentState
        ?.showMaterialBanner(MaterialBanner(
        backgroundColor: AppColors.red,
        content: Text(
          errorMessage.toString(),
          style: const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              AppGlobalKey.rootScaffoldMessengerKey.currentState
                  ?.clearMaterialBanners();
            },
            child: const Text('DISMISS'),
          ),
        ]));

  }

  static showMaterialBannerSuccess({required String message}) {
    Timer(const Duration(seconds: 4), () {
      AppGlobalKey.rootScaffoldMessengerKey.currentState
          ?.clearMaterialBanners();
    });
    return AppGlobalKey.rootScaffoldMessengerKey.currentState
        ?.showMaterialBanner(MaterialBanner(
        backgroundColor: AppColors.red,
        content: Text(
          message.toString(),
          style: const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              AppGlobalKey.rootScaffoldMessengerKey.currentState
                  ?.clearMaterialBanners();
            },
            child: const Text('DISMISS'),
          ),
        ]));
  }
}


class ShowModal extends StatefulWidget {
  final String errorMessage;
  const ShowModal({super.key,required this.errorMessage});

  @override
  State<ShowModal> createState() => _ShowModalState();
}

class _ShowModalState extends State<ShowModal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAdaptiveDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog.adaptive(
          title: Container(
              decoration: const BoxDecoration(color: AppColors.red),
              child: const Icon(Icons.close,color: AppColors.white,)),
          content: Text(widget.errorMessage),
          actions: [
            ElevatedButton(
                onPressed: () {
                  AppNavigator.pop();
                },
                child: const Text("Ok"))
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
