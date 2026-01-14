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

  /// Устанавливает язык с сохранением локально и перезапуском приложения
  Future<void> setLang(String lang, BuildContext context) async {
    await LocalStorage.instance.setLang(lang);
    await AppLocalization.setLocale(lang);
    state = state.copyWith(localLang: lang, currentLang: Locale(lang));
    RestartWidget.restartApp(context);
    ref.read(homeProvider.notifier).getProducts(isRefresh: true);
  }

  /// Синхронизирует язык с бэкендом без перезапуска приложения
  /// Используется при инициализации приложения или получении данных пользователя
  Future<void> syncLangFromBackend(String lang, BuildContext? context) async {
    final currentLang = LocalStorage.instance.getLang();
    
    // Если язык отличается от текущего, обновляем
    if (currentLang != lang && lang.isNotEmpty) {
      await LocalStorage.instance.setLang(lang);
      await AppLocalization.setLocale(lang);
      state = state.copyWith(localLang: lang, currentLang: Locale(lang));
      
      // Перезапускаем приложение только если есть контекст
      if (context != null && context.mounted) {
        RestartWidget.restartApp(context);
      }
    }
  }

  /// Временно меняет язык в UI (для модального окна выбора языка)
  Future<void> changeLang(String lang) async {
    state = state.copyWith(localLang: lang);
  }

  /// Устанавливает язык из локального хранилища
  getLang(String lang, BuildContext? context) {
    state = state.copyWith(localLang: lang, currentLang: Locale(lang));
  }
}

