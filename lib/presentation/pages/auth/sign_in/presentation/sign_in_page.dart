import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/presentation/riverpod/provider/sign_up_provider.dart';

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
      appBar: AppBar(
        title: const Text("Авторизация"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24.sp,
            children: [
              120.sp.verticalSpace,
              CustomTextField(
                controller: notifier.emailController,
                title: "Email",
                labelText: "Введите email",
                errorText: AppTextFieldErrorsStatus.status(state.errorMessage, "EMAIL"),
                onChanged: (value) {
                  notifier.validator();
                },
              ),
          
              /// Password feature
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    controller: notifier.passwordController,
                    title: 'Пароль',
                    labelText: 'Введите пароль',
                    obscureText: true,
                    errorText: AppTextFieldErrorsStatus.status(
                        state.errorMessage, "PASSWORD"),
                    onChanged: (value) {
                      notifier.validator();
                    },
                  ),
                  InkWell(
                    onTap: (){
                      AppNavigator.push(const ForgotPasswordRoute());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Забыли пароль?',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
          
              /// Auth feature
              Column(
                spacing: 10.sp,
                children: [
                  CustomButtonWidget(
                      title: 'Войти',
                      isLoading: state.isLoading,
                      isDisabled: !state.isValid,
                      onTap: () {
                    notifier.signIn(
                      context: context,
                        success: () {
                        const SnackBar(
                            content: Text('Login Successfully'),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.red,
                          );
                          debugPrint(state.signInData?.jwt);
                          AppNavigator.pushAndPopUntil(const MainRoute());

                        },
                        checkYourNetwork: (){
                          AppHelpers.showMaterialBannerError(errorMessage: "Network error!");
                        }
                    );
                  }
                  ),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("У вас нет аккаунта? ", style: TextStyle(fontSize: 13.sp),),
                      InkWell(
                          onTap: () => AppNavigator.push(SignUpRoute()),
                          child: Text("Регистрация",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
