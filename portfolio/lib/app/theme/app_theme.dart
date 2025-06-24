import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/app/theme/app_colors.dart';

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.cardColor,
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          bodyLarge: TextStyle(color: AppColors.fontColor),
          bodyMedium: TextStyle(color: AppColors.fontColor),
          displayLarge: TextStyle(color: AppColors.fontColor),
          displayMedium: TextStyle(color: AppColors.fontColor),
          displaySmall: TextStyle(color: AppColors.fontColor),
          headlineMedium: TextStyle(color: AppColors.fontColor),
          headlineSmall: TextStyle(color: AppColors.fontColor),
          titleLarge: TextStyle(color: AppColors.fontColor),
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primary,
        background: AppColors.background,
        surface: AppColors.cardColor,
      ),
    );
  }
}
