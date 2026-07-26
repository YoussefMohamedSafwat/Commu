import 'package:cleanarch/core/constants/enums/filter.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/posts_page/posts_list.dart';
import 'package:cleanarch/features/Search/presentation/cubit/posts_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;

class SearchResultsPage extends StatelessWidget {
  final String query;
  final SearchFilter filter;

  const SearchResultsPage({
    super.key,
    required this.query,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.dc<PostsSearchCubit>()..executeSearch(query, filter),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search: $query',
            style: context.heading.copyWith(fontSize: 18),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Filtered by: ${filter == SearchFilter.tags ? "Tags" : "Users"}',
                style: context.normalText,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<PostsSearchCubit, PostsSearchState>(
              builder: (context, state) {
                if (state is PostsSearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostsSearchEmpty) {
                  return Center(
                    child: Text("No posts found.", style: context.titleText),
                  );
                } else if (state is PostsSearchError) {
                  return Center(
                    child: Text(state.message, style: context.titleText),
                  );
                } else if (state is PostsSearchLoaded) {
                  return PostsList(
                    posts: state.posts,
                    isPage: true,
                    onRefresh: () async {
                      await context.read<PostsSearchCubit>().executeSearch(
                        query,
                        filter,
                      );
                    },
                    onLoadMore: () {
                      // Currently pagination is not implemented for search
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
