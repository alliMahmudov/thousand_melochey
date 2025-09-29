import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/favorite/data/add_to_favorites_response.dart';
import 'package:thousand_melochey/presentation/pages/favorite/data/favorites_response.dart';
import 'package:thousand_melochey/presentation/pages/favorite/repository/favorites_repository.dart';

class FavoritesRepositoryImpl extends FavoritesRepository {
  @override
  Future<ApiResult> getFavoritesList({required String jwtToken}) async {
    try {
      final client = inject<HttpService>()
          .client(requireAuth: true);
      final response = await client.get("/api/user/favorites/");

      return ApiResult.success(
        data: FavoritesResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get favorites list failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: FavoritesResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> get favorites list failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> addToFavorites(
      {required int productID, required String jwtToken}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post("api/products/favorites/$productID/");
      return ApiResult.success(
          data: AddToFavoritesResponse.fromJson(response.data));
    } on DioException catch (e) {
      debugPrint('==> add to favorites failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: FavoritesResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> add to favorites failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> removeFromFavorites(
      {required int productID, required String jwtToken}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.delete('api/products/favorites/$productID/');
      return const ApiResult.success(data: "Removed from favorites");
    } on DioException catch (e) {
      debugPrint("==> remove from favorites: ${e.response?.data}");
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: FavoritesResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> remove from favorites failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
