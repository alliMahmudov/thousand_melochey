import 'package:thousand_melochey/core/imports/imports.dart';


T inject<T extends Object>() {
  return GetIt.I.get<T>();
}

final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerLazySingleton<SignInRepository>(() => SignInRepositoryImpl());
  getIt.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImpl());
  getIt.registerLazySingleton<OTPRepository>(() => OTPRepositoryImpl());
  getIt.registerLazySingleton<ForgotPasswordRepository>(() => ForgotPasswordRepositoryImpl());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
  getIt.registerLazySingleton<FavoritesRepository>(() => FavoritesRepositoryImpl());
  getIt.registerLazySingleton<ResetPassRepository>(() => ResetPassRepositoryImpl());
  getIt.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());
}

final appRouter = getIt.get<AppRouter>();
final httpService = getIt.get<HttpService>();
final signInRepository = getIt.get<SignInRepository>();
final signUpRepository = getIt.get<SignUpRepository>();
final otpRepository = getIt.get<OTPRepository>();
final forgotPasswordRepository = getIt.get<ForgotPasswordRepository>();
final homeRepository = getIt.get<HomeRepository>();
final profileRepository = getIt.get<ProfileRepository>();
final resetPassRepository = getIt.get<ResetPassRepository>();
final favoritesRepository = getIt.get<FavoritesRepository>();
final cartRepository = getIt.get<CartRepository>();
