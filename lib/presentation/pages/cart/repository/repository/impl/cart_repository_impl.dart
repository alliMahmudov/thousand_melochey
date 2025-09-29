import 'package:thousand_melochey/contstants/app_api_error_helper.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/add_to_cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/create_order_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_districts_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_order_response.dart';
import 'package:thousand_melochey/presentation/pages/profile/data/all_adresses_response.dart';

class CartRepositoryImpl extends CartRepository {
  @override
  Future<ApiResult<dynamic>> getCartProducts() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("api/user/cart/");

      return ApiResult.success(data: CartResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> get cart products failure1: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> get cart products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> addToCart({required int id}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post('/api/products/cart/$id/');

      return ApiResult.success(data: AddToCartResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> add to cart products failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> add to cart products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> removeFromCart({required int id}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.delete('/api/products/cart/$id/');
      return const ApiResult.success(
          data: "Product successfully removed from cart");
    } on DioException catch (e) {
      debugPrint('==> remove from cart products failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> remove from cart products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> deleteFromCart({required int id}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.delete('api/cart/delete/$id/');

      return const ApiResult.success(data: "Product successfully deleted from cart");

    } on DioException catch (e) {
      debugPrint('==> delete from cart products failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> delete from cart products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> fillAddress(
      {required String address,
      required String address2,
      required String city,
      required String postalCode}) async {
    try {
      final data = <String, String>{
        "address_line1": address,
        "address_line2": address2,
        "city": city,
        "postal_code": postalCode,
        "country": "Uzbekistan"
      };

      final client = inject<HttpService>()
          .client(requireAuth: true);
      final response = await client.post('api/user/addresses/', data: data);
      return const ApiResult.success(data: "Address section filled");
    } on DioException catch (e) {
      debugPrint('==> Address filled failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> Address filled failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> createOrder({
    required int addressID,
    required String paymentType,
    required String deliveryType,
    String? orderComment
}) async {
    final data = <String, dynamic>{
      "address_id": "$addressID",
      "payment_type": paymentType,
      "delivery_type": deliveryType,
      if(orderComment != null) "comment": orderComment
    };
    try {
      final client = inject<HttpService>()
          .client(requireAuth: true);
      final response = await client.post('api/user/create-order/', data: data);
      return ApiResult.success(
          data: CreateOrderResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> Create order failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: AppApiErrorHelper.message(e.response?.data)
      );
    } catch (e) {
      debugPrint('==> Create order failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> getOrders() async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('api/user/orders/');
      return ApiResult.success(
          data: OrdersResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> Create order failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> Create order failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> getAllAddresses() async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('api/user/all/addresses/');
      return ApiResult.success(
          data: AllAddressesResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get all addresses failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> get all addresses failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> clearCart() async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.delete('api/products/cart/delete_entirely/');
      return ApiResult.success(data: response.data);

    } on DioException catch (e) {
      debugPrint('==> Get districts failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );

    } catch (e) {
      debugPrint('==> Get districts failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
