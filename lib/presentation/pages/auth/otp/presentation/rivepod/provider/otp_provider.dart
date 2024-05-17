import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_melochey/injection.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/presentation/rivepod/notifier/otp_notifier.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/presentation/rivepod/state/otp_state.dart';

//final otpProvider = StateNotifierProvider<OTPNotifier, OTPState>((ref) => OTPNotifier(otpRepository));

final otpProvider = StateNotifierProvider<OTPNotifier, OTPState>(
        (ref) => OTPNotifier(otpRepository));