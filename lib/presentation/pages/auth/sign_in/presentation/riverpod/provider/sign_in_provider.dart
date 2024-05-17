import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_in/presentation/riverpod/notifier/sign_in_notifier.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_in/presentation/riverpod/state/sign_in_state.dart';

final signInProvider =
StateNotifierProvider.autoDispose<SignInNotifier, SignInState>(
      (ref) => SignInNotifier(signInRepository),
);
