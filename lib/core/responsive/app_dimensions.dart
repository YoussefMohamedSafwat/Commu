import 'package:cleanarch/core/responsive/responsive.dart';
import 'package:flutter/widgets.dart';

class AppDimensions {
  AppDimensions._();

  static double loginContainerWidth(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 650;
    }
    return Responsive.width(context) * 0.9;
  }

  static double loginContainerHeight(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return double.infinity;
    }
    return Responsive.height(context) * 0.7;
  }

  static double loginBtnWidth(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 400;
    }
    return Responsive.height(context) * 0.8;
  }
}
