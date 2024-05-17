
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_melochey/injection.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/presentation/riverpod/notifier/sign_up_notifier.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/presentation/riverpod/state/sign_up_state.dart';


final signUpProvider =
StateNotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
      (ref) => SignUpNotifier(signUpRepository),
);
