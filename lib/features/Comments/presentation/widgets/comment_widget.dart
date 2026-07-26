import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/core/util/bottom_sheet.dart';
import 'package:cleanarch/features/Comments/presentation/pages/comment_page.dart';
import 'package:cleanarch/features/Reacts/presentation/cubit/react_cubit.dart';
import 'package:cleanarch/features/Reacts/presentation/cubit/react_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentWidget extends StatelessWidget {
  final int postId;
  const CommentWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () =>
              openbBottomSheet(context, CommentPage(postid: postId)),
          icon: Icon(Icons.chat_bubble_outline),
          color: context.iconBtnColor,
          iconSize: 25,
        ),
        BlocSelector<ReactCubit, ReactState, int>(
          selector: (state) => state.commentCounts[postId] ?? 0,
          builder: (context, counts) => Text(
            counts.toString(),
            style: context.subTitleText.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
