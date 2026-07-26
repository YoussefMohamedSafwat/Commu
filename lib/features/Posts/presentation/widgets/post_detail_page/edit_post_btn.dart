import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditPostBtn extends StatelessWidget {
  final Posts post;
  const EditPostBtn({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: context.elevatedbuttonstyle.copyWith(
        backgroundColor: WidgetStatePropertyAll(context.editBtnColor),
      ),
      onPressed: () {
        context.goNamed(
          "editpost",
          pathParameters: {"id": post.id.toString()},
          extra: post,
        );
      },
      icon: Icon(Icons.edit),
      label: Text("Edit", style: context.buttonTextStyle),
    );
  }
}
