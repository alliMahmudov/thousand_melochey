import 'package:thousand_melochey/core/imports/imports.dart';

class ProfileRepositoryImpl extends ProfileRepository {
/*  @override
  Future<ApiResult<UserInfoResponse>> getUserInfo() async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get("/api/user/");

      return ApiResult.success(
        data: UserInfoResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint("==> get user info failure: ${e.response?.data}");
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: UserInfoResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint("==> get products failure: $e");
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }*/

  @override
  Future<ApiResult<UserInfoResponse>> getUserInfo({
    required String jwtToken
}) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true, jwtToken: jwtToken, isToken: true);
      final response = await client.get('/api/user/');
      return ApiResult.success(
        data: UserInfoResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> get user info failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: UserInfoResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> get user info failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> logOut() async {
    try {
      final client = inject<HttpService>().client();
      final response = await client.post('/api/logout/');
      return const ApiResult.success(
        data: "Log out successfully",
      );
    } on DioException catch (e) {
      debugPrint('==> logout  failure: ${e.response?.data}');
      return ApiResult.failure(
        error: NetworkExceptions.getDioException(e),
        statusCode: NetworkExceptions.getDioStatus(e),
        data: UserInfoResponse.fromJson(e.response?.data),
      );
    } catch (e) {
      debugPrint('==> log out failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
