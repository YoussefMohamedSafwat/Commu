import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/presentation/widgets/add_comment.dart';
import 'package:flutter/material.dart';

class EditCommentContainer extends StatefulWidget {
  final Comment comment;
  const EditCommentContainer({super.key, required this.comment});

  @override
  State<EditCommentContainer> createState() => _EditCommentContainerState();
}

class _EditCommentContainerState extends State<EditCommentContainer>
    with TickerProviderStateMixin {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isEditing
            ? AddComment(
                postid: widget.comment.postId,
                comment: widget.comment,
                isEditing: isEditing,
                autoFocus: true,
              )
            : TextButton(
                child: Text("Edit", style: context.normalText),
                onPressed: () {
                  setState(() {
                    isEditing = true;
                  });
                },
              ),
      ),
    );
  }
}
