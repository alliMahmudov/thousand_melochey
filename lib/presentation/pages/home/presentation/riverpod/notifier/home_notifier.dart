import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/home/data/products_response.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository _homeRepository;

  HomeNotifier(this._homeRepository) : super(const HomeState());

  TextEditingController searchTextFieldController = TextEditingController();

  List<Widget> tabs(context) {
    return [
      const Tab(
        child: Text("All"),
      ),
      const Tab(
        child: Text("Gloves"),
      ),
      const Tab(
        child: Text("Screwdrivers"),
      ),
      const Tab(
        child: Text("Electronics"),
      ),
      const Tab(
        child: Text("Tools"),
      ),
    ];
  }

  void expandDescription (bool isDescriptionExpanded) => state = state.copyWith(isDescriptionExpanded: isDescriptionExpanded);


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
            List<Result> products = List.from(state.products?.results ?? []);
            List<Result> newProducts = data.results ?? [];
            isRefresh ? products = newProducts : products.addAll(newProducts);

            state = state.copyWith(
              isLoading: false,
              products: ProductsResponse(
                  results: products,
                  next: data.next,
                  previous: data.previous,
                  count: data.count
              ),
            );

            if (isRefresh) {
            } else {
              (data.results?.length ?? 0) <= 15
                  ? state = state.copyWith(isLoadMore: false)
                  : state = state.copyWith(isLoadMore: true);
            }
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
            if (isRefresh) {
            } else {}
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
    bool hasMore = false,
    bool isRefresh = false,
  }) async {
    // state = state.copyWith(isLoadingShopInfoClients: true);
    // int page = 0;
    try {
      if (!(hasMore)) {
        if (isRefresh) {
          state = state.copyWith(isLoading: true);
        } else {
          state = state.copyWith(isLoadMore: true);

          // page = state.shopInfoClients?.paginator?.lastPage ?? (state.shopInfoClients?.paginator?.currentPage ?? 1);
        }

        final response = await _homeRepository.getProducts(
          currentPage: currentPage,
          searchQuery: searchQuery
        );

        response.when(
          success: (data) async {
            List<Result> products = List.from(state.products?.results ?? []);
            List<Result> newProducts = data.results ?? [];
            isRefresh ? products = newProducts : products.addAll(newProducts);

            state = state.copyWith(
              isLoading: false,
              products: ProductsResponse(
                results: products,
                next: data.next,
                previous: data.previous,
                count: data.count
              ),
            );

            if (isRefresh) {
            } else {
              (data.results?.length ?? 0) <= 15
                  ? state = state.copyWith(isLoadMore: false)
                  : state = state.copyWith(isLoadMore: true);
            }
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
            debugPrint('==> get products response failure: $failure');
            if (isRefresh) {
            } else {}
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

  // Future<void> getCategories({
  //   VoidCallback? checkYourNetwork,
  //   VoidCallback? unAuthorised,
  //   VoidCallback? success,
  // }) async {
  //   state = state.copyWith(isLoading: true);
  //   final response = await _homeRepository.getCategories();
  //   response.when(
  //     success: (data) async {
  //       state = state.copyWith(isLoading: false, categories: data);
  //       success?.call();
  //     },
  //     failure: (failure, status, data) {
  //       state = state.copyWith(
  //           isLoading: false, isResponseError: true, categories: data);
  //       if (failure == const NetworkExceptions.unauthorisedRequest()) {
  //         unAuthorised?.call();
  //       }
  //       debugPrint('==> get categories response failure: $failure');
  //     },
  //   );
  // }
}
