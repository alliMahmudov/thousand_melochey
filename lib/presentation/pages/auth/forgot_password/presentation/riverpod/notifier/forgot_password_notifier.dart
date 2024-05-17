import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/app_helpers.dart';
import 'package:thousand_melochey/presentation/pages/auth/forgot_password/presentation/riverpod/state/forgot_password_state.dart';
import 'package:thousand_melochey/presentation/pages/auth/forgot_password/repository/forgot_password_repository.dart';
import 'package:thousand_melochey/service/connectivity_plus/app_connective.dart';

class ForgotPassNotifier extends StateNotifier<ForgotPasswordState>{
  final ForgotPasswordRepository _forgotPassRepository;
  ForgotPassNotifier(this._forgotPassRepository) : super(const ForgotPasswordState());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();



  Future<void> forgotPass({
    // required String email,
    // required String newPassword,
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    final Function(String errorMessage)? error,
    VoidCallback? success,
  })async {

    if(emailController.text.isNotEmpty) {
      state = state.copyWith(isLoading: true);

      final connectivity = await AppConnectivity.connectivity();

      if(connectivity){

        final response = await _forgotPassRepository.forgotPass(
          email: emailController.text,
        );
        response.when(
          success: (data) async {
            state = state.copyWith(isLogin: true, isLoading: false, forgotPass: data);

            success?.call();
          },
          failure: (failure, status, errorMessage) {
            state = state.copyWith(isLoading: false, isLoginError: true);
            if (failure == const NetworkExceptions.unauthorisedRequest()) {
              unAuthorised?.call();
            }
            AppHelpers.showMaterialBannerError(errorMessage: errorMessage);
            error?.call(errorMessage);
            debugPrint('==> login failure: $failure');
          },
        );
      }else{
        state = state.copyWith(isLoading: false);

        checkYourNetwork?.call();
      }
    }
  }


}