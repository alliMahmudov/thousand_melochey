

import 'package:thousand_melochey/core/handlers/api_result.dart';
import 'package:thousand_melochey/presentation/pages/auth/sign_in/data/sign_in_response.dart';

abstract class SignInRepository{
  Future<ApiResult<SignInResponse>> login({required String email, required String password});
}