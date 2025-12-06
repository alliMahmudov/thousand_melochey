// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localization_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocalizationState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String? get localLang => throw _privateConstructorUsedError;
  Locale? get currentLang => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalizationStateCopyWith<LocalizationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationStateCopyWith<$Res> {
  factory $LocalizationStateCopyWith(
          LocalizationState value, $Res Function(LocalizationState) then) =
      _$LocalizationStateCopyWithImpl<$Res, LocalizationState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isValid,
      bool isError,
      String? localLang,
      Locale? currentLang});
}

/// @nodoc
class _$LocalizationStateCopyWithImpl<$Res, $Val extends LocalizationState>
    implements $LocalizationStateCopyWith<$Res> {
  _$LocalizationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isValid = null,
    Object? isError = null,
    Object? localLang = freezed,
    Object? currentLang = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      localLang: freezed == localLang
          ? _value.localLang
          : localLang // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLang: freezed == currentLang
          ? _value.currentLang
          : currentLang // ignore: cast_nullable_to_non_nullable
              as Locale?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalizationStateImplCopyWith<$Res>
    implements $LocalizationStateCopyWith<$Res> {
  factory _$$LocalizationStateImplCopyWith(_$LocalizationStateImpl value,
          $Res Function(_$LocalizationStateImpl) then) =
      __$$LocalizationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isValid,
      bool isError,
      String? localLang,
      Locale? currentLang});
}

/// @nodoc
class __$$LocalizationStateImplCopyWithImpl<$Res>
    extends _$LocalizationStateCopyWithImpl<$Res, _$LocalizationStateImpl>
    implements _$$LocalizationStateImplCopyWith<$Res> {
  __$$LocalizationStateImplCopyWithImpl(_$LocalizationStateImpl _value,
      $Res Function(_$LocalizationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isValid = null,
    Object? isError = null,
    Object? localLang = freezed,
    Object? currentLang = freezed,
  }) {
    return _then(_$LocalizationStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      localLang: freezed == localLang
          ? _value.localLang
          : localLang // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLang: freezed == currentLang
          ? _value.currentLang
          : currentLang // ignore: cast_nullable_to_non_nullable
              as Locale?,
    ));
  }
}

/// @nodoc

class _$LocalizationStateImpl implements _LocalizationState {
  const _$LocalizationStateImpl(
      {this.isLoading = false,
      this.isValid = false,
      this.isError = false,
      this.localLang = "ru",
      this.currentLang});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isValid;
  @override
  @JsonKey()
  final bool isError;
  @override
  @JsonKey()
  final String? localLang;
  @override
  final Locale? currentLang;

  @override
  String toString() {
    return 'LocalizationState(isLoading: $isLoading, isValid: $isValid, isError: $isError, localLang: $localLang, currentLang: $currentLang)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalizationStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.localLang, localLang) ||
                other.localLang == localLang) &&
            (identical(other.currentLang, currentLang) ||
                other.currentLang == currentLang));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, isValid, isError, localLang, currentLang);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalizationStateImplCopyWith<_$LocalizationStateImpl> get copyWith =>
      __$$LocalizationStateImplCopyWithImpl<_$LocalizationStateImpl>(
          this, _$identity);
}

abstract class _LocalizationState implements LocalizationState {
  const factory _LocalizationState(
      {final bool isLoading,
      final bool isValid,
      final bool isError,
      final String? localLang,
      final Locale? currentLang}) = _$LocalizationStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isValid;
  @override
  bool get isError;
  @override
  String? get localLang;
  @override
  Locale? get currentLang;
  @override
  @JsonKey(ignore: true)
  _$$LocalizationStateImplCopyWith<_$LocalizationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
