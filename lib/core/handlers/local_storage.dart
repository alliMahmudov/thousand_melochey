import 'package:get_storage/get_storage.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/cart_response.dart';
import 'package:thousand_melochey/presentation/pages/cart/data/local_cart_item_model.dart';
import '../../contstants/app_constants.dart';
import '../../presentation/pages/home/data/products_response.dart';

class LocalStorage {
  static GetStorage? _storage;
  static LocalStorage? _localStorage;

  LocalStorage._();

  static LocalStorage get instance {
    _localStorage ??= LocalStorage._();
    return _localStorage!;
  }

  static Future<void> init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  Future<void> setLang(String lang) async {
    await _storage?.write(AppConstants.lang, lang);
  }

  String getLang() => _storage?.read(AppConstants.lang) ?? "ru";

  void deleteLang() => _storage?.remove(AppConstants.lang);

  Future<void> setJWT(String jwt) async {
    await _storage?.write(AppConstants.jwt, jwt);
  }

  String getJWT() => _storage?.read(AppConstants.jwt) ?? "";

  void deleteJWT() => _storage?.remove(AppConstants.jwt);

  Future<void> logout() async {
    await _storage?.erase();
  }

  // Проверка авторизации
  bool isAuthenticated() => getJWT().isNotEmpty;

  Future<void> saveLocalFavorite(Product product) async {
    final List<dynamic> storedList = _storage?.read(AppConstants.localFavorites) ?? [];

    // конвертируем список обратно в объекты
    List<Product> favorites = storedList.map((e) => Product.fromJson(Map<String, dynamic>.from(e))).toList();

    final alreadyExists = favorites.any((e) => e.id == product.id);

    if (alreadyExists) {
      // если уже есть — удаляем (повторное нажатие = убрать лайк)
      favorites.removeWhere((e) => e.id == product.id);
    } else {
      favorites.add(product);
    }

    // сохраняем обратно
    await _storage?.write(
      AppConstants.localFavorites,
      favorites.map((e) => e.toJson()).toList(),
    );
  }

  List<CartProduct> getLocalFavorites() {
    final List<dynamic> storedList = _storage?.read(AppConstants.localFavorites) ?? [];
    return storedList.map((e) => CartProduct.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> removeLocalFavorite(int productId) async {
    final List<CartProduct> favorites = getLocalFavorites();

    // фильтруем: оставляем всё, кроме продукта с нужным id
    final updatedFavorites = favorites.where((item) => item.id != productId).toList();

    // сохраняем обратно
    final jsonList = updatedFavorites.map((e) => e.toJson()).toList();
    await _storage?.write(AppConstants.localFavorites, jsonList);
  }

  Future<void> clearLocalFavorites() async {
    await _storage?.remove(AppConstants.localFavorites);
  }


  Future<void> addToLocalCart(LocalCartProduct product) async {
    final List<LocalCartProduct> cart = getLocalCart();
    final index = cart.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      // товар уже есть — обновляем количество
      final oldItem = cart[index];
      cart[index] = LocalCartProduct(
        id: oldItem.id,
        name: oldItem.name,
        price: oldItem.price,
        image: oldItem.image,
        quantity: (oldItem.quantity ?? 1) + (product.quantity ?? 1),
      );
    } else {
      cart.add(product);
    }
    await _storage?.write(
      AppConstants.localCart,
      cart.map((e) => e.toJson()).toList(),
    );
  }

  List<LocalCartProduct> getLocalCart() {
    final List<dynamic> storedList = _storage?.read(AppConstants.localCart) ?? [];
    return storedList.map((e) => LocalCartProduct.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> removeLocalCartItem(int productId) async {
    final List<LocalCartProduct> cart = getLocalCart();
    final index = cart.indexWhere((item) => item.id == productId);
    if (index != -1) {
      final item = cart[index];
      if ((item.quantity ?? 1) > 1) {
        cart[index] = LocalCartProduct(
          id: item.id,
          name: item.name,
          price: item.price,
          image: item.image,
          quantity: (item.quantity ?? 1) - 1,
        );
      } else {
        cart.removeAt(index);
      }
      await _storage?.write(
        AppConstants.localCart,
        cart.map((e) => e.toJson()).toList(),
      );
    }
  }

  Future<void> deleteLocalCartItem(int productId) async {
    final List<LocalCartProduct> cart = getLocalCart();
    final filtered = cart.where((item) => item.id != productId).toList();
    await _storage?.write(
      AppConstants.localCart,
      filtered.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> clearLocalCart() async {
    await _storage?.remove(AppConstants.localCart);
  }

  int getLocalCartTotalQuantity() {
    final localCart = getLocalCart();
    int count = 0;
    for (final item in localCart) {
      count += item.quantity ?? 0;
    }
    return count;
  }

  double getLocalCartTotalPrice() {
    final localCart = getLocalCart();
    double sum = 0;
    for (final item in localCart) {
      final price = double.tryParse(item.price ?? '0') ?? 0;
      sum += price * (item.quantity ?? 0);
    }
    return sum;
  }

}