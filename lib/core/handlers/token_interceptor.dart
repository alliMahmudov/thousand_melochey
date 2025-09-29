
import 'package:dio/dio.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import '../imports/imports.dart';

class TokenInterceptor extends Interceptor {
  final bool requireAuth;

  TokenInterceptor({required this.requireAuth});

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final String token = await LocalStorage.instance.getJWT() ?? "1";
    if (token.isNotEmpty && token != "" && requireAuth) {
      options.headers.addAll({'Cookie': 'jwt=$token'});
    }
    handler.next(options);
  }
}

