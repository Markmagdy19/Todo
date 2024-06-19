import 'package:chatt/generated/l10n.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!S.delegate.isSupported(locale)) {
      return;
    }
    _locale = locale;
    notifyListeners();
  }
}
