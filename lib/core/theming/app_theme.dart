import 'package:cleanarch/core/constants/app_sizes.dart';
import 'package:cleanarch/core/theming/app_bar_theme.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:flutter/material.dart';
export 'colors.dart';
export 'app_theme_extension.dart';
export 'text_styles.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Inter';

  static ButtonStyle get _elevatedbuttonstyle => ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    iconSize: AppSizes.s22,
    iconColor: Colors.white,
    textStyle: const TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  static ThemeData lightTheme = ThemeData(
    fontFamily: _fontFamily,
    colorSchemeSeed: AppColors.primary,
    scaffoldBackgroundColor: AppColors.neutral,
    appBarTheme: appBarTheme(Brightness.light),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 1,
      shadowColor: AppColors.primary.withAlpha(60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: Colors.grey,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: _elevatedbuttonstyle),
    iconTheme: const IconThemeData(
      size: AppSizes.s16,
      color: AppColors.primary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsetsGeometry.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primary.withAlpha(130)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      hintStyle: const TextStyle(color: AppColors.darkTextTertiary),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: _fontFamily,
    colorSchemeSeed: AppColors.primary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: appBarTheme(Brightness.dark),
    cardTheme: CardThemeData(
      elevation: 3,
      color: AppColors.darkSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: Colors.grey,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: _elevatedbuttonstyle),
    iconTheme: const IconThemeData(
      size: AppSizes.s16,
      color: AppColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsetsGeometry.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      filled: true,
      fillColor: AppColors.darkSurfaceGlass,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white.withAlpha(25)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white.withAlpha(25)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      hintStyle: const TextStyle(color: AppColors.darkTextTertiary),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
      bodySmall: TextStyle(color: AppColors.darkTextSecondary),
    ),
  );
}
