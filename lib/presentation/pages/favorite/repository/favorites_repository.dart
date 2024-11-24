

import 'package:thousand_melochey/core/handlers/api_result.dart';

abstract class FavoritesRepository{

  Future<ApiResult<dynamic>> getFavoritesList();
  Future<ApiResult<dynamic>> addToFavorites({required int productID});
  Future<ApiResult<dynamic>> removeFromFavorites({required int productID});

}