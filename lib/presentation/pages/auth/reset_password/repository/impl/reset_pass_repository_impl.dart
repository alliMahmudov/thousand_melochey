import 'package:thousand_melochey/core/imports/imports.dart';

class ResetPassRepositoryImpl extends ResetPassRepository {
  @override
  Future resetPassword(
      {required String otp, required String newPassword}) async {
    final data = <String, String>{"otp": otp, "new_password": newPassword};

    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post('api/reset-password/', data: data);
      return ApiResult.success(
        data: ResetPassResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      debugPrint('==> reset password failure: $e');
      final errorMessage = json.encode(e.response?.data);
      Map<String, dynamic> jsonData = json.decode(errorMessage);
      String message = jsonData['message'];
      debugPrint('Message: ${message.toString()}');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e),
          data: message);
    } catch (e) {
      debugPrint('==> reset password failure: $e');
      return ApiResult.failure(
          error: NetworkExceptions.getDioException(e),
          statusCode: NetworkExceptions.getDioStatus(e));
    }
  }
}
