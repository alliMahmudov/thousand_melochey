import 'package:thousand_melochey/contstants/app_api_error_helper.dart';
import 'package:thousand_melochey/core/handlers/http_service.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/catogories/data/categories_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/category_products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/electronic_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/gloves_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/screwdrivers_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/tools_response.dart';

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
}
