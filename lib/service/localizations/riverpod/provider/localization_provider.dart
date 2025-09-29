import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/service/localizations/riverpod/notifier/localization_notifier.dart';
import 'package:thousand_melochey/service/localizations/riverpod/state/localization_state.dart';

final langProvider =
StateNotifierProvider.family<AppLocalizationNotifier, LocalizationState,int>((ref,index) => AppLocalizationNotifier(ref,index));