import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../profile/data/all_adresses_response.dart';

class CartNotifier extends StateNotifier<CartState> {
  final CartRepository _cartRepository;

  CartNotifier(this._cartRepository) : super(const CartState());
  ScrollController scrollController = ScrollController();

  TextEditingController orderCommentController = TextEditingController();

  // Проверка аутентификации должна быть динамической, а не вычисляться один раз
  bool get isAuth => LocalStorage.instance.isAuthenticated();

  bool? checkForExistence(int id) {
    return state.cartProduct?.data
        ?.any((cartProduct) => cartProduct.product?.id == id);
  }

  // Проверяем, есть ли pending операция для конкретного продукта
  bool isPendingOperation(int id) {
    return state.pendingCartOperations.containsKey(id);
  }

  selectOrderTab(int id) => state = state.copyWith(selectedOrderTab: id);

  isSelectedTab(int id) => id == state.selectedOrderTab;

  removeErrorMessage() => state = state.copyWith(errorMessage: '');

  selectUserAddress(Address address) => state = state.copyWith(selectedUserAddress: address);

  togglePaymentType(String type) => state = state.copyWith(paymentType: type);

  toggleDeliveryType(String type) => state = state.copyWith(deliveryType: type);

  // Future<void> fillAddress({
  //   VoidCallback? checkYourNetwork,
  //   VoidCallback? unAuthorised,
  //   VoidCallback? success,
  //   required BuildContext context,
  // }) async {
  //   final connectivity = await AppConnectivity.connectivity();
  //
  //   if (
  //       addressController.text.isNotEmpty &&
  //       state.selectedDistrict != null &&
  //       postalCodeController.text.isNotEmpty) {
  //     if (connectivity) {
  //       state = state.copyWith(isLoading: true);
  //       final response = await _cartRepository.fillAddress(
  //           address: addressController.text,
  //           address2: "Ulanmagan",
  //           city: state.selectedDistrict!.name!,
  //           postalCode: postalCodeController.text);
  //       response.when(success: (data) async {
  //         state = state.copyWith(isLoading: false);
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(const SnackBar(content: Text("Address confirmed")));
  //         success?.call();
  //       }, failure: (failure, status, data) {
  //         state = state.copyWith(isLoading: false, isResponseError: true);
  //         if (failure == const NetworkExceptions.unauthorisedRequest()) {
  //           unAuthorised?.call();
  //         }
  //         debugPrint('==> Address filled response failure: $failure');
  //       });
  //     } else {
  //       checkYourNetwork?.call();
  //     }
  //   } else {
  //     if (addressController.text == "") {
  //       state = state.copyWith(errorMessage: "address".toUpperCase());
  //     }
  //     if (state.selectedDistrict == null) {
  //       state = state.copyWith(errorMessage: "district".toUpperCase());
  //     }
  //     if (postalCodeController.text == "") {
  //       state = state.copyWith(errorMessage: "postal code".toUpperCase());
  //     }
  //   }
  // }

  Future<void> getCartProducts({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    // // Проверяем авторизацию
    // if (!LocalStorage.instance.isAuthenticated()) {
    //   // Если не авторизован, загружаем из локального хранилища
    //   // await loadLocalCart();
    //   success?.call();
    //   return;
    // }

    state = state.copyWith(isLoading: true);
    final response = await _cartRepository.getCartProducts();
    response.when(success: (data) async {
      state = state.copyWith(isLoading: false, cartProduct: data);
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(
          isLoading: false, isResponseError: true, cartProduct: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> get cart products response failure: $failure');
    });
  }

  Future<void> addToGlobalCart({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required int id,
    required BuildContext context,
  }) async {
    // Добавляем в pending операции
    final newPendingOperations = Map<int, bool>.from(state.pendingCartOperations);
    newPendingOperations[id] = true;
    state = state.copyWith(pendingCartOperations: newPendingOperations);

    final response = await _cartRepository.addToCart(id: id);
    response.when(success: (data) async {
      // Убираем из pending операций
      final updatedPendingOperations = Map<int, bool>.from(state.pendingCartOperations);
      updatedPendingOperations.remove(id);
      state = state.copyWith(pendingCartOperations: updatedPendingOperations, isLoading: false);
      AppHelpers.showSuccessToast(message: data.message);
      success?.call();
    }, failure: (failure, status, data) {
      // Убираем из pending операций при ошибке
      final updatedPendingOperations = Map<int, bool>.from(state.pendingCartOperations);
      updatedPendingOperations.remove(id);
      AppHelpers.showErrorToast(errorMessage: data.toString());
      state = state.copyWith(
          pendingCartOperations: updatedPendingOperations,
          isLoading: false,
          isResponseError: true
      );
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> add to cart products response failure: $failure');
    });
  }

  Future<void> removeFromGlobalCart({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required int id,
    required BuildContext context,
  }) async {
    // // Проверяем авторизацию
    // if (!LocalStorage.instance.isAuthenticated()) {
    //   await removeFromLocalCart(id);
    //   success?.call();
    //   return;
    // }

    // Добавляем в pending операции
    final newPendingOperations = Map<int, bool>.from(state.pendingCartOperations);
    newPendingOperations[id] = true;
    state = state.copyWith(pendingCartOperations: newPendingOperations);

    final response = await _cartRepository.removeFromCart(id: id);
    response.when(
        success: (data) async {
          // Убираем из pending операций
          final updatedPendingOperations = Map<int, bool>.from(state.pendingCartOperations);
          updatedPendingOperations.remove(id);
          state = state.copyWith(pendingCartOperations: updatedPendingOperations, isLoading: false);
          success?.call();
        },
        failure: (failure, status, data) {
          // Убираем из pending операций при ошибке
          final updatedPendingOperations = Map<int, bool>.from(state.pendingCartOperations);
          updatedPendingOperations.remove(id);
          AppHelpers.showErrorToast(errorMessage: data.toString());
          state = state.copyWith(
              pendingCartOperations: updatedPendingOperations,
              isResponseError: true,
              isLoading: false
          );
          if (failure == const NetworkExceptions.unauthorisedRequest()) {
            unAuthorised?.call();
          }
          debugPrint('==> remove from cart products response failure: $failure');
        });
  }

  Future<void> deleteFromGlobalCart({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required int id,
    required BuildContext context,
  }) async {
    // // Проверяем авторизацию
    // if (!LocalStorage.instance.isAuthenticated()) {
    //   await deleteFromLocalCart(id);
    //   success?.call();
    //   return;
    // }

    // Добавляем в pending операции
    final newPendingOperations = Map<int, bool>.from(state.pendingCartOperations);
    newPendingOperations[id] = true;
    state = state.copyWith(pendingCartOperations: newPendingOperations);

    final response = await _cartRepository.deleteFromCart(id: id);
    response.when(success: (data) async {

      // Убираем из pending операций
      final updatedPendingOperations = Map<int, bool>.from(state.pendingCartOperations);
      updatedPendingOperations.remove(id);
      state = state.copyWith(pendingCartOperations: updatedPendingOperations, isLoading: false);
      success?.call();
    }, failure: (failure, status, data) {
      // Убираем из pending операций при ошибке
      final updatedPendingOperations = Map<int, bool>.from(state.pendingCartOperations);
      updatedPendingOperations.remove(id);
      AppHelpers.showErrorToast(errorMessage: data.toString());
      state = state.copyWith(
          pendingCartOperations: updatedPendingOperations,
          isResponseError: true,
          isLoading: false
      );
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> delete from cart response failure: $failure');
    });
  }

  Future<void> createOrder({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required BuildContext context,
    int? addressID
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _cartRepository.createOrder(
        addressID: addressID,
        paymentType: state.paymentType,
        deliveryType: state.deliveryType,
        orderComment: orderCommentController.text.trim()
    );
    response.when(success: (data) async {
      state = state.copyWith(isLoading: false, orders: data);
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(
          isLoading: false, isResponseError: true, orders: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> create order response failure: $failure');
    });
  }

  Future<void> getOrders({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response =
    await _cartRepository.getOrders();
    response.when(success: (data) async {
      state = state.copyWith(isLoading: false, getOrders: data);
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(isLoading: false, isResponseError: true);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==>create order response failure: $failure');
    });
  }

  Future<void> getAllAddresses({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _cartRepository.getAllAddresses();
    response.when(success: (data) async {

      state = state.copyWith(isLoading: false, userAllAddresses: data);
      success?.call();
    }, failure: (failure, status, data) {

      state = state.copyWith(isLoading: false, isResponseError: true);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> get all addresses response failure: $failure');
    });
  }

  Future<void> clearGlobalCart({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final response = await _cartRepository.clearCart();
    response.when(success: (data) async {
      state = state.copyWith(isLoading: false);
      success?.call();
    }, failure: (failure, status, data) {

      state = state.copyWith(isLoading: false, isResponseError: true);

      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==> clear cart response failure: $failure');
    });
  }

  // Методы для работы с локальной корзиной (для неавторизованных)
  Future<void> initLocalCartState() async {
    state = state.copyWith(localCartItems: LocalStorage.instance.getLocalCart());
  }

  Future<void> addToLocalCart(LocalCartProduct product) async {
    await LocalStorage.instance.addToLocalCart(product);
    state = state.copyWith(localCartItems: LocalStorage.instance.getLocalCart());
  }

  getLocalCart() {
    final localCartItems = LocalStorage.instance.getLocalCart();
    state = state.copyWith(localCartItems: localCartItems);
  }
  Future<void> removeFromLocalCart(int productId) async {
    await LocalStorage.instance.removeLocalCartItem(productId);
    state = state.copyWith(localCartItems: LocalStorage.instance.getLocalCart());
  }

  Future<void> deleteFromLocalCart(int productId) async {
    await LocalStorage.instance.deleteLocalCartItem(productId);
    state = state.copyWith(localCartItems: LocalStorage.instance.getLocalCart());
  }

  Future<void> clearLocalCart() async {
    await LocalStorage.instance.clearLocalCart();
    state = state.copyWith(localCartItems: []);
  }

  addToCart(BuildContext context, LocalCartProduct cartProduct) {
    if (LocalStorage.instance.isAuthenticated()) {
      addToGlobalCart(
          id: cartProduct.id ?? 0,
          context: context,
          success: () {
            getCartProducts();
          }
      );
    } else {
      addToLocalCart(cartProduct);
    }
  }

  removeFromCart(BuildContext context, int productId) {
    if (LocalStorage.instance.isAuthenticated()) {
      removeFromGlobalCart(
        id: productId,
        context: context,
        success: () {
          getCartProducts();
        },
      );
    } else {
      removeFromLocalCart(productId);
    }
  }

  deleteFromCart(BuildContext context, int productId) {
    if (LocalStorage.instance.isAuthenticated()) {
      deleteFromGlobalCart(
        id: productId,
        context: context,
        success: () {
          getCartProducts();
        },
      );
    } else {
      deleteFromLocalCart(productId);
    }
  }

  clearCart() {
    if (LocalStorage.instance.isAuthenticated()) {
      clearGlobalCart(
          success: () {
            getCartProducts();
          }
      );
    } else {
      clearLocalCart();
    }
  }

  getCartItems() {
    if(LocalStorage.instance.isAuthenticated()) {
      getCartProducts();
    } else {
      getLocalCart();
    }
  }

  Future<void> openMap() async {
    if (Platform.isAndroid) {
      // Android покажет список приложений (chooser)
      final uri = Uri.parse('geo:${41.355349},${69.253245}?q=${41.355349},${69.253245}(1000 Мелочей)');
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // iOS откроет Apple Maps (или другую, если пользователь сменил по умолчанию)
      final uri = Uri.parse('http://maps.apple.com/?ll=${41.355349},${69.253245}&q=1000 Мелочей');
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> syncLocalCartToBackend() async {
    if (!isAuth) return;
    // Получаем локальные товары гостя
    final List<LocalCartProduct> localItems = LocalStorage.instance.getLocalCart();
    if (localItems.isEmpty) return;

    // Загружаем текущую корзину пользователя на сервере
    final serverResp = await _cartRepository.getCartProducts();
    List<int> serverProductIds = [];
    serverResp.when(
      success: (data) {
        serverProductIds = (data.data ?? [])
            .map((e) => e.product?.id)
            .whereType<int>()
            .toList();
      },
      failure: (f, s, d) {
        // Если не удалось получить корзину — всё равно попробуем синкнуть вслепую
        serverProductIds = [];
      },
    );

    // Добавляем на сервер то, чего там нет
    for (final item in localItems) {
      final productId = item.id;
      if (productId == null) continue;
      if (serverProductIds.contains(productId)) {
        // Уже есть на сервере — пропускаем
        continue;
      }
      final qty = (item.quantity ?? 1);
      for (int i = 0; i < qty; i++) {
        await _cartRepository.addToCart(id: productId);
      }
    }

    // Чистим локальную корзину и обновляем серверные данные
    await LocalStorage.instance.clearLocalCart();
    await getCartProducts();
  }
}
