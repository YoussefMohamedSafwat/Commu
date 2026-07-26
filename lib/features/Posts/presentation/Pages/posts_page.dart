import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/util/snackbar_message.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/message_display_widget.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/posts_list.dart';
import 'package:cleanarch/features/Reacts/presentation/cubit/react_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  final bool isPage;
  final bool shrinkWrap;
  const PostsPage({super.key, this.isPage = true, this.shrinkWrap = false});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.isPage
        ? Scaffold(appBar: _buildappbar(context), body: _buildbody())
        : _buildbody();
  }

  Widget _buildbody() {
    return BlocListener<AddDeleteUpdateBloc, AddDeleteUpdateState>(
      listenWhen: (prev, curr) =>
          prev != curr && curr is AddDeleteUpdateMessage ||
          curr is AddDeleteUpdateError,
      listener: (addDeleteUpdateContext, addDeleteUpdateState) {
        if (addDeleteUpdateState is AddDeleteUpdateMessage) {
          addDeleteUpdateContext.read<PostsBloc>().add(RefreshPostsEvent());
          SnackBarMessage().showSuccessSnackBar(
            message: addDeleteUpdateState.message,
            context: addDeleteUpdateContext,
          );
        } else if (addDeleteUpdateState is AddDeleteUpdateError) {
          SnackBarMessage().showErrorSnackBar(
            message: addDeleteUpdateState.message,
            context: addDeleteUpdateContext,
          );
        }
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: BlocConsumer<PostsBloc, PostsState>(
              listener: (context, state) {
                if (state is PostsLoaded) {
                  context.read<ReactCubit>().seed(state.posts);
                }
              },
              builder: (context, state) {
                if (state is PostsLoading) {
                  return const LoadingWidget();
                } else if (state is PostsLoaded) {
                  return PostsList(
                    posts: state.posts,
                    isPage: widget.isPage,
                    shrinkWrap: widget.shrinkWrap,
                  );
                } else if (state is PostsError) {
                  return MessageDisplayWidget(message: state.message);
                }
                return Center(
                  child: Text("No posts yet !", style: context.titleText),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildappbar(BuildContext context) =>
      AppBar(title: Text("Feed", style: context.appBarTextStyle));
}
