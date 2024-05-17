import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/notifier/main_notifier.dart';
import 'package:thousand_melochey/presentation/pages/main/riverpod/state/main_state.dart';

final mainProvider = StateNotifierProvider.family<MainNotifier, MainState,int>(
    (ref,index) => MainNotifier(index,ref));
