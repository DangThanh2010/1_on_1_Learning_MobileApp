import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends ChangeNotifier{
  Setting(this.language, this.theme);

  String language;
  String theme;

  void  changeLanguage(String value) async {
    language = value;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
    notifyListeners();
  }

  void  changeTheme(String value) async {
    theme = value;

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
    notifyListeners();
  }
}