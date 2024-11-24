import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/cart_page.dart';
import 'package:thousand_melochey/presentation/pages/profile/widgets/all_orders_widget.dart';
import 'package:thousand_melochey/presentation/pages/splash_page/splash_page.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CupertinoRoute(page: SplashRoute.page, initial: true, path: "/splash"),
        CupertinoRoute(page: WelcomeRoute.page, path: "/welcome"),
        CupertinoRoute(page: SignInRoute.page, path: "/sign_in"),
        CupertinoRoute(page: SignUpRoute.page, path: "/sign_up"),
        CupertinoRoute(page: MainRoute.page,  path: "/main"),
        CupertinoRoute(page: HomeRoute.page, path: "/home"),
        CupertinoRoute(page: OTPRoute.page, path: "/OTP"),
        CupertinoRoute(
            page: ForgotPasswordRoute.page, path: "/forgot_password"),
        CupertinoRoute(page: ProductDetailRoute.page, path: "/product_detail"),
        CupertinoRoute(page: ResetPassRoute.page, path: "/reset_password"),
        CupertinoRoute(page: CheckOutRoute.page, path: "/checkout"),
        CupertinoRoute(page: CartRoute.page, path: "/cart"),
        CupertinoRoute(page: AllOrdersRoute.page, path: "/all_route"),
      ];
}
