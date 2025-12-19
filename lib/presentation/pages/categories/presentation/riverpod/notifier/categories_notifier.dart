import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/state/categories_state.dart';
import 'package:thousand_melochey/presentation/pages/categories/repository/categories_repository.dart';
import 'package:thousand_melochey/presentation/pages/home/data/category_products_response.dart';
import '../../../../../../core/imports/imports.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final CategoriesRepository _categoriesRepository;

  CategoriesNotifier(this._categoriesRepository) : super(const CategoriesState());

  final ScrollController scrollController = ScrollController();


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
    required int categoryId,
    int currentPage = 1,
    bool isRefresh = false
  }) async {

    state = state.copyWith(isLoading: true);

    try {
      if (isRefresh) {
        state = state.copyWith(isLoading: true);
      } else {
        state = state.copyWith(isLoadMore: true);
      }

      final response = await _categoriesRepository.getCategoryProducts(
          categoryId: categoryId,
          currentPage: currentPage
      );

      response.when(
        success: (data) async {
            List<Datum> products = List.from(state.categoryProducts?.data ?? []);
            List<Datum> newProducts = data.data ?? [];

            isRefresh ? products = newProducts : products.addAll(newProducts);

            state = state.copyWith(
                isLoading: false,
                isLoadMore: false,
                categoryProducts: CategoryProductsResponse(
                  data: products,
                  meta: data.meta
                ));

            success?.call();
          },
        failure: (failure, status, data) {
            state = state.copyWith(isLoading: false, isLoadMore: false);

            if (failure == const NetworkExceptions.unauthorisedRequest()) {
              unAuthorised?.call();
            }
            debugPrint('==> get category products response failure: $failure');
          },
      );

    } catch (e) {
      state = state.copyWith(isLoadMore: false, isLoading: false);
    }
  }
}
