import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part "localization_state.freezed.dart";

@freezed
class LocalizationState with _$LocalizationState {
  const factory LocalizationState({
    @Default(false) bool isLoading,
    @Default(false) bool isValid,
    @Default(false) bool isError,
    @Default("ru") String? localLang,
    Locale? currentLang

  }) = _LocalizationState;

}
