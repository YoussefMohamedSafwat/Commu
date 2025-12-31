import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/elevated_btn_theme.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final Icon icon;

  const FormSubmitBtn({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label, style: AppTextStyle.buttonText),
      style: elevatedbuttonstyle.copyWith(
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
      ),
    );
  }
}
