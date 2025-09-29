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
  int get selectedOrderTab => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  String get paymentType => throw _privateConstructorUsedError;
  String get deliveryType => throw _privateConstructorUsedError;
  Map<int, bool> get pendingCartOperations =>
      throw _privateConstructorUsedError;
  CartResponse? get cartProduct => throw _privateConstructorUsedError;
  CreateOrderResponse? get orders => throw _privateConstructorUsedError;
  OrdersResponse? get getOrders => throw _privateConstructorUsedError;
  AllAddressesResponse? get userAllAddresses =>
      throw _privateConstructorUsedError;
  Address? get selectedUserAddress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
      int selectedOrderTab,
      String errorMessage,
      String paymentType,
      String deliveryType,
      Map<int, bool> pendingCartOperations,
      CartResponse? cartProduct,
      CreateOrderResponse? orders,
      OrdersResponse? getOrders,
      AllAddressesResponse? userAllAddresses,
      Address? selectedUserAddress});
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res, $Val extends CartState>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProductLoading = null,
    Object? isOrdersLoading = null,
    Object? isResponseError = null,
    Object? isError = null,
    Object? selectedOrderTab = null,
    Object? errorMessage = null,
    Object? paymentType = null,
    Object? deliveryType = null,
    Object? pendingCartOperations = null,
    Object? cartProduct = freezed,
    Object? orders = freezed,
    Object? getOrders = freezed,
    Object? userAllAddresses = freezed,
    Object? selectedUserAddress = freezed,
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
      selectedOrderTab: null == selectedOrderTab
          ? _value.selectedOrderTab
          : selectedOrderTab // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryType: null == deliveryType
          ? _value.deliveryType
          : deliveryType // ignore: cast_nullable_to_non_nullable
              as String,
      pendingCartOperations: null == pendingCartOperations
          ? _value.pendingCartOperations
          : pendingCartOperations // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
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
              as OrdersResponse?,
      userAllAddresses: freezed == userAllAddresses
          ? _value.userAllAddresses
          : userAllAddresses // ignore: cast_nullable_to_non_nullable
              as AllAddressesResponse?,
      selectedUserAddress: freezed == selectedUserAddress
          ? _value.selectedUserAddress
          : selectedUserAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
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
      int selectedOrderTab,
      String errorMessage,
      String paymentType,
      String deliveryType,
      Map<int, bool> pendingCartOperations,
      CartResponse? cartProduct,
      CreateOrderResponse? orders,
      OrdersResponse? getOrders,
      AllAddressesResponse? userAllAddresses,
      Address? selectedUserAddress});
}

/// @nodoc
class __$$CartStateImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartStateImpl>
    implements _$$CartStateImplCopyWith<$Res> {
  __$$CartStateImplCopyWithImpl(
      _$CartStateImpl _value, $Res Function(_$CartStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProductLoading = null,
    Object? isOrdersLoading = null,
    Object? isResponseError = null,
    Object? isError = null,
    Object? selectedOrderTab = null,
    Object? errorMessage = null,
    Object? paymentType = null,
    Object? deliveryType = null,
    Object? pendingCartOperations = null,
    Object? cartProduct = freezed,
    Object? orders = freezed,
    Object? getOrders = freezed,
    Object? userAllAddresses = freezed,
    Object? selectedUserAddress = freezed,
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
      selectedOrderTab: null == selectedOrderTab
          ? _value.selectedOrderTab
          : selectedOrderTab // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      paymentType: null == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as String,
      deliveryType: null == deliveryType
          ? _value.deliveryType
          : deliveryType // ignore: cast_nullable_to_non_nullable
              as String,
      pendingCartOperations: null == pendingCartOperations
          ? _value._pendingCartOperations
          : pendingCartOperations // ignore: cast_nullable_to_non_nullable
              as Map<int, bool>,
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
              as OrdersResponse?,
      userAllAddresses: freezed == userAllAddresses
          ? _value.userAllAddresses
          : userAllAddresses // ignore: cast_nullable_to_non_nullable
              as AllAddressesResponse?,
      selectedUserAddress: freezed == selectedUserAddress
          ? _value.selectedUserAddress
          : selectedUserAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
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
      this.selectedOrderTab = 0,
      this.errorMessage = '',
      this.paymentType = '',
      this.deliveryType = '',
      final Map<int, bool> pendingCartOperations = const {},
      this.cartProduct,
      this.orders,
      this.getOrders,
      this.userAllAddresses,
      this.selectedUserAddress})
      : _pendingCartOperations = pendingCartOperations;

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
  final int selectedOrderTab;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final String paymentType;
  @override
  @JsonKey()
  final String deliveryType;
  final Map<int, bool> _pendingCartOperations;
  @override
  @JsonKey()
  Map<int, bool> get pendingCartOperations {
    if (_pendingCartOperations is EqualUnmodifiableMapView)
      return _pendingCartOperations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pendingCartOperations);
  }

  @override
  final CartResponse? cartProduct;
  @override
  final CreateOrderResponse? orders;
  @override
  final OrdersResponse? getOrders;
  @override
  final AllAddressesResponse? userAllAddresses;
  @override
  final Address? selectedUserAddress;

  @override
  String toString() {
    return 'CartState(isLoading: $isLoading, isProductLoading: $isProductLoading, isOrdersLoading: $isOrdersLoading, isResponseError: $isResponseError, isError: $isError, selectedOrderTab: $selectedOrderTab, errorMessage: $errorMessage, paymentType: $paymentType, deliveryType: $deliveryType, pendingCartOperations: $pendingCartOperations, cartProduct: $cartProduct, orders: $orders, getOrders: $getOrders, userAllAddresses: $userAllAddresses, selectedUserAddress: $selectedUserAddress)';
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
            (identical(other.selectedOrderTab, selectedOrderTab) ||
                other.selectedOrderTab == selectedOrderTab) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.deliveryType, deliveryType) ||
                other.deliveryType == deliveryType) &&
            const DeepCollectionEquality()
                .equals(other._pendingCartOperations, _pendingCartOperations) &&
            (identical(other.cartProduct, cartProduct) ||
                other.cartProduct == cartProduct) &&
            (identical(other.orders, orders) || other.orders == orders) &&
            (identical(other.getOrders, getOrders) ||
                other.getOrders == getOrders) &&
            (identical(other.userAllAddresses, userAllAddresses) ||
                other.userAllAddresses == userAllAddresses) &&
            (identical(other.selectedUserAddress, selectedUserAddress) ||
                other.selectedUserAddress == selectedUserAddress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isProductLoading,
      isOrdersLoading,
      isResponseError,
      isError,
      selectedOrderTab,
      errorMessage,
      paymentType,
      deliveryType,
      const DeepCollectionEquality().hash(_pendingCartOperations),
      cartProduct,
      orders,
      getOrders,
      userAllAddresses,
      selectedUserAddress);

  @JsonKey(ignore: true)
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
      final int selectedOrderTab,
      final String errorMessage,
      final String paymentType,
      final String deliveryType,
      final Map<int, bool> pendingCartOperations,
      final CartResponse? cartProduct,
      final CreateOrderResponse? orders,
      final OrdersResponse? getOrders,
      final AllAddressesResponse? userAllAddresses,
      final Address? selectedUserAddress}) = _$CartStateImpl;

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
  int get selectedOrderTab;
  @override
  String get errorMessage;
  @override
  String get paymentType;
  @override
  String get deliveryType;
  @override
  Map<int, bool> get pendingCartOperations;
  @override
  CartResponse? get cartProduct;
  @override
  CreateOrderResponse? get orders;
  @override
  OrdersResponse? get getOrders;
  @override
  AllAddressesResponse? get userAllAddresses;
  @override
  Address? get selectedUserAddress;
  @override
  @JsonKey(ignore: true)
  _$$CartStateImplCopyWith<_$CartStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
