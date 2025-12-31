import 'package:cleanarch/core/responsive/app_dimensions.dart';

import 'package:cleanarch/core/theming/container_theme.dart';
import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  final Widget Function(double parentWidth, double parentHeight) child;
  const AuthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.loginContainerWidth(context),
      height: AppDimensions.loginContainerHeight(context),

      decoration: containerTheme,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return child(constraints.maxWidth, constraints.maxHeight);
        },
      ),
    );
  }
}
