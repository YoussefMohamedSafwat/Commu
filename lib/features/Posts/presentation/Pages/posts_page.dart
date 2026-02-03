import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  final bool isPage;
  const PostsPage({super.key, this.isPage = true});

  @override
  Widget build(BuildContext context) {
    return isPage
        ? Scaffold(appBar: _buildappbar(context), body: _buildbody())
        : _buildbody();
  }

  Widget _buildbody() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is PostsLoading) {
                return LoadingWidget();
              } else if (state is PostsLoaded) {
                return PostsList(posts: state.posts, isPage: isPage);
              } else if (state is PostsError) {
                return MessageDisplayWidget(message: state.message);
              }
              return Center(
                child: Text("NO Posts yet", style: AppTextStyle.titleText),
              );
            },
          ),
        ),
      ],
    );
  }

  AppBar _buildappbar(BuildContext context) =>
      AppBar(title: Text("posts"), elevation: 2, actions: [

            ],
  );
}
