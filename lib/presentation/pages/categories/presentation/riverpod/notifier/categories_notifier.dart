import 'package:thousand_melochey/presentation/pages/categories/data/categories_response.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/state/categories_state.dart';
import 'package:thousand_melochey/presentation/pages/categories/repository/categories_repository.dart';
import 'package:thousand_melochey/presentation/pages/home/data/category_products_response.dart';
// import 'package:thousand_melochey/presentation/pages/home/data/category_products_response.dart';
import '../../../../../../core/imports/imports.dart';
import '../../../../home/data/products_response.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final CategoriesRepository _categoriesRepository;

  CategoriesNotifier(this._categoriesRepository) : super(const CategoriesState());

  final ScrollController scrollController = ScrollController();
  final TextEditingController categorySearchController = TextEditingController();


  Future<void> getCategories({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _categoriesRepository.getSearchedCategory(search: categorySearchController.text);
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

  // Future<void> getCategories({
  //   VoidCallback? checkYourNetwork,
  //   VoidCallback? unAuthorised,
  //   VoidCallback? success,
  //   String? searchQuery,
  //   int currentPage = 1,
  //   bool hasMore = false,
  //   bool isRefresh = false
  // }) async {
  //   try {
  //     if (!(hasMore)) {
  //       if (isRefresh) {
  //         state = state.copyWith(isLoading: true);
  //       } else {
  //         state = state.copyWith(isLoadMore: true);
  //       }
  //
  //       final response = await _categoriesRepository.getSearchedCategory(search: searchQuery);
  //
  //       response.when(
  //         success: (data) async {
  //           List<Category> categories = List.from(state.categories?.data ?? []);
  //           List<Category> newCategories = data ?? [];
  //           isRefresh ? categories = newCategories : categories.addAll(newCategories);
  //
  //           state = state.copyWith(
  //             isLoading: false,
  //             categories: CategoriesResponse(
  //                 data: categories,
  //                 meta: data.meta
  //             ),
  //           );
  //
  //           if (isRefresh) {
  //           } else {
  //             (data.results?.length ?? 0) <= 15
  //                 ? state = state.copyWith(isLoadMore: false)
  //                 : state = state.copyWith(isLoadMore: true);
  //           }
  //           success?.call();
  //         },
  //         failure: (failure, status, data) {
  //           state = state.copyWith(
  //             isLoading: false,
  //             isLoadMore: false,
  //           );
  //
  //           if (isRefresh) {
  //             state = state.copyWith(
  //               isLoading: false,
  //               isLoadMore: false,
  //             );
  //             // refreshController?.finishRefresh();
  //           } else {
  //             (data?.results?.length ?? 0) <= 15
  //                 ? state = state.copyWith(
  //               isLoadMore: false,
  //               isLoading: false,
  //             ) : state = state.copyWith(
  //               isLoadMore: true,
  //               isLoading: false,
  //             );
  //           }
  //           if (failure == const NetworkExceptions.unauthorisedRequest()) {
  //             unAuthorised?.call();
  //           }
  //           debugPrint('==> get searched categories response failure: $failure');
  //         },
  //       );
  //     } else {
  //       state = state.copyWith(
  //         isLoadMore: false,
  //         isLoading: false,
  //       );
  //     }
  //   } catch (e) {
  //     state = state.copyWith(
  //       isLoadMore: false,
  //       isLoading: false,
  //     );
  //   }
  // }

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
            List<Product> products = List.from(state.products?.data ?? []);
            List<Product> newProducts = data.data ?? [];

            isRefresh ? products = newProducts : products.addAll(newProducts);

            state = state.copyWith(
                isLoading: false,
                isLoadMore: false,
                products: ProductsResponse(
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

  Future<void> getPaginationCategoryProducts({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required int categoryId,
    int currentPage = 1,
    bool isRefresh = false
  }) async {

    state = state.copyWith(isLoadingPaginationProducts: true);

    try {
      if (isRefresh) {
        state = state.copyWith(isLoadingPaginationProducts: true);
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
              isLoadingPaginationProducts: false,
              isLoadMore: false,
              categoryProducts: CategoryProductsResponse(
                  data: products,
                  meta: data.meta
              ));

          success?.call();
        },
        failure: (failure, status, data) {
          state = state.copyWith(isLoadingPaginationProducts: false, isLoadMore: false);

          if (failure == const NetworkExceptions.unauthorisedRequest()) {
            unAuthorised?.call();
          }
          debugPrint('==> get category products response failure: $failure');
        },
      );

    } catch (e) {
      state = state.copyWith(isLoadMore: false, isLoadingPaginationProducts: false);
    }
  }
}
