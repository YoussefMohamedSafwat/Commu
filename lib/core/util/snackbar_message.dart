import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:flutter/material.dart';

class SnackBarMessage {
  void showSuccessSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: context.primaryColor,
      ),
    );
  }

  void showErrorSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: context.deleteBtnColor,
      ),
    );
  }
}
