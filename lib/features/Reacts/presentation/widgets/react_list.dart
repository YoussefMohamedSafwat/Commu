import 'package:cleanarch/features/Comments/presentation/widgets/comment_widget.dart';
import 'package:cleanarch/features/Reacts/presentation/widgets/react_container.dart';
import 'package:flutter/material.dart';

class ReactList extends StatelessWidget {
  final int postId;
  const ReactList({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ReactContainer(islike: true),
        SizedBox(width: 10),
        ReactContainer(islike: false),
        Spacer(),
        CommentWidget(postId: postId),
      ],
    );
  }
}
