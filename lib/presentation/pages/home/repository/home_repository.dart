import 'package:thousand_melochey/core/imports/imports.dart';

abstract class HomeRepository{
  Future<ApiResult<dynamic>> getProducts({
    int? currentPage,
    String? searchQuery
  });

  Future<ApiResult<dynamic>> getSearchedProducts({String? search});

  Future<ApiResult<dynamic>> getNewProducts();

}