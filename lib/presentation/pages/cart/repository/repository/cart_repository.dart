import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/create_order_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_order_response.dart';

abstract class CartRepository {
  Future<ApiResult<CartResponse>> getCartProducts({required String jwtToken});

  Future<ApiResult<dynamic>> addToCart(
      {required String jwtToken, required int id});

  Future<ApiResult<dynamic>> removeFromCart(
      {required String jwtToken, required int id});

  Future<ApiResult<dynamic>> deleteFromCart(
      {required String jwtToken, required int id});

  Future<ApiResult<dynamic>> fillAddress({
    required String jwtToken,
    required String address,
    required String address2,
    required String city,
    required String postalCode,
  });

  Future<ApiResult<CreateOrderResponse>> createOrder({required String jwtToken});
  Future<ApiResult<GetOrderResponse>> getOrders({required String jwtToken});



}
