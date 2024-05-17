import 'package:thousand_melochey/core/handlers/http_service.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/data/electronic_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/gloves_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/screwdrivers_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/tools_response.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<ApiResult<ProductsResponse>> getProducts({required String? jwtToken}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true, jwtToken: jwtToken, isToken: true);
      final response = await client.get("/api/products/");

      return ApiResult.success(
        data: ProductsResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get products failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: ProductsResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> get products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

/*  @override
  Future<ApiResult<ProductsResponse>> getProductsByCategory(
      {required String? category}) async {
    String path =
        category == "all" ? "/api/products/" : "/api/category/$category";
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(path);

      return ApiResult.success(data: ProductsResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> get products by category failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: ProductsResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> get products failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }*/

  @override
  Future<ApiResult<GlovesCategoryResponse>> getGlovesCategory() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/category/gloves");

      return ApiResult.success(
        data: GlovesCategoryResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get gloves category failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: GlovesCategoryResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> get gloves category  failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ElectronicResponse>> getElectronicsCategory() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/category/electronics");

      return ApiResult.success(
        data: ElectronicResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get electronics category failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: ElectronicResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> get electronics category  failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ScrewdriversResponse>> getScrewdriversCategory() async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/category/screwdrivers");

      return ApiResult.success(
        data: ScrewdriversResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get screwdrivers category failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: ScrewdriversResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> get screwdrivers category  failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ToolsResponse>> getToolsCategory() async{
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/category/tools");

      return ApiResult.success(
        data: ToolsResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get tools category failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: ToolsResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> get tools category failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

}
