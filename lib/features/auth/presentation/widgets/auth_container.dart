import 'dart:ui';
import 'package:cleanarch/core/responsive/app_dimensions.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  final Widget Function(double parentWidth, double parentHeight) child;
  const AuthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: AppDimensions.loginContainerWidth(context),
          decoration: context.glassCardDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return child(constraints.maxWidth, constraints.maxHeight);
            },
          ),
        ),
      ),
    );
  }
}
