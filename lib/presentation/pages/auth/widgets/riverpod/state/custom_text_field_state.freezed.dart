// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_text_field_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomTextFieldState {
  bool get onSecureText => throw _privateConstructorUsedError;
  String get errorValidation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomTextFieldStateCopyWith<CustomTextFieldState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomTextFieldStateCopyWith<$Res> {
  factory $CustomTextFieldStateCopyWith(CustomTextFieldState value,
          $Res Function(CustomTextFieldState) then) =
      _$CustomTextFieldStateCopyWithImpl<$Res, CustomTextFieldState>;
  @useResult
  $Res call({bool onSecureText, String errorValidation});
}

/// @nodoc
class _$CustomTextFieldStateCopyWithImpl<$Res,
        $Val extends CustomTextFieldState>
    implements $CustomTextFieldStateCopyWith<$Res> {
  _$CustomTextFieldStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onSecureText = null,
    Object? errorValidation = null,
  }) {
    return _then(_value.copyWith(
      onSecureText: null == onSecureText
          ? _value.onSecureText
          : onSecureText // ignore: cast_nullable_to_non_nullable
              as bool,
      errorValidation: null == errorValidation
          ? _value.errorValidation
          : errorValidation // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomTextFieldStateImplCopyWith<$Res>
    implements $CustomTextFieldStateCopyWith<$Res> {
  factory _$$CustomTextFieldStateImplCopyWith(_$CustomTextFieldStateImpl value,
          $Res Function(_$CustomTextFieldStateImpl) then) =
      __$$CustomTextFieldStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool onSecureText, String errorValidation});
}

/// @nodoc
class __$$CustomTextFieldStateImplCopyWithImpl<$Res>
    extends _$CustomTextFieldStateCopyWithImpl<$Res, _$CustomTextFieldStateImpl>
    implements _$$CustomTextFieldStateImplCopyWith<$Res> {
  __$$CustomTextFieldStateImplCopyWithImpl(_$CustomTextFieldStateImpl _value,
      $Res Function(_$CustomTextFieldStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onSecureText = null,
    Object? errorValidation = null,
  }) {
    return _then(_$CustomTextFieldStateImpl(
      onSecureText: null == onSecureText
          ? _value.onSecureText
          : onSecureText // ignore: cast_nullable_to_non_nullable
              as bool,
      errorValidation: null == errorValidation
          ? _value.errorValidation
          : errorValidation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CustomTextFieldStateImpl implements _CustomTextFieldState {
  const _$CustomTextFieldStateImpl(
      {this.onSecureText = true, this.errorValidation = ""});

  @override
  @JsonKey()
  final bool onSecureText;
  @override
  @JsonKey()
  final String errorValidation;

  @override
  String toString() {
    return 'CustomTextFieldState(onSecureText: $onSecureText, errorValidation: $errorValidation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomTextFieldStateImpl &&
            (identical(other.onSecureText, onSecureText) ||
                other.onSecureText == onSecureText) &&
            (identical(other.errorValidation, errorValidation) ||
                other.errorValidation == errorValidation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, onSecureText, errorValidation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomTextFieldStateImplCopyWith<_$CustomTextFieldStateImpl>
      get copyWith =>
          __$$CustomTextFieldStateImplCopyWithImpl<_$CustomTextFieldStateImpl>(
              this, _$identity);
}

abstract class _CustomTextFieldState implements CustomTextFieldState {
  const factory _CustomTextFieldState(
      {final bool onSecureText,
      final String errorValidation}) = _$CustomTextFieldStateImpl;

  @override
  bool get onSecureText;
  @override
  String get errorValidation;
  @override
  @JsonKey(ignore: true)
  _$$CustomTextFieldStateImplCopyWith<_$CustomTextFieldStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
