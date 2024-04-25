import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.amber, 
  scaffoldBackgroundColor: const Color.fromARGB(255, 243, 241, 206), 
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.amber, toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(color: Colors.black),
    ).bodyMedium, titleTextStyle: const TextTheme(
      titleLarge: TextStyle(color: Colors.black), 
    ).titleLarge,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black, 
  scaffoldBackgroundColor: const Color.fromARGB(255, 52, 50, 50), 
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black, toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(color: Colors.white), 
    ).bodyMedium, titleTextStyle: const TextTheme(
      titleLarge: TextStyle(color: Colors.white), 
    ).titleLarge,
  ),
);
enum ThemeState { light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _prefs;
  ThemeCubit(this._prefs) : super(ThemeState.light);

  void toggleTheme() {
    emit(state == ThemeState.light ? ThemeState.dark : ThemeState.light);
    _prefs.setString('theme', state == ThemeState.light ? 'light' : 'dark');
  }

  Future<ThemeState> loadTheme() async {
    final themeMode = _prefs.getString('theme') ?? 'light';
    emit(themeMode == 'light' ? ThemeState.light : ThemeState.dark);
    return themeMode == 'light' ? ThemeState.light : ThemeState.dark;
  }
}