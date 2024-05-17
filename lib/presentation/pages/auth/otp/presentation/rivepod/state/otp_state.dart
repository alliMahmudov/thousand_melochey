


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/data/otp_response.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/data/sign_up_response.dart';

part 'otp_state.freezed.dart';

@freezed
class OTPState with _$OTPState {
  const factory OTPState({

    @Default(false) bool isLoading,
    @Default(false) bool isLogin,
    @Default(false) bool isLoginError,
    @Default(false) bool isValid,
    @Default(false) bool resendCodeActive,
    @Default("") String otpCode,
    @Default("") String errorMessage,
    @Default(0) int countDown,
    @Default(2) int resendCodeDuration,
    // @Default(false) bool saveMe,
    OtpResponse? otpResponse,
    SignUpResponse? signUpResponse,
    //ForgotPassResponse? forgotPassResponse,

  }) = _OTPState;
}
