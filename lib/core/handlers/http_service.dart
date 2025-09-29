import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:thousand_melochey/contstants/api_path.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/handlers/token_interceptor.dart';



class HttpService {

  Dio client({bool requireAuth = false, bool? requiredPost}) => Dio(
    BaseOptions(
      baseUrl: ApiPath.baseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      headers: {
        'Accept': 'application/json',
        // if (isToken) 'cookie': jwtToken,
        'Accept-Language': LocalStorage.instance.getLang(),
        'cookie': 'jwt=${LocalStorage.instance.getJWT()}'
        // 'Content-type': 'application/json',
        // 'Authorization': 'Bearer ${LocalStorage.instance.getToken()}'
      },
    ),
  )
    ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
    ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true))
    ..interceptors.add(CookieManager(CookieJar()))
   // ..interceptors.add(CachedInterceptor(requiredPost: requiredPost))
    //..transformer = FlutterTransformer()
  ;
}
