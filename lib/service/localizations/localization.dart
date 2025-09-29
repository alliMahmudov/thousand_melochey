
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocalization{
  final AppLocalizations appLocalizations;
  AppLocalization._(
      this.appLocalizations
      );


  static  const delegate = AppLocalizations.delegate;


  static Future setLocale(String langName)async{
    await AppLocalizations.delegate.load(Locale(langName));

  }


  static Future<String> currentLang(context)async{
    final localeName = AppLocalizations.of(context)?.localeName ?? "";
    return localeName;
  }

  static AppLocalizations? getText(context){
    final localeName = AppLocalizations.of(context);
    return localeName;
  }


}