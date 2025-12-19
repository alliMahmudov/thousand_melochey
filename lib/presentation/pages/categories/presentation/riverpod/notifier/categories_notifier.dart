import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_melochey/presentation/pages/catogories/presentation/riverpod/state/categories_state.dart';
import 'package:thousand_melochey/presentation/pages/catogories/repository/categories_repository.dart';

import '../../../../../../core/imports/imports.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final CategoriesRepository _categoriesRepository;

  CategoriesNotifier(this._categoriesRepository) : super(const CategoriesState());

  Future<void> getCategories({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _categoriesRepository.getCategories();
    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false, categories: data);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(
            isLoading: false, categories: data);
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> get categories response failure: $failure');
      },
    );
  }

  Future<void> getCategoryProducts({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required String categoryName
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _categoriesRepository.getCategoryProducts(categoryName: categoryName);
    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false, categoryProducts: data);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(isLoading: false);
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> get category products response failure: $failure');
      },
    );
  }
}
