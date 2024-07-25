import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_melochey/core/handlers/network_exception.dart';
import 'package:thousand_melochey/presentation/global_widgets/app_helpers.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/presentation/riverpod/state/sign_up_state.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/repositories/sign_up_repository.dart';
import 'package:thousand_melochey/service/connectivity_plus/app_connective.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  final SignUpRepository _signUpRepository;

  SignUpNotifier(this._signUpRepository) : super(const SignUpState());

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUp({
    VoidCallback? checkYourNetwork,
    VoidCallback? success,
    VoidCallback? unAuthorised,
    required BuildContext context
  }) async {
    if (mounted) {
      state = state.copyWith(isLoading: true);
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      /*   String email = emailController.text.replaceAll(RegExp(
          r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'), '')*/
      final response = await _signUpRepository.register(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );
      response.when(
        success: (data) async {
          state = state.copyWith(isLogin: true, isLoading: false, data: data);
          AppHelpers.showMaterialBannerSuccess(
              message: data.message.toString());
          success?.call();
        },
        failure: (failure, status, errorMessage) {
          state = state.copyWith(
              isLoading: false, isLoginError: true, errorMessage: errorMessage);
          if (failure == const NetworkExceptions.unauthorisedRequest()) {
            unAuthorised?.call();
          }
          AppHelpers.showMaterialBannerError(
              errorMessage: errorMessage.toString());
          if ((!errorMessage.toString().toUpperCase().contains("PASSWORD")) &&
              !errorMessage.toString().toUpperCase().contains("PHONE") &&
              !errorMessage.toString().toUpperCase().contains("NAME")) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage.toString())));
            AppHelpers.showMaterialBannerError(
                errorMessage: errorMessage.toString());
          }
          debugPrint('==> REGISTER failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void validator() {
    if (passwordController.text.length > 7 &&
        nameController.text.isNotEmpty &&
        phoneController.text.length == 14 &&
        emailController.text.isNotEmpty) {
      state = state.copyWith(isValid: true);
    } else {
      state = state.copyWith(isValid: false);
    }
  }
}
