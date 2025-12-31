import 'package:cleanarch/core/util/comments_sheet.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final int postId;
  const CommentWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => openComments(context, postId),
      icon: Icon(Icons.comment),
      color: Colors.blueGrey[300],
      iconSize: 25,
    );
  }
}
