import 'package:thousand_melochey/contstants/app_text_field_error_status.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/app_helpers.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/presentation/riverpod/provider/sign_up_provider.dart';
import 'package:thousand_melochey/router/routes.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends ConsumerState<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(signUpProvider.notifier);
    final state = ref.watch(signUpProvider);
    return Form(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  100.sp.verticalSpace,
                  const CustomTitleWidget(title: "Create Account"),
                  35.sp.verticalSpace,
                  CustomTextField(
                    controller: notifier.nameController,
                    title: "Name",
                    labelText: "Enter your name",
                    errorText:
                        AppTextFieldErrorsStatus.status(state.errorMessage, "NAME"),
                    onChanged: (value) {
                      notifier.textFormIsNotEmpty();
                    },
                  ),
                  24.sp.verticalSpace,
                  CustomTextField(
                    controller: notifier.emailController,
                    title: "Email",
                    labelText: "Enter your email",
                    errorText:
                        AppTextFieldErrorsStatus.status(state.errorMessage, "EMAIL"),
                    onChanged: (value) {
                      notifier.textFormIsNotEmpty();
                    },
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    controller: notifier.phoneController,
                    title: "Phone number",
                    labelText: "",
                    keyboardType: TextInputType.phone,
                    errorText:
                        AppTextFieldErrorsStatus.status(state.errorMessage, "PHONE"),
                    onChanged: (value) {
                      notifier.textFormIsNotEmpty();
                    },
                  ),
                  24.sp.verticalSpace,
                  CustomTextField(
                    controller: notifier.passwordController,
                    title: "Password",
                    obscureText: true,
                    labelText: "Enter your password",
                    errorText: AppTextFieldErrorsStatus.status(
                        state.errorMessage, "PASSWORD"),
                    onChanged: (value) {
                      notifier.textFormIsNotEmpty();
                    },
                  ),
                    
                  30.sp.verticalSpace,
                    
                  CustomButtonWidget(title: "Create", isLoading: state.isLoading,
                    onTap: () async {
                      state.isLoading
                          ? null
                          : notifier.signUp(success: () {
                        if (context.mounted) {
                          AppNavigator.push(
                              OTPRoute(email: notifier.emailController.text)
                        /*    OtpRoute(
                              name: notifier.nameController.text,
                              password:
                              notifier.passwordController.text,
                              phoneNumber:
                              notifier.phoneController.text,
                              isForgotPassword: false,
                            ),*/
                          );
                        }
                      },checkYourNetwork: (){
                        AppHelpers.showMaterialBannerError(errorMessage: "Network error!");
                    
                      });
                    },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
