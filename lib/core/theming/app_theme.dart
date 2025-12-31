import 'package:cleanarch/core/constants/app_sizes.dart';
import 'package:cleanarch/core/theming/app_bar_theme.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/elevated_btn_theme.dart';

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed: AppColors.primaryColor,
    appBarTheme: appBarTheme,

    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedbuttonstyle),
    iconTheme: IconThemeData(size: AppSizes.s16, color: AppColors.primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorSchemeSeed: AppColors.iconBtnColor,
    brightness: Brightness.dark,
    appBarTheme: appBarTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedbuttonstyle),
    iconTheme: IconThemeData(size: AppSizes.s16, color: AppColors.primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
