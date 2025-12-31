import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final double parentWidth;
  const OrDivider({super.key, required this.parentWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: parentWidth * 0.36, child: Divider(thickness: 2)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("Or", style: AppTextStyle.normalText),
        ),
        SizedBox(width: parentWidth * 0.36, child: Divider(thickness: 2)),
      ],
    );
  }
}
