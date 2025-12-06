import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/favorite/data/add_to_favorites_response.dart';
import 'package:thousand_melochey/presentation/pages/favorite/data/favorites_response.dart';
import '../../../../home/data/products_response.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default(false) bool isLoading,
    @Default(false) bool isResponseError,
    @Default(false) bool isNotEmpty,
    @Default(false) bool isCollapse,
    @Default(false) bool isError,
    @Default(false) bool isFavoritesLoading,
    @Default(false) bool isFavorite,
    @Default({}) Map<int, bool> pendingFavorites,
    @Default([]) List<Product> localFavoritesForGuest,

    FavoritesResponse? favoritesList,
    AddToFavoritesResponse? addToFavorites
  }) = _FavoritesState;
}
