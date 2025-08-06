// language_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class LanguageController extends ChangeNotifier {
  bool isEnglish = true;

  void toggleLanguage() {
    isEnglish = !isEnglish;
    notifyListeners();
  }

  Locale get currentLocale => isEnglish ? const Locale('en') : const Locale('pt');
}

// Provider para usar com Riverpod
final languageControllerProvider = ChangeNotifierProvider<LanguageController>((ref) {
  return LanguageController();
});
