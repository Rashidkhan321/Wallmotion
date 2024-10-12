import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    if (_themeData.brightness == Brightness.dark) {
      _themeData = ThemeData.light();
    } else {
      _themeData = ThemeData.dark();
    }
    notifyListeners();
  }
}