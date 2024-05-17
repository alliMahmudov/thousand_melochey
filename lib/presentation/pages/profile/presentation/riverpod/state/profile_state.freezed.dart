// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isResponseError => throw _privateConstructorUsedError;
  bool get isNotEmpty => throw _privateConstructorUsedError;
  bool get isCollapse => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  bool get isUserInfoLoading => throw _privateConstructorUsedError;
  UserInfoResponse? get userInfo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isResponseError,
      bool isNotEmpty,
      bool isCollapse,
      bool isError,
      bool isUserInfoLoading,
      UserInfoResponse? userInfo});
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isResponseError = null,
    Object? isNotEmpty = null,
    Object? isCollapse = null,
    Object? isError = null,
    Object? isUserInfoLoading = null,
    Object? userInfo = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isResponseError: null == isResponseError
          ? _value.isResponseError
          : isResponseError // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotEmpty: null == isNotEmpty
          ? _value.isNotEmpty
          : isNotEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
      isCollapse: null == isCollapse
          ? _value.isCollapse
          : isCollapse // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isUserInfoLoading: null == isUserInfoLoading
          ? _value.isUserInfoLoading
          : isUserInfoLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      userInfo: freezed == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserInfoResponse?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
          _$ProfileStateImpl value, $Res Function(_$ProfileStateImpl) then) =
      __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isResponseError,
      bool isNotEmpty,
      bool isCollapse,
      bool isError,
      bool isUserInfoLoading,
      UserInfoResponse? userInfo});
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
      _$ProfileStateImpl _value, $Res Function(_$ProfileStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isResponseError = null,
    Object? isNotEmpty = null,
    Object? isCollapse = null,
    Object? isError = null,
    Object? isUserInfoLoading = null,
    Object? userInfo = freezed,
  }) {
    return _then(_$ProfileStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isResponseError: null == isResponseError
          ? _value.isResponseError
          : isResponseError // ignore: cast_nullable_to_non_nullable
              as bool,
      isNotEmpty: null == isNotEmpty
          ? _value.isNotEmpty
          : isNotEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
      isCollapse: null == isCollapse
          ? _value.isCollapse
          : isCollapse // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      isUserInfoLoading: null == isUserInfoLoading
          ? _value.isUserInfoLoading
          : isUserInfoLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      userInfo: freezed == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserInfoResponse?,
    ));
  }
}

/// @nodoc

class _$ProfileStateImpl implements _ProfileState {
  const _$ProfileStateImpl(
      {this.isLoading = false,
      this.isResponseError = false,
      this.isNotEmpty = false,
      this.isCollapse = false,
      this.isError = false,
      this.isUserInfoLoading = false,
      this.userInfo});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isResponseError;
  @override
  @JsonKey()
  final bool isNotEmpty;
  @override
  @JsonKey()
  final bool isCollapse;
  @override
  @JsonKey()
  final bool isError;
  @override
  @JsonKey()
  final bool isUserInfoLoading;
  @override
  final UserInfoResponse? userInfo;

  @override
  String toString() {
    return 'ProfileState(isLoading: $isLoading, isResponseError: $isResponseError, isNotEmpty: $isNotEmpty, isCollapse: $isCollapse, isError: $isError, isUserInfoLoading: $isUserInfoLoading, userInfo: $userInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isResponseError, isResponseError) ||
                other.isResponseError == isResponseError) &&
            (identical(other.isNotEmpty, isNotEmpty) ||
                other.isNotEmpty == isNotEmpty) &&
            (identical(other.isCollapse, isCollapse) ||
                other.isCollapse == isCollapse) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.isUserInfoLoading, isUserInfoLoading) ||
                other.isUserInfoLoading == isUserInfoLoading) &&
            (identical(other.userInfo, userInfo) ||
                other.userInfo == userInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isResponseError,
      isNotEmpty, isCollapse, isError, isUserInfoLoading, userInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState implements ProfileState {
  const factory _ProfileState(
      {final bool isLoading,
      final bool isResponseError,
      final bool isNotEmpty,
      final bool isCollapse,
      final bool isError,
      final bool isUserInfoLoading,
      final UserInfoResponse? userInfo}) = _$ProfileStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isResponseError;
  @override
  bool get isNotEmpty;
  @override
  bool get isCollapse;
  @override
  bool get isError;
  @override
  bool get isUserInfoLoading;
  @override
  UserInfoResponse? get userInfo;
  @override
  @JsonKey(ignore: true)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
