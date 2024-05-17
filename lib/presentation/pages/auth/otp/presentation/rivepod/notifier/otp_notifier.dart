

import 'package:thousand_melochey/presentation/global_widgets/app_helpers.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/presentation/rivepod/state/otp_state.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/repository/otp_repository.dart';

import '../../../../../../../core/imports/imports.dart';

class OTPNotifier extends StateNotifier<OTPState> {
  final OTPRepository _otpRepository;

  OTPNotifier(this._otpRepository) : super(const OTPState());
  final controller = TextEditingController();
  final focusNode = FocusNode();

  Future<void> otpPost({
    required String email,
    required String otpCode,
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);



    final response = await _otpRepository.postOTP(
      email: email,
      otp: otpCode,
    );
    response.when(
      success: (data) async {
        state = state.copyWith(isLogin: true, isLoading: false, otpResponse: data);

        /*await LocalStorage.instance.setID(data?.data?.user?.id);
        await LocalStorage.instance
            .setPhoneNumber(data?.data?.user?.phoneNumber);
        await LocalStorage.instance.setUserName(data?.data?.user?.name);
        await LocalStorage.instance.setToken(data?.data?.token);
        await LocalStorage.instance.setLoginApp(true);*/

        success?.call();
      },
      failure: (failure, status, errorMessage) {
        state = state.copyWith(
            isLoading: false, isLoginError: true, errorMessage: errorMessage);
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        AppHelpers.showMaterialBannerError(errorMessage: errorMessage);
        debugPrint('==> OTP failure notifier page: $failure');
      },
    );


  }




  setOtpCode(String otp) {
    state = state.copyWith(otpCode: otp);
  }
}