import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;
  final Widget spacerWidget;
  const DrawerItem({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
    required this.spacerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return (InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, 2),
                  color: Colors.black.withAlpha(10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
          ),
          Text(text, style: context.body),
          Spacer(),
          spacerWidget,
        ],
      ),
    ));
  }
}
