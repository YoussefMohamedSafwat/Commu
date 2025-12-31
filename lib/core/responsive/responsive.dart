import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 904;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1280;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 904 &&
      MediaQuery.of(context).size.width < 1280;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
