import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/forgot_password/presentation/riverpod/notifier/forgot_password_notifier.dart';
import 'package:thousand_melochey/presentation/pages/auth/forgot_password/presentation/riverpod/state/forgot_password_state.dart';

final forgotPassProvider =
StateNotifierProvider.autoDispose<ForgotPassNotifier, ForgotPasswordState>(
      (ref) => ForgotPassNotifier(forgotPasswordRepository),
);