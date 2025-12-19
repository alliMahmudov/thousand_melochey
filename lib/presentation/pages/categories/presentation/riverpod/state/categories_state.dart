import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thousand_melochey/presentation/pages/catogories/data/categories_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/category_products_response.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';

part 'categories_state.freezed.dart';

@freezed
class CategoriesState with _$CategoriesState{
  const factory CategoriesState({
    @Default(false) bool isLoading,
    CategoriesResponse? categories,
    CategoryProductsResponse? categoryProducts,
}) = _CategoriesState;
}