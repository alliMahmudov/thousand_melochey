import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../contstants/app_constants.dart';

class LocalStorage {
  static GetStorage? _storage;
  static LocalStorage? _localStorage;

  LocalStorage._();

  static LocalStorage get instance {
    _localStorage ??= LocalStorage._();
    return _localStorage!;
  }

  static Future<void> init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  Future<void> setLang(String lang) async {
    await _storage?.write(AppConstants.lang, lang);
  }

  String getLang() => _storage?.read(AppConstants.lang) ?? "en";

  void deleteLang() => _storage?.remove(AppConstants.lang);

  Future<void> setJWT(String jwt) async {
    await _storage?.write(AppConstants.jwt, jwt);
  }

  String getJWT() => _storage?.read(AppConstants.jwt) ?? "";

  void deleteJWT() => _storage?.remove(AppConstants.jwt);

  Future<void> logout() async {
    await _storage?.erase();
  }
}