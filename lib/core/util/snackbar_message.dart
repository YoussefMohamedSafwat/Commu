import 'package:cleanarch/core/theming/colors.dart';
import 'package:flutter/material.dart';

class SnackBarMessage {
  void showSuccessSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
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
        backgroundColor: AppColors.deleteBtnColor,
      ),
    );
  }
}
