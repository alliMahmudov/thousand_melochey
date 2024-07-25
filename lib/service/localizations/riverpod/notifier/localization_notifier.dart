


import 'package:thousand_melochey/core/imports/imports.dart';
import 'package:thousand_melochey/service/localizations/riverpod/state/localization_state.dart';

class AppLocalizationNotifier extends StateNotifier<LocalizationState>{
  final Ref ref;
  final int index;
  AppLocalizationNotifier(this.ref,this.index) : super(const LocalizationState());


  Future<void> setLang(String lang,context) async {
    // await LocalStorage.instance.setLang(
    //   lang,
    // );
    // AppLocalization.setLocale(lang);
    // state = state.copyWith(localLang: lang,currentLang: Locale(lang));
    // RestartWidget.restartApp(context);

  }
  getLang(String lang,context)  {

    // state = state.copyWith(localLang: lang,currentLang: Locale(lang));

  }

  Future<void> changeLang(String lang) async {
    // ref.read(homeProvider(0).notifier).changeTab(index: 0);
    // state = state.copyWith(localLang: lang);
  }

}