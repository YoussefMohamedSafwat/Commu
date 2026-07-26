import 'package:cleanarch/features/Comments/presentation/widgets/comment_widget.dart';
import 'package:cleanarch/features/Reacts/presentation/widgets/react_container.dart';
import 'package:flutter/material.dart';

class ReactList extends StatelessWidget {
  final int postId;
  final int commentCount;
  final int reactCount;
  const ReactList({
    super.key,
    required this.postId,
    required this.commentCount,
    required this.reactCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ReactContainer(postId: postId),
        SizedBox(width: 10),
        CommentWidget(postId: postId),
      ],
    );
  }
}
