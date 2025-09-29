import 'package:flutter/cupertino.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/cart_page.dart';
import 'package:thousand_melochey/presentation/pages/catogories/presentation/categories_page.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/favorite_page.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/home_page.dart';
import 'package:thousand_melochey/presentation/pages/main/data/navbar_enum.dart';
import 'package:thousand_melochey/presentation/pages/profile/presentation/profile_page.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

import '../state/main_state.dart';

class MainNotifier extends StateNotifier<MainState> {
  final Ref ref;
  final int index;

  MainNotifier(this.index, this.ref) : super(const MainState());
  List<IndexedStackChild> list = [
    IndexedStackChild(child: const HomePage(), preload: false),
    IndexedStackChild(child: const CategoriesPage(), preload: false),
    IndexedStackChild(child: const FavoritePage(), preload: false),
    IndexedStackChild(child: const CartPage(), preload: false),
    IndexedStackChild(child: const ProfilePage(), preload: false),
  ];
  List<NavItemEnum> navItem = [
    NavItemEnum.home,
    NavItemEnum.search,
    NavItemEnum.favorite,
    NavItemEnum.cart,
    NavItemEnum.profile,
  ];

  List<String> labels(context) {
    return [
      '${AppLocalization.getText(context)?.home}',
      '${AppLocalization.getText(context)?.catalog}',
      '${AppLocalization.getText(context)?.favorite}',
      '${AppLocalization.getText(context)?.cart}',
      '${AppLocalization.getText(context)?.profile}',
    ];
  }

  List<GlobalKey<NavigatorState>> listKey = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<IconData> icons = [
    CupertinoIcons.house,
    CupertinoIcons.search_circle,
    CupertinoIcons.heart,
    CupertinoIcons.cart,
    CupertinoIcons.person,
  ];

  List<IconData> selectedIcons = [
    CupertinoIcons.house_fill,
    CupertinoIcons.search_circle_fill,
    CupertinoIcons.heart_fill,
    CupertinoIcons.cart_fill,
    CupertinoIcons.person_fill,
  ];

  void incrementPageIndex(item) {
    state = state.copyWith(indexPage: item);
  }

  userTypeChange(String userType) {
    state = state.copyWith(userType: userType);
  }

}


