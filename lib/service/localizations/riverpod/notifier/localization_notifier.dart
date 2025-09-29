import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/presentation/global_widgets/restart_widget.dart';
import 'package:thousand_melochey/service/localizations/localization.dart';
import 'package:thousand_melochey/service/localizations/riverpod/state/localization_state.dart';

import '../../../../core/handlers/local_storage.dart';

class AppLocalizationNotifier extends StateNotifier<LocalizationState> {
  final Ref ref;
  final int index;

  AppLocalizationNotifier(this.ref, this.index) : super(LocalizationState(
    localLang: LocalStorage.instance.getLang(),
    currentLang: Locale(LocalStorage.instance.getLang()),
  ));

  Future<void> setLang(String lang, BuildContext context) async {
    await LocalStorage.instance.setLang(lang);
    await AppLocalization.setLocale(lang);
    state = state.copyWith(localLang: lang, currentLang: Locale(lang));
    RestartWidget.restartApp(context);
    ref.read(homeProvider.notifier).getProducts(isRefresh: true);
  }

  Future<void> changeLang(String lang) async {
    state = state.copyWith(localLang: lang);
  }

  getLang(String lang,context)  {
    state = state.copyWith(localLang: lang,currentLang: Locale(lang));
  }
}

