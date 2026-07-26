import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatefulWidget {
  final List<Posts> posts;
  final bool isPage;
  final Future<void> Function()? onRefresh;
  final VoidCallback? onLoadMore;
  final bool shrinkWrap;

  const PostsList({
    super.key,
    required this.posts,
    this.isPage = true,
    this.shrinkWrap = false,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.onLoadMore != null) {
        widget.onLoadMore!();
      } else {
        context.read<PostsBloc>().add(GetMorePostsEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.posts.isEmpty
        ? Center(
            child: Text(
              "No Posts Yet!",
              style: context.normalText.copyWith(fontWeight: FontWeight.w500),
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              if (widget.onRefresh != null) {
                await widget.onRefresh!();
              } else {
                context.read<PostsBloc>().add(GetAllPostsEvent());
                await context.read<PostsBloc>().stream.firstWhere(
                  (state) => state is! PostsLoading,
                );
              }
            },
            child: ListView.separated(
              controller: widget.isPage ? _scrollController : null,
              shrinkWrap: widget.shrinkWrap,
              physics: widget.shrinkWrap
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              itemCount: widget.posts.length,
              itemBuilder: (context, index) {
                return PostCard(
                  title: widget.posts[index].title,
                  userId: widget.posts[index].userId,
                  body: widget.posts[index].body,
                  tags: widget.posts[index].tags ?? [],
                  postId: widget.posts[index].id,
                  reactCount: widget.posts[index].reactCount,
                  commentCount: widget.posts[index].commentCount,
                  imagesUrl: widget.posts[index].imagesUrl,
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 0.5),
            ),
          );
  }
}
