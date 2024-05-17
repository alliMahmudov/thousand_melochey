

import 'package:thousand_melochey/contstants/app_api_error_helper.dart';
import 'package:thousand_melochey/core/handlers/api_result.dart';
import 'package:thousand_melochey/core/handlers/http_service.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/data/otp_response.dart';
import 'package:thousand_melochey/presentation/pages/auth/otp/repository/otp_repository.dart';

class OTPRepositoryImpl extends OTPRepository{


  @override
  Future<ApiResult> postOTP({required String email, required String otp}) async {
    final data = <String, String> {
      'email': email,
      'otp': otp
    };


    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post('api/verify-otp/', data: data);
      return ApiResult.success(
        data: OtpResponse.fromJson(response.data),
      );
    } on DioError catch (e) {
      debugPrint('==> OTP failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: AppApiErrorHelper.message(e.response?.data));
    } catch (e) {
      debugPrint('==> OTP failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }


}