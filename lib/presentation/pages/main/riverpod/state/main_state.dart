import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thousand_melochey/presentation/pages/main/data/navbar_enum.dart';


part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default(0) int indexPage,
    @Default(0) int shopId,
    @Default("") String lang,
    @Default("") String loadingText,
    @Default("") String userType,
    // @Default(false) bool showFloatingButtonHome,
    //InternetStatus? connectionStatus,
    //LocalStorageDebtActionsResponse? debtActionsResponse,

    @Default([
      NavItemEnum.home,
      NavItemEnum.favorite,
      NavItemEnum.cart,
      NavItemEnum.profile,
    ])
    List<NavItemEnum> navItem,
    @Default([]) List<GlobalKey<NavigatorState>> listKey,
    @Default([]) List<String> icons,
  }) = _MainState;
}
