import 'package:thousand_melochey/core/handlers/sp.dart';
import 'package:thousand_melochey/core/imports/imports.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository _homeRepository;

  HomeNotifier(this._homeRepository) : super(const HomeState());

/*  List categories = ["all", "gloves", "screwdrivers", "electronics", "tools"];

  String currentCategory = "all";
  changeCategory(String? category) => currentCategory = category ?? "";

  Future selectCategory(String? value) async {
    state = state.copyWith(selectedCategory: value ?? "1");
    await getProductsByCategory(category: value);
  }*/
  List<Widget> tabs(context) {
    return [
      const Tab(
        child: Text("All"),
      ),
      const Tab(
        child: Text("Gloves"),
      ),
      const Tab(
        child: Text("Screwdrivers"),
      ),
      const Tab(
        child: Text("Electronics"),
      ),
      const Tab(
        child: Text("Tools"),
      ),
    ];
  }
/*
  void setJwtToken(String jwt){
    state = state.copyWith(jwt: jwt);
  }*/

  Future refreshHomePage() async{
    getProducts();

  }
  Future<void> getProducts({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isProductLoading: true);
    final jwtToken = await SP.getJWT("JWT");
    final response = await _homeRepository.getProducts(jwtToken: "jwt=$jwtToken");
    response.when(
      success: (data) async {
        state = state.copyWith(isProductLoading: false, products: data);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(
            isProductLoading: false, isResponseError: true, products: data);
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> get products response failure: $failure');
      },
    );
  }

  Future<void> getGlovesCategory({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isProductLoading: true);

    final response = await _homeRepository.getGlovesCategory();
    response.when(success: (data) {
      state = state.copyWith(isProductLoading: false, glovesCategory: data);
      success?.call();

    }, failure: (failure, status, data) {
      state = state.copyWith(
          isProductLoading: false, isResponseError: true, glovesCategory: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> get gloves category response failure: $failure');
    });
  }

  Future<void> getScrewdriversCategory({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isProductLoading: true);

    final response = await _homeRepository.getScrewdriversCategory();
    response.when(success: (data) {
      state =
          state.copyWith(isProductLoading: false, screwdriversCategory: data);
      success?.call();

    }, failure: (failure, status, data) {
      state = state.copyWith(
          isProductLoading: false,
          isResponseError: true,
          screwdriversCategory: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> get screwdrivers category response failure: $failure');
    });
  }

  Future<void> getElectronicCategory({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isProductLoading: true);

    final response = await _homeRepository.getElectronicsCategory();
    response.when(success: (data) {
      state = state.copyWith(isProductLoading: false, electronicCategory: data);
      success?.call();

    }, failure: (failure, status, data) {
      state = state.copyWith(
          isProductLoading: false,
          isResponseError: true,
          electronicCategory: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> get electronic category response failure: $failure');
    });
  }

  Future<void> getToolsCategory({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isProductLoading: true);

    final response = await _homeRepository.getToolsCategory();
    response.when(success: (data) {
      state = state.copyWith(isProductLoading: false, toolsCategory: data);
      success?.call();

    }, failure: (failure, status, data) {
      state = state.copyWith(
          isProductLoading: false, isResponseError: true, toolsCategory: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> get tools category response failure: $failure');
    });
  }
}
