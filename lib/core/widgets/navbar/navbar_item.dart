import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:flutter/material.dart';

class NavbarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final bool isActive;
  final VoidCallback onTap;

  const NavbarItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            isActive ? activeIcon : icon,
            key: ValueKey(isActive),
            color: isActive ? context.primaryColor : Colors.grey,
            size: 30,
          ),
        ),
      ),
    );
  }
}
