import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/presentation/riverpod/provider/sign_up_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

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
        title: Text("${AppLocalization.getText(context)?.sign_up}"),
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
                title: "${AppLocalization.getText(context)?.name}",
                labelText: "${AppLocalization.getText(context)?.enter_name}",
                errorText:
                    AppTextFieldErrorsStatus.status(state.errorMessage, "NAME"),
                onChanged: (value) {
                  notifier.validator();
                },
              ),
              CustomTextField(
                controller: notifier.emailController,
                requiredField: true,
                title: "${AppLocalization.getText(context)?.email}",
                labelText: "${AppLocalization.getText(context)?.enter_email}",
                errorText:
                    AppTextFieldErrorsStatus.status(state.errorMessage, "EMAIL"),
                onChanged: (value) {
                  //notifier.validator();
                },
              ),
              CustomTextField(
                controller: notifier.phoneController,
                requiredField: true,
                title: "${AppLocalization.getText(context)?.phone_number}",
                labelText: "",
                keyboardType: TextInputType.phone,
                errorText: AppTextFieldErrorsStatus.status(state.errorMessage, "PHONE"),
                onChanged: (value) {
                  notifier.validator();
                },
              ),
              CustomTextField(
                controller: notifier.passwordController,
                requiredField: true,
                title: "${AppLocalization.getText(context)?.pass}",
                obscureText: true,
                labelText: "${AppLocalization.getText(context)?.enter_pass}",
                errorText: AppTextFieldErrorsStatus.status(
                    state.errorMessage, "PASSWORD"),
                onChanged: (value) {
                  notifier.validator();
                },
              ),
              CustomButtonWidget(
                title: "${AppLocalization.getText(context)?.create}",
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
