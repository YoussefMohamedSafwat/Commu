import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const LabeledText({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.body.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
        ),
      ],
    );
  }
}
