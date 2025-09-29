import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/cart_page.dart';
import 'package:thousand_melochey/presentation/pages/catogories/presentation/categories_page.dart';
import 'package:thousand_melochey/presentation/pages/catogories/presentation/widgets/category_products.dart';

import '../presentation/pages/profile/presentation/widgets/all_orders_page.dart';
import '../presentation/pages/profile/presentation/widgets/user_addresses_page.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CupertinoRoute(page: WelcomeRoute.page, initial: true, path: "/welcome"),
        CupertinoRoute(page: SignInRoute.page,path: "/sign_in"),
        CupertinoRoute(page: SignUpRoute.page, path: "/sign_up"),
        CupertinoRoute(page: MainRoute.page,  path: "/main"),
        CupertinoRoute(page: HomeRoute.page, path: "/home"),
        CupertinoRoute(page: OTPRoute.page, path: "/OTP"),
        CupertinoRoute(page: ForgotPasswordRoute.page, path: "/forgot_password"),
        CupertinoRoute(page: ProductDetailRoute.page, path: "/product_detail"),
        CupertinoRoute(page: ResetPassRoute.page, path: "/reset_password"),
        CupertinoRoute(page: CheckOutRoute.page, path: "/checkout"),
        CupertinoRoute(page: CartRoute.page, path: "/cart"),
        CupertinoRoute(page: AllOrdersRoute.page, path: "/all_route"),
        CupertinoRoute(page: CategoryProductsRoute.page, path: "/category_products"),
        CupertinoRoute(page: UserAddressesRoute.page, path: "/user_addresses"),
      ];
}
