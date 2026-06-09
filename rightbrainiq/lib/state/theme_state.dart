import 'package:flutter/foundation.dart';

class ThemeState extends ChangeNotifier {
  static final ThemeState instance = ThemeState._internal();
  ThemeState._internal();

  bool _isDark = false;

  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void setDark(bool value) {
    if (_isDark != value) {
      _isDark = value;
      notifyListeners();
    }
  }
}
