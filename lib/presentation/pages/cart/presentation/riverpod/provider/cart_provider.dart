import 'package:thousand_melochey/core/imports/imports.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartState>(
    (ref) => CartNotifier(cartRepository));
