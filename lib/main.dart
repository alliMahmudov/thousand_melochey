import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/no_internet_screen.dart';
import 'package:thousand_melochey/presentation/global_widgets/restart_widget.dart';
import 'package:thousand_melochey/service/connectivity_plus/internet_status_provider.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/service/localizations/riverpod/provider/localization_provider.dart';
import 'package:toastification/toastification.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.black));

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await LocalStorage.init();
  setUpDependencies();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langState = ref.watch(langProvider(0));
    final internetState = ref.watch(internetStatusProvider);
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
              title: '1000 МЕЛОЧЕЙ',
              builder: (context, child) {
                // if (internetState != InternetState.disconnected) {
                //   return const NoInternetScreen();
                // }
                return child!;
              },
              theme: ThemeData(
                primaryColor: AppColors.primaryColor,
                textTheme: GoogleFonts.interTextTheme(),
                appBarTheme: AppBarTheme(
                  color: AppColors.primaryColor,
                  centerTitle: true,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
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
