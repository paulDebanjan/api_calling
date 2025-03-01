import 'package:flutter/material.dart';
import 'package:api_calling/theme/dark_mode.dart';
import 'package:api_calling/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // current mode is light Mode
  ThemeData _themeData = darkMode;

  // get the current theme
  ThemeData get themeData => _themeData;

  // is blackMode
  bool get isDarkMode => _themeData == darkMode;

  // set the ThemeMode
  void setThemeMode(ThemeData themeMode) {
    _themeData = themeMode;
    notifyListeners();
  }

  // switch theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}
