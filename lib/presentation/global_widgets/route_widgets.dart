import 'package:thousand_melochey/core/imports/imports.dart';

class AppNavigator {
  AppNavigator._();

  static pushAndPopUntil(PageRouteInfo pageRouteInfo) {
    appRouter.pushAndPopUntil(pageRouteInfo, predicate: (route) => false);
  }

  static push(PageRouteInfo pageRouteInfo) {
    appRouter.push(
      pageRouteInfo,
    );
  }

  static pushNamed(String route) {
    appRouter.pushNamed(route);
  }

  static Future<void> pop() async {
    await appRouter.pop();
  }

  static back() {
    appRouter.back();
  }
// static materialBannerClosed() {
//   // AppGlobalKey.rootUI.navigatorKey.currentContext?.d();
// }
}
