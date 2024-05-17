

import 'package:thousand_melochey/core/handlers/api_result.dart';

abstract class OTPRepository{
  Future<ApiResult<dynamic>> postOTP({required String email, required String otp});

}