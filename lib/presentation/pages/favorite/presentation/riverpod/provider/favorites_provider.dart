import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/riverpod/notifier/favorites_notifier.dart';
import 'package:thousand_melochey/presentation/pages/favorite/presentation/riverpod/state/favorites_state.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>(
        (ref) => FavoritesNotifier(favoritesRepository));
