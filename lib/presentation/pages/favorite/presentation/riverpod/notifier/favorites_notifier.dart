import 'package:shared_preferences/shared_preferences.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/presentation/pages/favorite/data/favorites_response.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/riverpod/state/favorites_state.dart';
import 'package:thousand_melochey/presentation/pages/favorite/repository/favorites_repository.dart';

import '../../../../../../core/imports/imports.dart';
import '../../../../home/data/products_response.dart';
import '../../../../favorite/data/favorites_response.dart';

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesNotifier(this._favoritesRepository) : super(const FavoritesState());

  List<FavoritesDatum> localFavorites = [];

  switchFavorite(bool isLiked, int id, context,
      {VoidCallback? success}) {
    // Оптимистичное обновление UI
    final newPendingFavorites = Map<int, bool>.from(state.pendingFavorites);
    newPendingFavorites[id] = !isLiked;
    state = state.copyWith(pendingFavorites: newPendingFavorites);
    
    // Выполняем запрос в фоне
    if (isLiked == true) {
      // Если продукт уже лайкнут, то убираем из избранного
      removeFromFavorites(
        productID: id,
        success: () {
          // Убираем из pending и обновляем локальное состояние
          final updatedPendingFavorites = Map<int, bool>.from(state.pendingFavorites);
          updatedPendingFavorites.remove(id);
          state = state.copyWith(pendingFavorites: updatedPendingFavorites);
          
          // Обновляем favoritesList, убирая продукт
          final updatedFavoritesList = state.favoritesList?.data?.where((item) => item.id != id).toList();
          final updatedFavoritesResponse = FavoritesResponse(data: updatedFavoritesList);

          state = state.copyWith(
            pendingFavorites: updatedPendingFavorites,
            favoritesList: updatedFavoritesResponse,
          );
          success?.call();
          // Обновляем список избранного, чтобы подтянуть актуальные данные
          getFavoritesList();
        },
        failure: () {
          // Возвращаем предыдущее состояние при ошибке
          final updatedPendingFavorites = Map<int, bool>.from(state.pendingFavorites);
          updatedPendingFavorites[id] = isLiked;
          state = state.copyWith(pendingFavorites: updatedPendingFavorites);
        }
      );
    } else {
      // Если продукт не лайкнут, то добавляем в избранное
      addToFavorites(
        productID: id,
        success: () {
          // Убираем из pending и обновляем локальное состояние
          final updatedPendingFavorites = Map<int, bool>.from(state.pendingFavorites);
          updatedPendingFavorites.remove(id);
          
          // Создаем новый элемент для добавления в favoritesList
          // Здесь нужно создать FavoritesDatum с минимальными данными
          final newFavoriteItem = FavoritesDatum(
            id: id,
            name: null, // Временное имя, можно оставить пустым
            description: null,
            price: null, // Временная цена
            image: null, // Временное изображение
          );
          
          final updatedFavoritesList = <FavoritesDatum>[...(state.favoritesList?.data ?? []), newFavoriteItem];
          final updatedFavoritesResponse = FavoritesResponse(data: updatedFavoritesList);
          
          state = state.copyWith(
            pendingFavorites: updatedPendingFavorites,
            favoritesList: updatedFavoritesResponse,
          );
          success?.call();
          // Обновляем список избранного, чтобы подтянуть актуальные данные
          getFavoritesList();
        },
        failure: () {
          // Возвращаем предыдущее состояние при ошибке
          final updatedPendingFavorites = Map<int, bool>.from(state.pendingFavorites);
          updatedPendingFavorites[id] = isLiked;
          state = state.copyWith(pendingFavorites: updatedPendingFavorites);
        }
      );
    }
  }


  bool? checkFavorite(int id){
    // Сначала проверяем pending состояния
    if (state.pendingFavorites.containsKey(id)) {
      return state.pendingFavorites[id];
    }
    // Затем проверяем реальное состояние
    return state.favoritesList?.data?.any((likedProduct) => likedProduct.id == id) ?? false;
  }

  Future<void> getFavoritesList({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    //required String jwtToken
  }) async {
    state = state.copyWith(isFavoritesLoading: true);
    final jwtToken = LocalStorage.instance.getJWT();
    final response =
        await _favoritesRepository.getFavoritesList(jwtToken: "jwt=$jwtToken");
    response.when(
      success: (data) async {
        state = state.copyWith(isFavoritesLoading: false, favoritesList: data);
        localFavorites = data?.data;
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
    VoidCallback? failure,
    required int productID,
    //required String jwtToken
  }) async {
    state = state.copyWith(isLoading: true);
    final jwtToken = await LocalStorage.instance.getJWT();
    final response = await _favoritesRepository.addToFavorites(
        productID: productID, jwtToken: "jwt=$jwtToken");
    response.when(success: (data) {
      state = state.copyWith(isLoading: false, addToFavorites: data);
      success?.call();
    }, failure: (fail, status, data) {
      state = state.copyWith(
          isLoading: false, isResponseError: true, addToFavorites: data);
      if (fail == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> add to favorites response failure: $fail');
      failure?.call();
    });
  }

  Future<void> removeFromFavorites({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    VoidCallback? failure,
    required int productID,
  }) async {
    state = state.copyWith(isLoading: true);

    final jwtToken = LocalStorage.instance.getJWT();
    final response = await _favoritesRepository.removeFromFavorites(
        productID: productID, jwtToken: "jwt=$jwtToken");
    response.when(success: (data) {
      state = state.copyWith(isLoading: false, isFavorite: true);
      success?.call();
    }, failure: (fail, status, data) {
      state = state.copyWith(isLoading: false, isResponseError: true);
      if (fail == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==>remove from favorite response failure: $fail');
      failure?.call();
    });
  }
}
