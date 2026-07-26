import 'package:cleanarch/core/theming/colors.dart';
import 'package:flutter/material.dart';

extension AppThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Brightness get brightness => theme.brightness;
  TextTheme get textTheme => theme.textTheme;

  bool get isDark => brightness == Brightness.dark;
  Color get primaryColor => AppColors.primary;
  Color get accentColor => AppColors.accent;
  Color get textPrimaryColor =>
      isDark ? AppColors.darkTextPrimary : AppColors.secondary;

  Color get textSecondaryColor =>
      isDark ? AppColors.darkTextSecondary : Colors.grey.shade600;

  Color get textTertiaryColor =>
      isDark ? AppColors.darkTextTertiary : Colors.grey.shade500;

  Color get surfaceColor => isDark ? AppColors.darkSurface : AppColors.surface;

  Color get backgroundColorApp =>
      isDark ? AppColors.darkBackground : AppColors.neutral;

  Decoration get containerTheme => BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    color: AppColors.lightPrimary,
  );

  Decoration get authBackground => BoxDecoration(
    gradient: RadialGradient(
      center: const Alignment(-0.3, -0.3),
      radius: 3.5,
      colors: isDark
          ? [
              AppColors.darkEmerald,
              AppColors.darkBackground,
              AppColors.darkBackground,
            ]
          : [AppColors.lightMint, AppColors.lightTeal, AppColors.lightTeal],
      stops: [0.0, 0.5, 1.0],
    ),
  );

  Decoration get glassCardDecoration => BoxDecoration(
    color: isDark
        ? AppColors.darkSurface.withValues(alpha: 0.65)
        : Colors.white.withValues(alpha: 0.7),
    borderRadius: BorderRadius.circular(40),
    border: Border.all(
      color: isDark
          ? Colors.white.withValues(alpha: 0.1)
          : Colors.white.withValues(alpha: 0.4),
    ),
  );

  Decoration get circleContainer => BoxDecoration(
    shape: BoxShape.circle,
    gradient: LinearGradient(
      colors: isDark
          ? [AppColors.lightPrimary, AppColors.secondary] // purple to pink
          : [AppColors.lightPrimary, AppColors.primary], // orange to pink
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    boxShadow: [
      BoxShadow(
        color: isDark
            ? AppColors.primary.withValues(alpha: 0.12)
            : AppColors.primary.withValues(alpha: 0.2),
        blurRadius: 12,
        spreadRadius: 2,
        offset: Offset(0, 4),
      ),
    ],
  );
  Decoration get outerCircleContainer =>
      BoxDecoration(shape: BoxShape.circle, color: surfaceColor);

  Color get deleteBtnColor => AppColors.deleteBtnColor;
  Color get editBtnColor => AppColors.editBtnColor;
  Color get iconBtnColor =>
      isDark ? AppColors.iconBtnColor : AppColors.darkSurface;

  ButtonStyle get elevatedbuttonstyle => ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
  );

  MenuStyle get menuStyle => MenuStyle(
    backgroundColor: WidgetStatePropertyAll(surfaceColor),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    elevation: const WidgetStatePropertyAll(8),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 6)),
  );
}
