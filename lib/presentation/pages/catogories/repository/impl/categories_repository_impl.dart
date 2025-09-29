import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/catogories/data/categories_response.dart';
import 'package:thousand_melochey/presentation/pages/catogories/repository/categories_repository.dart';
import 'package:thousand_melochey/presentation/pages/home/data/category_products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';

class CategoriesRepositoryImpl extends CategoriesRepository{
  @override
  Future<ApiResult<dynamic>> getCategories() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/categories/");

      return ApiResult.success(
        data: CategoriesResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get categories failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> get categories failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> getCategoryProducts({required String categoryName}) async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/categories/$categoryName/products");

      return ApiResult.success(
        data: CategoryProductsResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get category products failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
      );
    } catch (e) {
      debugPrint('==> get category products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}