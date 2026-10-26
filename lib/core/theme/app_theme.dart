import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'DMSans',
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.textprimary,
        surface: AppColors.background,
      ),
    );
  }
}