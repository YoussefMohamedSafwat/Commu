import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:flutter/material.dart';

class PostMenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final void Function() onPressed;
  const PostMenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: onPressed,
      leadingIcon: Icon(icon, color: iconColor),
      child: Text(text, style: context.normalText),
    );
  }
}
