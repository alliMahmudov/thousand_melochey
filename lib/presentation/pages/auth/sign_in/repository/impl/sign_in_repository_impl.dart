
import 'package:thousand_melochey/contstants/app_api_error_helper.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_in/data/sign_in_response.dart';


class SignInRepositoryImpl extends SignInRepository {
  @override
  Future<ApiResult<dynamic>> login(
      {required String email, required String password}) async {
    final data = <String, String>{"email": email, "password": password};

    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post('api/login/', data: data);
      return ApiResult.success(
        data: SignInResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> sign in failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: AppApiErrorHelper.message(e.response?.data));
    } catch (e) {
      debugPrint('==> sign in failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
/*@override
  Future<ApiResult<SignInResponse>> login(
      {required String email, required String password}) async {
    final data = <String, String>{"email": email, "password": password};

    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post('api/login/', data: data);
      return ApiResult.success(
        data: SignInResponse.fromJson(response.data),

      );
    } on DioError catch (e) {
      debugPrint('==> sign in failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: SignInResponse.fromJson(e.response?.data));
    } catch (e) {
      debugPrint('==> sign in failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }*/
}
