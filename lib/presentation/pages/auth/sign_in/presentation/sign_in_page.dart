import 'package:thousand_melochey/core/imports/imports.dart';

import '../../../home/presentation/home_page.dart';
import '../../../main/main_page.dart';

@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(signInProvider.notifier);
    final state = ref.watch(signInProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                100.sp.verticalSpace,
                //const CustomTitleWidget(title: "Log In"),
                const CustomTitleWidget(title: "Log in"),
                35.sp.verticalSpace,
                CustomTextField(
                  controller: notifier.emailController,
                  title: "Email",
                  labelText: "Enter your email",
                  errorText: AppTextFieldErrorsStatus.status(
                      state.errorMessage, "EMAIL"),
                  onChanged: (value) {
                    notifier.validator();
                  },
                ),
                35.sp.verticalSpace,
                CustomTextField(
                  controller: notifier.passwordController,
                  title: 'Password',
                  labelText: 'Enter your password',
                  obscureText: true,
                  errorText: AppTextFieldErrorsStatus.status(
                      state.errorMessage, "PASSWORD"),
                  onChanged: (value) {
                    notifier.validator();
                  },
                ),
                InkWell(
                  onTap: () {
                    AppNavigator.push(const ForgotPasswordRoute());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Spacer(),
                        Text('Forgot password?'),
                      ],
                    ),
                  ),
                ),
                24.verticalSpace,
                CustomButtonWidget(
                    title: 'Log in',
                    isLoading: state.isLoading,
                    onTap: () async {
                      try {
                        print('Button pressed');
                        await notifier.signIn(
                          context: context,
                          success: () async {
                            print('Login success');
                            const SnackBar(
                              content: Text('Login Successfully'),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.green,
                            );
                            AppNavigator.pushAndPopUntil(const MainRoute());
                          },
                        );
                      } catch (e) {
                        SnackBar(
                          content: Text('$e'),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.red,
                        );
                      }
                    /*  notifier.signIn(
                          context: context,
                          success: () async {
                            const SnackBar(
                              content: Text('Login Successfully'),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            );
                            AppNavigator.pushAndPopUntil(MainRoute());
                          });*/
                    }),
          
                12.sp.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    InkWell(
                        onTap: () {
                          AppNavigator.push(const SignUpRoute());
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: AppColors.primaryColor),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
