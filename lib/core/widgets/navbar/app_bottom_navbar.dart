import 'package:cleanarch/core/widgets/navbar/cusotm_bottom_navbar.dart';
import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final Widget child;

  const AppBottomNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }
}
