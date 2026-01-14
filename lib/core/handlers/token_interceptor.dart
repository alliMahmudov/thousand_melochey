
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
    final String token = LocalStorage.instance.getJWT();
    if (token.isNotEmpty && token != "" && requireAuth) {
      options.headers.addAll({'Cookie': 'jwt=$token'});
    }
    // Обновляем заголовок языка динамически при каждом запросе
    options.headers['Accept-Language'] = LocalStorage.instance.getLang();
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Обрабатываем ошибки аутентификации
    if (requireAuth && LocalStorage.instance.isAuthenticated()) {
      final statusCode = err.response?.statusCode;
      // Если сервер вернул 401 или 403, токен невалидный - удаляем его
      if (statusCode == 401 || statusCode == 403) {
        final path = err.requestOptions.path.toLowerCase();
        // Не удаляем токен и не перенаправляем, если это запрос на аутентификацию
        final isAuthRequest = path.contains('login') || 
                              path.contains('sign-in') || 
                              path.contains('sign-up') ||
                              path.contains('otp') ||
                              path.contains('forgot-password') ||
                              path.contains('reset-password');
        
        if (!isAuthRequest) {
          // Токен невалидный - удаляем его и перенаправляем на страницу входа
          LocalStorage.instance.deleteJWT();
          LocalStorage.instance.logout();
          AppNavigator.pushAndPopUntil(SignInRoute());
        }
      }
    }
    handler.next(err);
  }
}

