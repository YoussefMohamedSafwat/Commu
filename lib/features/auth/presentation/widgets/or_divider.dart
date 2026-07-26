import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final double parentWidth;
  const OrDivider({super.key, required this.parentWidth});

  @override
  Widget build(BuildContext context) {
    final dividerColor = context.isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFE2E8F0);
    final textColor = context.isDark
        ? Colors.white.withValues(alpha: 0.4)
        : const Color(0xFF64748B);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Or connect with",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }
}
