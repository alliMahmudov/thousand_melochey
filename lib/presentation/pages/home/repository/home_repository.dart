import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/catogories/data/categories_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/category_products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/electronic_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/gloves_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/screwdrivers_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/tools_response.dart';

abstract class HomeRepository{
  Future<ApiResult<dynamic>> getProducts({
    int? currentPage,
    String? searchQuery
  });

  Future<ApiResult<dynamic>> getSearchedProducts({String? search});
}