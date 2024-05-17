import 'package:shared_preferences/shared_preferences.dart';
import 'package:thousand_melochey/core/handlers/jwt_token.dart';
import 'package:thousand_melochey/core/handlers/sp.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/app_helpers.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_in/presentation/riverpod/state/sign_in_state.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_in/repository/sign_in_repository.dart';
import 'package:thousand_melochey/service/connectivity_plus/app_connective.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  final SignInRepository _loginRepository;

  SignInNotifier(this._loginRepository) : super(const SignInState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    final connectivity = await AppConnectivity.connectivity();
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      if (connectivity) {
        state = state.copyWith(isLoading: true);
        final response = await _loginRepository.login(
          email: emailController.text,
          password: passwordController.text,
        );
        response.when(
          success: (data) async {
            state = state.copyWith(isLoading: false, signInData: data);
            SP.saveToSP('JWT', data.jwt ?? "");
            success?.call();
          },
          failure: (failure, status, data) {
            state = state.copyWith(
                isLoading: false, isLoginError: true, signInData: data);
            if (failure == const NetworkExceptions.unauthorisedRequest()) {
              unAuthorised?.call();
            }
            debugPrint('==> Sign in notifier failure: $failure');
          },
        );
      } else {
        checkYourNetwork?.call();
      }
    } else {
      if (emailController.text.isEmpty) {
        state = state.copyWith(errorMessage: "email");
      }
      if (passwordController.text.isEmpty) {
        state = state.copyWith(errorMessage: "password");
      }
    }
  }
  validator() {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      state = state.copyWith(isValid: false);
    } else {
      state = state.copyWith(isValid: true);
    }
  }

/*  textFormIsNotEmpty() {
    // if(mounted){
    if(
    passwordController.text != "" &&
        nameController.text != "" &&
        // passwordConfirmationController.text.isNotEmpty &&
        emailController.text != "") {
      state = state.copyWith(isValid: true);
    } else {
      state = state.copyWith(isValid: false);

    }
  }*/
  saveMe() {
    state = state.saveMe
        ? state.copyWith(saveMe: false)
        : state.copyWith(saveMe: true);
  }
}