
import 'package:thousand_melochey/core/handlers/api_result.dart';

abstract class SignUpRepository {
  Future<ApiResult<dynamic>> register({
    required String name,

    required String password,
    required String phone,
    // required String passwordConfirmation,
    required String email,
  });
}
