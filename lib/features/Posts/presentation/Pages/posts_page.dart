import 'package:cleanarch/core/util/comment_sheet_controller.dart';
import 'package:cleanarch/features/Comments/presentation/pages/comment_page.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildappbar(context), body: _buildbody());
  }

  // Widget _buildfloatingbutton(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsetsGeometry.symmetric(vertical: 20),
  //     child: FloatingActionButton(
  //       onPressed: () => context.pushNamed("addpost"),
  //       child: Icon(Icons.add, color: Colors.white),
  //     ),
  //   );
  // }

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
                return PostsList(posts: state.posts);
              } else if (state is PostsError) {
                return MessageDisplayWidget(message: state.message);
              }
              return LoadingWidget();
            },
          ),
        ),
        // ValueListenableBuilder(
        //   valueListenable: CommentsSheetController.instance.isOpen,
        //   builder: (context, isopen, child) {
        //     if (!isopen) return const SizedBox.shrink();
        //     return DraggableScrollableSheet(
        //       initialChildSize: 0.8,
        //       maxChildSize: 0.95,
        //       minChildSize: 0.4,
        //       builder: (_, controller) {
        //         return Container(
        //           decoration: BoxDecoration(
        //             color: Theme.of(
        //               context,
        //             ).colorScheme.surfaceContainerHighest,
        //             borderRadius: BorderRadius.vertical(
        //               top: Radius.circular(25),
        //             ),
        //           ),
        //           child: CommentPage(
        //             postid: CommentsSheetController.instance.currentPostId!,
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
      ],
    );
  }

  AppBar _buildappbar(BuildContext context) =>
      AppBar(title: Text("posts"), elevation: 2, actions: [

    ],
  );
}
