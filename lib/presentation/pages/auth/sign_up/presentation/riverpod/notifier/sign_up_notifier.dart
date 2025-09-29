import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_melochey/core/handlers/network_exception.dart';
import 'package:thousand_melochey/presentation/global_widgets/app_helpers.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/presentation/riverpod/state/sign_up_state.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/repositories/sign_up_repository.dart';
import 'package:thousand_melochey/service/connectivity_plus/app_connective.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  final SignUpRepository _signUpRepository;

  SignUpNotifier(this._signUpRepository) : super(const SignUpState());

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegExp.hasMatch(email);
  }

  Future<void> signUp({
    VoidCallback? checkYourNetwork,
    VoidCallback? success,
    VoidCallback? unAuthorised,
    required BuildContext context
  }) async {
    try {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final phone = phoneController.text.replaceAll(RegExp(r'[-()\s]'), '');
      final password = passwordController.text.trim();

      final error = _validateSignUp(email, password, context);

      if(error != null) {
        AppHelpers.showErrorToast(errorMessage: error);
        state = state.copyWith(errorMessage: error, isLoading: false);
        return;
      }

      final connectivity = await AppConnectivity.connectivity();

      if(!connectivity) {
        state = state.copyWith(isLoading: false);
        checkYourNetwork?.call();
        return;
      }

      state = state.copyWith(isLoading: true);

      final response = await _signUpRepository.register(
          name: name,
          password: password,
          phone: phone,
          email: email
      );

      response.when(
          success: (data) {
            state = state.copyWith(isLogin: true, isLoading: false, data: data);
            AppHelpers.showMaterialBannerSuccess(message: data.message.toString());
            success?.call();
          },
          failure: (failure, status, errorMessage) {
            state = state.copyWith(
                isLoading: false,
                isLoginError: true,
                errorMessage: errorMessage
            );

            if ( failure == const NetworkExceptions.unauthorisedRequest() ) {
              unAuthorised?.call();
            }

            if( !errorMessage.toString().contains('email')
                && !errorMessage.toString().contains('password') ) {
              AppHelpers.showErrorToast(errorMessage: errorMessage);
            }

            debugPrint(" ==> sign up failure: $failure");

          }
      );
    } catch(e) {
      if(context.mounted) {
        AppHelpers.showErrorToast(errorMessage: e.toString());
      }
      state = state.copyWith(isLoading: false, isLoginError: true);
    }
  }

  String? _validateSignUp(String email, String password, BuildContext context) {
    if (email.isEmpty) return "Email обязателен";
    if (!isValidEmail(email)) return "${AppLocalization.getText(context)?.enter_correct_email}";
    if (password.isEmpty) return "Пароль обязателен";
    return null;
  }

  void validator() {
    if (passwordController.text.length > 5 &&
        nameController.text.isNotEmpty &&
        phoneController.text.length == 14 &&
        emailController.text.isNotEmpty) {
      state = state.copyWith(isValid: true);
    } else {
      state = state.copyWith(isValid: false);
    }
  }
}
