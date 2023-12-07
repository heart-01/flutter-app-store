import 'package:flutter/material.dart';
import 'package:flutter_store/utils/utility.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  // Constructor
  LocaleProvider(Locale locale) {
    _locale = locale;
  }

  // Getter
  Locale get locale => _locale;

  // Change language
  void changeLanguage(Locale newLocale) async {
    // Save new locale to shared preference
    await Utility.setSharedPreference('languageCode', newLocale.languageCode);
    
    _locale = newLocale;
    notifyListeners();
  }
}
