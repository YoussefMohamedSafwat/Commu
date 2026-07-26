import 'package:cleanarch/core/responsive/responsive.dart';
import 'package:flutter/widgets.dart';

class AppDimensions {
  AppDimensions._();

  static double loginContainerWidth(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 420;
    }
    return Responsive.width(context) * 0.9;
  }

  static double? loginContainerHeight(BuildContext context) {
    return null;
  }
}
