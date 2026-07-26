import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:flutter/material.dart';

extension AppTextStyle on BuildContext {
  static const String _fontFamily = 'Inter';

  TextStyle get heading => TextStyle(
    inherit: false,
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );

  TextStyle get body => TextStyle(
    inherit: false,
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textSecondaryColor,
  );
  TextStyle get caption => TextStyle(
    inherit: false,
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textSecondaryColor,
  );

  TextStyle get tagsText => TextStyle(
    inherit: false,
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  TextStyle get normalText => body;

  TextStyle get normalTextHigh =>
      body.copyWith(fontSize: 18, fontWeight: FontWeight.w600);

  TextStyle get commentText => body;

  TextStyle get titleText => heading;

  TextStyle get hintText => caption.copyWith(
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
    color: Colors.grey,
  );

  TextStyle get subTitleText => caption.copyWith(
    fontWeight: FontWeight.w200,
    fontStyle: FontStyle.italic,
  );

  TextStyle get numberHeaderText =>
      heading.copyWith(fontSize: 16, fontWeight: FontWeight.bold);

  TextStyle get appBarTextStyle => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );
  TextStyle get buttonTextStyle => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
