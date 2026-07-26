import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:flutter/material.dart';

class TagsList extends StatelessWidget {
  final List<String> tags;

  final Function(String tag)? onRemove;
  const TagsList({super.key, required this.tags, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: tags.map((tag) {
        return Container(
          decoration: context.containerTheme,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: onRemove == null
                ? Text(tag, style: context.tagsText)
                : Row(
                    spacing: 6,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(tag, style: context.tagsText),
                      GestureDetector(
                        onTap: () => onRemove?.call(tag),
                        child: Icon(
                          Icons.close,
                          size: 17,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      }).toList(),
    );
  }
}
