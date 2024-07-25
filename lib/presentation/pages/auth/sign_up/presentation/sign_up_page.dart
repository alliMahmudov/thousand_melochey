import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/presentation/riverpod/provider/sign_up_provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Регистрация"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24.sp,
            children: [
              100.sp.verticalSpace,
              CustomTextField(
                controller: notifier.nameController,
                requiredField: true,
                title: "Name",
                labelText: "Enter your name",
                errorText:
                    AppTextFieldErrorsStatus.status(state.errorMessage, "NAME"),
                onChanged: (value) {
                  notifier.validator();
                },
              ),
              CustomTextField(
                controller: notifier.emailController,
                requiredField: true,
                title: "Email",
                labelText: "Enter your email",
                errorText:
                    AppTextFieldErrorsStatus.status(state.errorMessage, "EMAIL"),
                onChanged: (value) {
                  //notifier.validator();
                },
              ),
              CustomTextField(
                controller: notifier.phoneController,
                requiredField: true,
                title: "Phone number",
                labelText: "",
                keyboardType: TextInputType.phone,
                errorText:
                    AppTextFieldErrorsStatus.status(state.errorMessage, "PHONE"),
                onChanged: (value) {
                  notifier.validator();
                },
              ),
              CustomTextField(
                controller: notifier.passwordController,
                requiredField: true,
                title: "Password",
                obscureText: true,
                labelText: "Enter your password",
                errorText: AppTextFieldErrorsStatus.status(
                    state.errorMessage, "PASSWORD"),
                onChanged: (value) {
                  notifier.validator();
                },
              ),
              CustomButtonWidget(
                title: "Create",
                isLoading: state.isLoading,
                isDisabled: !state.isValid,
                onTap: () async {
                  state.isLoading
                      ? null
                      : notifier.signUp(
                      context: context,
                      success: () {
                    if (context.mounted) {
                      AppNavigator.push(
                          OTPRoute(email: notifier.emailController.text)
                      );
                    }
                  },checkYourNetwork: (){
                    AppHelpers.showMaterialBannerError(errorMessage: "Network error!");
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


}
