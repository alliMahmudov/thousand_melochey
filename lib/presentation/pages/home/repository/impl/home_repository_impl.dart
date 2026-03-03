import 'package:thousand_melochey/contstants/app_api_error_helper.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/data/new_products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<ApiResult<dynamic>> getProducts({
    int? currentPage,
    String? searchQuery
  }) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/products/?page=${currentPage ?? 1}"
          "${searchQuery != null && searchQuery != "" ? "&q=$searchQuery" : ""}");

      return ApiResult.success(
        data: ProductsResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get products failure: ${e.response?.data}');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: AppApiErrorHelper.message(e.response?.data));
    } catch (e) {
      debugPrint('==> get products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> getSearchedProducts({String? search}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/products/autocomplete/?q=$search");

      return ApiResult.success(
        data: ProductsResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get searched products failure: ${e.response?.data}');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: AppApiErrorHelper.message(e.response?.data));
    } catch (e) {
      debugPrint('==> get searched products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> getNewProducts() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/products/latest/");
      return ApiResult.success(
        data: NewProductsResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get new products failure: ${e.response?.data}');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: AppApiErrorHelper.message(e.response?.data));
    } catch (e) {
      debugPrint('==> get new products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
