import 'dart:developer';

import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository _homeRepository;

  HomeNotifier(this._homeRepository) : super(const HomeState());

  TextEditingController searchTextFieldController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void expandDescription (bool isDescriptionExpanded) => state = state.copyWith(isDescriptionExpanded: isDescriptionExpanded);

  void onSearchChanged(String value) {
    final query = value.trim();
    final isSearching = query.isNotEmpty;

    if (state.isSearching != isSearching) {
      state = state.copyWith(isSearching: isSearching);
    }

    getProducts(
      searchQuery: isSearching ? query : null,
      isRefresh: true,
    );
  }


  Future<void> getSearchedProducts({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    String? searchQuery,
    int currentPage = 1,
    bool hasMore = false,
    bool isRefresh = false
  }) async {
    // state = state.copyWith(isLoadingShopInfoClients: true);
    // int page = 0;
    try {
      if (!(hasMore)) {
        if (isRefresh) {
          state = state.copyWith(isLoading: true);
        } else {
          state = state.copyWith(isLoadMore: true);
        }

        final response = await _homeRepository.getSearchedProducts(search: searchQuery);

        response.when(
          success: (data) async {
            List<Product> products = List.from(state.products?.data ?? []);
            List<Product> newProducts = data.results ?? [];
            isRefresh ? products = newProducts : products.addAll(newProducts);

            state = state.copyWith(
              isLoading: false,
              products: ProductsResponse(
                  data: products,
                  meta: data.meta
              ),
            );

            if (isRefresh) {
            } else {
              (data.results?.length ?? 0) <= 15
                  ? state = state.copyWith(isLoadMore: false)
                  : state = state.copyWith(isLoadMore: true);
            }
            success?.call();
          },
          failure: (failure, status, data) {
            state = state.copyWith(
              isLoading: false,
              isLoadMore: false,
            );

            if (isRefresh) {
              state = state.copyWith(
                isLoading: false,
                isLoadMore: false,
              );
              // refreshController?.finishRefresh();
            } else {
              (data?.results?.length ?? 0) <= 15
                  ? state = state.copyWith(
                isLoadMore: false,
                isLoading: false,
              ) : state = state.copyWith(
                isLoadMore: true,
                isLoading: false,
              );
            }
            if (failure == const NetworkExceptions.unauthorisedRequest()) {
              unAuthorised?.call();
            }
            debugPrint('==> get searched products response failure: $failure');
          },
        );
      } else {
        state = state.copyWith(
          isLoadMore: false,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadMore: false,
        isLoading: false,
      );
    }
  }

  Future refreshHomePage() async{
    getProducts(
        isRefresh: true
    );
  }

  Future<void> getProducts({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    String? searchQuery,
    int currentPage = 1,
    bool isRefresh = false,
  }) async {
    try {
      if (isRefresh) {
        state = state.copyWith(isLoading: true);
      } else {
        state = state.copyWith(isLoadMore: true);
      }

      final response = await _homeRepository.getProducts(
          currentPage: currentPage,
          searchQuery: searchQuery
      );

      response.when(
        success: (data) async {
          List<Product> products = List.from(state.products?.data ?? []);
          List<Product> newProducts = data.data ?? [];
          isRefresh ? products = newProducts : products.addAll(newProducts);

          // hasNext из метаданных автоматически сохраняется в state через data.meta
          state = state.copyWith(
            isLoading: false,
            isLoadMore: false,
            products: ProductsResponse(
                data: products,
                meta: data.meta
            ),
          );
          success?.call();
        },
        failure: (failure, status, data) {
          state = state.copyWith(
            isLoading: false,
            isLoadMore: false,
          );

          if (failure == const NetworkExceptions.unauthorisedRequest()) {
            unAuthorised?.call();
          }
          debugPrint('==> get products response failure: $failure');
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoadMore: false,
        isLoading: false,
      );
    }
  }

  Future<void> getNewProducts({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _homeRepository.getNewProducts();
    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false, newProducts: data);
        success?.call();
      },
      failure: (failure, status, data) {
        state = state.copyWith(isLoading: false, isResponseError: true, newProducts: data);
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          unAuthorised?.call();
        }
        debugPrint('==> get new products response failure: $failure');
      },
    );
  }
}
