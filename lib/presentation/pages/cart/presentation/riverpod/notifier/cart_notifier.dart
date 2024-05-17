import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thousand_melochey/core/handlers/sp.dart';
import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/service/connectivity_plus/app_connective.dart';

class CartNotifier extends StateNotifier<CartState> {
  final CartRepository _cartRepository;

  CartNotifier(this._cartRepository) : super(const CartState());
  ScrollController scrollController = ScrollController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  bool? checkForExistence(int id) {
    return state.cartProduct?.data
        ?.any((cartProduct) => cartProduct.product?.id == id);
  }

  Future<void> fillAddress({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
    required BuildContext context,
  }) async {
    final connectivity = await AppConnectivity.connectivity();

    if (
        addressController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        postalCodeController.text.isNotEmpty) {
      if (connectivity) {
        state = state.copyWith(isLoading: true);
        final jwtToken = await SP.readFromSP("JWT");
        final response = await _cartRepository.fillAddress(
            jwtToken: "jwt=$jwtToken",
            address: addressController.text,
            address2: "Ulanmagan",
            city: cityController.text,
            postalCode: postalCodeController.text);
        response.when(success: (data) async {
          state = state.copyWith(isLoading: false);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Address confirmed")));
          success?.call();
        }, failure: (failure, status, data) {
          state = state.copyWith(isLoading: false, isResponseError: true);
          if (failure == const NetworkExceptions.unauthorisedRequest()) {
            unAuthorised?.call();
          }
          debugPrint('==> Address filled response failure: $failure');
        });
      } else {
        checkYourNetwork?.call();
      }
    } else {
      if (addressController.text == "") {
        state = state.copyWith(errorMessage: "address".toUpperCase());
      }
      if (cityController.text == "") {
        state = state.copyWith(errorMessage: "city".toUpperCase());
      }
      if (postalCodeController.text == "") {
        state = state.copyWith(errorMessage: "postal code".toUpperCase());
      }
    }
  }

  Future<void> getCartProducts({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isProductLoading: true);
    final jwtToken = await SP.readFromSP("JWT");
    final response =
        await _cartRepository.getCartProducts(jwtToken: "jwt=$jwtToken");
    response.when(success: (data) async {
      state = state.copyWith(isProductLoading: false, cartProduct: data);
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(
          isProductLoading: false, isResponseError: true, cartProduct: data);
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
    state = state.copyWith(isLoading: true);
    final jwtToken = await SP.readFromSP("JWT");
    final response =
        await _cartRepository.addToCart(jwtToken: "jwt=$jwtToken", id: id);
    response.when(success: (data) async {
      state = state.copyWith(isLoading: false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Product added to cart")));
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(isLoading: false, isResponseError: true);
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
    state = state.copyWith(isLoading: true);
    final jwtToken = await SP.readFromSP("JWT");
    final response =
        await _cartRepository.removeFromCart(jwtToken: "jwt=$jwtToken", id: id);
    response.when(success: (data) async {
      state = state.copyWith(isLoading: false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product removed from cart")));
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(isLoading: false, isResponseError: true);
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
    state = state.copyWith(isLoading: true);
    final jwtToken = await SP.readFromSP("JWT");
    final response =
        await _cartRepository.deleteFromCart(jwtToken: "jwt=$jwtToken", id: id);
    response.when(success: (data) async {
      state = state.copyWith(isLoading: false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product deleted from cart")));
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(isLoading: false, isResponseError: true);
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
  }) async {
    state = state.copyWith(isLoading: true);
    final jwtToken = await SP.readFromSP("JWT");
    final response =
    await _cartRepository.createOrder(jwtToken: "jwt=$jwtToken");
    response.when(success: (data) async {
      state = state.copyWith(isLoading: false, orders: data);
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(
          isLoading: false, isResponseError: true, orders: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==>create order response failure: $failure');
    });
  }

  Future<void> getOrders({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? success,
  }) async {
    state = state.copyWith(isLoading: true);
    final jwtToken = await SP.readFromSP("JWT");
    final response =
    await _cartRepository.getOrders(jwtToken: "jwt=$jwtToken");
    response.when(success: (data) async {
      state = state.copyWith(isLoading: false, getOrders: data);
      success?.call();
    }, failure: (failure, status, data) {
      state = state.copyWith(
          isLoading: false, isResponseError: true, getOrders: data);
      if (failure == const NetworkExceptions.unauthorisedRequest()) {
        unAuthorised?.call();
      }
      debugPrint('==>create order response failure: $failure');
    });
  }



}
