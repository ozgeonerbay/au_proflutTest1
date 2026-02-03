import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists and provides app locale (tr/en). Used with MaterialApp.locale.
class LocaleProvider extends ChangeNotifier {
  static const String _key = 'selected_language';
  Locale _locale = const Locale('tr');

  Locale get locale => _locale;
  bool get isTurkish => _locale.languageCode == 'tr';

  LocaleProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'tr';
    _locale = Locale(code);
    notifyListeners();
  }

  Future<void> setLocale(Locale value) async {
    _locale = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, value.languageCode);
    notifyListeners();
  }
}
