import 'package:thousand_melochey/core/imports/imports.dart';


class AppToast{

  static showToastSuccess(String title, context){
    return toastification.show(
        context: context,
        primaryColor: AppColors.white,
        backgroundColor: AppColors.successColor,
        foregroundColor: AppColors.white,
        alignment: Alignment.topCenter,
        type: ToastificationType.success,
        closeOnClick: false,
        dismissDirection: DismissDirection.up,
        autoCloseDuration: const Duration(seconds: 2),
        title: Text(
          title,
          style: TextStyle(fontSize: 16.sp),
        ),
        showProgressBar: false);
  }
  static showToastError(String title, context){
    return toastification.show(
        context: context,
        primaryColor: AppColors.white,
        backgroundColor: AppColors.errorColor,
        foregroundColor: AppColors.white,
        alignment: Alignment.bottomCenter,
        type: ToastificationType.error,
        closeOnClick: false,
        autoCloseDuration: const Duration(seconds: 2),
        title: Text(
          title,
          style: TextStyle(fontSize: 16.sp),
        ),
        showProgressBar: false);
  }
}