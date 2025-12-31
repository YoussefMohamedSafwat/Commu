
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsList extends StatefulWidget {
  final List<Posts> posts;
  const PostsList({super.key, required this.posts});

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
      context.read<PostsBloc>().add(GetMorePostsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        return PostCard(
          title: widget.posts[index].title,
          body: widget.posts[index].body,
          tags: widget.posts[index].tags,
          postId: widget.posts[index].id,
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 0.5),
    );
  }
}
