import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchDataWidget extends StatelessWidget {
  final int id;
  final Widget Function(Posts post) pageBuilder;
  const FetchDataWidget({
    super.key,
    required this.pageBuilder,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<PostsBloc>()..add(GetPostByIdEvent(id: id)),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const LoadingWidget();
          } else if (state is PostsError) {
            return MessageDisplayWidget(message: state.message);
          } else if (state is PostLoaded) {
            return pageBuilder(state.post);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
