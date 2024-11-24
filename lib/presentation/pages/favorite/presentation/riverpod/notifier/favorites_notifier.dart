import 'package:thousand_melochey/core/imports/imports.dart';

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesNotifier(this._favoritesRepository) : super(const FavoritesState());

  switchFavorite(
    bool isLiked,
    int id,
    context, {
    VoidCallback? success,
    VoidCallback? failure,
  }) {
    return isLiked == true
        ? removeFromFavorites(
            productID: id,
            success: () async {
              await getFavoritesList();
              success?.call();
              AppToast.showToastSuccess(
                  "Product removed from wishlist", context);
            },
            fail: () {
              AppToast.showToastError(
                  "Something went wrong. Try again", context);
            })
        : addToFavorites(
            productID: id,
            success: () async {
              AppToast.showToastSuccess("Product added to wishlist", context);
              await getFavoritesList();
              success?.call();
            },
            fail: () {
              AppToast.showToastError(
                  "Something went wrong. Try again", context);
            });
  }

  bool? checkFavorite(int id) {
    return state.favoritesList?.data
        ?.any((likedProduct) => likedProduct.id == id);
  }

  Future<void> getFavoritesList({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    //required String jwtToken
  }) async {
    state = state.copyWith(isFavoritesLoading: true);
    final response = await _favoritesRepository.getFavoritesList();
    response.when(
      success: (data) async {
        state = state.copyWith(isFavoritesLoading: false, favoritesList: data);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(
            isFavoritesLoading: false,
            isResponseError: true,
            favoritesList: data);
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> get favorites list response failure: $failure');
      },
    );
  }

  Future<void> addToFavorites({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    VoidCallback? fail,
    required int productID,
    //required String jwtToken
  }) async {
    state = state.copyWith(isLoading: true);
    final response =
        await _favoritesRepository.addToFavorites(productID: productID);
    response.when(success: (data) {
      state = state.copyWith(isLoading: false, addToFavorites: data);
      success?.call();
    }, failure: (failure, status, data) {
      fail?.call();
      state = state.copyWith(
          isLoading: false, isResponseError: true, addToFavorites: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> add to favorites response failure: $failure');
    });
  }

  Future<void> removeFromFavorites({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    VoidCallback? fail,
    required int productID,
  }) async {
    state = state.copyWith(isLoading: true);
    final response =
        await _favoritesRepository.removeFromFavorites(productID: productID);
    response.when(success: (data) {
      state = state.copyWith(isLoading: false, isFavorite: true);
      success?.call();
    }, failure: (failure, status, data) {
      fail?.call();
      state = state.copyWith(isLoading: false, isResponseError: true);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==>remove from favorite response failure: $failure');
    });
  }
}
