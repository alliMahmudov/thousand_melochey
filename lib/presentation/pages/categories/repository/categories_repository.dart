import 'package:thousand_melochey/core/handlers/api_result.dart';
import 'package:thousand_melochey/presentation/pages/catogories/data/categories_response.dart';

abstract class CategoriesRepository{
  Future<ApiResult<dynamic>> getCategories();

  Future<ApiResult<dynamic>> getCategoryProducts({required String categoryName});

}