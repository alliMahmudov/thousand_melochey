


import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/reset_password/presentation/state/reset_pass_state.dart';
import 'package:thousand_melochey/presentation/pages/auth/reset_password/repository/reset_pass_repository.dart';

class ResetPassNotifier extends StateNotifier<ResetPasswordState> {
  final ResetPassRepository _resetPassRepository;

  ResetPassNotifier(this._resetPassRepository) : super(const ResetPasswordState());

  final controller = TextEditingController();
  final newPassController = TextEditingController();
  final focusNode = FocusNode();


  Future<void> resetPassword({
    required String newPass,
    required String otpCode,
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _resetPassRepository.resetPassword(
      otp: otpCode,
      newPassword: newPass,
    );
    response.when(
      success: (data) async {
        state = state.copyWith(isLogin: true, isLoading: false, resetPass: data);

        /*await LocalStorage.instance.setID(data?.data?.user?.id);
        await LocalStorage.instance
            .setPhoneNumber(data?.data?.user?.phoneNumber);
        await LocalStorage.instance.setUserName(data?.data?.user?.name);
        await LocalStorage.instance.setToken(data?.data?.token);
        await LocalStorage.instance.setLoginApp(true);*/
        AppHelpers.showSuccessToast(message: data.message);
        success?.call();
      },
      failure: (failure, status, errorMessage) {
        state = state.copyWith(
            isLoading: false, isLoginError: true, errorMessage: errorMessage);
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        AppHelpers.showMaterialBannerError(errorMessage: errorMessage);
        debugPrint('==> Reset pass notifier page: $failure');
      },
    );


  }
}