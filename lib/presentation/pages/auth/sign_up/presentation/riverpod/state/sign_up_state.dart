import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/data/sign_up_response.dart';


part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({

    @Default(false) bool isLoading,
    @Default(false) bool isLogin,
    @Default(false) bool isLoginError,
    @Default(false) bool isValid,
    @Default("") String email,
    @Default("") String errorMessage,
    @Default("") String password,
    @Default("") String id,
    @Default("") String name,
    @Default("") String lastName,
    @Default("") String phoneNumber,
    @Default(false) bool saveMe,
    SignUpResponse? data,
    TextEditingController? emailController,
    TextEditingController? passwordController

  }) = _SignUpState;
}
