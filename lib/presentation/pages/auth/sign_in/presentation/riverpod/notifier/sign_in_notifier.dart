import 'package:overlay_kit/overlay_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thousand_melochey/core/handlers/jwt_token.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/app_helpers.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_in/presentation/riverpod/state/sign_in_state.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_in/repository/sign_in_repository.dart';
import 'package:thousand_melochey/service/connectivity_plus/app_connective.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

class SignInNotifier extends StateNotifier<SignInState> {
  final SignInRepository _loginRepository;

  SignInNotifier(this._loginRepository) : super(const SignInState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegExp.hasMatch(email);
  }

  Future<void> signIn({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required BuildContext context,
  }) async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final error = _validateSignIn(email, password, context);
      if (error != null) {
        AppHelpers.showErrorToast(errorMessage: error);
        state = state.copyWith(errorMessage: error, isLoading: false);
        return;
      }

      final connectivity = await AppConnectivity.connectivity();
      if (!connectivity) {
        state = state.copyWith(isLoading: false);
        checkYourNetwork?.call();
        return;
      }

      state = state.copyWith(isLoading: true);

      final response = await _loginRepository.login(
        email: email,
        password: password,
      );

      response.when(
        success: (data) async {
          state = state.copyWith(isLoading: false, signInData: data);
          await LocalStorage.instance.setJWT(data?.jwt);
          success?.call();
        },
        failure: (failure, status, errorMessage) {
          state = state.copyWith(
            isLoading: false,
            isLoginError: true,
            errorMessage: errorMessage,
          );

          if (failure == const NetworkExceptions.unauthorisedRequest()) {
            unAuthorised?.call();
          }

          if (!errorMessage.toString().contains("email") &&
              !errorMessage.toString().contains("password")) {
            AppHelpers.showErrorToast(errorMessage: errorMessage);
          }

          debugPrint('==> sign in failure: $failure');
        },
      );
    } catch (e) {
      OverlayLoadingProgress.stop();
      if (context.mounted) {
        AppHelpers.showErrorToast(errorMessage: e.toString());
      }
      state = state.copyWith(isLoading: false, isLoginError: true);
    }
  }

  String? _validateSignIn(String email, String password, BuildContext context) {
    if (email.isEmpty) return "Email обязателен";
    if (!isValidEmail(email)) return "${AppLocalization.getText(context)?.enter_correct_email}";
    if (password.isEmpty) return "Пароль обязателен";
    return null;
  }


  validator() {
    if (emailController.text.isNotEmpty && passwordController.text.length > 5) {
      state = state.copyWith(isValid: true);
    } else {
      state = state.copyWith(isValid: false);
    }
  }

  saveMe() {
    state = state.saveMe
        ? state.copyWith(saveMe: false)
        : state.copyWith(saveMe: true);
  }
}