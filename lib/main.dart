import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:thousand_melochey/core/imports/imports.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
  setUpDependencies();
  runApp(const ProviderScope(
      child: RequestsInspector(
          enabled: true, navigatorKey: null, child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 835),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter.config(),
          title: '1000 melochey',
          theme: ThemeData(
            fontFamily: "Comfortaa",
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: AppColors.primaryColor,
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
        );
      },
    );
  }
}
