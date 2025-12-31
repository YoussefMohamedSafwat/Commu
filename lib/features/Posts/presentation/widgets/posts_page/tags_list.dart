import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class TagsList extends StatelessWidget {
  final List<String> tags;
  const TagsList({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.tagscontainterColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            tag,
            style: AppTextStyle.normalText.copyWith(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        );
      }).toList(),
    );
  }
}
