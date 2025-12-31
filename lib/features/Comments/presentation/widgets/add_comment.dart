import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/presentation/blocs/commentbloc/bloc/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddComment extends StatefulWidget {
  final int postid;
  final Comment? comment;
  final bool isEditing;
  final bool autoFocus;

  const AddComment({
    super.key,
    required this.postid,
    this.comment,
    this.isEditing = false,
    this.autoFocus = false,
  });

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    if (widget.isEditing) {
      _controller.text = widget.comment!.body;
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: widget.autoFocus,
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Add a comment...",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send, size: 25),
          onPressed: () {
            final commentText = _controller.text;
            if (commentText.trim().isNotEmpty) {
              if (widget.isEditing) {
                context.read<CommentBloc>().add(
                  UpdateCommentEvent(
                    commentID: widget.comment!.id,
                    commentBody: _controller.text,
                  ),
                );
                Navigator.of(context).pop();
              } else {
                context.read<CommentBloc>().add(
                  AddCommentEvent(
                    postId: widget.postid,
                    body: commentText,
                    userId: context.read<CurrentUserCubit>().state!.id,
                  ),
                );
              }
              _controller.clear();
            }
          },
        ),
      ],
    );
  }
}
