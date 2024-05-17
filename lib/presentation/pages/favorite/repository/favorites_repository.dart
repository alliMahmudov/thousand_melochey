

import 'package:thousand_melochey/core/handlers/api_result.dart';

abstract class FavoritesRepository{

  Future<ApiResult<dynamic>> getFavoritesList({required String jwtToken});
  Future<ApiResult<dynamic>> addToFavorites({required int productID, required String jwtToken});
  Future<ApiResult<dynamic>> removeFromFavorites({required int productID, required String jwtToken});

}