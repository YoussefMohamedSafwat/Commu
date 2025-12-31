import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Comments/presentation/blocs/commentbloc/bloc/comment_bloc.dart';
import 'package:cleanarch/features/Comments/presentation/widgets/add_comment.dart';
import 'package:cleanarch/features/Comments/presentation/widgets/comment_list.dart';
import 'package:cleanarch/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPage extends StatelessWidget {
  final int postid;
  const CommentPage({super.key, required this.postid});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: bottom, // THIS pushes the input up
          top: 10,
        ),
        child: BlocProvider(
          create: (context) =>
              di.dc<CommentBloc>()..add(GetCommentsEvent(postId: postid)),
          child: Column(
            children: [
              Text(
                "Comments",
                style: AppTextStyle.titleText.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),

              Expanded(child: CommentList()),

              const SizedBox(height: 10),
              AddComment(postid: postid), // NO Expanded here
            ],
          ),
        ),
      ),
    );
  }
}
