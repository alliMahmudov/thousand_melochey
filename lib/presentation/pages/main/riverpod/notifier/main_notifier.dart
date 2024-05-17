import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/presentation/cart_page.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/favorite_page.dart';
import 'package:thousand_melochey/presentation/pages/home/presentation/home_page.dart';
import 'package:thousand_melochey/presentation/pages/main/data/navbar_enum.dart';
import 'package:thousand_melochey/presentation/pages/profile/profile_page.dart';

import '../state/main_state.dart';

class MainNotifier extends StateNotifier<MainState> {
  final Ref ref;
  final int index;

  MainNotifier(this.index, this.ref) : super(MainState());
  List<IndexedStackChild> list = [
    IndexedStackChild(child: const HomePage(), preload: false),
    IndexedStackChild(child: const FavoritePage(), preload: false),
    IndexedStackChild(child: const CartPage(), preload: false),
    IndexedStackChild(child: const ProfilePage(), preload: false),
  ];
  List<NavItemEnum> navItem = [
    NavItemEnum.home,
    NavItemEnum.favorite,
    NavItemEnum.cart,
    NavItemEnum.profile,
  ];

  // List<String> labels = [
  //    "navbar.home".tr(),
  //    "navbar.catalog".tr(),
  //    "navbar.shopping_cart".tr(),
  //    "navbar.profile".tr(),
  //
  // ];

  List<String> labels(context) {
    return [
      'Home',
      'Favourite',
      'Cart',
      'Profile',
    ];
  }

  /*List<String> labels = [
    "Home",
    "Statistics",
    "Subscription",
    "Account",
  ];*/

  List<GlobalKey<NavigatorState>> listKey = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  void incrementPageIndex(item) {
    state = state.copyWith(indexPage: item);
  }

  userTypeChange(String userType) {
    state = state.copyWith(userType: userType);
  }

/*  listenId() {
    state = state.copyWith(shopId: LocalStorage.instance.getSelectedShopId());
  }*/



  /*internetConnection() {
    InternetConnection().onStatusChange.listen(
      (status) async {
        state = state.copyWith(
          connectionStatus: status,
          shopId: LocalStorage.instance.getSelectedShopId(),
        );
        fetchDebtActions(LocalStorage.instance.getDebtActions());
        if (status == InternetStatus.connected) {
          final debtActionsResponse = LocalStorage.instance.getDebtActions();
          final dataString = json.encode(debtActionsResponse);
          final data = jsonDecode(dataString);
          log("$data");
          final actions = LocalStorageDebtActionsResponse.fromJson(data);
          if (actions.data?.isNotEmpty ?? false) {
            processDebtActions(
                LocalStorageDebtActionsResponse.fromJson(data).data ?? []);
          }
          // }
        }
      },
    );
  }*/

/*  Future<void> paymentDebtsClient({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    VoidCallback? validate,
    required int shopId,
    required int clientId,
    required String? deadline,
    String? description1,
    int? debtAmount,
  }) async {
    final response = await clientProfileRepository.paymentDebtClient(
      shopId: shopId,
      clientId: clientId,
      deadline: deadline,
      description: description1,
      baseAmount: debtAmount,
    );
    response.when(
      success: (data) async {
        success?.call();
        AppHelpers.showMaterialBannerSuccess(
            message:
                "Success add ${AppMoneyFormatter.formatString(debtAmount.toString())} UZS");
        ref.read(homeProvider(0).notifier).getShopInfoClients(shopId: shopId);
      },
      failure: (failure, status, errorMessage) {
        // state = state.copyWith(isLoading: false, isError: true);
        AppHelpers.showMaterialBannerError(errorMessage: errorMessage);
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }

        debugPrint('==> add debts client failure: $failure');
      },
    );
  }
  fetchDebtActions(dynamic debt){
    state = state.copyWith(debtActionsResponse: AppDebtActionsResponseParser.parser(debt));

  }

  Future<void> processDebtActions(List<Datum> debtActions) async {
    log("${debtActions.first.baseAmount},${debtActions.first.shopId},${debtActions.first.clientId},${debtActions.length}");
    await paymentDebtsClient(
      shopId: debtActions.first.shopId ?? 0,
      clientId: debtActions.first.clientId ?? 0,
      deadline: debtActions.first.deadline,
      debtAmount: debtActions.first.baseAmount,
      description1: debtActions.first.description,
    ).whenComplete(() async {
      final debtActionsResponse = LocalStorage.instance.getDebtActions();
      final dataString = json.encode(debtActionsResponse);
      final dataJson = jsonDecode(dataString);
      final data = LocalStorageDebtActionsResponse.fromJson(dataJson);
      data.data?.removeAt(0);
      await LocalStorage.instance.setDebtActions(
          LocalStorageDebtActionsResponse.fromJson(data.toJson()));
      if ((data.data?.length ?? 0) > 0) {
        log(data.toJson().toString());
        fetchDebtActions(data.toJson());
        return processDebtActions(
            LocalStorageDebtActionsResponse.fromJson(data.toJson()).data ?? []);
      }
      fetchDebtActions(data.toJson());

    });
    fetchDebtActions(LocalStorage.instance.getDebtActions());

  }*/
}


