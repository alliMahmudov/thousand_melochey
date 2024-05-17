

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
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              100.verticalSpace,
             const Center(child: Text("Forgot password?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
              40.verticalSpace,
              CustomTextField(controller: notifier.emailController, title: "Email", labelText: "Enter your email"),

              40.verticalSpace,

              CustomButtonWidget(title: "Next", isLoading: state.isLoading, onTap: (){
                notifier.forgotPass(
                  success: (){
                    AppNavigator.push(ResetPassRoute(email: notifier.emailController.text));
                  }
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
