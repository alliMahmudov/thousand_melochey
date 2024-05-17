import 'package:thousand_melochey/core/imports/imports.dart';
part "custom_text_field_state.freezed.dart";

@freezed
class CustomTextFieldState with _$CustomTextFieldState {
  const factory CustomTextFieldState({
    @Default(true) bool onSecureText,
    @Default("") String errorValidation,
  }) = _CustomTextFieldState;
}
