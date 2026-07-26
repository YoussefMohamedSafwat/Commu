import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/presentation/blocs/commentbloc/bloc/comment_bloc.dart';
import 'package:cleanarch/features/Comments/presentation/widgets/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoading) {
          return LoadingWidget();
        } else if (state is CommentLoaded) {
          return _buildCommentList(context, state.comments);
        } else if (state is CommentError) {
          return Center(child: Text(state.message));
        }
        return SizedBox();
      },
    );
  }

  Widget _buildCommentList(BuildContext context, List<Comment> comments) {
    return comments.isEmpty
        ? Center(
            child: Text(
              "No comments on this post ",
              style: context.commentText,
            ),
          )
        : ListView.separated(
            itemCount: comments.length,
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemBuilder: (context, index) {
              final comment = comments[index];
              return CommentTile(comment: comment);
            },
          );
  }
}
