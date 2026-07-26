import 'package:cleanarch/core/theming/colors.dart';
import 'package:flutter/material.dart';

class InkWellContainer extends StatelessWidget {
  final IconData icon;
  final double containerSize;
  final double iconSize;
  final VoidCallback? onTap;
  const InkWellContainer({
    super.key,
    required this.icon,
    required this.containerSize,
    required this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(icon, color: Colors.white, size: iconSize),
          ),
        ),
      ),
    );
  }
}
