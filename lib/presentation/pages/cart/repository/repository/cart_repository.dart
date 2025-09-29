import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/create_order_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_order_response.dart';

abstract class CartRepository {
  Future<ApiResult<dynamic>> getCartProducts();

  Future<ApiResult<dynamic>> addToCart({required int id});

  Future<ApiResult<dynamic>> removeFromCart({required int id});

  Future<ApiResult<dynamic>> deleteFromCart({required int id});

  Future<ApiResult<dynamic>> fillAddress({
    required String address,
    required String address2,
    required String city,
    required String postalCode,
  });

  Future<ApiResult<dynamic>> getOrders();

  Future<ApiResult<dynamic>> createOrder({
    required int addressID,
    required String paymentType,
    required String deliveryType,
    String? orderComment
});

  Future<ApiResult<dynamic>> getAllAddresses();

  Future<ApiResult<dynamic>> clearCart();

}
