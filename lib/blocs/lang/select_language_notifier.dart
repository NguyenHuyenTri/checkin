import 'package:flutter/cupertino.dart';
import 'package:vao_ra/models/LanguageModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguageNotifier extends ChangeNotifier {
  String _currentLang = languages[0];

  SelectLanguageNotifier();

  String get currentLang => _currentLang;

  updateLanguage(String value) async {
    if(value != _currentLang) {
      _currentLang = value;
      notifyListeners();
    }
  }
}