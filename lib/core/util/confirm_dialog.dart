import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

Future<bool> openConfirmDialog(BuildContext context, String title) async {
  bool confirm = false;
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(title, style: AppTextStyle.buttonText),

        actions: [
          TextButton(
            onPressed: () {
              confirm = true;
              Navigator.of(context).pop();
            },
            child: Text("Confirm", style: AppTextStyle.normalText),
          ),
          TextButton(
            onPressed: () {
              confirm = false;
              Navigator.of(context).pop();
            },
            child: Text("Cancel", style: AppTextStyle.normalText),
          ),
        ],
      );
    },
  );

  return Future.value(confirm);
}
