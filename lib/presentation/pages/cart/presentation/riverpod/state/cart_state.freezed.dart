// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CartState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isProductLoading => throw _privateConstructorUsedError;
  bool get isOrdersLoading => throw _privateConstructorUsedError;
  bool get isResponseError => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  TextEditingController? get phoneController =>
      throw _privateConstructorUsedError;
  TextEditingController? get addressController =>
      throw _privateConstructorUsedError;
  TextEditingController? get nameController =>
      throw _privateConstructorUsedError;
  CartResponse? get cartProduct => throw _privateConstructorUsedError;
  CreateOrderResponse? get orders => throw _privateConstructorUsedError;
  GetOrderResponse? get getOrders => throw _privateConstructorUsedError;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartStateCopyWith<CartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res, CartState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isProductLoading,
      bool isOrdersLoading,
      bool isResponseError,
      bool isError,
      String errorMessage,
      TextEditingController? phoneController,
      TextEditingController? addressController,
      TextEditingController? nameController,
      CartResponse? cartProduct,
      CreateOrderResponse? orders,
      GetOrderResponse? getOrders});
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res, $Val extends CartState>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProductLoading = null,
    Object? isOrdersLoading = null,
    Object? isResponseError = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? phoneController = freezed,
    Object? addressController = freezed,
    Object? nameController = freezed,
    Object? cartProduct = freezed,
    Object? orders = freezed,
    Object? getOrders = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isProductLoading: null == isProductLoading
          ? _value.isProductLoading
          : isProductLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isOrdersLoading: null == isOrdersLoading
          ? _value.isOrdersLoading
          : isOrdersLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isResponseError: null == isResponseError
          ? _value.isResponseError
          : isResponseError // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      phoneController: freezed == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      addressController: freezed == addressController
          ? _value.addressController
          : addressController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      nameController: freezed == nameController
          ? _value.nameController
          : nameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      cartProduct: freezed == cartProduct
          ? _value.cartProduct
          : cartProduct // ignore: cast_nullable_to_non_nullable
              as CartResponse?,
      orders: freezed == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as CreateOrderResponse?,
      getOrders: freezed == getOrders
          ? _value.getOrders
          : getOrders // ignore: cast_nullable_to_non_nullable
              as GetOrderResponse?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartStateImplCopyWith<$Res>
    implements $CartStateCopyWith<$Res> {
  factory _$$CartStateImplCopyWith(
          _$CartStateImpl value, $Res Function(_$CartStateImpl) then) =
      __$$CartStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isProductLoading,
      bool isOrdersLoading,
      bool isResponseError,
      bool isError,
      String errorMessage,
      TextEditingController? phoneController,
      TextEditingController? addressController,
      TextEditingController? nameController,
      CartResponse? cartProduct,
      CreateOrderResponse? orders,
      GetOrderResponse? getOrders});
}

/// @nodoc
class __$$CartStateImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartStateImpl>
    implements _$$CartStateImplCopyWith<$Res> {
  __$$CartStateImplCopyWithImpl(
      _$CartStateImpl _value, $Res Function(_$CartStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProductLoading = null,
    Object? isOrdersLoading = null,
    Object? isResponseError = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? phoneController = freezed,
    Object? addressController = freezed,
    Object? nameController = freezed,
    Object? cartProduct = freezed,
    Object? orders = freezed,
    Object? getOrders = freezed,
  }) {
    return _then(_$CartStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isProductLoading: null == isProductLoading
          ? _value.isProductLoading
          : isProductLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isOrdersLoading: null == isOrdersLoading
          ? _value.isOrdersLoading
          : isOrdersLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isResponseError: null == isResponseError
          ? _value.isResponseError
          : isResponseError // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      phoneController: freezed == phoneController
          ? _value.phoneController
          : phoneController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      addressController: freezed == addressController
          ? _value.addressController
          : addressController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      nameController: freezed == nameController
          ? _value.nameController
          : nameController // ignore: cast_nullable_to_non_nullable
              as TextEditingController?,
      cartProduct: freezed == cartProduct
          ? _value.cartProduct
          : cartProduct // ignore: cast_nullable_to_non_nullable
              as CartResponse?,
      orders: freezed == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as CreateOrderResponse?,
      getOrders: freezed == getOrders
          ? _value.getOrders
          : getOrders // ignore: cast_nullable_to_non_nullable
              as GetOrderResponse?,
    ));
  }
}

/// @nodoc

class _$CartStateImpl implements _CartState {
  const _$CartStateImpl(
      {this.isLoading = false,
      this.isProductLoading = false,
      this.isOrdersLoading = false,
      this.isResponseError = false,
      this.isError = false,
      this.errorMessage = '',
      this.phoneController,
      this.addressController,
      this.nameController,
      this.cartProduct,
      this.orders,
      this.getOrders});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isProductLoading;
  @override
  @JsonKey()
  final bool isOrdersLoading;
  @override
  @JsonKey()
  final bool isResponseError;
  @override
  @JsonKey()
  final bool isError;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  final TextEditingController? phoneController;
  @override
  final TextEditingController? addressController;
  @override
  final TextEditingController? nameController;
  @override
  final CartResponse? cartProduct;
  @override
  final CreateOrderResponse? orders;
  @override
  final GetOrderResponse? getOrders;

  @override
  String toString() {
    return 'CartState(isLoading: $isLoading, isProductLoading: $isProductLoading, isOrdersLoading: $isOrdersLoading, isResponseError: $isResponseError, isError: $isError, errorMessage: $errorMessage, phoneController: $phoneController, addressController: $addressController, nameController: $nameController, cartProduct: $cartProduct, orders: $orders, getOrders: $getOrders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isProductLoading, isProductLoading) ||
                other.isProductLoading == isProductLoading) &&
            (identical(other.isOrdersLoading, isOrdersLoading) ||
                other.isOrdersLoading == isOrdersLoading) &&
            (identical(other.isResponseError, isResponseError) ||
                other.isResponseError == isResponseError) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.phoneController, phoneController) ||
                other.phoneController == phoneController) &&
            (identical(other.addressController, addressController) ||
                other.addressController == addressController) &&
            (identical(other.nameController, nameController) ||
                other.nameController == nameController) &&
            (identical(other.cartProduct, cartProduct) ||
                other.cartProduct == cartProduct) &&
            (identical(other.orders, orders) || other.orders == orders) &&
            (identical(other.getOrders, getOrders) ||
                other.getOrders == getOrders));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isProductLoading,
      isOrdersLoading,
      isResponseError,
      isError,
      errorMessage,
      phoneController,
      addressController,
      nameController,
      cartProduct,
      orders,
      getOrders);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartStateImplCopyWith<_$CartStateImpl> get copyWith =>
      __$$CartStateImplCopyWithImpl<_$CartStateImpl>(this, _$identity);
}

abstract class _CartState implements CartState {
  const factory _CartState(
      {final bool isLoading,
      final bool isProductLoading,
      final bool isOrdersLoading,
      final bool isResponseError,
      final bool isError,
      final String errorMessage,
      final TextEditingController? phoneController,
      final TextEditingController? addressController,
      final TextEditingController? nameController,
      final CartResponse? cartProduct,
      final CreateOrderResponse? orders,
      final GetOrderResponse? getOrders}) = _$CartStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isProductLoading;
  @override
  bool get isOrdersLoading;
  @override
  bool get isResponseError;
  @override
  bool get isError;
  @override
  String get errorMessage;
  @override
  TextEditingController? get phoneController;
  @override
  TextEditingController? get addressController;
  @override
  TextEditingController? get nameController;
  @override
  CartResponse? get cartProduct;
  @override
  CreateOrderResponse? get orders;
  @override
  GetOrderResponse? get getOrders;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartStateImplCopyWith<_$CartStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
