import 'package:thousand_melochey/core/imports/imports.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  setUpDependencies();
  final navigatorKey = GlobalKey<NavigatorState>();
  runApp(ProviderScope(child: RequestsInspector(
      enabled: true,
      navigatorKey: navigatorKey,
      child: const MyApp())));
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
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
                useMaterial3: false),
          );
        });
  }
}
