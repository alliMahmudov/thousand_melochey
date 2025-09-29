import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thousand_melochey/core/handlers/local_storage.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/add_to_cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/get_districts_response.dart';
import 'package:thousand_melochey/service/connectivity_plus/app_connective.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';

import '../../../../profile/data/all_adresses_response.dart';

class CartNotifier extends StateNotifier<CartState> {
  final CartRepository _cartRepository;

  CartNotifier(this._cartRepository) : super(const CartState());
  ScrollController scrollController = ScrollController();

  TextEditingController orderCommentController = TextEditingController();

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

  Future<void> addToCart({
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

  Future<void> removeFromCart({
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

    final response =
        await _cartRepository.removeFromCart(id: id);
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
      debugPrint('==> remove from cart products response failure: $failure');
    });
  }

  Future<void> deleteFromCart({
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
    required int addressID
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

  Future<void> clearCart({
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



}
