import 'dart:developer';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/confirm_dialog.dart';
import 'package:cleanarch/core/util/edit_comment_sheet.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/presentation/blocs/commentbloc/bloc/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return //comment.user.id == context.read<CurrentUserCubit>().state!.id
    Dismissible(
      key: ValueKey(comment.id),
      confirmDismiss: (dismiss) => _confirmdismiss(context),
      onDismissed: (dismiss) => context.read<CommentBloc>().add(
        DeleteCommentEvent(commentID: comment.id),
      ),
      direction: DismissDirection.endToStart,
      background: _dismissContainer(),
      child: InkWell(   
        onLongPress: () {
          openEditSheet(context, comment);
        },
        child: _commentListTile(context),
      ),
    );
  }

  Future<bool> _confirmdismiss(BuildContext context) async {
    final response = await openConfirmDialog(
      context,
      "Are you sure you want to delete this comment?",
    );
    log(response.toString());
    return response;
  }

  Widget _commentListTile(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        child: Icon(Icons.person, color: Colors.grey.shade700),
      ),
      title: Text(
        comment.user.username,
        style: AppTextStyle.normalText.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(comment.body, style: AppTextStyle.commentText),
      trailing: IconButton(
        icon: Icon(Icons.reply),
        onPressed: () {
          // Handle reply action
        },
      ),
    );
  }

  Widget _dismissContainer() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.delete, color: Colors.white, size: 28),
    );
  }
}
