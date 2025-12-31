import 'package:cleanarch/features/Comments/presentation/pages/comment_page.dart';
import 'package:flutter/material.dart';

void openComments(BuildContext context, int postid) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black26,
    transitionAnimationController: AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: Navigator.of(context),
    ),
    builder: (_) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.4,
        builder: (_, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: CommentPage(postid: postid),
          );
        },
      );
    },
  );
}
