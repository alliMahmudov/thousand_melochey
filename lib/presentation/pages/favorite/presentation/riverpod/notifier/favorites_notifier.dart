import 'package:shared_preferences/shared_preferences.dart';
import 'package:thousand_melochey/core/handlers/sp.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/riverpod/state/favorites_state.dart';
import 'package:thousand_melochey/presentation/pages/favorite/repository/favorites_repository.dart';

import '../../../../../../core/imports/imports.dart';
import '../../../../home/data/products_response.dart';

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesNotifier(this._favoritesRepository) : super(const FavoritesState());

  switchFavorite(bool isLiked, int id, context) {
    return isLiked == true
        ? removeFromFavorites(
            productID: id,
            success: () {
              getFavoritesList();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Product removed to wishlist")));
            })
        : addToFavorites(
            productID: id,
            success: () {
              getFavoritesList();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Product added to wishlist")));
            });
  }


  bool? checkFavorite(int id){
    return state.favoritesList?.data?.any((likedProduct) => likedProduct.id == id);
  }

  Future<void> getFavoritesList({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    //required String jwtToken
  }) async {
    state = state.copyWith(isFavoritesLoading: true);
    final jwtToken = await SP.readFromSP("JWT");
    final response =
        await _favoritesRepository.getFavoritesList(jwtToken: "jwt=$jwtToken");
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
    required int productID,
    //required String jwtToken
  }) async {
    state = state.copyWith(isLoading: true);
    final jwtToken = await SP.readFromSP("JWT");
    final response = await _favoritesRepository.addToFavorites(
        productID: productID, jwtToken: "jwt=$jwtToken");
    response.when(success: (data) {
      state = state.copyWith(isLoading: false, addToFavorites: data);
      success?.call();
    }, failure: (failure, status, data) {
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
    required int productID,
  }) async {
    state = state.copyWith(isLoading: true);

    final jwtToken = await SP.readFromSP("JWT");
    final response = await _favoritesRepository.removeFromFavorites(
        productID: productID, jwtToken: "jwt=$jwtToken");
    response.when(success: (data) {
      state = state.copyWith(isLoading: false, isFavorite: true);
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(isLoading: false, isResponseError: true);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==>remove from favorite response failure: $failure');
    });
  }
}
