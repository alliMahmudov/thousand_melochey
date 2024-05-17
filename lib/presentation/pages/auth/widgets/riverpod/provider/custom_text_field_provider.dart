import 'package:thousand_melochey/core/imports/imports.dart';

final customTextFieldProvider =
    StateNotifierProvider.autoDispose<CustomTextFieldNotifier, CustomTextFieldState>(
        (ref) => CustomTextFieldNotifier());
