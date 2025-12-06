import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';


@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  final bool? redirectFromCart;
  const SignInPage({
    this.redirectFromCart,
    super.key});

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
        title: Text("${AppLocalization.getText(context)?.sign_in}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24.sp,
            children: [
              120.sp.verticalSpace,
              if(widget.redirectFromCart == true) Text("${AppLocalization.getText(context)?.register_first}", style: TextStyle(fontSize: 14.sp),),

              CustomTextField(
                controller: notifier.emailController,
                title: "${AppLocalization.getText(context)?.email}",
                labelText: "${AppLocalization.getText(context)?.enter_email}",
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
                    title: '${AppLocalization.getText(context)?.pass}',
                    labelText: '${AppLocalization.getText(context)?.enter_pass}',
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
                        '${AppLocalization.getText(context)?.forgot_password}',
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
                      title: '${AppLocalization.getText(context)?.enter}',
                      isLoading: state.isLoading,
                      isDisabled: !state.isValid,
                      onTap: () {
                    notifier.signIn(
                      context: context,
                        success: () async {
                          final cartNotifier = ref.read(cartProvider.notifier);
                          final favoritesNotifier = ref.read(favoritesProvider.notifier);
                          await cartNotifier.syncLocalCartToBackend();
                          await favoritesNotifier.syncLocalFavoritesToBackend();
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
                      Text("${AppLocalization.getText(context)?.you_dont_have_an_account} ", style: TextStyle(fontSize: 13.sp),),
                      InkWell(
                          onTap: () => AppNavigator.push(SignUpRoute()),
                          child: Text("${AppLocalization.getText(context)?.sign_up}",
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
