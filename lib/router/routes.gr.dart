// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AllOrdersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AllOrdersPage(),
      );
    },
    CartRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CartPage(),
      );
    },
    CategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoriesPage(),
      );
    },
    CategoryProductsRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryProductsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CategoryProductsPage(
          categoryName: args.categoryName,
          key: args.key,
        ),
      );
    },
    CheckOutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CheckOutPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    OTPRoute.name: (routeData) {
      final args = routeData.argsAs<OTPRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OTPPage(
          email: args.email,
          key: args.key,
        ),
      );
    },
    ProductDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductDetailPage(
          key: args.key,
          id: args.id,
          name: args.name,
          price: args.price,
          description: args.description,
          image: args.image,
          images: args.images,
        ),
      );
    },
    ResetPassRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPassRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ResetPassPage(
          email: args.email,
          key: args.key,
        ),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
    UserAddressesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserAddressesPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [AllOrdersPage]
class AllOrdersRoute extends PageRouteInfo<void> {
  const AllOrdersRoute({List<PageRouteInfo>? children})
      : super(
          AllOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllOrdersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CartPage]
class CartRoute extends PageRouteInfo<void> {
  const CartRoute({List<PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoriesPage]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CategoryProductsPage]
class CategoryProductsRoute extends PageRouteInfo<CategoryProductsRouteArgs> {
  CategoryProductsRoute({
    required String categoryName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CategoryProductsRoute.name,
          args: CategoryProductsRouteArgs(
            categoryName: categoryName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryProductsRoute';

  static const PageInfo<CategoryProductsRouteArgs> page =
      PageInfo<CategoryProductsRouteArgs>(name);
}

class CategoryProductsRouteArgs {
  const CategoryProductsRouteArgs({
    required this.categoryName,
    this.key,
  });

  final String categoryName;

  final Key? key;

  @override
  String toString() {
    return 'CategoryProductsRouteArgs{categoryName: $categoryName, key: $key}';
  }
}

/// generated route for
/// [CheckOutPage]
class CheckOutRoute extends PageRouteInfo<void> {
  const CheckOutRoute({List<PageRouteInfo>? children})
      : super(
          CheckOutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckOutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OTPPage]
class OTPRoute extends PageRouteInfo<OTPRouteArgs> {
  OTPRoute({
    required String email,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          OTPRoute.name,
          args: OTPRouteArgs(
            email: email,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OTPRoute';

  static const PageInfo<OTPRouteArgs> page = PageInfo<OTPRouteArgs>(name);
}

class OTPRouteArgs {
  const OTPRouteArgs({
    required this.email,
    this.key,
  });

  final String email;

  final Key? key;

  @override
  String toString() {
    return 'OTPRouteArgs{email: $email, key: $key}';
  }
}

/// generated route for
/// [ProductDetailPage]
class ProductDetailRoute extends PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    Key? key,
    required int? id,
    required String? name,
    required String? price,
    required String? description,
    required String? image,
    List<String>? images,
    List<PageRouteInfo>? children,
  }) : super(
          ProductDetailRoute.name,
          args: ProductDetailRouteArgs(
            key: key,
            id: id,
            name: name,
            price: price,
            description: description,
            image: image,
            images: images,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static const PageInfo<ProductDetailRouteArgs> page =
      PageInfo<ProductDetailRouteArgs>(name);
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    this.key,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    this.images,
  });

  final Key? key;

  final int? id;

  final String? name;

  final String? price;

  final String? description;

  final String? image;

  final List<String>? images;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, id: $id, name: $name, price: $price, description: $description, image: $image, images: $images}';
  }
}

/// generated route for
/// [ResetPassPage]
class ResetPassRoute extends PageRouteInfo<ResetPassRouteArgs> {
  ResetPassRoute({
    required String email,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ResetPassRoute.name,
          args: ResetPassRouteArgs(
            email: email,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPassRoute';

  static const PageInfo<ResetPassRouteArgs> page =
      PageInfo<ResetPassRouteArgs>(name);
}

class ResetPassRouteArgs {
  const ResetPassRouteArgs({
    required this.email,
    this.key,
  });

  final String email;

  final Key? key;

  @override
  String toString() {
    return 'ResetPassRouteArgs{email: $email, key: $key}';
  }
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserAddressesPage]
class UserAddressesRoute extends PageRouteInfo<void> {
  const UserAddressesRoute({List<PageRouteInfo>? children})
      : super(
          UserAddressesRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAddressesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
