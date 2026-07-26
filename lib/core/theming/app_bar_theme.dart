import 'package:cleanarch/core/theming/colors.dart';
import 'package:flutter/material.dart';

AppBarTheme appBarTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  const fontFamily = 'Inter';
  return AppBarTheme(
    backgroundColor: isDark ? AppColors.darkappbar : AppColors.surface,
    centerTitle: false,
    scrolledUnderElevation: 0,
    titleTextStyle: const TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ).copyWith(color: isDark ? AppColors.lightPrimary : AppColors.primary),
    iconTheme: IconThemeData(
      color: isDark ? AppColors.neutral : AppColors.secondary,
    ),
  );
}
