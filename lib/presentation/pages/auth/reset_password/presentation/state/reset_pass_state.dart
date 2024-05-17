import 'package:thousand_melochey/core/imports/imports.dart';

part 'reset_pass_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({

    @Default(false) bool isLoading,
    @Default(false) bool isLogin,
    @Default(false) bool isLoginError,
    @Default(false) bool isValid,
    @Default("") String errorMessage,
    @Default("") String otp,
    @Default("") String newPass,
    @Default("") String message,
    @Default(2) int resendCodeDuration,
    ResetPassResponse? resetPass,

  }) = _ResetPasswordState;
}
