import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:thousand_melochey/contstants/app_api_error_helper.dart';
import 'package:thousand_melochey/core/handlers/api_result.dart';
import 'package:thousand_melochey/core/handlers/http_service.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/data/sign_up_response.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_up/repositories/sign_up_repository.dart';
import '../../../../../../core/handlers/network_exception.dart';
import '../../../../../../injection.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  @override
  Future<ApiResult<dynamic>> register(
      {required String name,

        required String password,
        required String phone,
        // required String passwordConfirmation,
        required String email}) async {
    final data = <String, String>{
      "name": name,
      "password": password,
      "phone_number": "+998$phone",
      "email": email
    };

    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post('api/register/', data: data);
      return ApiResult.success(
        data: SignUpResponse.fromJson(response.data),
      );
    } on DioError catch (e) {
      debugPrint('==> register failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: AppApiErrorHelper.message(e.response?.data)
      );
    } catch (e) {
      debugPrint('==> register failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
