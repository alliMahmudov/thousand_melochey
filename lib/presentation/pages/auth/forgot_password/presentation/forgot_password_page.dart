

import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/forgot_password/presentation/riverpod/provider/forgot_password_provider.dart';

@RoutePage()
class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(forgotPassProvider.notifier);
    final state = ref.watch(forgotPassProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Восстановления пароля"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24.sp,
            children: [
              Spacer(
                flex: 1,
              ),
              CustomTextField(controller: notifier.emailController, title: "Email", labelText: "Enter your email"),
              CustomButtonWidget(title: "Next", isLoading: state.isLoading, onTap: (){
                notifier.forgotPass(
                  success: (){
                    AppNavigator.push(ResetPassRoute(email: notifier.emailController.text));
                  }
                );
              }),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
