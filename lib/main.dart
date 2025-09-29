import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/restart_widget.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/service/localizations/riverpod/provider/localization_provider.dart';
import 'package:toastification/toastification.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await LocalStorage.init();
  setUpDependencies();
  runApp(const ProviderScope(
      child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langState = ref.watch(langProvider(0));
    FlutterNativeSplash.remove();
    return RestartWidget(
      child: ScreenUtilInit(
        designSize: const Size(393, 835),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return ToastificationWrapper(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter.config(),
              title: '1000 melochey',
              theme: ThemeData(
                //colorSchemeSeed: AppColors.primaryColor,
                primaryColor: AppColors.primaryColor,
                fontFamily: "Comfortaa",
                appBarTheme: AppBarTheme(
                  color: AppColors.primaryColor,
                  centerTitle: true,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Comfortaa-Bold",
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                ),
                useMaterial3: false,
              ),
              localizationsDelegates: const [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              locale: langState.currentLang,
              supportedLocales: const [
                Locale('en'),
                Locale('ru'),
                Locale('uz'),
              ],
            ),
          );
        },
      ),
    );
  }
}
