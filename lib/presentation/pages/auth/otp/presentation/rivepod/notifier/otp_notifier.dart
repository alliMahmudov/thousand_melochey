
import 'package:thousand_melochey/presentation/global_widgets/app_helpers.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/presentation/rivepod/state/otp_state.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/repository/otp_repository.dart';

import '../../../../../../../core/imports/imports.dart';

class OTPNotifier extends StateNotifier<OTPState> {
  final OTPRepository _otpRepository;

  OTPNotifier(this._otpRepository) : super(const OTPState());
  final controller = TextEditingController();
  final focusNode = FocusNode();

  Future<void> resendOTP({
    required String email,
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _otpRepository.resendOTP(email: email);
    response.when(
        success: (data) async {
          state = state.copyWith(isLogin: true, isLoading: false, otpResponse: data);
          success?.call();
    }, failure: (failure, status, errorMessage){
      state = state.copyWith(
        isLoading: false, isLoginError: true, errorMessage: errorMessage
      );
      if(failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      AppHelpers.showMaterialBannerError(errorMessage: errorMessage);
      debugPrint('==> resend OTP notifier page $failure');
    });
  }

  resentCodeDuration(){
    state = state.copyWith(resendCodeActive: state.resendCodeActive ? false : true);
  }

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
