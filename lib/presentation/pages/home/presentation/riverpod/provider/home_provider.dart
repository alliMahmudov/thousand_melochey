import 'package:thousand_melochey/core/imports/imports.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
    (ref) => HomeNotifier(homeRepository));
