import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/create_order_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_districts_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_order_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/all_adresses_response.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(false) bool isLoading,
    @Default(false) bool isProductLoading,
    @Default(false) bool isOrdersLoading,
    @Default(false) bool isResponseError,
    @Default(false) bool isError,
    @Default(0) int selectedOrderTab,
    @Default('') String errorMessage,
    @Default('') String paymentType,
    @Default('') String deliveryType,
    @Default({}) Map<int, bool> pendingCartOperations,
    CartResponse? cartProduct,
    CreateOrderResponse? orders,
    OrdersResponse? getOrders,
    AllAddressesResponse? userAllAddresses,
    Address? selectedUserAddress


  }) = _CartState;
}
