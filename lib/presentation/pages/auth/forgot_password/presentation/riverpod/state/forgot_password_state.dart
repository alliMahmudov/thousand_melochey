
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thousand_melochey/presentation/pages/auth/forgot_password/data/forgot_password_response.dart';


part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({

    @Default(false) bool isLoading,
    @Default(false) bool isLogin,
    @Default(false) bool isLoginError,
    @Default(false) bool isValid,
    @Default("") String email,
    @Default("") String password,
    @Default("") String message,
    ForgotPassResponse? forgotPass,
    TextEditingController? emailController,
    TextEditingController? passwordController

  }) = _ForgotPassState;
}
