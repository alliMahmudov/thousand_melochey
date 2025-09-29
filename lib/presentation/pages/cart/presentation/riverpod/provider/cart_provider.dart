import 'package:thousand_melochey/core/imports/imports.dart';

final cartProvider = StateNotifierProvider.autoDispose<CartNotifier, CartState>(
    (ref) => CartNotifier(cartRepository));
