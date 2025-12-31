import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/presentation/blocs/commentbloc/bloc/comment_bloc.dart';
import 'package:cleanarch/features/Comments/presentation/widgets/edit_comment_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void openEditSheet(BuildContext context, Comment comment) {
  FocusScope.of(context).unfocus(); // important!
  final commentBloc = context.read<CommentBloc>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return BlocProvider.value(
        value: commentBloc,
        child: BottomSheet(
          onClosing: () {},
          builder: (ctx2) {
            final bottom = MediaQuery.of(ctx).viewInsets.bottom;
            return Padding(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: bottom,
              ),
              child: EditCommentContainer(comment: comment),
            );
          },
        ),
      );
    },
  );
}
