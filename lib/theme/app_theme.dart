import 'package:flutter/material.dart';
import 'package:themoviedb/theme/app_colors.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.grey.withOpacity(0.2)),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.mainAppColor),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.mainAppColor),
  );
}