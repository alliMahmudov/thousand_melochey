



import '../../../../../core/handlers/api_result.dart';

abstract class ForgotPasswordRepository{
  Future<ApiResult<dynamic>> forgotPass({required String email});
}