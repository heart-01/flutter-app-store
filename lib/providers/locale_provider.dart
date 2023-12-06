import 'package:flutter/material.dart';

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
    _locale = newLocale;
    notifyListeners();
  }
}
