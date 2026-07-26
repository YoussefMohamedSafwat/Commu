import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final String label;

  const FormSubmitBtn({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.add),
      label: Text(label, style: context.buttonTextStyle),
    );
  }
}
