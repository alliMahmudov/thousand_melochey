import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_in/data/sign_in_response.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({

    @Default(false) bool isLoading,
    @Default(false) bool isLogin,
    @Default(false) bool isLoginError,
    @Default(true) bool isValid,
    @Default("") String email,
    @Default("") String password,
    @Default("") String errorMessage,
    @Default(false) bool saveMe,
    SignInResponse? signInData,
    TextEditingController? emailController,
    TextEditingController? passwordController

  }) = _SignInState;
}
