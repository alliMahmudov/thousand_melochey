


import 'dart:convert';

import 'package:thousand_melochey/core/handlers/api_result.dart';
import 'package:thousand_melochey/core/handlers/http_service.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/forgot_password/data/forgot_password_response.dart';
import 'package:thousand_melochey/presentation/pages/auth/forgot_password/repository/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository{
  @override
  Future<ApiResult<dynamic>> forgotPass({required String email, }) async {

    final data = <String, String>{"email": email,};

    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post('api/forgot-password/', data: data);
      return ApiResult.success(
        data: ForgotPassResponse.fromJson(response.data),
      );
    } on DioError catch (e) {
      debugPrint('==> forgot password failure: $e');
      final errorMessage = json.encode(e.response?.data);
      Map<String, dynamic> jsonData = json.decode(errorMessage);
      String message = jsonData['message'];
      debugPrint('Message: ${message.toString()}');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: message
      );
    } catch (e) {
      debugPrint('==> forgot password failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }

  }

}