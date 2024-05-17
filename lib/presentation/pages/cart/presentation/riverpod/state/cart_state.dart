import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/create_order_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_order_response.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(false) bool isLoading,
    @Default(false) bool isProductLoading,
    @Default(false) bool isOrdersLoading,
    @Default(false) bool isResponseError,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    TextEditingController? phoneController,
    TextEditingController? addressController,
    TextEditingController? nameController,

    CartResponse? cartProduct,
    CreateOrderResponse? orders,
    GetOrderResponse? getOrders
  }) = _CartState;
}
