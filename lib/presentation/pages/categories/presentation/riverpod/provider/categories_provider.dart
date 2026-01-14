
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_melochey/injection.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/notifier/categories_notifier.dart';
import 'package:thousand_melochey/presentation/pages/categories/presentation/riverpod/state/categories_state.dart';

final categoriesProvider = StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) =>
    CategoriesNotifier(categoriesRepository));