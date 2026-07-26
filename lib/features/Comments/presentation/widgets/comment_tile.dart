import 'dart:developer';
import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/confirm_dialog.dart';
import 'package:cleanarch/core/util/edit_comment_sheet.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/presentation/blocs/commentbloc/bloc/comment_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<CurrentUserCubit>().state?.id;
    return comment.userId == currentUserId && currentUserId != null
        ? Dismissible(
            key: ValueKey(comment.id),
            confirmDismiss: (dismiss) => _confirmdismiss(context),
            onDismissed: (dismiss) => context.read<CommentBloc>().add(
              DeleteCommentEvent(commentID: comment.id!),
            ),
            direction: DismissDirection.endToStart,
            background: _dismissContainer(),
            child: InkWell(
              onLongPress: () {
                openEditSheet(context, comment);
              },
              child: _commentListTile(context),
            ),
          )
        : _commentListTile(context);
  }

  Future<bool> _confirmdismiss(BuildContext context) async {
    final response = await openConfirmDialog(
      context,
      "Are you sure you want to delete this comment?",
    );
    return response;
  }

  Widget _commentListTile(BuildContext context) {
    return UserWidget(
      isUser: false,
      userId: comment.userId,
      builder: (context, user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: user.imageUrl != null
                      ? NetworkImage(user.imageUrl!)
                      : null,
                  child: user.imageUrl == null
                      ? const Icon(Icons.person, size: 20)
                      : null,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.username, style: context.normalTextHigh),
                    const SizedBox(height: 5),
                    Text(comment.body, style: context.commentText),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dismissContainer() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.delete, color: Colors.white, size: 28),
    );
  }
}
