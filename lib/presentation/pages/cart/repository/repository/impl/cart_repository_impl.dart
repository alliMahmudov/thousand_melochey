import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/create_order_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_order_response.dart';

class CartRepositoryImpl extends CartRepository {
  @override
  Future<ApiResult<CartResponse>> getCartProducts(
      {required String jwtToken}) async {
    try {
      final client = inject<HttpService>()
          .client(requireAuth: true, jwtToken: jwtToken, isToken: true);
      final response = await client.get("api/user/cart/");

      return ApiResult.success(data: CartResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> get cart products failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: CartResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> get cart products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> addToCart(
      {required String jwtToken, required int id}) async {
    try {
      final client = inject<HttpService>()
          .client(requireAuth: true, isToken: true, jwtToken: jwtToken);
      final response = await client.post('/api/products/cart/$id/');

      return const ApiResult.success(
          data: "Product successfully added to cart");
    } on DioException catch (e) {
      debugPrint('==> add to cart products failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: CartResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> add to cart products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> removeFromCart(
      {required String jwtToken, required int id}) async {
    try {
      final client = inject<HttpService>()
          .client(requireAuth: true, isToken: true, jwtToken: jwtToken);
      final response = await client.delete('/api/products/cart/$id/');
      return const ApiResult.success(
          data: "Product successfully removed from cart");
    } on DioException catch (e) {
      debugPrint('==> remove from cart products failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: CartResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> remove from cart products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> deleteFromCart(
      {required String jwtToken, required int id}) async {
    try {
      final client = inject<HttpService>()
          .client(requireAuth: true, isToken: true, jwtToken: jwtToken);
      final response =
          await client.delete('api/products/cart/delete_entirely/$id/');
      return const ApiResult.success(
          data: "Product successfully deleted from cart");
    } on DioException catch (e) {
      debugPrint('==> delete from cart products failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: CartResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> delete from cart products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> fillAddress(
      {required String jwtToken,
      required String address,
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
          .client(requireAuth: true, isToken: true, jwtToken: jwtToken);
      final response = await client.post('api/user/addresses/', data: data);
      return const ApiResult.success(data: "Address section filled");
    } on DioException catch (e) {
      debugPrint('==> Address filled failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: CartResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> Address filled failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<CreateOrderResponse>> createOrder({
    required String jwtToken,
  }) async {
    try {
      final client = inject<HttpService>()
          .client(requireAuth: true, isToken: true, jwtToken: jwtToken);
      final response = await client.post('api/user/create-order/');
      return ApiResult.success(
          data: CreateOrderResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> Create order failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: CreateOrderResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> Create order failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<GetOrderResponse>> getOrders({required String jwtToken}) async{
    try {
      final client = inject<HttpService>()
          .client(requireAuth: true, isToken: true, jwtToken: jwtToken);
      final response = await client.get('api/user/order-details/');
      return ApiResult.success(
          data: GetOrderResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> Create order failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: GetOrderResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> Create order failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
