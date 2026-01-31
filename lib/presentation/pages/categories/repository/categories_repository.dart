import 'package:thousand_melochey/core/handlers/api_result.dart';

abstract class CategoriesRepository{
  Future<ApiResult<dynamic>> getCategories();

  Future<ApiResult<dynamic>> getCategoryProducts({required int categoryId, int? currentPage});

  Future<ApiResult<dynamic>> getSearchedCategory({String? search});

}