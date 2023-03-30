import 'package:flutter/material.dart';
import './themes.dart';

class ThemeManager extends ChangeNotifier {
  ThemeData theme = ThemeClass.lightTheme;
  bool? darkMode;
  ThemeManager({required this.darkMode}) {
    if (darkMode != null) {
      theme = darkMode! ? ThemeClass.darkTheme : ThemeClass.lightTheme;
    } else
      theme = ThemeClass.lightTheme; //Default to light mode if null
    notifyListeners();
  }

  get getTheme => theme;

  void toggleTheme(bool darkMode) {
    theme = darkMode ? ThemeClass.darkTheme : ThemeClass.lightTheme;
    print("Dark mode is $darkMode");
    notifyListeners();
  }
}
