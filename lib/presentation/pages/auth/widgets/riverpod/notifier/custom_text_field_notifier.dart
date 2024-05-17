import 'package:thousand_melochey/core/imports/imports.dart';

class CustomTextFieldNotifier extends StateNotifier<CustomTextFieldState> {
  CustomTextFieldNotifier() : super(const CustomTextFieldState());

  onVisiblePassword() {
    state = state.copyWith(onSecureText: state.onSecureText ? false : true);
  }
}
